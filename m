Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3039120878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="JqEPnQTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfAKVlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:41:23 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:41250 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfAKVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=dkTgIoBYmG5bhX2EV0AQQw0OR7Z9GYn0EvmhBzLX44Y=;
        b=JqEPnQTYsrdat1gs49LwdtXDvVq+Ib5V1NTkj1l3VGj1cVNBGWRiJqDHqShS2XYhlJFeL1uVqhj7Qm/vtpuiva1iuP0xZxBmEUSgbu+NMyJz8wUYorbR9GmZVpqrbk8v7HJoE4mi+Idz1rBrZRogMfmMT1GgpSvI/nO2R0Qfg1LW/YgTEIRjzn0XtZy1DUyqI7ZU9dgBDw5YLzzfjIah1h4mLYp1U8VCbT5iDVqXAPbnF2/tQSgvJEFX6yosjEW1YHkLiUpyx4diwgARSl74QzngClL5sMvyJZ8Y4Q5C/fgo/R0oqAS+/3tIu60McROtN3GfRFwVmgDWds4NDa16Tg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54035 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gi4YJ-0004Lw-8C; Fri, 11 Jan 2019 22:41:19 +0100
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
To:     Sam Ravnborg <sam@ravnborg.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sean Paul <sean@poorly.run>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com>
 <20190111211931.GA29735@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <27708d2d-23cf-747e-7e54-7ec894a25729@tronnes.org>
