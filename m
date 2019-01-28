Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FF62082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smyhOxUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390673AbfA1QjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45101 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389235AbfA1QYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so12279428lfa.12;
        Mon, 28 Jan 2019 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Hg27jIP5CHtmguFv1lE5PlXBOWzxPHaZKeCjw1ORGA=;
        b=smyhOxUan3q9eEO7TR8bfjSSwLjtlj7luR0Nr1hpF6kEYdiuu1otMAVcnzTUVHPLmB
         fChMphVlAYpIRze5PSjYXnj9jtpqZI3Ag0PLkI+SsuwCjDS8K0hdA842NYuA9HeHO/nA
         UCZXbryXltyH9Mi3JaM2YFdMTrgPCNJ6Y+wrTrIqKO0m++s5lnsYTTv5e7DIwQ3MYvBG
         8yqUqn5Mat8S2zA5GvteAuyqn9RONLIhVqbrKQD9lg4XC1R3kGEmexHyFyJbeM79fPv/
         Vp0I2sIv8E0l8oSTtpjXUq24w+FPgcHUcX/JrvudW7EerKVFkaAUjzK7LX+Tw3Yefvkp
         InLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Hg27jIP5CHtmguFv1lE5PlXBOWzxPHaZKeCjw1ORGA=;
        b=dXLdJ7WTN4RXSAtbdepiYOtOlsicm4VwPmp3Y+p4sCaY/+a8A8RN3+Qu4Ophsoaeml
         eFEcYFnSy/Tv6ZuCOFGTbzfpY1b/i5df7rwkQOnaFaogOCAe0JvGdGXsKrw0iQP3HGFR
         9A8jgy1Y0T9/KRkvLk2vBtFHBPoVCejUBopLdp2ivru6KeRhJ1LwmvxTcc+OWBW8f04G
         ZesO6ZuLhRP7lbKHHoOaqcAJS7+9+zJCpptQQJY3vRg9quJeFJTEvu6gU9v8ZzHEurzi
         ztYFrja6QA4DFJBdrns1vXCefCuMwGeEPXa4SjEIx+07x+4/Fq6PE+wr+mgpPOc0Wxgt
         Cd6w==
X-Gm-Message-State: AJcUukf8PFNtEW05kZsWDen+GDGaBfTQqJWHCZD5isQb8xcMuRp7dhMM
        LU8kVmv0Sx6h6517fxLWHqY=
X-Google-Smtp-Source: ALg8bN4/gl40Wb5z5AwokWPb7WYe9AeF3O+pe9gpvWjo6KUbopn/fIv7mIdFzyz9dXe7jB3pkHu2sQ==
X-Received: by 2002:a19:a411:: with SMTP id q17mr16997927lfc.160.1548692672959;
        Mon, 28 Jan 2019 08:24:32 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:ed06:b4f0:d2de:7b0f])
        by smtp.gmail.com with ESMTPSA id j9sm3015142lfk.74.2019.01.28.08.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:24:32 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Date:   Mon, 28 Jan 2019 17:24:30 +0100
