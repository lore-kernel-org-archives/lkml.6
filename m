Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628D1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22D820881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSUO6SgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22D820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGJLLf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:11:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeGJLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:11:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so5252948wrp.0;
        Tue, 10 Jul 2018 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qVUiSAWTiMLKsXiVo9dVw66MHteDnYtOT98VZIePsos=;
        b=cSUO6SgLEo66XoK5W622iWVDfRqMDva7JomBgZ3YxoPZ+5BZTi7LT65kB1LRrVxkUC
         NCMT7bfK1t+cgLqTawPShSKf60Fltdd1EMtBJZp4sgy6zHHx9BbPBBd8SaIYms0w8AfA
         Z1yL7eIKAcw1/7R8JvVYfOsTXrQzE+Dg7iQr3bZX+ZVbc0LVzApmFg8d9kJ2BBrwQiqS
         2UTdTnSv3WWIGtbhu5je4f2w1LMEOtvTcBrOhOR6jdNySeO8Kiydrx2CnlbT1ONzbqQ2
         UP64WylUsc+mgFSvk6cgk+0DYM/1NPsTfbf2902eG0mJUzdfvLry7ca1DqfQryBdQVT9
         FDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVUiSAWTiMLKsXiVo9dVw66MHteDnYtOT98VZIePsos=;
        b=LBhVVAf8ini2yu0b9EHFAVZmKuk4kSb4btOLcJmhuIflz6DHzES/M0xzhfuSGrxwDx
         xEZt0kTzGJfC/9ql5HJSzDNrWbAuK7jMXNtadK4P4Sgn7SzYTnMCUJOuV3oo7IOu/YkP
         hxEX5l3wRwlb9hWSktqdFTp0bHBhJjLhsU1/ItKxEW1lyvRylDi6vDONYX0ghTK9wlN+
         Ch75zTCHshM5MAalE7vjcqWd5a+/BaGBm1Kbq0liD4QnheUO6y5zE/zyMRO/wOrRLDK9
         71T0Yp5UzdvN9UooLTi8r9eF0O9hKlcD1gDXbFHPzQzVp6WvZhlfaN0rurzDDF5Y1UgV
         hB2w==
X-Gm-Message-State: APt69E3PRjZkQrymVlaVl5aVBTFmJ2TdXjCe4NXYPO20mO0pisrdidUy
        9lpv5m+6cfJ//nBhHjnzfjo=
X-Google-Smtp-Source: AAOMgpeGVPGiSXMZXlF7HAIfrxrnI95b0FrnoUngdhP1V9Z/WhooAoOtDqJ8uxCy4bFBQsJx1IjtAw==
X-Received: by 2002:adf:ad38:: with SMTP id p53-v6mr18367270wrc.10.1531221091946;
        Tue, 10 Jul 2018 04:11:31 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id g15-v6sm2754307wrh.48.2018.07.10.04.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 04:11:30 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:11:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH v2 3/3] drm/panel: add Kingdisplay kd097d04 panel driver
Message-ID: <20180710111129.GQ1504@ulmo>
References: <20180702103229.3952-1-heiko@sntech.de>
 <20180702103229.3952-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Content-Disposition: inline
