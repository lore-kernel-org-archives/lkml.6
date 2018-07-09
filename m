Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AEFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5A20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VODWESqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5A20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933619AbeGIRQh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:16:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39369 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933360AbeGIRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:16:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so5645782wmb.4;
        Mon, 09 Jul 2018 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dSMvQOO7xhisvJw9iHvnlkYT+zvBJLoWKBHs7M3MzM=;
        b=VODWESqRCRubhvKBJycJSI1QZbjQUmoxrBhd+nW8fPaewf4jB2bbH3B98jmY3hRZI5
         VWNo5dSc+AfL5L2upYQhZCcPsvIKdKGakn5oRbSpRzj6SvQu+OqTxuElR0u6KosgFXlE
         2p2Dx5SNNm2nM/R87XqpQ/fu2pB9e1iG/Yyv0PQAtsn5fCdDWlmWF3+0i3pfkv5tpus/
         29Cj7HpdKdTfSQLhAQmosRIKIbmcrHY3lMlsslXA5O6lGzELgWFLZYLcX9ehsNWfrG/T
         UdGpXCZLxlr9GJrpWICFzGQwUt7I5GsNHq6LeB6E4QNfQqkbDaMdilyPn8XjJPZblPOv
         1BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dSMvQOO7xhisvJw9iHvnlkYT+zvBJLoWKBHs7M3MzM=;
        b=ZzXa6vxn6CYFFPPmutEloalysewSpvYCUF0TwY/JVKi1o/J1OACTWX8uqHsj0Ak3go
         gfNCQk8Ynw5aZKfdvm8yiI72gRelBtAD8XA2A2XvTePGRHvd6tMp7R1PkS2fvq7d3w7j
         o7he5gAYrHSHJOwxfJpEZpVHrr13S4U3R/8LpZw5Dbp9dKZ1RoqSoIRz63PP22y2aSuS
         rXE+9s/EHIiM1ae43IEAQ/iNUVaAjNM7Z7PtcZ9V1uN28hBjacayK5ck/9Fwjx6nchcB
         v/faQkjZz0iHImVJbIr7nOAQS8DNR6xCIkv6Lq4Z64tSRuskB/PvLG71K/8bWnYiP08+
         BF6A==
X-Gm-Message-State: APt69E0nE8T6bsLHtLuHY3HwJKsITr1QF1MYU0vusOTFze1FEPM2zzZ6
        NWAOqEmr+dHVKIO7jgtuUcM=
X-Google-Smtp-Source: AAOMgpc09IEkRJ6yKox87mPKKL06FMEm/rHz5nxYLYqVlvn0eGXexe5cM76HvUN8XMa2aKutPpeL4A==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr12657986wmi.28.1531156594384;
        Mon, 09 Jul 2018 10:16:34 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id s41-v6sm24915901wrc.5.2018.07.09.10.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:16:33 -0700 (PDT)
Date:   Mon, 9 Jul 2018 19:16:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Davide Bonfanti <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 1/4] drm/panel: simple: Add support for Rocktech
 RK070ER9427 LCD panel
Message-ID: <20180709171632.GG26651@ulmo>
References: <20180607134648.2902-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20180607134648.2902-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 07:16:48PM +0530, Jagan Teki wrote:
> This adds support for the Rocktech Display Ltd. RK070ER9427
> 800(RGB)x480 TFT LCD panel, which can be supported by the
> simple panel driver.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2:
> - collect Rob r-w-b tag
>=20
>  .../display/panel/rocktech,rk070er9427.txt         | 25 ++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++=
++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rockt=
ech,rk070er9427.txt

checkpatch warns about the rocktech vendor prefix not being documented.
Can you send a patch which adds it to

	Documentation/devicetree/bindings/vendor-prefixes.txt

Thanks,
Thierry

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDmHAACgkQ3SOs138+
s6HYdhAAhynfztVQmvGwykaLzw5Kc3pgHt7wjVbnXkM504tjImRQ2O49LFS+HQGC
w8tBkAUB/omsqqmfGF5OiTxG14FjmlmA9qAnfFLcwjhZhFZ4eIIIqGQQpnif4Dbu
MEU0ZsH4wYYG3qiuO0YwV+ft+0y/aPVHV0Xhtf4+QxHfIBAySMWm3PPHVdvxHSU2
vWNxcJyoqmjthgPdqDV8F5iWPB6TO7t7sfK0Lux09Y2Bzye/NvOXiepJBlqirzRF
b+kO5UtC3Gxj4eGLYIIjNdxjPmMcDBI2FVLb9mkXiSwQlKVugfZh7QmYj4QDgDLW
eb91mG1FViPWTneHFYYATgubHUIRZgM9GnA4uL4aRG5oQNGdQvDT7ccS9c6gn1/0
r+u9DqxLkY7bOiXyelsdQFgOeBIFV6Y0MWLywSAJmkF3KXqKc+4PD+Ed4dL3WI+l
qyB9LTwJc5n4daDvfihXdBJ1GhnCI9Th/D/Vy7LpheBoT1i2yUNfIpoE9A6fvvQM
v0UOP+ImU81GKsvHZ/jGd8mnnyJtz3eCPk8qRbFQPwDW/CepIgEZQoAq7eHFFboR
tvi9E7DXolFtwQ0MbRndQ7EAnHqmtsqACeCn+HPfhqAEqmXrIWplBb9ttITvy+rO
SUO/D0+3jsuM2yzAFsxw9G8mUvm9RVzR91Wh2WSD5CpmUAdZfPo=
=2CEH
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
