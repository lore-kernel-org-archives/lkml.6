Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B9A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B9A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbeKPBJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:09:53 -0500
Received: from sauhun.de ([88.99.104.3]:36872 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeKPBJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:09:52 -0500
Received: from localhost (p54B33432.dip0.t-ipconnect.de [84.179.52.50])
        by pokefinder.org (Postfix) with ESMTPSA id 29A1E3E408C;
        Thu, 15 Nov 2018 16:01:39 +0100 (CET)
Date:   Thu, 15 Nov 2018 16:01:37 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     vitor <vitor.soares@synopsys.com>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181115150137.GB4169@kunai>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20181115135731.25f60990@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.

...

> Mark, Wolfram, Arnd, Greg, any opinion?

Is there a benefit for having drivers in userspace? My gut feeling is to
encourage people to write kernel drivers. If this is, for some reason,
not possible for some driver, then we have a use case at hand to test
the then-to-be-developed userspace interface against. Until then, I
personally wouldn't waste effort on designing it without a user in
sight.

Dunno if you have that, but a debug interface (exchanging data with
clients) on the other hand would be super useful most probably. Maybe
you can start having that in debugfs and already learn from it if you
ever want to move some interface outside of debugfs?

Kind regards,

   Wolfram


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvtilEACgkQFA3kzBSg
KbZgrxAAnFddvV2JFwTmL+pCc42D4FXaCvrGViEzLVgkMVXziaNTd2fgsowj0Gdh
UZWnUbWd5YklqE4MxirpuHmsQvbYlYQ46r2eS22Xbfd/8JqdgNdRHep3jLYc4M4f
TC8MCNU4u/j0m8pGvdEvRJZpLVI5qlHUBl9rP8locXiCUrW5Tsb7AnvUdZ/Vsv39
MYC4yzGp7JZbO9LgPpHS1BRy+H3W2pQdquivQQEh1IIc/pqyehbN3c4MK23ZyBbZ
7EGHMzvM6JHcVtgV547oJLNzJ5oyzKUpyRfqO7rhHA8drdZqEsULLFVeAmL7ee+x
6GC8iYG0Fz+juySLh9Gk2c+k0gpnGBCiQZqu/kAssI/cXA+vGAMOb6WIrRrgfV6l
m3RcxTqB4IbdLVJWOMXukNF4LoJXOSNIy991K167umJF4/l17WIlhCQahMcsBUm+
HoXcPaiI7qTKhT1KHXCd6hoKz0PaRO8LMGG7ZOtJyJEPb/i+/khyNOejo2tmNO/J
aBc1kWhEwNeBMPUQynlr/hgtHQ4+fudBr5dQjJieOVNjVZLJiZQYPglIaj6sQqRv
RAmIa9erFrftKn8Wye2I5uGLG9FnljVTbtb1vfH8X2oeGIKG2VldDtHGahYBpx01
4GIH4afxFT7b1VRbbhEqouiwS29o+GKEh45yR2uOKQ8Ham8pBSQ=
=Ox07
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
