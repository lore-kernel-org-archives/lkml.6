Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D4AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D582420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJaHmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:42:02 -0400
Received: from anholt.net ([50.246.234.109]:43772 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeJaHmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:42:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 875E610A1311;
        Tue, 30 Oct 2018 15:46:38 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hmncn9qAbbzR; Tue, 30 Oct 2018 15:46:36 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 960B310A03D5;
        Tue, 30 Oct 2018 15:46:36 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 1F60E2FE1B8E; Tue, 30 Oct 2018 15:46:36 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/3] drm: Add an hx8367d tinydrm driver.
In-Reply-To: <a3995168-3d9f-07b3-1e93-7ee5bd14e5a8@tronnes.org>
References: <20181024184313.2967-1-eric@anholt.net> <20181024184313.2967-3-eric@anholt.net> <a3995168-3d9f-07b3-1e93-7ee5bd14e5a8@tronnes.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 30 Oct 2018 15:46:34 -0700
Message-ID: <87efc7m4s5.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Noralf Tr=C3=B8nnes <noralf@tronnes.org> writes:

> Den 24.10.2018 20.43, skrev Eric Anholt:
>> I want to sort out support for tinydrm in vc4, so I needed to get a
>> tinydrm-appropriate panel working and this is what I had on hand.
>> This is derived from a combination of ili9341.c from tinydrm and
>> fb_hx8357d.c from staging's fbtft.  The register header is copied
>> directly from staging's fbtft, on the assumption that we will delete
>> that copy later.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>   MAINTAINERS                       |   7 +
>>   drivers/gpu/drm/tinydrm/Kconfig   |  11 ++
>>   drivers/gpu/drm/tinydrm/Makefile  |   1 +
>>   drivers/gpu/drm/tinydrm/hx8357d.c | 261 ++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/tinydrm/hx8357d.h |  71 ++++++++
>>   5 files changed, 351 insertions(+)
>>   create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.c
>>   create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 39c3f6682ace..e78971e20a11 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4623,6 +4623,13 @@ S:	Maintained
>>   F:	drivers/gpu/drm/tinydrm/ili9225.c
>>   F:	Documentation/devicetree/bindings/display/ilitek,ili9225.txt
>>=20=20=20
>> +DRM DRIVER FOR HX8357D PANELS
>> +M:	Eric Anholt <eric@anholt.net>
>> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>> +S:	Maintained
>> +F:	drivers/gpu/drm/tinydrm/hx8357d.c
>> +F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
>> +
>>   DRM DRIVER FOR INTEL I810 VIDEO CARDS
>>   S:	Orphan / Obsolete
>>   F:	drivers/gpu/drm/i810/
>> diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/K=
config
>> index 16f4b5c91f1b..2c408ac1a900 100644
>> --- a/drivers/gpu/drm/tinydrm/Kconfig
>> +++ b/drivers/gpu/drm/tinydrm/Kconfig
>> @@ -10,6 +10,17 @@ menuconfig DRM_TINYDRM
>>   config TINYDRM_MIPI_DBI
>>   	tristate
>>=20=20=20
>> +config TINYDRM_HX8357D
>> +	tristate "DRM support for HX8357D display panels"
>> +	depends on DRM_TINYDRM && SPI
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	select TINYDRM_MIPI_DBI
>> +	help
>> +	  DRM driver for the following HX8357D panels:
>> +	  * YX350HV15-T 3.5" 340x350 TFT (Adafruit 3.5")
>> +
>> +	  If M is selected the module will be called hx8357d.
>> +
>>   config TINYDRM_ILI9225
>>   	tristate "DRM support for ILI9225 display panels"
>>   	depends on DRM_TINYDRM && SPI
>> diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/=
Makefile
>> index 14d99080665a..f823066f7743 100644
>> --- a/drivers/gpu/drm/tinydrm/Makefile
>> +++ b/drivers/gpu/drm/tinydrm/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_TINYDRM)		+=3D core/
>>   obj-$(CONFIG_TINYDRM_MIPI_DBI)		+=3D mipi-dbi.o
>>=20=20=20
>>   # Displays
>> +obj-$(CONFIG_TINYDRM_HX8357D)		+=3D hx8357d.o
>>   obj-$(CONFIG_TINYDRM_ILI9225)		+=3D ili9225.o
>>   obj-$(CONFIG_TINYDRM_ILI9341)		+=3D ili9341.o
>>   obj-$(CONFIG_TINYDRM_MI0283QT)		+=3D mi0283qt.o
>> diff --git a/drivers/gpu/drm/tinydrm/hx8357d.c b/drivers/gpu/drm/tinydrm=
/hx8357d.c
>> new file mode 100644
>> index 000000000000..51d4da624d57
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tinydrm/hx8357d.c
>> @@ -0,0 +1,261 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * DRM driver for the HX8357D LCD controller
>> + *
>> + * Copyright 2018 Broadcom
>> + * Copyright 2018 David Lechner <david@lechnology.com>
>> + * Copyright 2016 Noralf Tr=C3=B8nnes
>> + * Copyright (C) 2015 Adafruit Industries
>> + * Copyright (C) 2013 Christian Vogelgsang
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/property.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <drm/drm_fb_helper.h>
>> +#include <drm/drm_gem_framebuffer_helper.h>
>> +#include <drm/drm_modeset_helper.h>
>> +#include <drm/tinydrm/mipi-dbi.h>
>> +#include <drm/tinydrm/tinydrm-helpers.h>
>> +#include <video/mipi_display.h>
>> +#include "hx8357d.h"
>
> I prefer to have the defines in the driver instead of an extra header fil=
e.
> The reason is that usually only a handful of defines are actually used,
> in this case it's 9.

