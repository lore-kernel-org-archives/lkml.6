Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335F221A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxlFmadz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfBKQH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:07:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34378 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfBKQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:07:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so2732393lfu.1;
        Mon, 11 Feb 2019 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2RpYKE6AoZfM2oyTIn54uYtFYA406+LkMirlxNaEtA=;
        b=SxlFmadzhDsbXkYcEsiO9ATYVsq4QQejAqwKMIoZdDqDDwGobLjVslfoNG4IVbMdQ0
         THpgzl27gDkyPkhD3OqTsPdSyjO0N/V4X7/1AUSvZgsWmvEonKHxkjLiyHDN5xxInP/f
         XaM2w3+n3r6H6aFKVXfRxIc40RTwbSajXRkK3iOBSmbgyfciOPySiHnGha5hujgQ2Bio
         GbAjfxLfDDYIo/Nz7vT/uaTuLyYvCPB/8A03169xr11Z8OofBfANHLWJqYn+tHJxJLCY
         MS0ASKgdFwm/75Cm0skwHaWErvBC53fPVpY9vt4BU1zJ4Wz3gGqyDKpHcf3JpshswPsY
         isvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2RpYKE6AoZfM2oyTIn54uYtFYA406+LkMirlxNaEtA=;
        b=NKrRsbZIRt0d8IvLTaYNBP1ejj7KdwQGCNVStVtXMsH5TmNyrfSDPoltUY/ZOJ/dSa
         TWITg3OxSIIvHILQV5VwrGYnFO95GCX4ZJ1GmaTHCKcXoh3Wue7R8Csery3pezo3OVne
         5LPVwdh5TyxDJiffTJG58rc7QcV6hQHfm5Txzq8eWuSAuYGgJTRl3VwjTnkVnotzSJ/p
         kJOtAQP1oeZyEEm2Jbe8G++rymuFgKIWQQkSZNNIAQFGVHzCiM5sSsv4urnbskVg0rhS
         wt5k/V6fLde7sAh6CFHNdOexGFeayzchpOsPLH5tV+g0R8s3mqpvcj+2/satqRNVa3RA
         VZ2Q==
X-Gm-Message-State: AHQUAubYG23s04zOKg7jgEn7pW6cBIEa30D+gJrQhkEE/a1qo21qzN5O
        0G4kz4rGnqBdlkQuug26qcU=
X-Google-Smtp-Source: AHgI3IY6oOsh1Dljtopvm49mPac79wg/vfpNVFpFBoMhBXUEedKnWpaGbNz9aGX7jU7bV6tlxf+IbQ==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr9166834lfk.24.1549901271787;
        Mon, 11 Feb 2019 08:07:51 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:340b:b9c7:fa94:cf7])
        by smtp.gmail.com with ESMTPSA id s12sm2386326lfs.37.2019.02.11.08.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 08:07:50 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Date:   Mon, 11 Feb 2019 17:07:49 +0100
