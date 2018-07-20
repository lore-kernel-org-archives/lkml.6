Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25658ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40DF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSMw8xUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40DF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbeGTO3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:29:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbeGTO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:29:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so11375505wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A16lgHdmohS1sXv8g/wpt/WpZPNZ5PlNiWBKhb73omw=;
        b=MSMw8xUI6Bjxmg22bB5iDqr3Ggojjfp+rh7nYYcLmNzC4eUl7bgbs7TjhyShU5UIs2
         8NlKN6t0CzlfRrQmPpljuHdaaBrQqvDu3NQY5Bk1Dcc+oY+MxIh90tYmpP5lbpaU5QP7
         4u/4KZMmBz3rJBizIYsC2CUvJBUVXi8v6Nrlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A16lgHdmohS1sXv8g/wpt/WpZPNZ5PlNiWBKhb73omw=;
        b=NjjLyXuPoDGMVDGA9D+TaUQC9JWNuYj4UPNLLdtlFh4+A0VKK4+6AmUAXAk6PwByPY
         D4/x0rQczK05v6lh4Rg05xWl5f0m6laMZFyP3jkmoVlh/rxxzwnWqXdmnkjX4/tPn5lq
         KghKxnDqjsVBbYD7j2r7j6nN+qimmpOE8acS/3qU2P9Zu3RIkxzvwD0M8MUIi3+fyIdc
         bZuehyVg9iPZFBydH1zVeIMwtsOblJiG0Z581G0lcUHsjSdwLXqh9wgIc1Ef8YoLOFEy
         KJQzuH1+Wf/cKaV0OUKyMaf9g6LoSyNSKW2AimOn0pSY4sDBUcGuQtNiXH+c7xqojY/X
         7+YA==
X-Gm-Message-State: AOUpUlGaD7FepXpQ82gKSGZgI+QMviWbprlRQFVC/RRCPmM1LLo+7Qbk
        Yc+JgwUmabM/QgQALaO8wS6PLg==
X-Google-Smtp-Source: AAOMgpf+WNfwwJ1CRbXClMEnW0H6/jWVPqfG7bTQPfT2dg17dVfJS2I8Eikl5IiSg1bVEzTaUlq2Gg==
X-Received: by 2002:adf:c5d3:: with SMTP id v19-v6mr1576879wrg.169.1532094042934;
        Fri, 20 Jul 2018 06:40:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id q140-v6sm2070814wmb.35.2018.07.20.06.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:40:42 -0700 (PDT)
Subject: Re: [PATCH V4 5/8] backlight: qcom-wled: Restructure the driver for
 WLED3
To:     Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org,
        jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <68673142-1496-de1b-55cc-78a3dd2256bd@linaro.org>
