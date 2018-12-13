Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9DCC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EFD2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML90rrVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EFD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeLMQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:07:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35218 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeLMQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:07:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so2495608edx.2;
        Thu, 13 Dec 2018 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z2OcE5BJtjcgIXV6HHAujf4D3VxK8BZhmANnizF1O8=;
        b=ML90rrVFChZ9h5dE86fXebiLHbhlQyDER1oq6IREfjFjGTWkdvBkplLlQtsL2oERjK
         eAWkvsP1uCnpIG6uvOiQ61KlQGaGhd+I43M4NNqzvCCk/S300GV+UATAUqgHuyxY1Yqp
         /5XlpojqXgm+cU9y7Ff2F3v8m4TNQXmkDrjHn4dfnQCYFlCJrJ++v6UhH0zNQ4VX/pPo
         mTnRv3D/UdPYqV6x5wjKOTIRu6L/bmeB8cqeCLQptsUPU5vJkyDyYq7brEn7amUFVsaG
         hAGrxZmysu3H+sPczKum5WKEJPm7NDnI3PXP8SR5LHR5Giucqy4zUv8+OVsaJhW8B71L
         d96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z2OcE5BJtjcgIXV6HHAujf4D3VxK8BZhmANnizF1O8=;
        b=JdKXnI8lZCvOHza3ounESwmKKYt8Nz9QMtaBiyQZMjR68Ol2uymLUUmSwfQ3aux/ow
         J4GsH3bIWESQlN1tMAKB4SK/0vI/6LdzkzkW+B7bC0e1a/l0lh/RxOiqnRGv2M1ijF8B
         2Icj6PkLN7gkGdadphZLVY7siaRt7VJyvuqhP4BMG20NvrzNgTYn1z6zdd82vzeWxAVU
         xZK6m0/Euv7GqHG1HbmJvXIEXOyfSjSBFuFVWHqF5jpCjWgMCtuVFILJ2qH3myFwucKn
         UjvXDRhpM+lFQCgptmrST3IwpEY5zXtsZFoY/+Gx82xWQM/h8pGFWC8OGZpTUgXqiBq2
         ETZQ==
X-Gm-Message-State: AA+aEWateTqdi1tV2M7Ouq7yFKjxqQyaq+0wmPmY4zsrwCkMjNZleEkd
        vJJ+g/l15Vxdv/aYdVA/GKo=
X-Google-Smtp-Source: AFSGD/W58zIgfYXijj83bjbUvLx0FWmqFL09++jBX8d5UI04VSPCqQx0J9T9k/WnnlmRnPZ748trUA==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr22154383edr.256.1544717268727;
        Thu, 13 Dec 2018 08:07:48 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id m5-v6sm394232ejq.21.2018.12.13.08.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:07:48 -0800 (PST)
Date:   Thu, 13 Dec 2018 17:07:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: pmc: Drop SMP dependency from CPU APIs
Message-ID: <20181213160746.GA13531@ulmo>
References: <1544694374-21231-1-git-send-email-jonathanh@nvidia.com>
 <154469574166.19322.12426804406101736786@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <154469574166.19322.12426804406101736786@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 02:09:01AM -0800, Stephen Boyd wrote:
> Quoting Jon Hunter (2018-12-13 01:46:14)
> > When CONFIG_SMP is disabled, the tegra clk driver now fails to build:
> >=20
> > drivers/clk/tegra/clk-tegra30.c: In function =E2=80=98tegra30_cpu_rail_=
off_ready=E2=80=99:
> > drivers/clk/tegra/clk-tegra30.c:1151:2: error: implicit declaration of =
function =E2=80=98tegra_pmc_cpu_is_powered=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
> >   cpu_pwr_status =3D tegra_pmc_cpu_is_powered(1) ||
> >     ^
> > Fix the above error by removing the CONFIG_SMP ifdef around the
> > declaration around the PMC CPU APIs because although these are not
> > needed for non-SMP configurations, there is no harm in including these
> > for non-SMP builds either.
> >=20
> > Fixes: 61866523ed6e ("clk: tegra30: Use Tegra CPU powergate helper func=
tion")
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>=20
> Can I pick this into clk tree? That would make the compilation bisection
> hole very small. I could even reorder the clk-tegra branch to have this
> before the user so the bisection hole doesn't exist.

Fine with me:

Acked-by: Thierry Reding <treding@nvidia.com>

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwSg88ACgkQ3SOs138+
s6GDthAAvY+4cuzyu4JZ64bkge2/tvYK0NzW6w1ra0K+S4b1cYSW6+Sr1wdUYNEp
Rzucht/l+Ez8DEVVHtDo32ld0JbwydYsAyB87ZTHxhkItFVdiGMdX05IH32QvJlg
gH+xZ09xtFsZNAvXuxXkaDQO1k9la61kUCcx68UCphucIjkd3jZKEGmykfptlpws
Miti4+By4X6C8VEBuhwdg+TiI04NsHRCntRZi8ZSwam5b5vGOX0zaFM1UZK9YWYa
BPI4Dmhfk039UUod1t8uJZH/oobYBsnCR9vUgL/wotxohkAHBIBr+AeAC4CD3ptU
tBpT2EYxEKvZquNBc1zDoE0ocNeDgvNf3gX4Revw9MgE7nzroCqB1jshY0dl2pkN
MDyAkgVpc97VN8RY7irZ8jiDqfYTQsCzqlp1A64PnEY5aObQQzSnhly65k6Iwd7n
X2OPiVKhCKhcE3/dXS6N+VDrITF7CCz/LvR2GaG/dUjBM/p1JW5IzFbdui65AyQo
15qCADrluYnuj8jbZhxRaf78nC18btexROGSRvgRmwZzOsVZwHnFKPN0MSAynBcL
TIwQ8LcujpC4o923UJVXZlVgn6bPfbHDX7N6njXNtqZLWw+Y/bykbmlGxI9umovE
Qt3oOVmFqIqYJAPBVr6Gd5NYtvsjkf0l+cUomZSMuDXRxbfR7ts=
=VQSX
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
