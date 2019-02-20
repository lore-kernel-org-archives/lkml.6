Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABE20700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C3yoxhKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfBTKeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:34:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34476 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:34:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KAXu2j017058;
        Wed, 20 Feb 2019 04:33:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550658836;
        bh=HYEBf4DS0GWISJ2/gj5d6xdznTot6WSsaO881ulEaM4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C3yoxhKQmJTxTnNHdGfzEQtlEzUX1/ZH5FYVy5CPPelivt2Wm7E/ZMmxnv+HF+QBp
         W4v89wsCy9GVXxN5UQED2wL/Qj6xtRVNdisxF7VDa3BiMDeR3zpQXN3jjVrraerIqw
         M2kJZLHQdyFHvDMokGFBttPisIm3to/ZbUCcAh8A=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KAXujQ098307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 04:33:56 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 04:33:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 04:33:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KAXp1X023954;
        Wed, 20 Feb 2019 04:33:52 -0600
Subject: Re: [PATCH 4/4] drm/panel: Add OSD101T2587-53TS driver
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>, <tomi.valkeinen@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
 <20190215140315.18046-5-peter.ujfalusi@ti.com>
 <20190215180759.GA26944@ravnborg.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2398a647-be4c-15e4-3e28-36382a834dce@ti.com>
Date:   Wed, 20 Feb 2019 12:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190215180759.GA26944@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 15/02/2019 20.07, Sam Ravnborg wrote:
> Hi Peter.
> 
> Good with more panel drivers.
> Some comments in the following, please do not blindly follow them but
> check that this is OK.

First of all, thank you for the review and sorry for the delay!

> 
> 	Sam
> 
> On Fri, Feb 15, 2019 at 04:03:15PM +0200, Peter Ujfalusi via dri-devel wrote:
>> The panel is similar to OSD101T2045-53TS (which is handled by panel-simple)
>> with one big difference: osd101t2587-53ts needs MIPI_DSI_TURN_ON_PERIPHERAL
>> message to be sent from the host to be operational and thus can not be
>> handled by panel-simple.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> +++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
>> @@ -0,0 +1,284 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
>> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <drm/drmP.h>
> Please do not use drmP.h in new drivers - we try to get rid of this file.

OK.

