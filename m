Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22039C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD42B20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhDTR4/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD42B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeLEQOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:14:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46759 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeLEQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:14:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so17463251edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2p4NxVeCKRks82Fu1ZL9aupLTCAXGu2nF50/M2SqSA=;
        b=lhDTR4/1VwICaLYiqYtxmvj8xyzHglYJX0s5AVmYm6JiPt2wSXv24oI6aNwkyzzw+p
         3T5kQm8BRIQvWXkU24TXSl9PD0hd1pXFai5Ky9eIK+NepNLfsj1Yiu7MH30JSDNIeg65
         pwk7R+MpaaoDJMLjVpJma3icBuT1uNp6TqY4R7F15cb4MvC5ZOPflxUlU7OahOtVwWTR
         BOOinhlj256f6/B3aizkJOfAkBAp9H5VjysHKB6774rWdkaVxrUb/fr3uc8bYhsn/WBX
         Gy19+fd4TbkOr6mR390GhlqopsHl3LJT9f9f31yEyM9HCee0KW7xaq5h2AyfVEQgW0Ng
         mcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2p4NxVeCKRks82Fu1ZL9aupLTCAXGu2nF50/M2SqSA=;
        b=eW8llGV0gBoOSMFlzKyKiZRiBth6mntgTkM2YbC2v5r7xUK5ra48tTXp0k1r1DxAQP
         W5UV/MkVG5F4iM12V2LyKNkfIpCfNz3/RIzadcCmg2Wog/PKVvII6pE+3ArLqmF3f79d
         hM9ilj04MiwxAjld0MdR46GjvHet18VTdAXav8lhCmzNqFFJHokape+bit/xhh4ovAfU
         BrnveLXloc8QJ4JLijJD4gga311rPslJOFz+6ZyEq54GeRfpuVS31atA/ZKrwXKyK0fU
         WHWbBbmpgiCvdSRv8jc1HfuQJpD8vg0RT0PX/q9aNaosAZek6FJf93Jzx246RKHqFdT5
         wj8g==
X-Gm-Message-State: AA+aEWZ/ew7yyGxlWP3NAPqPWSCAayJLUijrBcatAInuyNYWqkax0vTn
        oZe7dAigXTTnueuSDlB6gOfreoS6
X-Google-Smtp-Source: AFSGD/UJF9qBd+ioAA9j8BbxRzu17IY4To8Vt//VxWj2xNSZBrJc60XMLFgoDaC/NX9aNkvxI5MvBA==
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr21395924edd.254.1544026449775;
        Wed, 05 Dec 2018 08:14:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z40sm3666471edz.86.2018.12.05.08.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:14:08 -0800 (PST)
Date:   Wed, 5 Dec 2018 17:14:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] mailbox: Device-managed registration
Message-ID: <20181205161406.GA26426@ulmo>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
 <20181128093950.GG17419@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20181128093950.GG17419@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 10:39:50AM +0100, Thierry Reding wrote:
> On Wed, Nov 21, 2018 at 03:54:10PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi,
> >=20
> > This series of patches adds device-managed registration functions for
> > mailbox controllers. A number of drivers can be simplified by making use
> > of this new API both in the error cleanup paths in their probe functions
> > and in the driver remove implementation.
> >=20
> > In addition to adding the new API this series converts all drivers to
> > use it. There is also an additional cleanup patch for the mtk-cmdq
> > driver that removes some calls to devm_kfree() that are not needed.
> >=20
> > Thierry
> >=20
> > Thierry Reding (19):
> >   mailbox: Add device-managed registration functions
> >   mailbox: arm-mhu: Use device-managed registration API
> >   mailbox: bcm2835: Use device-managed registration API
> >   mailbox: bcm-flexrm: Use device-managed registration API
> >   mailbox: bcm-pdc: Use device-managed registration API
> >   mailbox: hi3660: Use device-managed registration API
> >   mailbox: hi6220: Use device-managed registration API
> >   mailbox: imx: Use device-managed registration API
> >   mailbox: altera: Use device-managed registration API
> >   mailbox: sti: Use device-managed registration API
> >   mailbox: xgene-slimpro: Use device-managed registration API
> >   mailbox: mtk-cmdq: Use device-managed registration API
> >   mailbox: mtk-cmdq: Remove needless devm_kfree() calls
> >   mailbox: omap: Use device-managed registration API
> >   mailbox: platform-mhu: Use device-managed registration API
> >   mailbox: qcom-apcs: Use device-managed registration API
> >   mailbox: rockchip: Use device-managed registration API
> >   mailbox: stm32-ipcc: Use device-managed registration API
> >   mailbox: ti-msgmgr: Use device-managed registration API
> >=20
> >  drivers/mailbox/arm_mhu.c               | 12 +----
> >  drivers/mailbox/bcm-flexrm-mailbox.c    |  4 +-
> >  drivers/mailbox/bcm-pdc-mailbox.c       |  4 +-
> >  drivers/mailbox/bcm2835-mailbox.c       | 10 +---
> >  drivers/mailbox/hi3660-mailbox.c        | 11 +---
> >  drivers/mailbox/hi6220-mailbox.c        | 11 +---
> >  drivers/mailbox/imx-mailbox.c           |  3 +-
> >  drivers/mailbox/mailbox-altera.c        | 15 +-----
> >  drivers/mailbox/mailbox-sti.c           | 13 +----
> >  drivers/mailbox/mailbox-xgene-slimpro.c | 11 +---
> >  drivers/mailbox/mailbox.c               | 70 +++++++++++++++++++++++++
> >  drivers/mailbox/mtk-cmdq-mailbox.c      | 11 +---
> >  drivers/mailbox/omap-mailbox.c          |  4 +-
> >  drivers/mailbox/platform_mhu.c          | 12 +----
> >  drivers/mailbox/qcom-apcs-ipc-mailbox.c |  3 +-
> >  drivers/mailbox/rockchip-mailbox.c      | 15 +-----
> >  drivers/mailbox/stm32-ipcc.c            |  4 +-
> >  drivers/mailbox/ti-msgmgr.c             | 13 +----
> >  include/linux/mailbox_controller.h      |  5 ++
> >  19 files changed, 92 insertions(+), 139 deletions(-)
>=20
> Hi Jassi,
>=20
> any comments on this?

Ping!

Thierry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwH+UcACgkQ3SOs138+
s6HBdxAApeerXvF6hH2r6SUtfbkK8tzNepYbajyZzvR1H9RD4l31F1erwgiT9Ooe
Boy8Fuo182t7XJ0TARjCTLIvwfMNqQrSGtQdS68QHE5aw7iA6HBIrhtmdjcjO9Re
XfnC21VgUFZ36JLPJchyYyoMtfeyxIfrtezyFYNjlB7QTLos5RAK9d8S1Aau4B+f
lh3tSUhzuL4HBADEbEBZqwHLuCdg6D6gFTmXM1Bh/+SLa0hYHuiU/Pfnty5FDZy4
vUbHX/OFkAciySryhE6PTMUkJ1CVMHiH0qKN8bqR0HIZTFGTs3GqOqFWyZCOSihV
BkBg29qM3pkjAslIpDEj0XqDPlmnHwIKXmrUGOnNLpSm2mL766dPlq/Wi/4yl+rq
IvRRtSOza2B8zi4MwFJkFz1QTwp39XGwqGA86ffOD55Ny3JvzeOsBgXThin1sOy2
XIiJHx6MzeqJycQvf8+TiTEgUj3m2dVFO2rENOTezIhsBDSK8lmzpfcCHcqaojNB
P/a/3ZbjZJfPkdph/Wja0gpdwaPmc+LLbeCZ3kHxX0B5Vnqb/Eha+UcQCwU+pY5p
HD1i662VJVwNXVNuKXFOUhw0+cYxXkn8WleibxHZ2muIk3sYrG8HRyB78mOkXsLR
Mhs9vbnm7Gxg8hg8GYD0o/TiD9s/taeZDLfJv3rmhKsDBJmkATU=
=MR8A
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