In-Reply-To: <20180702103229.3952-4-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:32:29PM +0200, Heiko Stuebner wrote:
> From: Nickey Yang <nickey.yang@rock-chips.com>
>=20
> Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> it is a MIPI dual-DSI panel.
>=20
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
>  .../drm/panel/panel-kingdisplay-kd097d04.c    | 469 ++++++++++++++++++
>  3 files changed, 481 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 25682ff3449a..9a0061f7fed7 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -68,6 +68,17 @@ config DRM_PANEL_JDI_LT070ME05000
>  	  The panel has a 1200(RGB)=C3=971920 (WUXGA) resolution and uses
>  	  24 bit per pixel.
> =20
> +config DRM_PANEL_KINGDISPLAY_KD097D04
> +	tristate "Kingdisplay kd097d04 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for Kingdisplay kd097d04
> +	  TFT-LCD modules. The panel has a 1536x2048 resolution and uses
> +	  24 bit RGB per pixel. It provides a MIPI DSI interface to
> +	  the host and has a built-in LED backlight.
> +
>  config DRM_PANEL_SAMSUNG_LD9040
>  	tristate "Samsung LD9040 RGB/SPI panel"
>  	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index f26efc11d746..314b272f1e14 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_PANEL_SIMPLE) +=3D panel-simple.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) +=3D panel-ilitek-ili9322.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) +=3D panel-innolux-p079zca.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) +=3D panel-jdi-lt070me05000.o
> +obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) +=3D panel-kingdisplay-kd09=
7d04.o
>  obj-$(CONFIG_DRM_PANEL_LG_LG4573) +=3D panel-lg-lg4573.o
>  obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) +=3D panel-orisetech-otm8009a=
=2Eo
>  obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) +=3D panel-panasonic-vvx1=
0f034n00.o
> diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers=
/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> new file mode 100644
> index 000000000000..9fc6b06fffee
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017, Fuzhou Rockchip Electronics Co., Ltd
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct kingdisplay_panel {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *link;
> +
> +	struct backlight_device *backlight;
> +	struct regulator *supply;
> +	struct gpio_desc *enable_gpio;
> +
> +	bool prepared;
> +	bool enabled;
> +};
> +
> +struct kingdisplay_panel_cmd {
> +	char cmd;
> +	char data;
> +};
> +
> +/*
> + * According to the discussion on
> + * https://review.coreboot.org/#/c/coreboot/+/22472/
> + * the panel init array is not part of the panels datasheet but instead
> + * just came in this form from the panel vendor.
> + */
> +static const struct kingdisplay_panel_cmd init_code[] =3D {
> +	/* voltage setting */
> +	{ 0xB0, 0x00 },
> +	{ 0xB2, 0x02 },
> +	{ 0xB3, 0x11 },
> +	{ 0xB4, 0x00 },
> +	{ 0xB6, 0x80 },
> +	/* VCOM disable */
> +	{ 0xB7, 0x02 },
> +	{ 0xB8, 0x80 },
> +	{ 0xBA, 0x43 },
> +	/* VCOM setting */
> +	{ 0xBB, 0x53 },
> +	/* VSP setting */
> +	{ 0xBC, 0x0A },
> +	/* VSN setting */
> +	{ 0xBD, 0x4A },
> +	/* VGH setting */
> +	{ 0xBE, 0x2F },
> +	/* VGL setting */
> +	{ 0xBF, 0x1A },
> +	{ 0xF0, 0x39 },
> +	{ 0xF1, 0x22 },
> +	/* Gamma setting */
> +	{ 0xB0, 0x02 },
> +	{ 0xC0, 0x00 },
> +	{ 0xC1, 0x01 },
> +	{ 0xC2, 0x0B },
> +	{ 0xC3, 0x15 },
> +	{ 0xC4, 0x22 },
> +	{ 0xC5, 0x11 },
> +	{ 0xC6, 0x15 },
> +	{ 0xC7, 0x19 },
> +	{ 0xC8, 0x1A },
> +	{ 0xC9, 0x16 },
> +	{ 0xCA, 0x18 },
> +	{ 0xCB, 0x13 },
> +	{ 0xCC, 0x18 },
> +	{ 0xCD, 0x13 },
> +	{ 0xCE, 0x1C },
> +	{ 0xCF, 0x19 },
> +	{ 0xD0, 0x21 },
> +	{ 0xD1, 0x2C },
> +	{ 0xD2, 0x2F },
> +	{ 0xD3, 0x30 },
> +	{ 0xD4, 0x19 },
> +	{ 0xD5, 0x1F },
> +	{ 0xD6, 0x00 },
> +	{ 0xD7, 0x01 },
> +	{ 0xD8, 0x0B },
> +	{ 0xD9, 0x15 },
> +	{ 0xDA, 0x22 },
> +	{ 0xDB, 0x11 },
> +	{ 0xDC, 0x15 },
> +	{ 0xDD, 0x19 },
> +	{ 0xDE, 0x1A },
> +	{ 0xDF, 0x16 },
> +	{ 0xE0, 0x18 },
> +	{ 0xE1, 0x13 },
> +	{ 0xE2, 0x18 },
> +	{ 0xE3, 0x13 },
> +	{ 0xE4, 0x1C },
> +	{ 0xE5, 0x19 },
> +	{ 0xE6, 0x21 },
> +	{ 0xE7, 0x2C },
> +	{ 0xE8, 0x2F },
> +	{ 0xE9, 0x30 },
> +	{ 0xEA, 0x19 },
> +	{ 0xEB, 0x1F },
> +	/* GOA MUX setting */
> +	{ 0xB0, 0x01 },
> +	{ 0xC0, 0x10 },
> +	{ 0xC1, 0x0F },
> +	{ 0xC2, 0x0E },
> +	{ 0xC3, 0x0D },
> +	{ 0xC4, 0x0C },
> +	{ 0xC5, 0x0B },
> +	{ 0xC6, 0x0A },
> +	{ 0xC7, 0x09 },
> +	{ 0xC8, 0x08 },
> +	{ 0xC9, 0x07 },
> +	{ 0xCA, 0x06 },
> +	{ 0xCB, 0x05 },
> +	{ 0xCC, 0x00 },
> +	{ 0xCD, 0x01 },
> +	{ 0xCE, 0x02 },
> +	{ 0xCF, 0x03 },
> +	{ 0xD0, 0x04 },
> +	{ 0xD6, 0x10 },
> +	{ 0xD7, 0x0F },
> +	{ 0xD8, 0x0E },
> +	{ 0xD9, 0x0D },
> +	{ 0xDA, 0x0C },
> +	{ 0xDB, 0x0B },
> +	{ 0xDC, 0x0A },
> +	{ 0xDD, 0x09 },
> +	{ 0xDE, 0x08 },
> +	{ 0xDF, 0x07 },
> +	{ 0xE0, 0x06 },
> +	{ 0xE1, 0x05 },
> +	{ 0xE2, 0x00 },
> +	{ 0xE3, 0x01 },
> +	{ 0xE4, 0x02 },
> +	{ 0xE5, 0x03 },
> +	{ 0xE6, 0x04 },
> +	{ 0xE7, 0x00 },
> +	{ 0xEC, 0xC0 },
> +	/* GOA timing setting */
> +	{ 0xB0, 0x03 },
> +	{ 0xC0, 0x01 },
> +	{ 0xC2, 0x6F },
> +	{ 0xC3, 0x6F },
> +	{ 0xC5, 0x36 },
> +	{ 0xC8, 0x08 },
> +	{ 0xC9, 0x04 },
> +	{ 0xCA, 0x41 },
> +	{ 0xCC, 0x43 },
> +	{ 0xCF, 0x60 },
> +	{ 0xD2, 0x04 },
> +	{ 0xD3, 0x04 },
> +	{ 0xD4, 0x03 },
> +	{ 0xD5, 0x02 },
> +	{ 0xD6, 0x01 },
> +	{ 0xD7, 0x00 },
> +	{ 0xDB, 0x01 },
> +	{ 0xDE, 0x36 },
> +	{ 0xE6, 0x6F },
> +	{ 0xE7, 0x6F },
> +	/* GOE setting */
> +	{ 0xB0, 0x06 },
> +	{ 0xB8, 0xA5 },
> +	{ 0xC0, 0xA5 },
> +	{ 0xD5, 0x3F },
> +};
> +
> +static inline
> +struct kingdisplay_panel *to_kingdisplay_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct kingdisplay_panel, base);
> +}
> +
> +static int kingdisplay_panel_disable(struct drm_panel *panel)
> +{
> +	struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel(panel);
> +	int err;
> +
> +	if (!kingdisplay->enabled)
> +		return 0;
> +
> +	backlight_disable(kingdisplay->backlight);
> +
> +	err =3D mipi_dsi_dcs_set_display_off(kingdisplay->link);
> +	if (err < 0)
> +		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> +			      err);
> +
> +	kingdisplay->enabled =3D false;
> +
> +	return 0;
> +}
> +
> +static int kingdisplay_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel(panel);
> +	int err;
> +
> +	if (!kingdisplay->prepared)
> +		return 0;
> +
> +	err =3D mipi_dsi_dcs_enter_sleep_mode(kingdisplay->link);
> +	if (err < 0) {
> +		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> +			      err);
> +		return err;
> +	}
> +
> +	/* T15: 120ms */
> +	msleep(120);
> +
> +	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
> +
> +	err =3D regulator_disable(kingdisplay->supply);
> +	if (err < 0)
> +		return err;
> +
> +	kingdisplay->prepared =3D false;
> +
> +	return 0;
> +}
> +
> +static int kingdisplay_panel_prepare(struct drm_panel *panel)
> +{
> +	struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel(panel);
> +	int err, regulator_err;
> +	int i;

i can be unsigned.

> +
> +	if (kingdisplay->prepared)
> +		return 0;
> +
> +	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
> +
> +	err =3D regulator_enable(kingdisplay->supply);
> +	if (err < 0)
> +		return err;
> +
> +	/* T2: 15ms - 1000ms */
> +	usleep_range(15000, 16000);

That's odd. Shouldn't that be usleep_range(15000, 1000000) according to
the comment?

> +
> +	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 1);
> +
> +	/* T4: 15ms - 1000ms */
> +	usleep_range(15000, 16000);

