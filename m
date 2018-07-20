Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41EECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8B7205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji8jrimJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8B7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeGTOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:35:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39513 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbeGTOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:35:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so11389782wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDsxoV8I4bvFx7XdxU3vOpRVbmbhHoqDKmahueIcrdA=;
        b=ji8jrimJtj2Sb3fuBJe/Jws/3TnTiDY0zbA16huIeDQn6BLmKcHzYyS4n5IGW9UjhH
         vgHJ4q3USnDCpq2opkLBJMejQvBbwFGXKKTPLwLnMrk5+bV+mYRQKse0O1WgFdjjbE+a
         CAxAsIwAK30AezBwTVe+LqD5W0XAOGLTfajEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDsxoV8I4bvFx7XdxU3vOpRVbmbhHoqDKmahueIcrdA=;
        b=S/rpN2KKL5yDYgfYcq+CGQaz5mj6oa/KmeQoTZIjmhFR46cC4NS96WPDTv46iPSVSk
         TnRk5UIdqIVPNT4wh/6/0EeliSMcCIWHlG9YtSPnZQkUMPNoN7RN9fKlVaD6YWbSzdP9
         91NtVXPVaUjJzEDYQvTbHbBzx4r5ZVzQmujl5pO4HYgWOjTFQhxWVq+JscBAOwM5uxHw
         9L1dIK92BrcFwBbYq2lHUJdYQ9VIqH9gADnWvZ51X/sOT2d9Ab3zrUkUhOXQUP/LNexc
         jYVlvgNvIJwRW35WXhPmnxwiBE3Du3vzmiKNaH/ya2IE2iF1HMy1/0k0s839k1hsMgUl
         krpA==
X-Gm-Message-State: AOUpUlHxfkWBTaiaGpKra1QgwyDzDIR6mrCBXN3qrwBNOMM9F3ae7nny
        0Ybi1XtzeiHNya9AP6HjU1Mfvg==
X-Google-Smtp-Source: AAOMgpclos6gP8wwaRxELAp4hXPvtXR7rGuuiS5jA55WXpG14jlpCvm32xjqU3ao0ADYtiDYkPcIMg==
X-Received: by 2002:a5d:574d:: with SMTP id q13-v6mr1532032wrw.24.1532094449570;
        Fri, 20 Jul 2018 06:47:29 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id w142-v6sm3139848wme.13.2018.07.20.06.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:47:28 -0700 (PDT)
Subject: Re: [PATCH V4 6/8] backlight: qcom-wled: Add support for WLED4
 peripheral
To:     Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org,
        jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