> 
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_panel.h>
>> +
>> +#include <video/mipi_display.h>
>> +
>> +struct osd101t2587_panel {
>> +	struct drm_panel base;
>> +	struct mipi_dsi_device *dsi;
>> +
>> +	struct backlight_device *backlight;
>> +	struct regulator *supply;
>> +
>> +	bool prepared;
>> +	bool enabled;
>> +
>> +	ktime_t earliest_wake;
> earliest_wake is not used, and can be deleted.

Yes, it is leftover.

>> +
>> +	const struct drm_display_mode *default_mode;
>> +	const struct drm_display_mode *mode;
> Assigned but never used. Drop the assignment and the variable?

Hrm, you are right.

> 
>> +};
>> +
>> +static inline struct osd101t2587_panel *to_osd101t2587_panel(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct osd101t2587_panel, base);
>> +}
>> +
>> +static int osd101t2587_panel_disable(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +	int ret;
>> +
>> +	if (!osd101t2587->enabled)
>> +		return 0;
>> +
>> +	if (osd101t2587->backlight) {
>> +		osd101t2587->backlight->props.power = FB_BLANK_POWERDOWN;
>> +		osd101t2587->backlight->props.state |= BL_CORE_FBBLANK;
>> +		backlight_update_status(osd101t2587->backlight);
>> +	}
> backlight_disable(osd101t2587->backlight);

OK

>> +
>> +	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
>> +
>> +	osd101t2587->enabled = false;
>> +
>> +	return ret;
>> +}
>> +
>> +static int osd101t2587_panel_unprepare(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +
>> +	if (!osd101t2587->prepared)
>> +		return 0;
>> +
>> +	regulator_disable(osd101t2587->supply);
>> +	osd101t2587->prepared = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int osd101t2587_panel_prepare(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +	int ret;
>> +
>> +	if (osd101t2587->prepared)
>> +		return 0;
>> +
>> +	ret = regulator_enable(osd101t2587->supply);
>> +	if (!ret)
>> +		osd101t2587->prepared = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int osd101t2587_panel_enable(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +	int ret;
>> +
>> +	if (osd101t2587->enabled)
>> +		return 0;
>> +
>> +	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (osd101t2587->backlight) {
>> +		osd101t2587->backlight->props.power = FB_BLANK_UNBLANK;
>> +		osd101t2587->backlight->props.state &= ~BL_CORE_FBBLANK;
>> +		backlight_update_status(osd101t2587->backlight);
>> +	}
> backlight_enable(osd101t2587->backlight);
> can be used here.

Yes, it can be used.

> 
>> +
>> +	osd101t2587->enabled = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct drm_display_mode default_mode_osd101t2587 = {
>> +	.clock = 164400,
>> +	.hdisplay = 1920,
>> +	.hsync_start = 1920 + 152,
>> +	.hsync_end = 1920 + 152 + 52,
>> +	.htotal = 1920 + 152 + 52 + 20,
>> +	.vdisplay = 1200,
>> +	.vsync_start = 1200 + 24,
>> +	.vsync_end = 1200 + 24 + 6,
>> +	.vtotal = 1200 + 24 + 6 + 48,
>> +	.vrefresh = 60,
>> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> +};
>> +
>> +static int osd101t2587_panel_get_modes(struct drm_panel *panel)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(panel->drm, osd101t2587->default_mode);
>> +	if (!mode) {
>> +		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
>> +			osd101t2587->default_mode->hdisplay,
>> +			osd101t2587->default_mode->vdisplay,
>> +			osd101t2587->default_mode->vrefresh);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drm_mode_set_name(mode);
>> +
>> +	drm_mode_probed_add(panel->connector, mode);
>> +
>> +	panel->connector->display_info.width_mm = 217;
>> +	panel->connector->display_info.height_mm = 136;
>> +
>> +	return 1;
>> +}
>> +
>> +static const struct drm_panel_funcs osd101t2587_panel_funcs = {
>> +	.disable = osd101t2587_panel_disable,
>> +	.unprepare = osd101t2587_panel_unprepare,
>> +	.prepare = osd101t2587_panel_prepare,
>> +	.enable = osd101t2587_panel_enable,
>> +	.get_modes = osd101t2587_panel_get_modes,
>> +};
>> +
>> +static const struct of_device_id osd101t2587_of_match[] = {
>> +	{
>> +		.compatible = "osd,osd101t2587-53ts",
>> +		.data = &default_mode_osd101t2587,
>> +	}, { }
> Move { } to a separate line and use { /* sentinel */ } to make it look like other drivers.
>  
> 
>> +};
>> +MODULE_DEVICE_TABLE(of, osd101t2587_of_match);
>> +
>> +static int osd101t2587_panel_add(struct osd101t2587_panel *osd101t2587)
>> +{
>> +	struct device *dev = &osd101t2587->dsi->dev;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	osd101t2587->mode = osd101t2587->default_mode;
>> +
>> +	osd101t2587->supply = devm_regulator_get(dev, "power");
>> +	if (IS_ERR(osd101t2587->supply))
>> +		return PTR_ERR(osd101t2587->supply);
>> +
>> +	np = of_parse_phandle(dev->of_node, "backlight", 0);
>> +	if (np) {
>> +		osd101t2587->backlight = of_find_backlight_by_node(np);
>> +		of_node_put(np);
>> +
>> +		if (!osd101t2587->backlight)
>> +			return -EPROBE_DEFER;
>> +	}
> Use devm_of_find_backlight() - this results in simpler code.

Yes, it certainly makes the code cleaner.

> 
>> +
>> +	drm_panel_init(&osd101t2587->base);
>> +	osd101t2587->base.funcs = &osd101t2587_panel_funcs;
>> +	osd101t2587->base.dev = &osd101t2587->dsi->dev;
>> +
>> +	ret = drm_panel_add(&osd101t2587->base);
>> +	if (ret < 0)
>> +		goto put_backlight;
>> +
>> +	return 0;
>> +
>> +put_backlight:
>> +	if (osd101t2587->backlight)
>> +		put_device(&osd101t2587->backlight->dev);
> When using devm_of_find_backlight() this is not needed.

OK.

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static void osd101t2587_panel_del(struct osd101t2587_panel *osd101t2587)
>> +{
>> +	if (osd101t2587->base.dev)
>> +		drm_panel_remove(&osd101t2587->base);
>> +
>> +	if (osd101t2587->backlight)
>> +		put_device(&osd101t2587->backlight->dev);
> When you use devm_of_find_backlight() then this is done for you, so the above can be deleted.

OK.

>> +}
>> +
>> +static int osd101t2587_panel_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct osd101t2587_panel *osd101t2587;
>> +	const struct of_device_id *id;
>> +	int ret;
>> +
>> +	id = of_match_node(osd101t2587_of_match, dsi->dev.of_node);
>> +	if (!id)
>> +		return -ENODEV;
>> +
>> +	dsi->lanes = 4;
>> +	dsi->format = MIPI_DSI_FMT_RGB888;
>> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>> +			  MIPI_DSI_MODE_VIDEO_BURST |
>> +			  MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>> +			  MIPI_DSI_MODE_EOT_PACKET;
>> +
>> +	osd101t2587 = devm_kzalloc(&dsi->dev, sizeof(*osd101t2587), GFP_KERNEL);
>> +	if (!osd101t2587)
>> +		return -ENOMEM;
>> +
>> +	mipi_dsi_set_drvdata(dsi, osd101t2587);
>> +
>> +	osd101t2587->dsi = dsi;
>> +	osd101t2587->default_mode = id->data;
>> +
>> +	ret = osd101t2587_panel_add(osd101t2587);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return mipi_dsi_attach(dsi);
>> +}
>> +
>> +static int osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
>> +	int ret;
>> +
>> +	ret = osd101t2587_panel_disable(&osd101t2587->base);
>> +	if (ret < 0)
>> +		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
>> +
> To trun off power supply call osd101t2587_panel_unprepare() here?
> 
>> +	ret = mipi_dsi_detach(dsi);
>> +	if (ret < 0)
>> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
>> +
>> +	osd101t2587_panel_del(osd101t2587);
> Replace this with
> 	drm_panel_remove(osd101t2587->base);
> This should be fine and no need to disable backlight, this is done in osd101t2587_panel_disable()

OK.

>> +
>> +	return 0;
>> +}
>> +
>> +static void osd101t2587_panel_shutdown(struct mipi_dsi_device *dsi)
>> +{
>> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
>> +
> Maybe call osd101t2587_panel_unprepare() here to turn off power supply?

Make sense, in this order:
	osd101t2587_panel_disable(&osd101t2587->base);
	osd101t2587_panel_unprepare(&osd101t2587->base);

But should the osd101t2587_panel_remove() do the same thing? or the
osd101t2587_panel_disable() is redundant in the osd101t2587_panel_remove()?

Regards,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