Date:   Fri, 11 Jan 2019 22:41:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111211931.GA29735@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 11.01.2019 22.19, skrev Sam Ravnborg:
> Hi Jagan.
> 
> Gave this another more detailed read - triggered some additional comments.
> Depite the comments it looks good, and this is all more or
> less cosmetic improvements.
> 
> 	Sam
> 
>> +struct st7701_panel_desc {
>> +	const struct drm_display_mode *mode;
>> +	unsigned int lanes;
>> +	unsigned long flags;
>> +	enum mipi_dsi_pixel_format format;
>> +	const char *const *supply_names;
>> +	unsigned int num_supplies;
>> +	unsigned int panel_sleep_delay;
>> +};
>> +
>> +struct st7701 {
>> +	struct drm_panel panel;
>> +	struct mipi_dsi_device *dsi;
>> +	const struct st7701_panel_desc *desc;
>> +
>> +	struct backlight_device *backlight;
>> +	struct regulator_bulk_data *supplies;
>> +	unsigned int num_supplies;
> I cannot see that num_supplies in this struct are used?
> 
> 
>> +	struct gpio_desc *reset;
>> +	unsigned int sleep_delay;
>> +};
>> +
>> +static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct st7701, panel);
>> +}
>> +
>> +static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
>> +				   size_t len)
>> +{
>> +	return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
>> +}
>> +
> 
> 
>> +static int st7701_prepare(struct drm_panel *panel)
>> +{
>> +	struct st7701 *st7701 = panel_to_st7701(panel);
>> +	int ret;
>> +
>> +	gpiod_set_value(st7701->reset, 0);
>> +	msleep(20);
>> +
>> +	ret = regulator_bulk_enable(st7701->desc->num_supplies,
>> +				    st7701->supplies);
>> +	if (ret < 0)
>> +		return ret;
>> +	msleep(20);
>> +
>> +	gpiod_set_value(st7701->reset, 1);
>> +	msleep(20);
>> +
>> +	gpiod_set_value(st7701->reset, 0);
>> +	msleep(30);
>> +
>> +	gpiod_set_value(st7701->reset, 1);
>> +	msleep(150);
>> +
>> +	st7701_init_sequence(st7701);
>> +
>> +	return 0;
>> +}
>> +
> 
>> +static int st7701_unprepare(struct drm_panel *panel)
>> +{
>> +	struct st7701 *st7701 = panel_to_st7701(panel);
>> +
>> +	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
>> +
>> +	msleep(st7701->sleep_delay);
>> +
>> +	gpiod_set_value(st7701->reset, 0);
>> +
>> +	gpiod_set_value(st7701->reset, 1);
>> +
>> +	gpiod_set_value(st7701->reset, 0);
> No timing constrains here? In prepare there are sleeps intermixed.
> 
>> +
>> +	regulator_bulk_disable(st7701->desc->num_supplies, st7701->supplies);
>> +
>> +	return 0;
>> +}
>> +
>> +static int st7701_get_modes(struct drm_panel *panel)
>> +{
>> +	struct st7701 *st7701 = panel_to_st7701(panel);
>> +	const struct drm_display_mode *desc_mode = st7701->desc->mode;
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(panel->drm, desc_mode);
>> +	if (!mode) {
>> +		dev_err(&st7701->dsi->dev, "failed to add mode %ux%ux@%u\n",
>> +			desc_mode->hdisplay, desc_mode->vdisplay,
>> +			desc_mode->vrefresh);
> Use something like:
> 		DRM_DEV_ERROR(st7701->dev, "failed to add mode" DRM_MODE_FMT ",
> 			      DRM_MODE_ARG(desc_mode));
> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drm_mode_set_name(mode);
>> +	drm_mode_probed_add(panel->connector, mode);
>> +
>> +	panel->connector->display_info.width_mm = desc_mode->width_mm;
>> +	panel->connector->display_info.height_mm = desc_mode->height_mm;
>> +
>> +	return 1;
>> +}
>> +
> 
>> +static const struct st7701_panel_desc ts8550b_desc = {
>> +	.mode = &ts8550b_mode,
>> +	.lanes = 2,
>> +	.flags = MIPI_DSI_MODE_VIDEO,
>> +	.format = MIPI_DSI_FMT_RGB888,
>> +	.supply_names = ts8550b_supply_names,
>> +	.num_supplies = ARRAY_SIZE(ts8550b_supply_names),
>> +	.panel_sleep_delay = 80, /* panel need extra 80ms for sleep out cmd */
> In the only place this is used there is added 120 ms too.
> Looks inconsistent - do we have the same delay twice?
> 
> 
>> +
>> +static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	const struct st7701_panel_desc *desc;
>> +	struct device_node *np;
>> +	struct st7701 *st7701;
>> +	int ret, i;
>> +
>> +	st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
>> +	if (!st7701)
>> +		return -ENOMEM;
>> +
>> +	desc = of_device_get_match_data(&dsi->dev);
>> +	dsi->mode_flags = desc->flags;
>> +	dsi->format = desc->format;
>> +	dsi->lanes = desc->lanes;
>> +
>> +	st7701->supplies = devm_kcalloc(&dsi->dev, desc->num_supplies,
>> +					sizeof(*st7701->supplies),
>> +					GFP_KERNEL);
>> +	if (!st7701->supplies)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < desc->num_supplies; i++)
>> +		st7701->supplies[i].supply = desc->supply_names[i];
>> +
>> +	ret = devm_regulator_bulk_get(&dsi->dev, desc->num_supplies,
>> +				      st7701->supplies);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(st7701->reset)) {
>> +		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
>> +		return PTR_ERR(st7701->reset);
>> +	}
>> +
>> +	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
>> +	if (np) {
>> +		st7701->backlight = of_find_backlight_by_node(np);
>> +		of_node_put(np);
>> +
>> +		if (!st7701->backlight)
>> +			return -EPROBE_DEFER;
>> +	}
> This is a simpler variant of the above:
> 	st7701->backlight = devm_of_find_backlight(dsi->dev);
> 	if (IS_ERR(st7701->backlight))
> 		return PTR_ERR(st7701->backlight);
> 
> Suggested by Noralf in another thread for a similar driver.
> 
> 
>> +
>> +	drm_panel_init(&st7701->panel);
>> +
>> +	/* We need to wait 120ms after a sleep out command */
>> +	st7701->sleep_delay = 120 + desc->panel_sleep_delay;
> This is the other place where we add 120 to the previous 80 - in total 200 ms.
> 
>> +	st7701->panel.funcs = &st7701_funcs;
>> +	st7701->panel.dev = &dsi->dev;
>> +
>> +	ret = drm_panel_add(&st7701->panel);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mipi_dsi_set_drvdata(dsi, st7701);
>> +	st7701->dsi = dsi;
> 
>> +	st7701->desc = desc;
> This assignment could come earlier, so we do not have it unassigned when calling
> other functions. As it is now it works so you can safely ignore this comment.
> 
>> +
>> +	return mipi_dsi_attach(dsi);
>> +}
>> +
>> +static int st7701_dsi_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
>> +
>> +	mipi_dsi_detach(dsi);
>> +	drm_panel_remove(&st7701->panel);
>> +
>> +	if (st7701->backlight)
>> +		put_device(&st7701->backlight->dev);
> 
> Use:
> 	backlight_put(st7701->backlight);

This happens automatically on driver detach if devm_of_find_backlight()
is used

Noralf.