Date:   Fri, 20 Jul 2018 14:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> WLED4 peripheral is present on some PMICs like pmi8998 and
> pm660l. It has a different register map and configurations
> are also different. Add support for it.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
> Changes from V3:
> 	- The WLED3 specific changes are splitted out
> 	- Merged the wled3_sync_toggle and wled4_syn_toggle functions
> 	- Modified the compatible .data
> 	- Moved from if/else to switch/case to select the version specific data
> 	- Addressed few more minor comments from Bjorn
> 
>   drivers/video/backlight/qcom-wled.c | 264 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 258 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 87fc1d0..362d254 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -64,6 +64,28 @@
>   #define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
>   #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
>   
> +/* WLED4 specific sink registers */
> +#define WLED4_SINK_REG_CURR_SINK			0x46
> +#define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
> +#define  WLED4_SINK_REG_CURR_SINK_SHFT			4
> +
> +/* WLED4 specific per-'string' registers below */
> +#define WLED4_SINK_REG_STR_MOD_EN(n)			(0x50 + (n * 0x10))
> +#define  WLED4_SINK_REG_STR_MOD_MASK			BIT(7)
> +
> +#define WLED4_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x52 + (n * 0x10))
> +#define  WLED4_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(3, 0)
> +
> +#define WLED4_SINK_REG_STR_MOD_SRC(n)			(0x53 + (n * 0x10))
> +#define  WLED4_SINK_REG_STR_MOD_SRC_MASK		BIT(0)
> +#define  WLED4_SINK_REG_STR_MOD_SRC_INT			0x00
> +#define  WLED4_SINK_REG_STR_MOD_SRC_EXT			0x01
> +
> +#define WLED4_SINK_REG_STR_CABC(n)			(0x56 + (n * 0x10))
> +#define  WLED4_SINK_REG_STR_CABC_MASK			BIT(7)
> +
> +#define WLED4_SINK_REG_BRIGHT(n)			(0x57 + (n * 0x10))
> +
>   struct wled_var_cfg {
>   	const u32 *values;
>   	u32 (*fn)(u32);
> @@ -98,6 +120,7 @@ struct wled {
>   	struct device *dev;
>   	struct regmap *regmap;
>   	u16 ctrl_addr;
> +	u16 sink_addr;
>   	u16 max_string_count;
>   	u32 brightness;
>   	u32 max_brightness;
> @@ -124,6 +147,29 @@ static int wled3_set_brightness(struct wled *wled, u16 brightness)
>   	return 0;
>   }
>   
> +static int wled4_set_brightness(struct wled *wled, u16 brightness)
> +{
> +	int rc, i;
> +	u16 low_limit = wled->max_brightness * 4 / 1000;
> +	u8 v[2];
> +
> +	/* WLED4's lower limit of operation is 0.4% */
> +	if (brightness > 0 && brightness < low_limit)
> +		brightness = low_limit;
> +
> +	v[0] = brightness & 0xff;
> +	v[1] = (brightness >> 8) & 0xf;
> +
> +	for (i = 0;  i < wled->cfg.num_strings; ++i) {
> +		rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
> +				       WLED4_SINK_REG_BRIGHT(i), v, 2);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>   static int wled_module_enable(struct wled *wled, int val)
>   {
>   	int rc;
> @@ -141,13 +187,13 @@ static int wled_sync_toggle(struct wled *wled)
>   	unsigned int mask = GENMASK(wled->max_string_count - 1, 0);
>   
>   	rc = regmap_update_bits(wled->regmap,
> -				wled->ctrl_addr + WLED_SINK_REG_SYNC,
> +				wled->sink_addr + WLED_SINK_REG_SYNC,
>   				mask, mask);
>   	if (rc < 0)
>   		return rc;
>   
>   	rc = regmap_update_bits(wled->regmap,
> -				wled->ctrl_addr + WLED_SINK_REG_SYNC,
> +				wled->sink_addr + WLED_SINK_REG_SYNC,
>   				mask, WLED_SINK_REG_SYNC_CLEAR);
>   
>   	return rc;
> @@ -274,6 +320,120 @@ static int wled3_setup(struct wled *wled)
>   	.cabc = false,
>   };
>   
> +static int wled4_setup(struct wled *wled)
> +{
> +	int rc, temp, i, j;
> +	u16 addr;
> +	u8 sink_en = 0;
> +	u32 sink_cfg = 0;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED_CTRL_REG_OVP,
> +				WLED_CTRL_REG_OVP_MASK, wled->cfg.ovp);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED_CTRL_REG_ILIMIT,
> +				WLED_CTRL_REG_ILIMIT_MASK,
> +				wled->cfg.boost_i_limit);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED_CTRL_REG_FREQ,
> +				WLED_CTRL_REG_FREQ_MASK,
> +				wled->cfg.switch_freq);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_read(wled->regmap, wled->sink_addr +
> +			 WLED4_SINK_REG_CURR_SINK, &sink_cfg);
> +	if (rc < 0)
> +		return rc;
> +
> +	for (i = 0; i < wled->cfg.num_strings; i++) {
> +		j = wled->cfg.enabled_strings[i];
> +		temp = j + WLED4_SINK_REG_CURR_SINK_SHFT;
> +		sink_en |= 1 << temp;
> +	}
> +
> +	if (sink_cfg == sink_en)
> +		return 0;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
> +				WLED4_SINK_REG_CURR_SINK_MASK, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
> +				WLED_CTRL_REG_MOD_EN,
> +				WLED_CTRL_REG_MOD_EN_MASK, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Per sink/string configuration */
> +	for (i = 0; i < wled->cfg.num_strings; i++) {
> +		j = wled->cfg.enabled_strings[i];
> +
> +		addr = wled->sink_addr +
> +				WLED4_SINK_REG_STR_MOD_EN(j);
> +		rc = regmap_update_bits(wled->regmap, addr,
> +					WLED4_SINK_REG_STR_MOD_MASK,
> +					WLED4_SINK_REG_STR_MOD_MASK);
> +		if (rc < 0)
> +			return rc;
> +
> +		addr = wled->sink_addr +
> +				WLED4_SINK_REG_STR_FULL_SCALE_CURR(j);
> +		rc = regmap_update_bits(wled->regmap, addr,
> +					WLED4_SINK_REG_STR_FULL_SCALE_CURR_MASK,
> +					wled->cfg.string_i_limit);
> +		if (rc < 0)
> +			return rc;
> +
> +		addr = wled->sink_addr +
> +				WLED4_SINK_REG_STR_CABC(j);
> +		rc = regmap_update_bits(wled->regmap, addr,
> +					WLED4_SINK_REG_STR_CABC_MASK,
> +					wled->cfg.cabc ?
> +					WLED4_SINK_REG_STR_CABC_MASK : 0);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
> +				WLED_CTRL_REG_MOD_EN,
> +				WLED_CTRL_REG_MOD_EN_MASK,
> +				WLED_CTRL_REG_MOD_EN_MASK);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
> +				WLED4_SINK_REG_CURR_SINK_MASK, sink_en);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = wled_sync_toggle(wled);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Failed to toggle sync reg rc:%d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct wled_config wled4_config_defaults = {
> +	.boost_i_limit = 4,
> +	.string_i_limit = 10,
> +	.ovp = 1,
> +	.num_strings = 4,
> +	.switch_freq = 11,
> +	.cabc = false,
> +};
> +
>   static const u32 wled3_boost_i_limit_values[] = {
>   	105, 385, 525, 805, 980, 1260, 1400, 1680,
>   };
> @@ -283,6 +443,15 @@ static int wled3_setup(struct wled *wled)
>   	.size = ARRAY_SIZE(wled3_boost_i_limit_values),
>   };
>   
> +static const u32 wled4_boost_i_limit_values[] = {
> +	105, 280, 450, 620, 970, 1150, 1300, 1500,
> +};
> +
> +static const struct wled_var_cfg wled4_boost_i_limit_cfg = {
> +	.values = wled4_boost_i_limit_values,
> +	.size = ARRAY_SIZE(wled4_boost_i_limit_values),
> +};
> +
>   static const u32 wled3_ovp_values[] = {
>   	35, 32, 29, 27,
>   };
> @@ -292,6 +461,15 @@ static int wled3_setup(struct wled *wled)
>   	.size = ARRAY_SIZE(wled3_ovp_values),
>   };
>   
> +static const u32 wled4_ovp_values[] = {
> +	31100, 29600, 19600, 18100,
> +};
> +
> +static const struct wled_var_cfg wled4_ovp_cfg = {
> +	.values = wled4_ovp_values,
> +	.size = ARRAY_SIZE(wled4_ovp_values),
> +};
> +
>   static u32 wled3_num_strings_values_fn(u32 idx)
>   {
>   	return idx + 1;
> @@ -302,6 +480,11 @@ static u32 wled3_num_strings_values_fn(u32 idx)
>   	.size = 3,
>   };
>   
> +static const struct wled_var_cfg wled4_num_strings_cfg = {
> +	.fn = wled3_num_strings_values_fn,
> +	.size = 4,
> +};
> +
>   static u32 wled3_switch_freq_values_fn(u32 idx)
>   {
>   	return 19200 / (2 * (1 + idx));
> @@ -316,10 +499,24 @@ static u32 wled3_switch_freq_values_fn(u32 idx)
>   	.size = 26,
>   };
>   
> +static const u32 wled4_string_i_limit_values[] = {
> +	0, 2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000,
> +	22500, 25000, 27500, 30000,
> +};
> +
> +static const struct wled_var_cfg wled4_string_i_limit_cfg = {
> +	.values = wled4_string_i_limit_values,
> +	.size = ARRAY_SIZE(wled4_string_i_limit_values),
> +};
> +
>   static const struct wled_var_cfg wled3_string_cfg = {
>   	.size = 8,
>   };
>   
> +static const struct wled_var_cfg wled4_string_cfg = {
> +	.size = 16,
> +};
> +
>   static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>   {
>   	if (idx >= cfg->size)
> @@ -332,6 +529,7 @@ static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>   }
>   
>   #define	WLED3	3
> +#define	WLED4	4

Are these macros always going to define 3 to be 3 and 4 to be 4. If so 
we probably don't need them (and they should be removed from patch 5/8 too).

There is a degree of nitpicking here however. The rest looks OK to me.


Daniel.