Message-ID: <1958995.aBsZzC1X05@acerlaptop>
In-Reply-To: <82ccf31e-13c3-1cd5-d87a-0c3291eb0224@samsung.com>
References: <20190202142748.6830-1-pawel.mikolaj.chmiel@gmail.com> <20190202142748.6830-2-pawel.mikolaj.chmiel@gmail.com> <82ccf31e-13c3-1cd5-d87a-0c3291eb0224@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On poniedzia=C5=82ek, 11 lutego 2019 16:35:19 CET Andrzej Hajda wrote:
> On 02.02.2019 15:27, Pawe=C5=82 Chmiel wrote:
> > This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> > spi. It's based on already removed, non dt s6e63m0 driver and
> > panel-samsung-ld9040. It can be found for example in some of Samsung
> > Aries based phones.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> > Changes from v2:
> >   - VIDEOMODE_HELPERS is not needed in Kconfig
> >   - Added help text to Kconfig
> >   - Remove unneeded videomode includes/fields
> >   - Add sentinel comment in s6e63m0_of_match struct
> >   - Handle errors during registration of backlight device. We shouldn't
> >     register panel if we fail to register backlight device
> >   - Added Reviewed-by
> >
> > Changes from v1:
> >   - Correct order of Kconfig/Makefile entry
> >   - Fix SPDX tag, so it matches value of MODULE_LICENSE
> >   - Remove inclusion of drmP.h
> >   - Fix code formatting
> >   - Use DRM_DEV_ERROR/DEBUG
> >   - Extract hardcoded values
> >   - Remove possibility to change gamma through sysfs, leaving only one
> >     gamma table values
> >   - Fix reset_gpio handling, so it'll be asserted in power_on and
> >     deasserted in power_off. Also do it before turning voltage on.
> >   - Disable backlight and enter sleep mode in disable callback.
> >     Previously it was done in unprepare
> >   - Enable display and backlight in enable callback. Previously it was
> >     done in prepare
> >   - Hardcode display timings and delays. Previously they were readed
> >     from device tree
> >   - We're using SPDX, so we don't need to have license body
> >   - Use MIPI_DCS_EXIT_SLEEP_MODE and MIPI_DCS_SET_DISPLAY_ON
> >   - Rename MAX_GAMMA_LEVEL to NUM_GAMMA_LEVELS
> >   - Ommit get_brightness callback
> >   - Use backlight_enable/disable API, like it's done in other panel
> >     drivers (for example panel-simple)
> >   - Make set_brightness called only from backlight api, like it's done
> >     in other panel drivers (for example panel-simple).
> >   - Reset gpio should be set to GPIOD_OUT_HIGH. It's declared as active
> >     low in device tree
> >   - Don't call power_off in remove callback
> > ---
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 517 ++++++++++++++++++
> >  3 files changed, 527 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index 3f3537719beb..45e9ab4b7857 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -158,6 +158,15 @@ config DRM_PANEL_SAMSUNG_S6E63J0X03
> >  	depends on BACKLIGHT_CLASS_DEVICE
> >  	select VIDEOMODE_HELPERS
> > =20
> > +config DRM_PANEL_SAMSUNG_S6E63M0
> > +	tristate "Samsung S6E63M0 RGB/SPI panel"
> > +	depends on OF
> > +	depends on SPI
> > +	depends on BACKLIGHT_CLASS_DEVICE
> > +	help
> > +	  Say Y here if you want to enable support for Samsung s6e63m0
> > +	  AMOLED LCD panel.
> > +
> >  config DRM_PANEL_SAMSUNG_S6E8AA0
> >  	tristate "Samsung S6E8AA0 DSI video mode panel"
> >  	depends on OF
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Mak=
efile
> > index 4396658a7996..4507a2d253ac 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) +=3D panel-sam=
sung-ld9040.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) +=3D panel-samsung-s6d16d0.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) +=3D panel-samsung-s6e3ha2.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) +=3D panel-samsung-s6e63j0x=
03.o
> > +obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) +=3D panel-samsung-s6e63m0.o
> >  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) +=3D panel-samsung-s6e8aa0.o
> >  obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) +=3D panel-seiko-43wvf1g.o
> >  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) +=3D panel-sharp-lq101r1sx01=
=2Eo
> > diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gp=
u/drm/panel/panel-samsung-s6e63m0.c
> > new file mode 100644
> > index 000000000000..4312aa3e4386
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> > @@ -0,0 +1,517 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * S6E63M0 AMOLED LCD drm_panel driver.
> > + *
> > + * Copyright (C) 2019 Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.co=
m>
> > + * Derived from drivers/gpu/drm/panel-samsung-ld9040.c
> > + *
> > + * Andrzej Hajda <a.hajda@samsung.com>
> > + */
> > +
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_panel.h>
> > +#include <drm/drm_print.h>
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +/* Manufacturer Command Set */
> > +#define MCS_ELVSS_ON                0xb1
> > +#define MCS_ACL_CTRL                0xc0
> > +#define MCS_DISPLAY_CONDITION   0xf2
> > +#define MCS_ETC_CONDITION           0xf6
> > +#define MCS_PANEL_CONDITION         0xF8
> > +#define MCS_GAMMA_CTRL              0xfa
> > +
> > +#define NUM_GAMMA_LEVELS             11
> > +#define GAMMA_TABLE_COUNT           23
> > +
> > +#define DATA_MASK                                       0x100
> > +
> > +#define MAX_BRIGHTNESS              (NUM_GAMMA_LEVELS - 1)
> > +
> > +/* array of gamma tables for gamma value 2.2 */
> > +static u8 const s6e63m0_gamma_22[NUM_GAMMA_LEVELS][GAMMA_TABLE_COUNT] =
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
> > +struct s6e63m0 {
> > +	struct device *dev;
> > +	struct drm_panel panel;
> > +	struct backlight_device *bl_dev;
> > +
> > +	struct regulator_bulk_data supplies[2];
> > +	struct gpio_desc *reset_gpio;
> > +
> > +	bool prepared;
> > +	bool enabled;
> > +
> > +	/*
> > +	 * This field is tested by functions directly accessing bus before
> > +	 * transfer, transfer is skipped if it is set. In case of transfer
> > +	 * failure or unexpected response the field is set to error value.
> > +	 * Such construct allows to eliminate many checks in higher level
> > +	 * functions.
> > +	 */
> > +	int error;
> > +};
> > +
> > +static const struct drm_display_mode default_mode =3D {
> > +	.clock		=3D 25628,
> > +	.hdisplay	=3D 480,
> > +	.hsync_start	=3D 480 + 16,
> > +	.hsync_end	=3D 480 + 16 + 2,
> > +	.htotal		=3D 480 + 16 + 2 + 16,
> > +	.vdisplay	=3D 800,
> > +	.vsync_start	=3D 800 + 28,
> > +	.vsync_end	=3D 800 + 28 + 2,
> > +	.vtotal		=3D 800 + 28 + 2 + 1,
> > +	.vrefresh	=3D 60,
> > +	.width_mm	=3D 53,
> > +	.height_mm	=3D 89,
> > +	.flags		=3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
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
> > +	DRM_DEV_DEBUG(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
> > +	ret =3D s6e63m0_spi_write_word(ctx, *data);
> > +
> > +	while (!ret && --len) {
> > +		++data;
> > +		ret =3D s6e63m0_spi_write_word(ctx, *data | DATA_MASK);
> > +	}
> > +
> > +	if (ret) {
> > +		DRM_DEV_ERROR(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
> > +			      (int)len, data);
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
> > +	int brightness =3D ctx->bl_dev->props.brightness;
> > +
> > +	/* disable and set new gamma */
> > +	s6e63m0_dcs_write(ctx, s6e63m0_gamma_22[brightness],
> > +			  ARRAY_SIZE(s6e63m0_gamma_22[brightness]));
> > +
> > +	/* update gamma table. */
> > +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL, 0x01);
> > +}
>=20
>=20
> I guess you can squash this callback into s6e63m0_set_brightness.
> Moreover you performs transfer here unconditionally, regardless of panel
> power state, it will fail when drm device is disabled (using echo 255
> >/sys/class/backlight/...) - panel is also disabled - making transfer to
> disabled panel by panel driver looks odd, moreover it could be little
> bit racy. But in practice it could work.
>=20
> Moreover I do not see usage of backlight_properties.power,
> backlight_properties.state, but I do not understand how exactly
> backlight interface should work, if someone can point out to proper
> docs/usage of backlight API I will be glad.
I also had similar problems (and it was mentioned in previous versions revi=
ew).
Now i've tried to replicate behaviour used by some other panel drivers.
>=20
>=20
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
> > +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_EXIT_SLEEP_MODE);
> > +}
> > +
> > +static int s6e63m0_power_on(struct s6e63m0 *ctx)
> > +{
> > +	int ret;
> > +
> > +	gpiod_set_value(ctx->reset_gpio, 0);
> > +	msleep(120);
> > +
> > +	ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplie=
s);
> > +	if (ret < 0)
> > +		return ret;
>=20
>=20
> Are you sure gpios before regulators, from my experience usually it is
> reverse.
In v1 i had also regulators -> gpios order (like in vendor sources), but i =
got suggestion that  changing it this way
we avoid situation where the panel is starting up, reset and then starting =
up again.
>=20
>=20
> > +
> > +	msleep(25);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_power_off(struct s6e63m0 *ctx)
> > +{
> > +	int ret;
> > +
> > +	ret =3D regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->suppli=
es);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	gpiod_set_value(ctx->reset_gpio, 1);
>=20
>=20
> Ditto.
>=20
>=20
> > +	msleep(120);
>=20
>=20
> What is the point of this msleep?
Yes, i missed it when fixing reset_gpio handling (previously it was done on=
ly on power_on, like in vendor driver).
After refactor and spliting code i leaved msleep in both places, where in p=
oweroff it don't have any sense.
>=20
>=20
> I guess, the answer for above comments can be difficult, since datasheet
> is not available, so if you just followed vendor code please feel free
> to add:
>=20
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
I got information that this driver was tested on some tegra 2 based samsung=
 device and it was working.
