Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B49C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00120851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+8TNC53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfB0Kly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:41:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39952 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0Kly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:41:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so4340455wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 02:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iFQmFxd5XnzDaH0CTevS1hsblX1sSdxEwwbIMUhfbq8=;
        b=n+8TNC53fNaUzzJDkLsGqcUORQCdUok7ExG+rZvhrkzfmn7ZCjm4lu4PSZe4aZ2NBV
         U5n0ohk2LfuO4jy7D9SpCRGw4NBnbtUtEqaIogY/oZavXeanosH/u9mBt2jxN/IuhAKW
         b9+2qH/Oo8FqG617UgrsqFydqdVaY/aE8ThdeadB/z2DNZK+A87dT9hRumR2oneOtZG3
         183v88esaEzugVH1MZsRqoX9GFUMz4djilMSgpkXW67x93M8m6WXq5oPtRxfiQk9/AQI
         oDaR4v+5p+djdpVsSAQ8wSQ6oLc8Fp4IgC5/PdQIwA12sYliJFlt2v7GumUziE5wfGVl
         sdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iFQmFxd5XnzDaH0CTevS1hsblX1sSdxEwwbIMUhfbq8=;
        b=h7cjufiAx/M1gdH6uYHjtW7lxy4rsnBqDpTTC/yNRwjctVidc/QExrxHaAWtADk55I
         Tg4MVrmyXhArAMxHJpGslxbXdCGlhPyHNrcOFGneLWUY17xW/F8eQwOkepMfjSYaMvrx
         6JLbOoaFdjDzndX/l0pKu4yUiwormJKM4P0XRdPpZwsKCUqjJpxvVgP6Dtq243bdK1pg
         y8nmE9Un9gUKUrV+iANmHxOelFVFwaD4kzDQ9siWtg/goX70d0jts9MJ52NC61hJXkTt
         Bif1daAyMQNj6EEM7qE1pNKfhjBbB/MNafOj8qMAWPWfVvMI49+arSOYZuFC1P5AxR6g
         KUzQ==
X-Gm-Message-State: AHQUAuYHcxRMnBgUFLKopehd0b82VkAuuR2Spp5KAzhoHcZEojU/aBq6
        NMdnh7AGqroAVgTsu+xxxIM=
X-Google-Smtp-Source: AHgI3IYFRrdChD+YDNMmUrTZoA6zFDTKs/JdzZ7ghX9JPxnuU6rLLAbXx7m4ranylWBeMt0BpRqtuw==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr1880040wmc.31.1551264111631;
        Wed, 27 Feb 2019 02:41:51 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id f7sm14456429wru.3.2019.02.27.02.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 02:41:50 -0800 (PST)
Date:   Wed, 27 Feb 2019 11:41:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Sameer Pujar <spujar@nvidia.com>, digetx@gmail.com,
        jhogan@kernel.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: tegra: enforce PM requirement
Message-ID: <20190227104148.GA14928@ulmo>
References: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
 <20190226091308.ycruijz2lcziv5gt@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20190226091308.ycruijz2lcziv5gt@shell.armlinux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 09:13:08AM +0000, Russell King - ARM Linux admin wr=
ote:
> On Tue, Feb 26, 2019 at 01:55:37PM +0530, Sameer Pujar wrote:
> > The requirement for this came while adding runtime PM support for HDA
> > driver. There were concerns about driver explicitly handling !PM case.
> > In general, drivers need to handle !PM case with work arounds for
> > managing clocks and power explicitly, which is not really necessary
> > when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
> > platforms enforce PM support and there is no reason why this cannot be
> > done for 32-bit.
> >=20
> > More details with regards to above can be found in following patch,
> > http://patchwork.ozlabs.org/patch/1036645/
> >=20
> > This patch selects PM unconditionally and drivers can rely on runtime
> > PM framework for clock and power management.
>=20
> What if the drivers are re-used on another SoC IP?  Doesn't this lead
> to unexpected failures?

I suppose it would if the configuration doesn't enable PM. In practice I
don't think this happens very often. I'm also not aware of any of the IP
blocks in Tegra being reused on other SoCs, so I think the risk of this
happening isn't very high.

> If you want to do this, maybe also make those drivers depend on PM as
> well?

That said, I think adding the dependency on PM is good documentation and
would prevent the cases that you're describing from happening, so I'll
see to it that we get it added where needed.

I think all drivers currently support running without PM, but the code
to do it is cumbersome and highly repetitive. I think we can add the PM
dependency at the same time that we remove the !PM boilerplate.

Thierry

> > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> > index 7f3b83e..51a8fa3 100644
> > --- a/arch/arm/mach-tegra/Kconfig
> > +++ b/arch/arm/mach-tegra/Kconfig
> > @@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
> >  	select HAVE_ARM_SCU if SMP
> >  	select HAVE_ARM_TWD if SMP
> >  	select PINCTRL
> > +	select PM
> >  	select PM_OPP
> >  	select ARCH_HAS_RESET_CONTROLLER
> >  	select RESET_CONTROLLER
> > --=20
> > 2.7.4
> >=20
> >=20
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s up
> According to speedtest.net: 11.9Mbps down 500kbps up

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx2aWgACgkQ3SOs138+
s6GRnxAAoIi3Mtv92T+80o4s613ECyatQqkuTMIFOoh4UMABqRyDN954lgPQM35+
cgq8OheVftM+5hOtp8M3nI5+GWx+DYKqD6s+4dNzCm/OtJm762p8kx7Jk0hhcX4a
QQu163amohfQKbNlblfAVCwrZyrqv7uQyCpe4LrVW1Vw/rLpQAkHhPLc0EtqqmQP
Xpvs/iVOxe43yrvCTaqmNMPOvUGzgZ72tse0L90U4wP0FWlBgXtwj10wnqCMOIA1
wE96IVAFaV34cncSeKHFbr5FcR3pH598QpncKRm2fRFwlF0WoicSwMPqZfQ4YfGJ
Qpk07aeIZUbesS2/k0aTAu3Yjx6lx7lT9OS1bTz4YUcIwZGFngPlSGa8G4ZMoxNB
RG8DkKMpdlIg4dNKaRWTHkmskollQ5WEeQrmID7d/zdpyAQYB6suz1VIQ1zZ9i/p
31BFQOBVNLQJ5OonUG3EAYHpfX1cT4LJTWjYrFASb11xMt5qoMdSVW/wxu6L+Uv1
/uPSRBMIeasOanyYVJHjOxDxXwv5BJtWNv1nRJu/ANFgne/mJcBUbFPE2VGm8EyY
wOAcj8usF31zw7YI7rhaW4FSgDrUL2xebpjs6MSLa/fM5PvCzGyLtjzSiixw3G42
IB7RX3A943hrlveURV3m39uTlNdoAjORLBkQ1LMUMuUVbih1AGo=
=sjfW
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