Date:   Fri, 20 Jul 2018 14:40:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> Restructure the driver to add the support for new WLED
> peripherals.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes from V3:
> 	- This is the new patch after splitting the
> 	  "backlight: qcom-wled: Add support for WLED4 peripheral" patch
> 	  to seperate the WLED3 specific restructure.
> 		
>   drivers/video/backlight/qcom-wled.c | 396 ++++++++++++++++++++++--------------
>   1 file changed, 246 insertions(+), 150 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3cd6e75..87fc1d0 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -15,59 +15,71 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/of_address.h>
>   #include <linux/regmap.h>
>   
>   /* From DT binding */
> +#define WLED_MAX_STRINGS				4
> +
>   #define WLED_DEFAULT_BRIGHTNESS				2048
>   
> -#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
> -#define WLED3_CTRL_REG_VAL_BASE				0x40
> +#define WLED_SINK_REG_BRIGHT_MAX			0xFFF
>   
> -/* WLED3 control registers */
> -#define WLED3_CTRL_REG_MOD_EN				0x46
> -#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
> -#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
> +/* WLED control registers */
> +#define WLED_CTRL_REG_MOD_EN				0x46
> +#define  WLED_CTRL_REG_MOD_EN_MASK			BIT(7)
> +#define  WLED_CTRL_REG_MOD_EN_SHIFT			7
>   
> -#define WLED3_CTRL_REG_FREQ				0x4c
> -#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
> +#define WLED_CTRL_REG_FREQ				0x4c
> +#define  WLED_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
>   
> -#define WLED3_CTRL_REG_OVP				0x4d
> -#define  WLED3_CTRL_REG_OVP_MASK			0x03
> +#define WLED_CTRL_REG_OVP				0x4d
> +#define  WLED_CTRL_REG_OVP_MASK				GENMASK(1, 0)
>   
> -#define WLED3_CTRL_REG_ILIMIT				0x4e
> -#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
> +#define WLED_CTRL_REG_ILIMIT				0x4e
> +#define  WLED_CTRL_REG_ILIMIT_MASK			GENMASK(2, 0)
>   
> -/* WLED3 sink registers */
> -#define WLED3_SINK_REG_SYNC				0x47
> -#define  WLED3_SINK_REG_SYNC_MASK			0x07
> -#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
> -#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
> -#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
> -#define  WLED3_SINK_REG_SYNC_ALL			0x07
> -#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
> +/* WLED sink registers */
> +#define WLED_SINK_REG_SYNC				0x47
> +#define  WLED_SINK_REG_SYNC_CLEAR			0x00
>   
>   #define WLED3_SINK_REG_CURR_SINK			0x4f
> -#define  WLED3_SINK_REG_CURR_SINK_MASK			0xe0
> -#define  WLED3_SINK_REG_CURR_SINK_SHFT			0x05
> +#define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
> +#define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>   
> -/* WLED3 per-'string' registers below */
> -#define WLED3_SINK_REG_STR_OFFSET			0x10
> +/* WLED3 specific per-'string' registers below */
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
>   
> -#define WLED3_SINK_REG_STR_MOD_EN_BASE			0x60
> +#define WLED3_SINK_REG_STR_MOD_EN(n)			(0x60 + (n * 0x10))
>   #define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
> -#define  WLED3_SINK_REG_STR_MOD_EN			BIT(7)
>   
> -#define WLED3_SINK_REG_STR_FULL_SCALE_CURR		0x62
> -#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	0x1f
> +#define WLED3_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x62 + (n * 0x10))
> +#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(4, 0)
>   
> -#define WLED3_SINK_REG_STR_MOD_SRC_BASE			0x63
> -#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		0x01
> +#define WLED3_SINK_REG_STR_MOD_SRC(n)			(0x63 + (n * 0x10))
> +#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		BIT(0)
>   #define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
>   #define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
>   
> -#define WLED3_SINK_REG_STR_CABC_BASE			0x66
> +#define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
>   #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
> -#define  WLED3_SINK_REG_STR_CABC_EN			BIT(7)
> +
> +struct wled_var_cfg {
> +	const u32 *values;
> +	u32 (*fn)(u32);
> +	int size;
> +};
> +
> +struct wled_u32_opts {
> +	const char *name;
> +	u32 *val_ptr;
> +	const struct wled_var_cfg *cfg;
> +};
> +
> +struct wled_bool_opts {
> +	const char *name;
> +	bool *val_ptr;
> +};
>   
>   struct wled_config {
>   	u32 boost_i_limit;
> @@ -75,132 +87,179 @@ struct wled_config {
>   	u32 switch_freq;
>   	u32 num_strings;
>   	u32 string_i_limit;
> +	u32 enabled_strings[WLED_MAX_STRINGS];
>   	bool cs_out_en;
>   	bool ext_gen;
> -	bool cabc_en;
> +	bool cabc;
>   };
>   
>   struct wled {
>   	const char *name;
> +	struct device *dev;
>   	struct regmap *regmap;
> -	u16 addr;
> +	u16 ctrl_addr;
> +	u16 max_string_count;
> +	u32 brightness;
> +	u32 max_brightness;
>   
>   	struct wled_config cfg;
> +	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
>   };
>   
> +static int wled3_set_brightness(struct wled *wled, u16 brightness)
> +{
> +	int rc, i;
> +	u8 v[2];
> +
> +	v[0] = brightness & 0xff;
> +	v[1] = (brightness >> 8) & 0xf;
> +
> +	for (i = 0;  i < wled->cfg.num_strings; ++i) {
> +		rc = regmap_bulk_write(wled->regmap, wled->ctrl_addr +
> +				       WLED3_SINK_REG_BRIGHT(i), v, 2);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wled_module_enable(struct wled *wled, int val)
> +{
> +	int rc;
> +
> +	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
> +				WLED_CTRL_REG_MOD_EN,
> +				WLED_CTRL_REG_MOD_EN_MASK,
> +				val << WLED_CTRL_REG_MOD_EN_SHIFT);
> +	return rc;
> +}
> +
> +static int wled_sync_toggle(struct wled *wled)
> +{
> +	int rc;
> +	unsigned int mask = GENMASK(wled->max_string_count - 1, 0);
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED_SINK_REG_SYNC,
> +				mask, mask);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED_SINK_REG_SYNC,
> +				mask, WLED_SINK_REG_SYNC_CLEAR);
> +
> +	return rc;
> +}
> +
>   static int wled_update_status(struct backlight_device *bl)
>   {
>   	struct wled *wled = bl_get_data(bl);
> -	u16 val = bl->props.brightness;
> -	u8 ctrl = 0;
> -	int rc;
> -	int i;
> +	u16 brightness = bl->props.brightness;
> +	int rc = 0;
>   
>   	if (bl->props.power != FB_BLANK_UNBLANK ||
>   	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
>   	    bl->props.state & BL_CORE_FBBLANK)
> -		val = 0;
> -
> -	if (val != 0)
> -		ctrl = WLED3_CTRL_REG_MOD_EN_BIT;
> +		brightness = 0;
>   
> -	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_MOD_EN,
> -			WLED3_CTRL_REG_MOD_EN_MASK, ctrl);
> -	if (rc)
> -		return rc;
> +	if (brightness) {
> +		rc = wled->wled_set_brightness(wled, brightness);
> +		if (rc < 0) {
> +			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
> +				rc);
> +			return rc;
> +		}
>   
> -	for (i = 0; i < wled->cfg.num_strings; ++i) {
> -		u8 v[2] = { val & 0xff, (val >> 8) & 0xf };
> +		rc = wled_sync_toggle(wled);
> +		if (rc < 0) {
> +			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
> +			return rc;
> +		}
> +	}
>   
> -		rc = regmap_bulk_write(wled->regmap,
> -				wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> -				v, 2);
> -		if (rc)
> +	if (!!brightness != !!wled->brightness) {
> +		rc = wled_module_enable(wled, !!brightness);
> +		if (rc < 0) {
> +			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
>   			return rc;
> +		}
>   	}
>   
> -	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_SINK_REG_SYNC,
> -			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_ALL);
> -	if (rc)
> -		return rc;
> +	wled->brightness = brightness;
>   
> -	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_SINK_REG_SYNC,
> -			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_CLEAR);
>   	return rc;
>   }
>   
> -static int wled_setup(struct wled *wled)
> +static int wled3_setup(struct wled *wled)
>   {
> -	int rc;
> -	int i;
> +	u16 addr;
> +	u8 sink_en = 0;
> +	int rc, i, j;
>   
>   	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_OVP,
> -			WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
> +				wled->ctrl_addr + WLED_CTRL_REG_OVP,
> +				WLED_CTRL_REG_OVP_MASK, wled->cfg.ovp);
>   	if (rc)
>   		return rc;
>   
>   	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_ILIMIT,
> -			WLED3_CTRL_REG_ILIMIT_MASK, wled->cfg.boost_i_limit);
> +				wled->ctrl_addr + WLED_CTRL_REG_ILIMIT,
> +				WLED_CTRL_REG_ILIMIT_MASK,
> +				wled->cfg.boost_i_limit);
>   	if (rc)
>   		return rc;
>   
>   	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_FREQ,
> -			WLED3_CTRL_REG_FREQ_MASK, wled->cfg.switch_freq);
> +				wled->ctrl_addr + WLED_CTRL_REG_FREQ,
> +				WLED_CTRL_REG_FREQ_MASK,
> +				wled->cfg.switch_freq);
>   	if (rc)
>   		return rc;
>   
> -	if (wled->cfg.cs_out_en) {
> -		u8 all = (BIT(wled->cfg.num_strings) - 1)
> -				<< WLED3_SINK_REG_CURR_SINK_SHFT;
> -
> -		rc = regmap_update_bits(wled->regmap,
> -				wled->addr + WLED3_SINK_REG_CURR_SINK,
> -				WLED3_SINK_REG_CURR_SINK_MASK, all);
> -		if (rc)
> -			return rc;
> -	}
> -
>   	for (i = 0; i < wled->cfg.num_strings; ++i) {
> -		u16 addr = wled->addr + WLED3_SINK_REG_STR_OFFSET * i;
> -
> -		rc = regmap_update_bits(wled->regmap,
> -				addr + WLED3_SINK_REG_STR_MOD_EN_BASE,
> -				WLED3_SINK_REG_STR_MOD_MASK,
> -				WLED3_SINK_REG_STR_MOD_EN);
> +		j = wled->cfg.enabled_strings[i];
> +		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_MOD_EN(j);
> +		rc = regmap_update_bits(wled->regmap, addr,
> +					WLED3_SINK_REG_STR_MOD_MASK,
> +					WLED3_SINK_REG_STR_MOD_MASK);
>   		if (rc)
>   			return rc;
>   
>   		if (wled->cfg.ext_gen) {
> -			rc = regmap_update_bits(wled->regmap,
> -					addr + WLED3_SINK_REG_STR_MOD_SRC_BASE,
> -					WLED3_SINK_REG_STR_MOD_SRC_MASK,
> -					WLED3_SINK_REG_STR_MOD_SRC_EXT);
> +			addr = wled->ctrl_addr + WLED3_SINK_REG_STR_MOD_SRC(j);
> +			rc = regmap_update_bits(wled->regmap, addr,
> +						WLED3_SINK_REG_STR_MOD_SRC_MASK,
> +						WLED3_SINK_REG_STR_MOD_SRC_EXT);
>   			if (rc)
>   				return rc;
>   		}
>   
> -		rc = regmap_update_bits(wled->regmap,
> -				addr + WLED3_SINK_REG_STR_FULL_SCALE_CURR,
> -				WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK,
> -				wled->cfg.string_i_limit);
> +		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_FULL_SCALE_CURR(j);
> +		rc = regmap_update_bits(wled->regmap, addr,
> +					WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK,
> +					wled->cfg.string_i_limit);
>   		if (rc)
>   			return rc;
>   
> -		rc = regmap_update_bits(wled->regmap,
> -				addr + WLED3_SINK_REG_STR_CABC_BASE,
> -				WLED3_SINK_REG_STR_CABC_MASK,
> -				wled->cfg.cabc_en ?
> -					WLED3_SINK_REG_STR_CABC_EN : 0);
> +		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_CABC(j);
> +		rc = regmap_update_bits(wled->regmap, addr,
> +					WLED3_SINK_REG_STR_CABC_MASK,
> +					wled->cfg.cabc ?
> +					WLED3_SINK_REG_STR_CABC_MASK : 0);
>   		if (rc)
>   			return rc;
> +
> +		sink_en |= BIT(j + WLED3_SINK_REG_CURR_SINK_SHFT);
>   	}
>   
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED3_SINK_REG_CURR_SINK,
> +				WLED3_SINK_REG_CURR_SINK_MASK, sink_en);
> +	if (rc)
> +		return rc;
> +
>   	return 0;
>   }
>   
> @@ -208,17 +267,11 @@ static int wled_setup(struct wled *wled)
>   	.boost_i_limit = 3,
>   	.string_i_limit = 20,
>   	.ovp = 2,
> +	.num_strings = 3,
>   	.switch_freq = 5,
> -	.num_strings = 0,
>   	.cs_out_en = false,
>   	.ext_gen = false,
> -	.cabc_en = false,
> -};
> -
> -struct wled_var_cfg {
> -	const u32 *values;
> -	u32 (*fn)(u32);
> -	int size;
> +	.cabc = false,
>   };
>   
>   static const u32 wled3_boost_i_limit_values[] = {
> @@ -263,7 +316,11 @@ static u32 wled3_switch_freq_values_fn(u32 idx)
>   	.size = 26,
>   };
>   
> -static u32 wled3_values(const struct wled_var_cfg *cfg, u32 idx)
> +static const struct wled_var_cfg wled3_string_cfg = {
> +	.size = 8,
> +};
> +
> +static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>   {
>   	if (idx >= cfg->size)
>   		return UINT_MAX;
> @@ -274,68 +331,77 @@ static u32 wled3_values(const struct wled_var_cfg *cfg, u32 idx)
>   	return idx;
>   }
>   
> -static int wled_configure(struct wled *wled, struct device *dev)
> +#define	WLED3	3
> +
> +static int wled_configure(struct wled *wled, int version)
>   {
>   	struct wled_config *cfg = &wled->cfg;
> -	u32 val;
> -	int rc;
> -	u32 c;
> -	int i;
> -	int j;
> -
> -	const struct {
> -		const char *name;
> -		u32 *val_ptr;
> -		const struct wled_var_cfg *cfg;
> -	} u32_opts[] = {
> +	struct device *dev = wled->dev;
> +	const __be32 *prop_addr;
> +	u32 size, val, c, string_len;
> +	int rc, i, j;
> +
> +	const struct wled_u32_opts *u32_opts = NULL;
> +	const struct wled_u32_opts wled3_opts[] = {
>   		{
> -			"qcom,current-boost-limit",
> -			&cfg->boost_i_limit,
> +			.name = "qcom,current-boost-limit",
> +			.val_ptr = &cfg->boost_i_limit,
>   			.cfg = &wled3_boost_i_limit_cfg,
>   		},
>   		{
> -			"qcom,current-limit",
> -			&cfg->string_i_limit,
> +			.name = "qcom,current-limit",
> +			.val_ptr = &cfg->string_i_limit,
>   			.cfg = &wled3_string_i_limit_cfg,
>   		},
>   		{
> -			"qcom,ovp",
> -			&cfg->ovp,
> +			.name = "qcom,ovp",
> +			.val_ptr = &cfg->ovp,
>   			.cfg = &wled3_ovp_cfg,
>   		},
>   		{
> -			"qcom,switching-freq",
> -			&cfg->switch_freq,
> +			.name = "qcom,switching-freq",
> +			.val_ptr = &cfg->switch_freq,
>   			.cfg = &wled3_switch_freq_cfg,
>   		},
>   		{
> -			"qcom,num-strings",
> -			&cfg->num_strings,
> +			.name = "qcom,num-strings",
> +			.val_ptr = &cfg->num_strings,
>   			.cfg = &wled3_num_strings_cfg,
>   		},
>   	};
> -	const struct {
> -		const char *name;
> -		bool *val_ptr;
> -	} bool_opts[] = {
> +
> +	const struct wled_bool_opts bool_opts[] = {
>   		{ "qcom,cs-out", &cfg->cs_out_en, },
>   		{ "qcom,ext-gen", &cfg->ext_gen, },
> -		{ "qcom,cabc", &cfg->cabc_en, },
> +		{ "qcom,cabc", &cfg->cabc, },
>   	};
>   
> -	rc = of_property_read_u32(dev->of_node, "reg", &val);
> -	if (rc || val > 0xffff) {
> -		dev_err(dev, "invalid IO resources\n");
> -		return rc ? rc : -EINVAL;
> +	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
> +	if (!prop_addr) {
> +		dev_err(wled->dev, "invalid IO resources\n");
> +		return -EINVAL;
>   	}
> -	wled->addr = val;
> +	wled->ctrl_addr = be32_to_cpu(*prop_addr);
>   
>   	rc = of_property_read_string(dev->of_node, "label", &wled->name);
>   	if (rc)
>   		wled->name = dev->of_node->name;
>   
> -	*cfg = wled3_config_defaults;
> -	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
> +	switch (version) {
> +	case WLED3:
> +		u32_opts = wled3_opts;
> +		size = ARRAY_SIZE(wled3_opts);
> +		*cfg = wled3_config_defaults;
> +		wled->wled_set_brightness = wled3_set_brightness;
> +		wled->max_string_count = 3;
> +		break;
> +
> +	default:
> +		dev_err(wled->dev, "Invalid WLED version\n");
> +		break;
> +	}
> +
> +	for (i = 0; i < size; ++i) {
>   		rc = of_property_read_u32(dev->of_node, u32_opts[i].name, &val);
>   		if (rc == -EINVAL) {
>   			continue;
> @@ -346,12 +412,15 @@ static int wled_configure(struct wled *wled, struct device *dev)
>   
>   		c = UINT_MAX;
>   		for (j = 0; c != val; j++) {
> -			c = wled3_values(u32_opts[i].cfg, j);
> +			c = wled_values(u32_opts[i].cfg, j);
>   			if (c == UINT_MAX) {
>   				dev_err(dev, "invalid value for '%s'\n",
>   					u32_opts[i].name);
>   				return -EINVAL;
>   			}
> +
> +			if (c == val)
> +				break;
>   		}
>   
>   		dev_dbg(dev, "'%s' = %u\n", u32_opts[i].name, c);
> @@ -365,6 +434,15 @@ static int wled_configure(struct wled *wled, struct device *dev)
>   
>   	cfg->num_strings = cfg->num_strings + 1;
>   
> +	string_len = of_property_count_elems_of_size(dev->of_node,
> +						     "qcom,enabled-strings",
> +						     sizeof(u32));
> +	if (string_len > 0)
> +		rc = of_property_read_u32_array(dev->of_node,
> +						"qcom,enabled-strings",
> +						wled->cfg.enabled_strings,
> +						sizeof(u32));
> +
>   	return 0;
>   }
>   
> @@ -378,6 +456,7 @@ static int wled_probe(struct platform_device *pdev)
>   	struct backlight_device *bl;
>   	struct wled *wled;
>   	struct regmap *regmap;
> +	int version;
>   	u32 val;
>   	int rc;
>   
> @@ -392,22 +471,39 @@ static int wled_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	wled->regmap = regmap;
> +	wled->dev = &pdev->dev;
>   
> -	rc = wled_configure(wled, &pdev->dev);
> -	if (rc)
> -		return rc;
> +	version = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	if (!version) {
> +		dev_err(&pdev->dev, "Unknown device version\n");
> +		return -ENODEV;
> +	}
>   
> -	rc = wled_setup(wled);
> +	rc = wled_configure(wled, version);
>   	if (rc)
>   		return rc;
>   
> +	switch (version) {
> +	case WLED3:
> +		rc = wled3_setup(wled);
> +		if (rc) {
> +			dev_err(&pdev->dev, "wled3_setup failed\n");
> +			return rc;
> +		}
> +		break;
> +
> +	default:
> +		dev_err(wled->dev, "Invalid WLED version\n");
> +		break;
> +	}
> +
>   	val = WLED_DEFAULT_BRIGHTNESS;
>   	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
>   
>   	memset(&props, 0, sizeof(struct backlight_properties));
>   	props.type = BACKLIGHT_RAW;
>   	props.brightness = val;
> -	props.max_brightness = WLED3_SINK_REG_BRIGHT_MAX;
> +	props.max_brightness = WLED_SINK_REG_BRIGHT_MAX;
>   	bl = devm_backlight_device_register(&pdev->dev, wled->name,
>   					    &pdev->dev, wled,
>   					    &wled_ops, &props);
> @@ -415,7 +511,7 @@ static int wled_probe(struct platform_device *pdev)
>   };
>   
>   static const struct of_device_id wled_match_table[] = {
> -	{ .compatible = "qcom,pm8941-wled" },
> +	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, wled_match_table);
> 