Same as above.

> +
> +	for (i =3D 0; i < ARRAY_SIZE(init_code); i++)
> +		mipi_dsi_generic_write(kingdisplay->link, &init_code[i],
> +				       sizeof(struct kingdisplay_panel_cmd));

Don't you want to check for errors here?

> +
> +	err =3D mipi_dsi_dcs_exit_sleep_mode(kingdisplay->link);
> +	if (err < 0) {
> +		DRM_DEV_ERROR(panel->dev, "failed to exit sleep mode: %d\n",
> +			      err);
> +		goto poweroff;
> +	}
> +
> +	/* T6: 120ms - 1000ms*/
> +	msleep(120);

Again, what's up with the 1000 ms?

> +
> +	err =3D mipi_dsi_dcs_set_display_on(kingdisplay->link);
> +	if (err < 0) {
> +		DRM_DEV_ERROR(panel->dev, "failed to set display on: %d\n",
> +			      err);
> +		goto poweroff;
> +	}
> +
> +	/* T7: 10ms */
> +	usleep_range(10000, 10000);
> +
> +	kingdisplay->prepared =3D true;
> +
> +	return 0;
> +
> +poweroff:
> +	regulator_err =3D regulator_disable(kingdisplay->supply);
> +	if (regulator_err)
> +		DRM_DEV_ERROR(panel->dev, "failed to disable regulator: %d\n",
> +			      regulator_err);
> +
> +	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
> +	return err;
> +}
> +
> +static int kingdisplay_panel_enable(struct drm_panel *panel)
> +{
> +	struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel(panel);
> +	int ret;
> +
> +	if (kingdisplay->enabled)
> +		return 0;
> +
> +	ret =3D backlight_enable(kingdisplay->backlight);
> +	if (ret) {
> +		DRM_DEV_ERROR(panel->drm->dev,
> +			      "Failed to enable backlight %d\n", ret);
> +		return ret;
> +	}
> +
> +	kingdisplay->enabled =3D true;
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode default_mode =3D {
> +	.clock =3D 229000,
> +	.hdisplay =3D 1536,
> +	.hsync_start =3D 1536 + 100,
> +	.hsync_end =3D 1536 + 100 + 24,
> +	.htotal =3D 1536 + 100 + 24 + 100,
> +	.vdisplay =3D 2048,
> +	.vsync_start =3D 2048 + 95,
> +	.vsync_end =3D 2048 + 95 + 2,
> +	.vtotal =3D 2048 + 95 + 2 + 23,
> +	.vrefresh =3D 60,
> +};
> +
> +static int kingdisplay_panel_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		DRM_DEV_ERROR(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
> +			      default_mode.hdisplay, default_mode.vdisplay,
> +			      default_mode.vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	panel->connector->display_info.width_mm =3D 147;
> +	panel->connector->display_info.height_mm =3D 196;
> +	panel->connector->display_info.bpc =3D 8;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs kingdisplay_panel_funcs =3D {
> +	.disable =3D kingdisplay_panel_disable,
> +	.unprepare =3D kingdisplay_panel_unprepare,
> +	.prepare =3D kingdisplay_panel_prepare,
> +	.enable =3D kingdisplay_panel_enable,
> +	.get_modes =3D kingdisplay_panel_get_modes,
> +};
> +
> +static const struct of_device_id kingdisplay_of_match[] =3D {
> +	{ .compatible =3D "kingdisplay,kd097d04", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kingdisplay_of_match);
> +
> +static int kingdisplay_panel_add(struct kingdisplay_panel *kingdisplay)
> +{
> +	struct device *dev =3D &kingdisplay->link->dev;
> +	int err;
> +
> +	kingdisplay->supply =3D devm_regulator_get(dev, "power");
> +	if (IS_ERR(kingdisplay->supply))
> +		return PTR_ERR(kingdisplay->supply);
> +
> +	kingdisplay->enable_gpio =3D devm_gpiod_get_optional(dev, "enable",
> +							   GPIOD_OUT_HIGH);
> +	if (IS_ERR(kingdisplay->enable_gpio)) {
> +		err =3D PTR_ERR(kingdisplay->enable_gpio);
> +		dev_dbg(dev, "failed to get enable gpio: %d\n", err);
> +		kingdisplay->enable_gpio =3D NULL;
> +	}
> +
> +	kingdisplay->backlight =3D devm_of_find_backlight(dev);
> +	if (IS_ERR(kingdisplay->backlight))
> +		return PTR_ERR(kingdisplay->backlight);
> +
> +	drm_panel_init(&kingdisplay->base);
> +	kingdisplay->base.funcs =3D &kingdisplay_panel_funcs;
> +	kingdisplay->base.dev =3D &kingdisplay->link->dev;
> +
> +	return drm_panel_add(&kingdisplay->base);
> +}
> +
> +static void kingdisplay_panel_del(struct kingdisplay_panel *kingdisplay)
> +{
> +	if (kingdisplay->base.dev)
> +		drm_panel_remove(&kingdisplay->base);
> +}

I don't understand what the purpose is here. You should always,
unconditionally, remove the panel when the driver is unloaded.

> +
> +static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct kingdisplay_panel *kingdisplay;
> +	int err;
> +
> +	dsi->lanes =3D 4;
> +	dsi->format =3D MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM;
> +
> +	kingdisplay =3D devm_kzalloc(&dsi->dev, sizeof(*kingdisplay), GFP_KERNE=
L);
> +	if (!kingdisplay)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, kingdisplay);
> +	kingdisplay->link =3D dsi;
> +
> +	err =3D kingdisplay_panel_add(kingdisplay);
> +	if (err < 0)
> +		return err;
> +
> +	err =3D mipi_dsi_attach(dsi);
> +	return err;
> +}
> +
> +static int kingdisplay_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct kingdisplay_panel *kingdisplay =3D mipi_dsi_get_drvdata(dsi);
> +	int err;
> +
> +	err =3D kingdisplay_panel_unprepare(&kingdisplay->base);
> +	if (err < 0)
> +		DRM_DEV_ERROR(&dsi->dev, "failed to unprepare panel: %d\n",
> +			      err);
> +
> +	err =3D kingdisplay_panel_disable(&kingdisplay->base);
> +	if (err < 0)
> +		DRM_DEV_ERROR(&dsi->dev, "failed to disable panel: %d\n", err);
> +
> +	err =3D mipi_dsi_detach(dsi);
> +	if (err < 0)
> +		DRM_DEV_ERROR(&dsi->dev, "failed to detach from DSI host: %d\n",
> +			      err);
> +
> +	drm_panel_detach(&kingdisplay->base);

Panels should no longer detach themselves, see commit 38992c57c9c8
("drm/panel: Remove drm_panel_detach() calls from all panel drivers")
for details.

> +MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
> +MODULE_AUTHOR("Nickey Yang <nickey.yang@rock-chips.com>");
> +MODULE_DESCRIPTION("kingdisplay KD097D04 panel driver");
> +MODULE_LICENSE("GPL v2");

This seems to contradict the license from the SPDX identifier.

Thierry

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltElGEACgkQ3SOs138+
s6EPyQ/9F8BqpRpp/QdTrWVpt20JDixvSWN+6vJfZcsGlj4LQ5oKinqqGxrEQEv6
cvS/vdBsGWnfMQ3fUKgpbjF7uTWkw51J3RwMvFFmFGiR5CA4IE/+7HRfFfnIKPPy
moxHtOI2pj1Dwq+H7iFt77Xw3OywC+KBorj6ej+yImLLUro4BOQbulo+1SYAx0QU
bxP2oP2v6qQQOKreUZrTToM6L4B8RNLGuTd4PSMv6U5++WQifq74RHa9zuBO84fH
Ce251PaMOeR8ejgAycXyxR/BCYJuj3jjAPGnl6D7NE/ux+npKVAdmOZiLTfxa4pX
4OB/tFDns1un2H7/ptu8A3IzlUr3yzDCxtEVWMFcp+QgNk7UN7KTakwBxKoyQvHO
AOCW8olsax9iBHntIX94Cof0HpM/ai3iVSxK1O5tUQY/fMvROW2WrBIOVDySIqwC
bo/txdrNTALtK86yKHQSD4MKG3M8kZdqJarFtXqGvk4/D9oVsV7JRvNdXcyNS4dP
VMJDYl9le02JHISMmFyWY8jFuPu7vrZz4Gdd0ZlclXxjOTOSIwVdsnhoUHjXGUI2
PrAyx6UDTzMgwGff2G9zRqhXm8sh5N18YJxmevWJqnBcrLNjBEuxM3oTEh2aEquU
1WL3ItEw+J5766iW91c4iOGTvFXhHKFRjDpLZzvhwaH3yjnIyno=
=0zgY
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--