Yeah.  Also, that license on the header is pretty sketchy.  I've written
my own defines based on reading the HX8357D spec and included it in the
driver instead.

>> +
>> +static const struct spi_device_id hx8357d_id[] =3D {
>> +	{ "hx8357d", 0 },
>
> Last time I tried, module autoloading didn't work unless this contains
> the last part of the compatible. In this case: "yx350hv15".
> Have you checked that autoloading does work?

I hadn't since I changed the compatible string to adafruit.  Thanks!

> Otherwise this looks good:
> Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvY30oACgkQtdYpNtH8
nujDcw/7B4nPmBV2vNYk/+xdfxvQvpgyWCqaVD190vGfcr/N8x52kSHfGtn0HvJ8
azQg7BMF2OcHjPXhEd2keJ3fCecqopDoUy6zfT0/Y8yV1ShzYm3FSnArgeHE6dOF
PUaqdB81XYdcGMIc4jUIgxuWt+0o4bEEj91F1+HnOUcyLW9dR6zV0TOR7+jpANAV
oXqoLWqNnnplnAvqqUZ4G4EFX9Om7vkG1rjBDJvvksDg7zEoM0Gq+xulyn4RzSP6
ynp53VuWc2kStAPOtAUMXYyw1R6d7ab6T9leB9Ny9mLO7FGfIHXqm+xzAXoGZLdM
p191iGbDH6n785BEeeRXyL0iV2fKuS5YX/ooJU/CsK2kUCKPpwJKoNXqDzA9U4LP
V2AVY8/Up80xnncq7NFmdsugFtWCD59+epnmQzamPXJNFoEpD5bihDEVHB7Quo13
3fvTaVPNd7oRbHapeZa5mt0XEgr1ZX+fEzlrvvPkzytw6VcgYXBonI994LHY0m4T
oEw6DRh5CHYs5MJLc4R8fH6jsBzcg9C2Cmc0MvNB4isRxwpoE8Vvavj6wykSwPtp
w3hemzW7ENraXmrL7lOHzyB1L3NF/XaioHMWa8JV497t35eU/DPn+1L0N6ThCaWa
Jj8v6NbYcOdEatUMXt2j0ifUeKJhNyx2AEE82zGt6wlwdy7O/qU=
=RhbB
-----END PGP SIGNATURE-----
--=-=-=--
