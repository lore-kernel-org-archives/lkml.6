Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB34C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DEE20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DEE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJBOi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:38:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41602 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeJBOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:38:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 78FB38078F; Tue,  2 Oct 2018 09:56:30 +0200 (CEST)
Date:   Tue, 2 Oct 2018 09:56:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org, Milo Kim <milo.kim@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Message-ID: <20181002075629.GB19677@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20180928182954.25446-2-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-28 13:29:46, Dan Murphy wrote:
> From: Pavel Machek <pavel@ucw.cz>
>=20
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>=20
> It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
>=20
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

So... this driver adds support for LM3532, LM3631, LM3632, LM3633,
LM3695 and LM3697 (or it did when I signed it off).

The rest of the series does not really bring any advantages (you claim
it may add advantages in future). It takes code out of common driver
and duplicates it.

Could we take this patch, get the basic support for LM3532, LM3631,
LM3632, LM3633, LM3695 and LM3697, and then split out the drivers when
we actually gain some advantage doing so (and also when the costs are
clear)?

Thanks,

								Pavel

>  drivers/leds/Kconfig             |   8 ++
>  drivers/leds/Makefile            |   1 +
>  drivers/leds/ti-lmu-led-common.c | 138 +++++++++++++++++++++++++++++++
>  drivers/leds/ti-lmu-led-common.h |  54 ++++++++++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 drivers/leds/ti-lmu-led-common.c
>  create mode 100644 drivers/leds/ti-lmu-led-common.h

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzJK0ACgkQMOfwapXb+vJPfQCeN5zfZPU7rrI6+9qKKKezKCj+
vLoAn1SVCqWQaZhDgEySYyhd3nxaxrA5
=0Ipj
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
