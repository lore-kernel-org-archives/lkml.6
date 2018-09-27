Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE621C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5885B206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3dVL426"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5885B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0SZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:25:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeI0SZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:25:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so5683592wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rA5HXrGguICT9+nXSQnjsA7qnbS9iyKMSToLqrzmqpI=;
        b=n3dVL42668f3Q3UxwQwGwePLQnI30Ua0uMXb1ebXaCE34Cb6JT0axcQfw8fPErCGod
         xWRP2vktnwT3mWGUGhvmkWlu0ryGqjknANXfNUIJ3mjHl5m3kb6heKwOBuBxP2Nb0u35
         iPSqcDs5b25qpeC3dIwyUG0jVh5CtKvJhG8LbS33GYBhKnup+GDWbjjlYPxL5s6MpmAy
         gHsu0EUx8JJJIJW6OAfRjfchuNga56QljVnyk3Bqi018jZGHg0h8/VaYxppeAzucI0At
         m/SzLelFUs3ldcC1izzllZ2DshVDSNFbO0yiu6A9r5YECkwWlrHD2oRD8pA9jWJoGwWa
         KpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rA5HXrGguICT9+nXSQnjsA7qnbS9iyKMSToLqrzmqpI=;
        b=EFVx4vQeY5vjtKvmhTj70Kx89+lUoNPslsahELA15VzyEZsCv7FVCghmnz0r2LQrPL
         wJ1fUHM7axkRzrF5nBWyZ5DhJtxHauGc0bQnYdr2tnN0Vc4p73u8S5ampP3sU2doJjnr
         9XM9GyGVhfzU1W1cJW100+HvCilJ6BfgpBYZfANTs+XQMGrKlnofUZJeUteFpf6TLkuJ
         /sELnLyCGb6MlqQVciQldFN/wgNmTDGEi2McdrqOWOgP1cEkWAhq2EB/EiZjFQiOmY4d
         zslR+kwYce4kJfiTmpptYdcVe4HHtPAatuxQj8Z/eqDan35dU0CkNbBMRFNBIMC6Fkvi
         WIFQ==
X-Gm-Message-State: ABuFfoj30U/Gv9QiUvSlFgi/5UXxTg0/XpiA7phnd/PVw+pFoRNHf5Fr
        pBIMxntJONx0d1U7Mhs8DwM=
X-Google-Smtp-Source: ACcGV63RbaQ/WrEhTRlTAPsMROe9t60FZBjZHrA4c1V8zP5Yrr5soGEM2BbRpLr5kkx87gMRxXKDPA==
X-Received: by 2002:a1c:760d:: with SMTP id r13-v6mr7821387wmc.22.1538050043326;
        Thu, 27 Sep 2018 05:07:23 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id t14-v6sm1856782wmi.35.2018.09.27.05.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 05:07:22 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:07:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v4] drm/panel: add Kingdisplay kd097d04 panel driver
Message-ID: <20180927120721.GF29102@ulmo>
References: <20180817093731.9850-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <20180817093731.9850-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2018 at 11:37:31AM +0200, Heiko Stuebner wrote:
> From: Nickey Yang <nickey.yang@rock-chips.com>
>=20
> Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> it is a MIPI dual-DSI panel.
>=20
> v4:
> - address Philipp's comments
>   - real range for usleep_range and
>   - poweroff ordering in kingdisplay_panel_prepare
>   - return value beautification in panel_probe
> - update author naming for full name
> v3:
> - address Thierry's comments
>   - error handling for init dsi writes in init
>   - unconditionally remove the panel
>   - don't use drm_panel_detach
>   - a bit of variable signednes wiggling
> - I did talk to ChromeOS people and the delays really should be as short
>   as possible, so dropped the 100ms from the delay comments
> v2:
> - update timing + cmds from chromeos kernel
> - new backlight API including switch to devm_of_find_backlight
> - fix most of Sean Paul's comments
>   enable/prepare tracking seems something all panels do
> - document origins of the init sequence
> - lanes per dsi interface to 4 (two interfaces). Matches how tegra
>   and pending rockchip dual-dsi handle (dual-)dsi lanes
> - spdx header instead of license boilerplate
>=20
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  11 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-kingdisplay-kd097d04.c    | 473 ++++++++++++++++++
>  3 files changed, 485 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c

This is missing device tree bindings.

Thierry

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlusx/kACgkQ3SOs138+
s6GsoBAApY77hwVAyBUvK6uezZix2+j957v3cx5riVNVemIFOzJa5EBhtwHHg0ji
UsZvYL21UEeueG/yiX4CQlrmHP44g3OzFFCSjI/cu69qG893zxuplGUK73qML1LL
pPXNU1eKk5PmfBf/ujwmUbXzhyVe/SdHIYPdU9R/D0HeZqrxTEC6NWp3ZpxPlLxa
C9Ai161nPwOSwzj0nLRKg1UPxwZk+T00VBHcX9+ObbZB6YXkAFb6/LqAbE6recGN
PSF4pE8ZaV9RlyfbXOovpz4b5BJyCQeh6gWEF/w2uMORyUCbTs32KgORz2Mf1KV0
zIz6lO+/PN5kwkHaqEc2PPKtdTdDp0m6dA2FdRMnSdeKpCwknd6ucwqwctnJI0+s
Tm8JX1Lso6H1ab1PSr2SHNAJzv6pbHjnOL9irs3kG9yjJrCBlgOLn2Q8R85HVgL9
EreCq2tAxzNe61VnbFmdGFDwoAE/yuAuncLq4hmX+DMNNoIUwtXt31ofZdOH8r6i
r93xC1vsicz7e0AKlOEc2gnje9QjgZt0pj8BHRvHUrhOedKzNw0Ora/pq87egAit
MsfkE1MTp4U/iiu11sIFBkifOCSNUITd3Tr687VncuWmHcKZGttIy9okScSgekwr
plkefloSB3+pbGq+CiocWxMWpgDRk1M/A+I7fbBdP/aDXlCSXh0=
=4gUX
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