Message-ID: <2907728.QhjCB61z50@acerlaptop>
In-Reply-To: <d34b1458-70ac-68ab-93a6-75da2227ce83@samsung.com>
References: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com> <20190125164645.19208-2-pawel.mikolaj.chmiel@gmail.com> <d34b1458-70ac-68ab-93a6-75da2227ce83@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On poniedzia=C5=82ek, 28 stycznia 2019 14:47:41 CET Andrzej Hajda wrote:
> Hi Pawe=C5=82,
>=20
> Nice work.
>=20
> I agree with most Sam's comments (maybe expect DRM_DEV_* logging - I am
> not sure if we need concurrent logging facility).
>=20
> I'd like to add few more comments:
>=20
>=20
>=20
> On 25.01.2019 17:46, Pawe=C5=82 Chmiel wrote:
> > This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> > spi. It's based on already removed, non dt s6e63m0 driver and
> > panel-samsung-ld9040. There is possibility to choose one from 3
> > different gamma tables.
> > It can be found for example in some of Samsung Aries based phones.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/Kconfig                 |   7 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 712 ++++++++++++++++++
> >  3 files changed, 720 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index 3f3537719beb..4a4b64f74e70 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -82,6 +82,13 @@ config DRM_PANEL_SAMSUNG_LD9040
> >  	depends on OF && SPI
> >  	select VIDEOMODE_HELPERS
> > =20
> > +config DRM_PANEL_SAMSUNG_S6E63M0
> > +	tristate "Samsung S6E63M0 RGB/SPI panel"
> > +	depends on OF
> > +	depends on SPI
> > +	depends on BACKLIGHT_CLASS_DEVICE
> > +	select VIDEOMODE_HELPERS
> > +
> >  config DRM_PANEL_LG_LG4573
> >  	tristate "LG4573 RGB/SPI panel"
> >  	depends on OF && SPI
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Mak=
efile
> > index 4396658a7996..3e5d53fdee47 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) +=3D =
panel-raspberrypi-touchscreen
> >  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) +=3D panel-raydium-rm68200.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) +=3D panel-samsung-ld9040.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) +=3D panel-samsung-s6d16d0.o
> > +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) +=3D panel-samsung-s6e63m0.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) +=3D panel-samsung-s6e3ha2.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) +=3D panel-samsung-s6e63j0x=
03.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) +=3D panel-samsung-s6e8aa0.o
> > diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gp=
u/drm/panel/panel-samsung-s6e63m0.c
> > new file mode 100644
> > index 000000000000..cb5c090621ad
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> > @@ -0,0 +1,712 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * S6E63M0 AMOLED LCD drm_panel driver.
> > + *
> > + * Copyright (C) 2019 Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.co=
m>
> > + * Derived from drivers/gpu/drm/panel-samsung-ld9040.c
> > + *
> > + * Andrzej Hajda <a.hajda@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
>=20
>=20
> You do not need license 'body' if SPDX is in use.
>=20
>=20
> > + */
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <video/mipi_display.h>
> > +#include <video/of_videomode.h>
> > +#include <video/videomode.h>
> > +
> > +/* Manufacturer Command Set */
> > +#define MCS_STAND_BY_OFF                0x11
>=20
> MIPI_DCS_EXIT_SLEEP_MODE
>=20
> > +#define MCS_DISPLAY_ON                  0x29
> MIPI_DCS_SET_DISPLAY_ON
> > +#define MCS_ELVSS_ON                0xb1
> > +#define MCS_ACL_CTRL                0xc0
> > +#define MCS_DISPLAY_CONDITION   0xf2
> > +#define MCS_ETC_CONDITION           0xf6
> > +#define MCS_PANEL_CONDITION         0xF8
> > +#define MCS_GAMMA_CTRL              0xfa
> > +
> > +#define MAX_GAMMA_LEVEL             11
>=20
>=20
> GAMMA_LEVEL_COUNT or NUM_GAMMA_LEVELS ?
Ok, NUM_GAMMA_LEVELS looks better.
>=20
>=20
> > +#define GAMMA_TABLE_COUNT           23
> > +
> > +#define MAX_BRIGHTNESS              (MAX_GAMMA_LEVEL - 1)
> > +#define GAMMA_MODE_22               0
> > +#define GAMMA_MODE_19               1
> > +#define GAMMA_MODE_17               2
> > +
> > +/* array of gamma tables for gamma value 2.2 */
> > +static u8 const s6e63m0_gamma_22[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] =
=3D {
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x78, 0xEC, 0x3D, 0xC8,
> > +	  0xC2, 0xB6, 0xC4, 0xC7, 0xB6, 0xD5, 0xD7,
> > +	  0xCC, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x73, 0x4A, 0x3D, 0xC0,
> > +	  0xC2, 0xB1, 0xBB, 0xBE, 0xAC, 0xCE, 0xCF,
> > +	  0xC5, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x70, 0x51, 0x3E, 0xBF,
> > +	  0xC1, 0xAF, 0xB9, 0xBC, 0xAB, 0xCC, 0xCC,
> > +	  0xC2, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x6C, 0x54, 0x3A, 0xBC,
> > +	  0xBF, 0xAC, 0xB7, 0xBB, 0xA9, 0xC9, 0xC9,
> > +	  0xBE, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x69, 0x54, 0x37, 0xBB,
> > +	  0xBE, 0xAC, 0xB4, 0xB7, 0xA6, 0xC7, 0xC8,
> > +	  0xBC, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x66, 0x55, 0x34, 0xBA,
> > +	  0xBD, 0xAB, 0xB1, 0xB5, 0xA3, 0xC5, 0xC6,
> > +	  0xB9, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x63, 0x53, 0x31, 0xB8,
> > +	  0xBC, 0xA9, 0xB0, 0xB5, 0xA2, 0xC4, 0xC4,
> > +	  0xB8, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x62, 0x54, 0x30, 0xB9,
> > +	  0xBB, 0xA9, 0xB0, 0xB3, 0xA1, 0xC1, 0xC3,
> > +	  0xB7, 0x00, 0x91, 0x00, 0x95, 0x00, 0xDA },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x66, 0x58, 0x34, 0xB6,
> > +	  0xBA, 0xA7, 0xAF, 0xB3, 0xA0, 0xC1, 0xC2,
> > +	  0xB7, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x64, 0x56, 0x33, 0xB6,
> > +	  0xBA, 0xA8, 0xAC, 0xB1, 0x9D, 0xC1, 0xC1,
> > +	  0xB7, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x5f, 0x50, 0x2d, 0xB6,
> > +	  0xB9, 0xA7, 0xAd, 0xB1, 0x9f, 0xbe, 0xC0,
> > +	  0xB5, 0x00, 0xa0, 0x00, 0xa4, 0x00, 0xdb },
> > +};
> > +
> > +/* array of gamma tables for gamma value 1.9 */
> > +static u8 const s6e63m0_gamma_19[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] =
=3D {
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x84, 0x45, 0x4F, 0xCA,
> > +	  0xCB, 0xBC, 0xC9, 0xCB, 0xBC, 0xDA, 0xDA,
> > +	  0xD0, 0x00, 0x35, 0x00, 0x34, 0x00, 0x4E },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x74, 0x60, 0x4A, 0xC3,
> > +	  0xC6, 0xB5, 0xBF, 0xC3, 0xB2, 0xD2, 0xD3,
> > +	  0xC8, 0x00, 0x5B, 0x00, 0x5B, 0x00, 0x81 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x6F, 0x65, 0x46, 0xC2,
> > +	  0xC4, 0xB3, 0xBF, 0xC2, 0xB2, 0xCF, 0xD1,
> > +	  0xC6, 0x00, 0x64, 0x00, 0x64, 0x00, 0x8D },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x6E, 0x65, 0x45, 0xC0,
> > +	  0xC3, 0xB2, 0xBA, 0xBE, 0xAE, 0xCD, 0xD0,
> > +	  0xC4, 0x00, 0x70, 0x00, 0x70, 0x00, 0x9C },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x69, 0x64, 0x40, 0xBF,
> > +	  0xC1, 0xB0, 0xB9, 0xBE, 0xAD, 0xCB, 0xCD,
> > +	  0xC2, 0x00, 0x7A, 0x00, 0x7B, 0x00, 0xAA },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x68, 0x64, 0x3F, 0xBE,
> > +	  0xC0, 0xB0, 0xB6, 0xBB, 0xAB, 0xC8, 0xCB,
> > +	  0xBF, 0x00, 0x85, 0x00, 0x86, 0x00, 0xB8 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x68, 0x64, 0x40, 0xBC,
> > +	  0xBF, 0xAF, 0xB4, 0xBA, 0xA9, 0xC8, 0xCA,
> > +	  0xBE, 0x00, 0x8B, 0x00, 0x8C, 0x00, 0xC0 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x67, 0x64, 0x3F, 0xBB,
> > +	  0xBE, 0xAD, 0xB3, 0xB9, 0xA7, 0xC8, 0xC9,
> > +	  0xBE, 0x00, 0x90, 0x00, 0x92, 0x00, 0xC8 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x63, 0x61, 0x3B, 0xBA,
> > +	  0xBE, 0xAC, 0xB3, 0xB8, 0xA7, 0xC6, 0xC8,
> > +	  0xBD, 0x00, 0x96, 0x00, 0x98, 0x00, 0xCF },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x61, 0x60, 0x39, 0xBB,
> > +	  0xBE, 0xAD, 0xB2, 0xB6, 0xA6, 0xC5, 0xC7,
> > +	  0xBD, 0x00, 0x9B, 0x00, 0x9E, 0x00, 0xD5 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x61, 0x5F, 0x39, 0xBA,
> > +	  0xBD, 0xAD, 0xB1, 0xB6, 0xA5, 0xC4, 0xC5,
> > +	  0xBC, 0x00, 0xA0, 0x00, 0xA4, 0x00, 0xDB },
> > +};
> > +
> > +/* array of gamma tables for gamma value 1.7 */
> > +static u8 const s6e63m0_gamma_17[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] =
=3D {
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x8F, 0x73, 0x63, 0xD1,
> > +	  0xD0, 0xC5, 0xCC, 0xD1, 0xC2, 0xDE, 0xE0,
> > +	  0xD6, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x82, 0x7A, 0x5B, 0xC8,
> > +	  0xCB, 0xBD, 0xC5, 0xCA, 0xBA, 0xD6, 0xD8,
> > +	  0xCE, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x81, 0x7B, 0x5D, 0xC6,
> > +	  0xCA, 0xBB, 0xC3, 0xC7, 0xB8, 0xD6, 0xD8,
> > +	  0xCD, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x7B, 0x77, 0x58, 0xC3,
> > +	  0xC8, 0xB8, 0xC2, 0xC6, 0xB6, 0xD3, 0xD4,
> > +	  0xCA, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x75, 0x77, 0x54, 0xC3,
> > +	  0xC7, 0xB7, 0xC0, 0xC3, 0xB4, 0xD1, 0xD3,
> > +	  0xC9, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x72, 0x75, 0x51, 0xC2,
> > +	  0xC6, 0xB5, 0xBF, 0xC1, 0xB3, 0xCE, 0xD1,
> > +	  0xC6, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x71, 0x73, 0x4F, 0xC2,
> > +	  0xC5, 0xB5, 0xBD, 0xC0, 0xB2, 0xCD, 0xD1,
> > +	  0xC5, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x71, 0x72, 0x4F, 0xC2,
> > +	  0xC4, 0xB5, 0xBB, 0xBF, 0xB0, 0xCC, 0xCF,
> > +	  0xC3, 0x00, 0x91, 0x00, 0x95, 0x00, 0xCA },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x72, 0x72, 0x50, 0xC0,
> > +	  0xC3, 0xB4, 0xB9, 0xBE, 0xAE, 0xCC, 0xCF,
> > +	  0xC4, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x71, 0x71, 0x50, 0xBF,
> > +	  0xC2, 0xB2, 0xBA, 0xBE, 0xAE, 0xCB, 0xCD,
> > +	  0xC3, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
> > +	{ MCS_GAMMA_CTRL, 0x00,
> > +	  0x18, 0x08, 0x24, 0x70, 0x70, 0x4F, 0xBF,
> > +	  0xC2, 0xB2, 0xB8, 0xBC, 0xAC, 0xCB, 0xCD,
> > +	  0xC3, 0x00, 0xA0, 0x00, 0xA4, 0x00, 0xDB },
> > +};
> > +
> > +#define S6E63M0_STATE_BIT_ENABLED       0
> > +
> > +struct s6e63m0 {
> > +	struct device *dev;
> > +	struct drm_panel panel;
> > +
> > +	struct regulator_bulk_data supplies[2];
> > +	struct gpio_desc *reset_gpio;
> > +	u32 power_on_delay;
> > +	u32 power_off_delay;
> > +	u32 reset_delay;
> > +	struct videomode vm;
> > +	u32 width_mm;
> > +	u32 height_mm;
> > +
> > +	unsigned long state;
> > +	unsigned int gamma_mode;
> > +	int brightness;
> > +
> > +	/* This field is tested by functions directly accessing bus before
> > +	 * transfer, transfer is skipped if it is set. In case of transfer
> > +	 * failure or unexpected response the field is set to error value.
> > +	 * Such construct allows to eliminate many checks in higher level
> > +	 * functions.
> > +	 */
> > +	int error;
> > +};
> > +
> > +static inline struct s6e63m0 *panel_to_s6e63m0(struct drm_panel *panel)
> > +{
> > +	return container_of(panel, struct s6e63m0, panel);
> > +}
> > +
> > +static int s6e63m0_clear_error(struct s6e63m0 *ctx)
> > +{
> > +	int ret =3D ctx->error;
> > +
> > +	ctx->error =3D 0;
> > +	return ret;
> > +}
> > +
> > +static int s6e63m0_spi_write_word(struct s6e63m0 *ctx, u16 data)
> > +{
> > +	struct spi_device *spi =3D to_spi_device(ctx->dev);
> > +	struct spi_transfer xfer =3D {
> > +		.len	=3D 2,
> > +		.tx_buf =3D &data,
> > +	};
> > +	struct spi_message msg;
> > +
> > +	spi_message_init(&msg);
> > +	spi_message_add_tail(&xfer, &msg);
> > +
> > +	return spi_sync(spi, &msg);
> > +}
> > +
> > +static void s6e63m0_dcs_write(struct s6e63m0 *ctx, const u8 *data, siz=
e_t len)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (ctx->error < 0 || len =3D=3D 0)
> > +		return;
> > +
> > +	dev_dbg(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
> > +	ret =3D s6e63m0_spi_write_word(ctx, *data);
> > +
> > +	while (!ret && --len) {
> > +		++data;
> > +		ret =3D s6e63m0_spi_write_word(ctx, *data | 0x100);
> > +	}
> > +
> > +	if (ret) {
> > +		dev_err(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
> > +			(int)len, data);
> > +		ctx->error =3D ret;
> > +	}
> > +
> > +	usleep_range(300, 310);
> > +}
> > +
> > +#define s6e63m0_dcs_write_seq_static(ctx, seq ...) \
> > +	({ \
> > +		static const u8 d[] =3D { seq }; \
> > +		s6e63m0_dcs_write(ctx, d, ARRAY_SIZE(d)); \
> > +	})
> > +
> > +static void s6e63m0_brightness_set(struct s6e63m0 *ctx)
> > +{
> > +	/* disable and set new gamma */
> > +	switch (ctx->gamma_mode) {
> > +	case GAMMA_MODE_22:
> > +		s6e63m0_dcs_write(ctx,
> > +				  s6e63m0_gamma_22[ctx->brightness],
> > +				  ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness])
> > +				  );
> > +		break;
> > +	case GAMMA_MODE_19:
> > +		s6e63m0_dcs_write(ctx,
> > +				  s6e63m0_gamma_19[ctx->brightness],
> > +				  ARRAY_SIZE(s6e63m0_gamma_19[ctx->brightness])
> > +				  );
> > +		break;
> > +	case GAMMA_MODE_17:
> > +		s6e63m0_dcs_write(ctx,
> > +				  s6e63m0_gamma_17[ctx->brightness],
> > +				  ARRAY_SIZE(s6e63m0_gamma_17[ctx->brightness])
> > +				  );
> > +		break;
> > +	default:
> > +		dev_info(ctx->dev,
> > +			 "gamma mode could be 0:2.2, 1:1.9 or 2:1.7.Assuming 2.2\n"
> > +			 );
> > +		s6e63m0_dcs_write(ctx,
> > +				  s6e63m0_gamma_22[ctx->brightness],
> > +				  ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness])
> > +				  );
> > +		break;
> > +	}
> > +
> > +	/* update gamma table. */
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL, 0x01);
> > +}
> > +
> > +static void s6e63m0_init(struct s6e63m0 *ctx)
> > +{
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_PANEL_CONDITION,
> > +				     0x01, 0x27, 0x27, 0x07, 0x07, 0x54, 0x9f,
> > +				     0x63, 0x86, 0x1a, 0x33, 0x0d, 0x00, 0x00);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_CONDITION,
> > +				     0x02, 0x03, 0x1c, 0x10, 0x10);
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xf7,
> > +				     0x03, 0x00, 0x00);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
> > +				     0x00, 0x18, 0x08, 0x24, 0x64, 0x56, 0x33,
> > +				     0xb6, 0xba, 0xa8, 0xac, 0xb1, 0x9d, 0xc1,
> > +				     0xc1, 0xb7, 0x00, 0x9c, 0x00, 0x9f, 0x00,
> > +				     0xd6);
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
> > +				     0x01);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_ETC_CONDITION,
> > +				     0x00, 0x8c, 0x07);
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xb3,
> > +				     0xc);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xb5,
> > +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> > +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> > +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> > +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> > +				     0x21, 0x20, 0x1e, 0x1e);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xb6,
> > +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
> > +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
> > +				     0x66, 0x66);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xb7,
> > +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> > +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> > +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> > +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> > +				     0x21, 0x20, 0x1e, 0x1e, 0x00, 0x00, 0x11,
> > +				     0x22, 0x33, 0x44, 0x44, 0x44, 0x55, 0x55,
> > +				     0x66, 0x66, 0x66, 0x66, 0x66, 0x66);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xb9,
> > +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> > +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> > +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> > +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> > +				     0x21, 0x20, 0x1e, 0x1e);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xba,
> > +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
> > +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
> > +				     0x66, 0x66);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xc1,
> > +				     0x4d, 0x96, 0x1d, 0x00, 0x00, 0x01, 0xdf,
> > +				     0x00, 0x00, 0x03, 0x1f, 0x00, 0x00, 0x00,
> > +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x06,
> > +				     0x09, 0x0d, 0x0f, 0x12, 0x15, 0x18);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, 0xb2,
> > +				     0x10, 0x10, 0x0b, 0x05);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_ACL_CTRL,
> > +				     0x01);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_ELVSS_ON,
> > +				     0x0b);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_STAND_BY_OFF);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_ON);
> > +
> > +	s6e63m0_brightness_set(ctx);
> > +}
> > +
> > +static int s6e63m0_power_on(struct s6e63m0 *ctx)
> > +{
> > +	int ret;
> > +
> > +	ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplie=
s);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	msleep(ctx->power_on_delay);
> > +
> > +	gpiod_set_value(ctx->reset_gpio, 1);
> > +	msleep(ctx->reset_delay);
> > +	gpiod_set_value(ctx->reset_gpio, 0);
> > +	msleep(ctx->reset_delay);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_power_off(struct s6e63m0 *ctx)
> > +{
> > +	msleep(ctx->power_off_delay);
> > +
> > +	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplie=
s);
> > +}
> > +
> > +static int s6e63m0_disable(struct drm_panel *panel)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_unprepare(struct drm_panel *panel)
> > +{
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +
> > +	clear_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
> > +
> > +	s6e63m0_clear_error(ctx);
> > +
> > +	return s6e63m0_power_off(ctx);
> > +}
> > +
> > +static int s6e63m0_prepare(struct drm_panel *panel)
> > +{
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +	int ret;
> > +
> > +	ret =3D s6e63m0_power_on(ctx);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	s6e63m0_init(ctx);
> > +
> > +	ret =3D s6e63m0_clear_error(ctx);
> > +
> > +	if (ret < 0)
> > +		s6e63m0_unprepare(panel);
> > +	else
> > +		set_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state);
> > +
> > +	return ret;
> > +}
> > +
> > +static int s6e63m0_enable(struct drm_panel *panel)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_get_modes(struct drm_panel *panel)
> > +{
> > +	struct drm_connector *connector =3D panel->connector;
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +	struct drm_display_mode *mode;
> > +
> > +	mode =3D drm_mode_create(connector->dev);
> > +	if (!mode) {
> > +		DRM_ERROR("failed to create a new display mode\n");
> > +		return 0;
> > +	}
> > +
> > +	drm_display_mode_from_videomode(&ctx->vm, mode);
> > +	mode->width_mm =3D ctx->width_mm;
> > +	mode->height_mm =3D ctx->height_mm;
> > +	connector->display_info.width_mm =3D mode->width_mm;
> > +	connector->display_info.height_mm =3D mode->height_mm;
> > +
> > +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> > +	mode->flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC;
> > +	drm_mode_probed_add(connector, mode);
> > +
> > +	return 1;
> > +}
> > +
> > +static const struct drm_panel_funcs s6e63m0_drm_funcs =3D {
> > +	.disable	=3D s6e63m0_disable,
> > +	.unprepare	=3D s6e63m0_unprepare,
> > +	.prepare	=3D s6e63m0_prepare,
> > +	.enable		=3D s6e63m0_enable,
> > +	.get_modes	=3D s6e63m0_get_modes,
> > +};
> > +
> > +static int s6e63m0_get_brightness(struct backlight_device *bd)
> > +{
> > +	return bd->props.brightness;
> > +}
>=20
>=20
> This callback can be omitted AFAIK.
>=20
>=20
> > +
> > +static int s6e63m0_set_brightness(struct backlight_device *bd)
> > +{
> > +	struct s6e63m0 *ctx =3D bl_get_data(bd);
> > +
> > +	bd->props.power =3D FB_BLANK_UNBLANK;
> > +	if (ctx->brightness !=3D bd->props.brightness) {
> > +		ctx->brightness =3D bd->props.brightness;
> > +		if (test_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state))
> > +			s6e63m0_brightness_set(ctx);
>=20
>=20
> It is racy: one thread setting brightness, another disabling panel,
> nasty timings and we have attempt to send data to disabled panel.
>=20
> I do not know backlight framework too much but it does not integrate
> well with drm's IMO.
>=20
> I guess some solution would be to add mutex protecting from concurrent
> hw accesses from drm and backlight APIs.
Ok, will try to fix this. I've based my work on other (already existing) dr=
ivers,
so it looks like they have similar issue.
>=20
>=20
> > +	}
> > +
> > +	return s6e63m0_clear_error(ctx);
> > +}
> > +
> > +static const struct backlight_ops s6e63m0_backlight_ops =3D {
> > +	.get_brightness =3D s6e63m0_get_brightness,
> > +	.update_status	=3D s6e63m0_set_brightness,
> > +};
> > +
> > +static void s6e63m0_backlight_register(struct s6e63m0 *ctx)
> > +{
> > +	struct backlight_properties props =3D {
> > +		.type		=3D BACKLIGHT_RAW,
> > +		.brightness	=3D ctx->brightness,
> > +		.max_brightness =3D MAX_BRIGHTNESS
> > +	};
> > +	struct device *dev =3D ctx->dev;
> > +	struct backlight_device *bd;
> > +
> > +	bd =3D devm_backlight_device_register(dev, "panel", dev, ctx,
> > +					    &s6e63m0_backlight_ops, &props);
> > +	if (IS_ERR(bd))
> > +		dev_err(dev, "error registering backlight device (%ld)\n",
> > +			PTR_ERR(bd));
> > +}
> > +
> > +
> > +static ssize_t s6e63m0_sysfs_gamma_mode_show(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	struct s6e63m0 *ctx =3D dev_get_drvdata(dev);
> > +	char temp[10];
> > +
> > +	switch (ctx->gamma_mode) {
> > +	case GAMMA_MODE_22:
> > +		sprintf(temp, "2.2 mode\n");
> > +		strcat(buf, temp);
> > +		break;
> > +	case GAMMA_MODE_19:
> > +		sprintf(temp, "1.9 mode\n");
> > +		strcat(buf, temp);
> > +		break;
> > +	case GAMMA_MODE_17:
> > +		sprintf(temp, "1.7 mode\n");
> > +		strcat(buf, temp);
> > +		break;
> > +	default:
> > +		dev_info(dev, "gamma mode could be 0:2.2, 1:1.9 or 2:1.7)n");
> > +		break;
> > +	}
> > +
> > +	return strlen(buf);
> > +}
> > +
> > +static ssize_t s6e63m0_sysfs_gamma_mode_store(struct device *dev,
> > +					      struct device_attribute *attr,
> > +					      const char *buf, size_t len)
> > +{
> > +	struct s6e63m0 *ctx =3D dev_get_drvdata(dev);
> > +	int rc;
> > +
> > +	rc =3D kstrtouint(buf, 0, &ctx->gamma_mode);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	s6e63m0_brightness_set(ctx);
> > +	return len;
> > +}
> > +
> > +static DEVICE_ATTR(gamma_mode, 0644,
> > +		   s6e63m0_sysfs_gamma_mode_show,
> > +		   s6e63m0_sysfs_gamma_mode_store);
>=20
>=20
> I see this attribute was copied from vendor code, but it is still
> unclear how it was used there. Have you seen userspace code that used
> this property?
>=20
No, i didn't saw (yet) any userspace code settings this. I've tried to make
this driver contain the same functionality as previous one.
I'll remove it and leave only 2.2 gamma.
>=20
> > +
> > +static int s6e63m0_parse_dt(struct s6e63m0 *ctx)
> > +{
> > +	struct device *dev =3D ctx->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	int ret;
> > +
> > +	ret =3D of_get_videomode(np, &ctx->vm, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D of_property_read_u32(np, "power-on-delay", &ctx->power_on_del=
ay);
> > +	if (ret) {
> > +		dev_info(ctx->dev, "using default power-on-delay of 25ms");
> > +		ctx->power_on_delay =3D 25;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(np, "power-off-delay",
> > +				   &ctx->power_off_delay);
> > +	if (ret) {
> > +		dev_info(ctx->dev, "using default power-of-delay of 200ms");
> > +		ctx->power_off_delay =3D 200;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(np, "reset-delay", &ctx->reset_delay);
> > +	if (ret) {
> > +		dev_info(ctx->dev, "using default reset-delay of 120ms");
> > +		ctx->reset_delay =3D 120;
> > +	}
> > +
> > +	of_property_read_u32(np, "panel-width-mm", &ctx->width_mm);
> > +	of_property_read_u32(np, "panel-height-mm", &ctx->height_mm);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_probe(struct spi_device *spi)
> > +{
> > +	struct device *dev =3D &spi->dev;
> > +	struct s6e63m0 *ctx;
> > +	int ret;
> > +
> > +	ctx =3D devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	spi_set_drvdata(spi, ctx);
> > +
> > +	ctx->dev =3D dev;
> > +	ctx->brightness =3D MAX_BRIGHTNESS;
> > +	ctx->gamma_mode =3D GAMMA_MODE_22;
> > +
> > +	ret =3D s6e63m0_parse_dt(ctx);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->supplies[0].supply =3D "vdd3";
> > +	ctx->supplies[1].supply =3D "vci";
> > +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> > +				      ctx->supplies);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get regulators: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>=20
>=20
> Shouldn't be set to GPIOD_OUT_HIGH? And declared as active low?
This (and overall reset handling mentioned by Sam) will be fixed.
>=20
>=20
> > +	if (IS_ERR(ctx->reset_gpio)) {
> > +		dev_err(dev, "cannot get reset-gpios %ld\n",
> > +			PTR_ERR(ctx->reset_gpio));
> > +		return PTR_ERR(ctx->reset_gpio);
> > +	}
> > +
> > +	spi->bits_per_word =3D 9;
> > +	spi->mode =3D SPI_MODE_3;
> > +	ret =3D spi_setup(spi);
> > +	if (ret < 0) {
> > +		dev_err(dev, "spi setup failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D device_create_file(dev, &dev_attr_gamma_mode);
> > +	if (ret < 0)
> > +		dev_err(dev, "failed to add sysfs entries\n");
> > +
> > +	drm_panel_init(&ctx->panel);
> > +	ctx->panel.dev =3D dev;
> > +	ctx->panel.funcs =3D &s6e63m0_drm_funcs;
> > +
> > +	ret =3D drm_panel_add(&ctx->panel);
> > +	if (ret < 0)
> > +		goto err_remove_file;
> > +
> > +	s6e63m0_backlight_register(ctx);
> > +
> > +	return 0;
> > +
> > +err_remove_file:
> > +	device_remove_file(dev, &dev_attr_gamma_mode);
> > +
> > +	return ret;
> > +}
> > +
> > +static int s6e63m0_remove(struct spi_device *spi)
> > +{
> > +	struct s6e63m0 *ctx =3D spi_get_drvdata(spi);
> > +
> > +	s6e63m0_power_off(ctx);
>=20
>=20
> Power should be controlled by drm, of course the problem is that drm
> still does not know that panel is during removal, maybe it will be fixed
> in near future.  I guess you can remove the line above, and hope the
> issue will be fixed in drm core.
>=20
>=20
> Regards
>=20
> Andrzej
>=20
>=20
> > +	drm_panel_remove(&ctx->panel);
> > +	device_remove_file(ctx->dev, &dev_attr_gamma_mode);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id s6e63m0_of_match[] =3D {
> > +	{ .compatible =3D "samsung,s6e63m0" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, s6e63m0_of_match);
> > +
> > +static struct spi_driver s6e63m0_driver =3D {
> > +	.probe			=3D s6e63m0_probe,
> > +	.remove			=3D s6e63m0_remove,
> > +	.driver			=3D {
> > +		.name		=3D "panel-samsung-s6e63m0",
> > +		.of_match_table =3D s6e63m0_of_match,
> > +	},
> > +};
> > +module_spi_driver(s6e63m0_driver);
> > +
> > +MODULE_AUTHOR("Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>");
> > +MODULE_DESCRIPTION("s6e63m0 LCD Driver");
> > +MODULE_LICENSE("GPL v2");
>=20
>=20
>=20
Thanks for review



