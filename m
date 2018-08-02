Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DCCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D1421473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uQnRWH1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D1421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeHBK3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:29:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46587 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeHBK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:29:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so1208194wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFlpmKxvQb7XgIdK5JeDiogilYAZH7sDkdsMFISZk0Y=;
        b=uQnRWH1CUNlpngpPSWRl1A9s0bnVnA56QaB+v8bOga5asWEQu6ZC41gTPx+P95pxpJ
         pC6xroA1qrAhZX6mO3nWdejHZMWkS88WHq+KmsUT8cqvv9Oop0M70inIO2OiW7mIT8/r
         CGwE3Avg7F9/waSoZpgJTfNECayCP7AJKspXSasiFeKbpKwI+QuikjF2uHt+CYUZfsGZ
         U64CANNXeQKYXeCGSqUB1SmHSzEuUSJmDGzpZ0OemY3GOGz2LwhiW0PP5RZKdsA3TTBZ
         05d287ekr5C/y6D3FCPd7z8FXgShnBSaMHGIqcy8JiZ2BbJozFx/jmRXvyMStClvgvsO
         lkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFlpmKxvQb7XgIdK5JeDiogilYAZH7sDkdsMFISZk0Y=;
        b=XNJq+WJyz8LFQoiHw5nuY5xmsKdLWLWM4JxRDXkQVacQbTkAuEzFZHPZa8iqft+QBN
         jEeERjHrtAKDVhFPOjpzgqg9HrBTJb6mPEpz5lH9CnktCfay+E/KVz5pYd6t9EK5SFTj
         4qgG6zscExdajRkwLyJgZdmlPG7/w9ACh0U1VJJ5WHT4NYLBTcsX8JnJI8gBiy4sIDpu
         VqKj/jKavssLBoARyDx7gTvSKESVryEIwfsRKCHn4g4hlXPChZfkZIBoWCJINan7IrLW
         2gnnWDcaoUEhAAqBkMrQSK4rY5NJmYzk9r0TzoII94u13Q4gZvPbZ2xs486qoAypzPI3
         1/Og==
X-Gm-Message-State: AOUpUlEYHoLbQBTO5GD+lT1E6oN1gXAMjMO4g6HF41kytjxn1SbjRtg0
        MNN5tb/weZpgurzHD/y4qiwntA==
X-Google-Smtp-Source: AAOMgpcHvaE8BOoLWap9gvG98pcmzchwh1EtLp1KngdvzXSo86+mSfZbUpy5XEiZ/Bq+/msD3wokLg==
X-Received: by 2002:adf:d842:: with SMTP id k2-v6mr1264241wrl.26.1533199154159;
        Thu, 02 Aug 2018 01:39:14 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y11-v6sm1427752wrt.4.2018.08.02.01.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 01:39:13 -0700 (PDT)
Message-ID: <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
Subject: Re: [PATCH 4/4] drm/meson: convert to the new canvas module
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Date:   Thu, 02 Aug 2018 10:39:12 +0200
In-Reply-To: <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
         <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 20:51 +0200, Maxime Jourdan wrote:
> This removes the meson_canvas files within the meson/drm layer
> and makes use of the new canvas module that is referenced in the dts.
> 
> Canvases can be used by different IPs and modules, and it is as such
> preferable to rely on a module that can safely dispatch canvases on
> demand.
> 
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  .../bindings/display/amlogic,meson-vpu.txt    |  9 +--
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  7 +-
>  drivers/gpu/drm/meson/Kconfig                 |  1 +
>  drivers/gpu/drm/meson/Makefile                |  2 +-
>  drivers/gpu/drm/meson/meson_canvas.c          | 70 -------------------
>  drivers/gpu/drm/meson/meson_canvas.h          | 42 -----------
>  drivers/gpu/drm/meson/meson_crtc.c            |  5 +-
>  drivers/gpu/drm/meson/meson_drv.c             | 35 ++++++----
>  drivers/gpu/drm/meson/meson_drv.h             |  5 +-
>  drivers/gpu/drm/meson/meson_plane.c           |  3 +-
>  drivers/gpu/drm/meson/meson_viu.c             |  1 -
>  11 files changed, 39 insertions(+), 141 deletions(-)
>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
> index 057b81335775..60b6e1398636 100644
> --- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
> @@ -60,9 +60,9 @@ Required properties:
>  - reg: base address and size of he following memory-mapped regions :
>  	- vpu
>  	- hhi
> -	- dmc
>  - reg-names: should contain the names of the previous memory regions
>  - interrupts: should contain the VENC Vsync interrupt number
> +- amlogic,canvas: should point to a meson canvas provider node
>  
>  Optional properties:
>  - power-domains: Optional phandle to associated power domain as described in
> @@ -98,13 +98,14 @@ tv-connector {
>  vpu: vpu@d0100000 {
>  	compatible = "amlogic,meson-gxbb-vpu";
>  	reg = <0x0 0xd0100000 0x0 0x100000>,
> -	      <0x0 0xc883c000 0x0 0x1000>,
> -	      <0x0 0xc8838000 0x0 0x1000>;
> -	reg-names = "vpu", "hhi", "dmc";
> +	      <0x0 0xc883c000 0x0 0x1000>;
> +	reg-names = "vpu", "hhi";
>  	interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  
> +	amlogic,canvas = <&canvas>;
> +
>  	/* CVBS VDAC output port */
>  	port@0 {
>  		reg = <0>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index d104b9e111fb..7c4d971ecd80 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -503,13 +503,14 @@
>  		vpu: vpu@d0100000 {
>  			compatible = "amlogic,meson-gx-vpu";
>  			reg = <0x0 0xd0100000 0x0 0x100000>,
> -			      <0x0 0xc883c000 0x0 0x1000>,
> -			      <0x0 0xc8838000 0x0 0x1000>;
> -			reg-names = "vpu", "hhi", "dmc";
> +			      <0x0 0xc883c000 0x0 0x1000>;
> +			reg-names = "vpu", "hhi";
>  			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> +			amlogic,canvas = <&canvas>;
> +
>  			/* CVBS VDAC output port */
>  			cvbs_vdac_port: port@0 {
>  				reg = <0>;
> diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
> index 3ce51d8dfe1c..c28b69f48555 100644
> --- a/drivers/gpu/drm/meson/Kconfig
> +++ b/drivers/gpu/drm/meson/Kconfig
> @@ -7,6 +7,7 @@ config DRM_MESON
>  	select DRM_GEM_CMA_HELPER
>  	select VIDEOMODE_HELPERS
>  	select REGMAP_MMIO
> +	select MESON_CANVAS
>  
>  config DRM_MESON_DW_HDMI
>  	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
> diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
> index c5c4cc362f02..bd67429185ff 100644
> --- a/drivers/gpu/drm/meson/Makefile
> +++ b/drivers/gpu/drm/meson/Makefile
> @@ -1,5 +1,5 @@
>  meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_venc_cvbs.o
> -meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_canvas.o
> +meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o
>  
>  obj-$(CONFIG_DRM_MESON) += meson-drm.o
>  obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
> diff --git a/drivers/gpu/drm/meson/meson_canvas.c b/drivers/gpu/drm/meson/meson_canvas.c
> deleted file mode 100644
> index 08f6073d967e..000000000000
> --- a/drivers/gpu/drm/meson/meson_canvas.c
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -/*
> - * Copyright (C) 2016 BayLibre, SAS
> - * Author: Neil Armstrong <narmstrong@baylibre.com>
> - * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
> - * Copyright (C) 2014 Endless Mobile
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include "meson_drv.h"
> -#include "meson_canvas.h"
> -#include "meson_registers.h"
> -
> -/**
> - * DOC: Canvas
> - *
> - * CANVAS is a memory zone where physical memory frames information
> - * are stored for the VIU to scanout.
> - */
> -
> -/* DMC Registers */
> -#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
> -#define CANVAS_WIDTH_LBIT	29
> -#define CANVAS_WIDTH_LWID       3
> -#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
> -#define CANVAS_WIDTH_HBIT       0
> -#define CANVAS_HEIGHT_BIT       9
> -#define CANVAS_BLKMODE_BIT      24
> -#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
> -#define CANVAS_LUT_WR_EN        (0x2 << 8)
> -#define CANVAS_LUT_RD_EN        (0x1 << 8)
> -
> -void meson_canvas_setup(struct meson_drm *priv,
> -			uint32_t canvas_index, uint32_t addr,
> -			uint32_t stride, uint32_t height,
> -			unsigned int wrap,
> -			unsigned int blkmode)
> -{
> -	unsigned int val;
> -
> -	regmap_write(priv->dmc, DMC_CAV_LUT_DATAL,
> -		(((addr + 7) >> 3)) |
> -		(((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
> -
> -	regmap_write(priv->dmc, DMC_CAV_LUT_DATAH,
> -		((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
> -						CANVAS_WIDTH_HBIT) |
> -		(height << CANVAS_HEIGHT_BIT) |
> -		(wrap << 22) |
> -		(blkmode << CANVAS_BLKMODE_BIT));
> -
> -	regmap_write(priv->dmc, DMC_CAV_LUT_ADDR,
> -			CANVAS_LUT_WR_EN | canvas_index);
> -
> -	/* Force a read-back to make sure everything is flushed. */
> -	regmap_read(priv->dmc, DMC_CAV_LUT_DATAH, &val);
> -}
> diff --git a/drivers/gpu/drm/meson/meson_canvas.h b/drivers/gpu/drm/meson/meson_canvas.h
> deleted file mode 100644
> index af1759da4b27..000000000000
> --- a/drivers/gpu/drm/meson/meson_canvas.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/*
> - * Copyright (C) 2016 BayLibre, SAS
> - * Author: Neil Armstrong <narmstrong@baylibre.com>
> - * Copyright (C) 2014 Endless Mobile
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -/* Canvas LUT Memory */
> -
> -#ifndef __MESON_CANVAS_H
> -#define __MESON_CANVAS_H
> -
> -#define MESON_CANVAS_ID_OSD1	0x4e
> -
> -/* Canvas configuration. */
> -#define MESON_CANVAS_WRAP_NONE	0x00
> -#define	MESON_CANVAS_WRAP_X	0x01
> -#define	MESON_CANVAS_WRAP_Y	0x02
> -
> -#define	MESON_CANVAS_BLKMODE_LINEAR	0x00
> -#define	MESON_CANVAS_BLKMODE_32x32	0x01
> -#define	MESON_CANVAS_BLKMODE_64x64	0x02
> -
> -void meson_canvas_setup(struct meson_drm *priv,
> -			uint32_t canvas_index, uint32_t addr,
> -			uint32_t stride, uint32_t height,
> -			unsigned int wrap,
> -			unsigned int blkmode);
> -
> -#endif /* __MESON_CANVAS_H */
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 05520202c967..506b3619c983 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -36,7 +36,6 @@
>  #include "meson_venc.h"
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /* CRTC definition */
> @@ -193,10 +192,10 @@ void meson_crtc_irq(struct meson_drm *priv)
>  		} else
>  			meson_vpp_disable_interlace_vscaler_osd1(priv);
>  
> -		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
> +		priv->canvas_ops->setup(priv->canvas_id_osd1,
>  			   priv->viu.osd1_addr, priv->viu.osd1_stride,
>  			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
> -			   MESON_CANVAS_BLKMODE_LINEAR);
> +			   MESON_CANVAS_BLKMODE_LINEAR, 0);
>  
>  		/* Enable OSD1 */
>  		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index d3443125e661..de468339d75a 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/component.h>
>  #include <linux/of_graph.h>
> +#include <linux/of_platform.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic.h>
> @@ -47,7 +48,6 @@
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
>  #include "meson_venc.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  #define DRIVER_NAME "meson"
> @@ -165,6 +165,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	struct meson_drm *priv;
>  	struct drm_device *drm;
>  	struct resource *res;
> +	struct device_node *canvas;
> +	struct platform_device *canvas_pdev;
>  	void __iomem *regs;
>  	int ret;
>  
> @@ -211,31 +213,35 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	priv->hhi = devm_regmap_init_mmio(dev, regs,
>  					  &meson_regmap_config);
>  	if (IS_ERR(priv->hhi)) {
> -		dev_err(&pdev->dev, "Couldn't create the HHI regmap\n");
> +		dev_err(dev, "Couldn't create the HHI regmap\n");
>  		ret = PTR_ERR(priv->hhi);
>  		goto free_drm;
>  	}
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
> -	if (!res) {
> -		ret = -EINVAL;
> +	canvas = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
> +	if (!canvas) {
> +		ret = -ENODEV;
>  		goto free_drm;
>  	}
> -	/* Simply ioremap since it may be a shared register zone */
> -	regs = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!regs) {
> -		ret = -EADDRNOTAVAIL;
> +
> +	canvas_pdev = of_find_device_by_node(canvas);
> +	if (!canvas_pdev) {
> +		dev_err(dev, "Unable to find canvas pdev\n");
> +		ret = -ENODEV;
>  		goto free_drm;
>  	}
>  
> -	priv->dmc = devm_regmap_init_mmio(dev, regs,
> -					  &meson_regmap_config);
> -	if (IS_ERR(priv->dmc)) {
> -		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
> -		ret = PTR_ERR(priv->dmc);
> +	priv->canvas_ops = dev_get_platdata(&canvas_pdev->dev);

I looks like the consumer of your 'canvas' devices must know how the canvas
device is organized internally. Maybe something better can be done ?

Your canvas driver could provide a consumer API, for example:
meson_canvas_get(): to translate for struct device_node to whatever abstract
pointer you would need.
meson_canvas_alloc(), setup(), etc ... 

... This is just adding a bit of indirection but it would help hide the plumbing
of your canvas driver from the consumers (and repeat this code in each). This
might be usefull if you ever to make this canvas driver evolve.

> +	if (!priv->canvas_ops) {
> +		dev_err(dev, "canvas pdata structure NULL\n");
> +		ret = -EINVAL;
>  		goto free_drm;
>  	}
>  
> +	ret = priv->canvas_ops->alloc(&priv->canvas_id_osd1);
> +	if (ret)
> +		goto free_drm;
> +
>  	priv->vsync_irq = platform_get_irq(pdev, 0);
>  
>  	ret = drm_vblank_init(drm, 1);
> @@ -315,6 +321,7 @@ static void meson_drv_unbind(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct meson_drm *priv = drm->dev_private;
>  
> +	priv->canvas_ops->free(priv->canvas_id_osd1);
>  	drm_dev_unregister(drm);
>  	drm_kms_helper_poll_fini(drm);
>  	drm_fbdev_cma_fini(priv->fbdev);
> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
> index 8450d6ac8c9b..dfea959baaa3 100644
> --- a/drivers/gpu/drm/meson/meson_drv.h
> +++ b/drivers/gpu/drm/meson/meson_drv.h
> @@ -22,15 +22,18 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> +#include <linux/soc/amlogic/meson-canvas.h>
>  #include <drm/drmP.h>
>  
>  struct meson_drm {
>  	struct device *dev;
>  	void __iomem *io_base;
>  	struct regmap *hhi;
> -	struct regmap *dmc;
>  	int vsync_irq;
>  
> +	struct meson_canvas_platform_data *canvas_ops;
> +	uint8_t canvas_id_osd1;
> +
>  	struct drm_device *drm;
>  	struct drm_crtc *crtc;
>  	struct drm_fbdev_cma *fbdev;
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index 12c80dfcff59..8745f9209625 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -36,7 +36,6 @@
>  #include "meson_plane.h"
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  struct meson_plane {
> @@ -105,7 +104,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>  				   OSD_BLK0_ENABLE;
>  
>  	/* Set up BLK0 to point to the right canvas */
> -	priv->viu.osd1_blk0_cfg[0] = ((MESON_CANVAS_ID_OSD1 << OSD_CANVAS_SEL) |
> +	priv->viu.osd1_blk0_cfg[0] = ((priv->canvas_id_osd1 << OSD_CANVAS_SEL) |
>  				      OSD_ENDIANNESS_LE);
>  
>  	/* On GXBB, Use the old non-HDR RGB2YUV converter */
> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
> index 6bcfa527c180..5b48c4c0985b 100644
> --- a/drivers/gpu/drm/meson/meson_viu.c
> +++ b/drivers/gpu/drm/meson/meson_viu.c
> @@ -25,7 +25,6 @@
>  #include "meson_viu.h"
>  #include "meson_vpp.h"
>  #include "meson_venc.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /**


