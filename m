Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD09C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80A3215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddvpFDdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80A3215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeI0SkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:40:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40891 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0SkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:40:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8-v6so2368986wrh.7;
        Thu, 27 Sep 2018 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fvnHgElxGvzhsfBZhgi8wJUX5ZqzGuSxNYrMRz90Abk=;
        b=ddvpFDdkNeM4tPk2SICn/3bDY3XMgPEqUOZBH/6WnX09SlqwNtYJ1tT5FPUjBOBIBB
         z7ojyfgFwdrMzF4Cshbf32VBUNwOu2OiqI04TuU2ulND9BHoReOs5kcQnwf2w55mhqzW
         nUJ+Hc7RxNrO/xdwia/hgV6RSCPLGmRLXaVfYZOO2aryy5SW383dl8IyXBf/UU/KE14S
         1um/NHitJczoSOexGDTVpuCFYT/5u6FTxTIwXSg4sMexUQSYs+gVshjpi6gj921Ejc2x
         +3hj0ScNGayr9KwyDlheeIyAy9oo/R25GSmLAw4LfMKWQeuMw/8pr8o7P6OK85DRrwp+
         LvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvnHgElxGvzhsfBZhgi8wJUX5ZqzGuSxNYrMRz90Abk=;
        b=V6R+Yvc62doXHPyyFKxERT88gLSP0Q7zy28/togOEPzjDnVyvbGv2BHO1Y3EcfUDQJ
         qy4rwiC3kuAvSS2OE3SI6xPdgeyMGeyc5nGlcyJVPcknWuK3s5aeYA+8IEYWBKjgIkX6
         TTTSQYzw5Naj4hBZKzItjFKBfUyoa8hdYaN3RuNm/FaPzkWU9GqL6WTVYjGjJzY9nwNH
         m9X7559RwXTgr9vkfrAoRQuPG74CrEC1tVl/MzSSsCYwx0mrmLCMVvm/1DR2AUnJnFRh
         wAutfmvXpp5Y99tU+GrTJ0gZsoAMIKq+R0REi/m0pgiNG8vT31bacZHWsLA8HwJJ08y7
         zpWQ==
X-Gm-Message-State: ABuFfojC0agP6rykom3DBP41rc5lyEmf6CZ+Xh8+ka822xY/Oj+q6nGA
        /Eime0Z0CnUB1+LAUyxIYKA=
X-Google-Smtp-Source: ACcGV63iQ5dBRKdINjBNOob/jmN7yKy4u4xWDt0T16j/JCs7cHlB3ECwwpBCsm+IKh0oPswtu8+rnw==
X-Received: by 2002:a5d:488c:: with SMTP id g12-v6mr8885550wrq.0.1538050923109;
        Thu, 27 Sep 2018 05:22:03 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id b124-v6sm1547233wmg.47.2018.09.27.05.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 05:22:02 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:22:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: Re: [PATCH v2 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
Message-ID: <20180927122201.GH29102@ulmo>
References: <20180907041948.19913-1-wens@csie.org>
 <20180907041948.19913-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <20180907041948.19913-5-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 12:19:46PM +0800, Chen-Yu Tsai wrote:
> This panel is marketed as Banana Pi 7" LCD display. On the back is
> a sticker denoting the model name S070WV20-CT16.
>=20
> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
> However the panel only does 262k colors.
>=20
> Depending on the variant, the PCB attached to the panel module either
> supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> itself.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 12 +++++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/banan=
api,s070wv20-ct16.txt

Next time, please make the bindings and driver changes separate patches.

Applied, thanks.
Thierry

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlusy2kACgkQ3SOs138+
s6FFEg//YgxjQ7wZvCkZJ0aenen20LklKB2OeVQ37/4BNXUkk2arXfDOUi1sP50V
8VS6Sm8fPLCfBksZZ3ilXVILZ0n0UYtfYjEYweBTZsltNVaCCGPauLLdtn+jw4x1
x3oCTn2ZrGQH5r3m/QF4OW20F7qb1bJOMmUpDPWf6VNTjXJab7iKOQWDJ81JY9yw
vmJDirUr1x0c603VExKThyjdHPen3BdACrWXKWSvSazHhBz0FW4LWbmPLgjdLehy
YeUke5LDB+wds4SvWymnHLNrTHku0124D7R+uVHOi+hLRw0maHuDvXV4zKFa7+7F
6JybOEcEDsfMrsRIjM9m2OHwXX4bcMwKHF149ET4WZHNJHnUkYMdE3Ancyuxy8i7
K0YU+6QMVEtRwHIAYp4O6HKDV7i9mciGdbNSD/iqObPab5Q8U8rzQnMF6q7zVyZT
UpYvKXZ60IzOO5jjc+yMY0WjoQBg+iz1F9o1oz9BfQfA5xJVYD5GU9Td0QCG2ojR
GoymLBcvTy2bagl5BIFlYJX+7bDkj521IyQmaTuU1uZiuf1mO50R49KPu5/+c6hk
WkXAKp+JoJ/iTabOyDQLsHUCaD/EZ18tzGfB3+VCqh21o2o3/Awg1UnEUcPcVyLU
ujHTfVGwWpb3gf1SIor+Y1D5yxL4ED3gVNyx6KJPyOYPwHhXOk4=
=lPil
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
