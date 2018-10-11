Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB87C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA6520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jaqywtzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA6520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJKUnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:43:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJKUnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wiisUMoB78VnRUVb0aR+wG/PIyXiqTPy3WOvms8qn8Y=; b=jaqywtzB7jLndd2k6Gz3BSpMu
        MtW/1HiEKpwkxaAuQsm+KY890mIziOc4kDPgGYtJZKJbrFyHhBi1aa5Bbml/o/dUT/et+HXldJzAU
        /dAuwYfaQjPuxZb2frc4VM29WalzlU63IAyKJankBIJxLsoKBVNUIFuLWk/yPdsHEOs9Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAaoT-0001et-57; Thu, 11 Oct 2018 13:15:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7767B11223ED; Thu, 11 Oct 2018 14:15:36 +0100 (BST)
Date:   Thu, 11 Oct 2018 14:15:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Message-ID: <20181011131536.GA25351@sirena.org.uk>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <20181011094701eucas1p2177080d98481b4d4ebcfad9960d7dd97~chNSImIbW1044610446eucas1p2Q@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20181011094701eucas1p2177080d98481b4d4ebcfad9960d7dd97~chNSImIbW1044610446eucas1p2Q@eucas1p2.samsung.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 11:46:59AM +0200, Marek Szyprowski wrote:
> On 2018-10-11 11:29, Linus Walleij wrote:
> > On Thu, Oct 11, 2018 at 11:01 AM Marek Szyprowski

> >> I've just noticed that this patch causes regression on Samsung
> >> Exynos4412-based Trats2 board. Conversion to GPIO descriptor breaks
> >> operation when regulators used shared GPIO:  sii9234 i2c driver
> >> is not able to get vcc33mhl regulator (it uses shared GPIO enable
> >> line with vsil12 regulator).

> > So I guess this means that this physical GPIO line will enable the
> > vcc33mhl and the vsil12 regulators at the same time?

> Right. It is so common case, that regulator core has special code for
> handling shared enable GPIO.

Yes, and we've discussed it several times already.

> > I was aware of the usecase "several consumers takes the same
> > GPIO line" (Mark told me several times...) so it was in the back of
> > my mind, but it's just hard to see when we were gonna run into it.
> > So it is the fixed regulators, on Samsung boards, I see.

> I don't think this is Samsung specific. I saw similar solution on various
> other boards too. Sharing enable gpio is rather common thing. The issue
> happens if there are separate drivers for each hw block and they need to
> enable it from their code.

It's really common, yeah - things like controlling the power for an
entire chip with one GPIO for all the regulators supplying that chip for
example.  I think what you're seeing here is that Samsung are among the
most active testers of -next (thanks!) rather than that their hardware
is particularly weird.

> > So I was thinking to introduce
> > gpiod_get_nonexclusive() to explicitly handle this case for the few
> > systems that use shared GPIO lines, let me see what I can do.

> The old interface also didn't allow sharing GPIO easily, so regulator
> core has special code for shared enable gpio. However I still have no
> idea how to do this cleanly using descriptor.

Yes, it's been discussed several times and I thought Linus had some idea
for it - IIRC it was a gpiod_is_equal() or something.  You can also do
this by converting descriptors back to numbers and comparing the numbers
but obviously the numbers are supposed to be being removed.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/TPIACgkQJNaLcl1U
h9D05Qf9FpuZ2XrDAw5QBvxw1FOhVUT9lextbm3jYOcZReoxMZDw8hjz8Xbj7NnP
QCprq5UrfQoqIJ+WUYDfsLj2fZSugrLLTTckjPF9T2TlAOa+6XKI01tfJvU0yp1p
GieLF0vCeU6Xi9lAlCNqa1ll20433ubr9wr6uhqEb9qgP3aTaOq5likBnTcoghfD
1iwWyr+5ZhdI7hAm5EdUhqXBk89Wzn5nQr1/nlqWpRIigxv01D1XVwyNLcZLuWdJ
vha1ocBj291/IktTWhfHNJhEfOcJuBcEdLG+bIsNRvr5F0MCvw5K/KOr/cwVLIsC
afRHotQXV+Z49dvryJPNGAhgeIr/Sw==
=Vvp8
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