Samsung Captivate Glide (SGH-i927).

The only one change was that in original driver for that device, there was =
rotation set.
Currently i'm sending=20
0xf7, 0x03, 0x00, 0x00
where on that device driver was sending=20
0xf7, 0x00, 0x00, 0x00
Difference is that when running driver in current shape (sending 0x03), scr=
een is rotated.

So it looks like that panel supports rotation. Should this be added to curr=
ent driver (for example next patch after gettting initial driver fixed/work=
ing/merged),
or it should be handled somewhere in drm/userspace/some other place?

>=20
> --
>=20
> Regards
> Andrzej
>=20
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_disable(struct drm_panel *panel)
> > +{
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +
> > +	if (!ctx->enabled)
> > +		return 0;
> > +
> > +	backlight_disable(ctx->bl_dev);
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
> > +	msleep(200);
> > +
> > +	ctx->enabled =3D false;
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_unprepare(struct drm_panel *panel)
> > +{
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +	int ret;
> > +
> > +	if (!ctx->prepared)
> > +		return 0;
> > +
> > +	s6e63m0_clear_error(ctx);
> > +
> > +	ret =3D s6e63m0_power_off(ctx);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->prepared =3D false;
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_prepare(struct drm_panel *panel)
> > +{
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +	int ret;
> > +
> > +	if (ctx->prepared)
> > +		return 0;
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
> > +
> > +	ctx->prepared =3D true;
> > +
> > +	return ret;
> > +}
> > +
> > +static int s6e63m0_enable(struct drm_panel *panel)
> > +{
> > +	struct s6e63m0 *ctx =3D panel_to_s6e63m0(panel);
> > +
> > +	if (ctx->enabled)
> > +		return 0;
> > +
> > +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_ON);
> > +
> > +	backlight_enable(ctx->bl_dev);
> > +
> > +	ctx->enabled =3D true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int s6e63m0_get_modes(struct drm_panel *panel)
> > +{
> > +	struct drm_connector *connector =3D panel->connector;
> > +	struct drm_display_mode *mode;
> > +
> > +	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> > +	if (!mode) {
> > +		DRM_ERROR("failed to add mode %ux%ux@%u\n",
> > +			  default_mode.hdisplay, default_mode.vdisplay,
> > +			  default_mode.vrefresh);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	drm_mode_set_name(mode);
> > +
> > +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
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
> > +static int s6e63m0_set_brightness(struct backlight_device *bd)
> > +{
> > +	struct s6e63m0 *ctx =3D bl_get_data(bd);
> > +
> > +	s6e63m0_brightness_set(ctx);
> > +
> > +	return s6e63m0_clear_error(ctx);
> > +}
> > +
> > +static const struct backlight_ops s6e63m0_backlight_ops =3D {
> > +	.update_status	=3D s6e63m0_set_brightness,
> > +};
> > +
> > +static int s6e63m0_backlight_register(struct s6e63m0 *ctx)
> > +{
> > +	struct backlight_properties props =3D {
> > +		.type		=3D BACKLIGHT_RAW,
> > +		.brightness	=3D MAX_BRIGHTNESS,
> > +		.max_brightness =3D MAX_BRIGHTNESS
> > +	};
> > +	struct device *dev =3D ctx->dev;
> > +	int ret =3D 0;
> > +
> > +	ctx->bl_dev =3D devm_backlight_device_register(dev, "panel", dev, ctx,
> > +						     &s6e63m0_backlight_ops,
> > +						     &props);
> > +	if (IS_ERR(ctx->bl_dev)) {
> > +		ret =3D PTR_ERR(ctx->bl_dev);
> > +		DRM_DEV_ERROR(dev, "error registering backlight device (%d)\n",
> > +			      ret);
> > +	}
> > +
> > +	return ret;
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
> > +	ctx->enabled =3D false;
> > +	ctx->prepared =3D false;
> > +
> > +	ctx->supplies[0].supply =3D "vdd3";
> > +	ctx->supplies[1].supply =3D "vci";
> > +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> > +				      ctx->supplies);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "failed to get regulators: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(ctx->reset_gpio)) {
> > +		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
> > +			      PTR_ERR(ctx->reset_gpio));
> > +		return PTR_ERR(ctx->reset_gpio);
> > +	}
> > +
> > +	spi->bits_per_word =3D 9;
> > +	spi->mode =3D SPI_MODE_3;
> > +	ret =3D spi_setup(spi);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "spi setup failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	drm_panel_init(&ctx->panel);
> > +	ctx->panel.dev =3D dev;
> > +	ctx->panel.funcs =3D &s6e63m0_drm_funcs;
> > +
> > +	ret =3D s6e63m0_backlight_register(ctx);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return drm_panel_add(&ctx->panel);
> > +}
> > +
> > +static int s6e63m0_remove(struct spi_device *spi)
> > +{
> > +	struct s6e63m0 *ctx =3D spi_get_drvdata(spi);
> > +
> > +	drm_panel_remove(&ctx->panel);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id s6e63m0_of_match[] =3D {
> > +	{ .compatible =3D "samsung,s6e63m0" },
> > +	{ /* sentinel */ }
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




