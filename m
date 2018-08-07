Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C157DC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6294C21A34
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCxENBIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6294C21A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbeHGHzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:55:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36109 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbeHGHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:55:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so7997574pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0FHKPe/ZkUS7eNgW1w4N+jWhHOQ0OmMbb4sovGT9n3A=;
        b=GCxENBIpAdg6pu6twMOXgftNwJWd3vqq6yWtQFg+A9Xk4ioFRUzvc2kVsS+TPhQKDx
         PxBW5UwtV2v6dgRbpqvWgnRDN+w4xQTwSQ4BU/TNNm9UP1j0F4AQt3dkgUqi4IsNz5F5
         +5ZDnhxeFWC8Tv4vXYGrAHzbkSe7ZA54pgGMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0FHKPe/ZkUS7eNgW1w4N+jWhHOQ0OmMbb4sovGT9n3A=;
        b=nNJdNqUWAErWpFiBAwZvgE+sq+wVb137DYi32wn97U/2i3cPFLr2xFijUUsf4+Gxfa
         26UHRXHMajjcpBUBo3MC9YpHnb9GoxTyvvGE2WlgRCoEEMwUhs6PW4g/5Bsp2nUlniGg
         M6ywuCZwcDCfQNq2O98vfDVlIlc5vclrMj7p0QwR2po+kWlnr+TZhQF5CKPN82KXaGjf
         zHnChZjjbIGL9nZ0XhsHT5H/uacS6t3NgLfzn00NtqsjqrB0B/LVQzzktU67bpXtjbXJ
         0kC93jdJXnDdfUCjnMQms5GaXn+vckFiEW/yQbC+WyW+v1ZneBzuLByI0Y3AV5MHxz5V
         8eCA==
X-Gm-Message-State: AOUpUlEypoUV9k3IMJYvIDWIVhFiHUOmmqp0rGfo84ToDZgGwzxk4ESm
        DYHbFKrbZElABsrujAMzu1H2Bw==
X-Google-Smtp-Source: AAOMgpcOcByIyn6EPD1jm4SV4pzpI3HggPjD29Hfzx3zdCCOLQeqPVH5idSdy/on6p7gX5A2qvYS3A==
X-Received: by 2002:a63:cb04:: with SMTP id p4-v6mr16751190pgg.197.1533620547102;
        Mon, 06 Aug 2018 22:42:27 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q78-v6sm769578pfi.185.2018.08.06.22.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 22:42:26 -0700 (PDT)
Date:   Mon, 6 Aug 2018 22:45:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 6/8] backlight: qcom-wled: Add support for WLED4
 peripheral
Message-ID: <20180807054544.GD23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:

> WLED4 peripheral is present on some PMICs like pmi8998 and
> pm660l. It has a different register map and configurations
> are also different. Add support for it.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Changes from V3:
> 	- The WLED3 specific changes are splitted out
> 	- Merged the wled3_sync_toggle and wled4_syn_toggle functions
> 	- Modified the compatible .data
> 	- Moved from if/else to switch/case to select the version specific data
> 	- Addressed few more minor comments from Bjorn
> 
>  drivers/video/backlight/qcom-wled.c | 264 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 258 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 87fc1d0..362d254 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -64,6 +64,28 @@
>  #define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
>  #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
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
>  struct wled_var_cfg {
>  	const u32 *values;
>  	u32 (*fn)(u32);
> @@ -98,6 +120,7 @@ struct wled {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	u16 ctrl_addr;
> +	u16 sink_addr;
>  	u16 max_string_count;
>  	u32 brightness;
>  	u32 max_brightness;
> @@ -124,6 +147,29 @@ static int wled3_set_brightness(struct wled *wled, u16 brightness)
>  	return 0;
>  }
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
>  static int wled_module_enable(struct wled *wled, int val)
>  {
>  	int rc;
> @@ -141,13 +187,13 @@ static int wled_sync_toggle(struct wled *wled)
>  	unsigned int mask = GENMASK(wled->max_string_count - 1, 0);
>  
>  	rc = regmap_update_bits(wled->regmap,
> -				wled->ctrl_addr + WLED_SINK_REG_SYNC,
> +				wled->sink_addr + WLED_SINK_REG_SYNC,
>  				mask, mask);
>  	if (rc < 0)
>  		return rc;
>  
>  	rc = regmap_update_bits(wled->regmap,
> -				wled->ctrl_addr + WLED_SINK_REG_SYNC,
> +				wled->sink_addr + WLED_SINK_REG_SYNC,
>  				mask, WLED_SINK_REG_SYNC_CLEAR);
>  
>  	return rc;
> @@ -274,6 +320,120 @@ static int wled3_setup(struct wled *wled)
>  	.cabc = false,
>  };
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
>  static const u32 wled3_boost_i_limit_values[] = {
>  	105, 385, 525, 805, 980, 1260, 1400, 1680,
>  };
> @@ -283,6 +443,15 @@ static int wled3_setup(struct wled *wled)
>  	.size = ARRAY_SIZE(wled3_boost_i_limit_values),
>  };
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
>  static const u32 wled3_ovp_values[] = {
>  	35, 32, 29, 27,
>  };
> @@ -292,6 +461,15 @@ static int wled3_setup(struct wled *wled)
>  	.size = ARRAY_SIZE(wled3_ovp_values),
>  };
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
>  static u32 wled3_num_strings_values_fn(u32 idx)
>  {
>  	return idx + 1;
> @@ -302,6 +480,11 @@ static u32 wled3_num_strings_values_fn(u32 idx)
>  	.size = 3,
>  };
>  
> +static const struct wled_var_cfg wled4_num_strings_cfg = {
> +	.fn = wled3_num_strings_values_fn,
> +	.size = 4,
> +};
> +
>  static u32 wled3_switch_freq_values_fn(u32 idx)
>  {
>  	return 19200 / (2 * (1 + idx));
> @@ -316,10 +499,24 @@ static u32 wled3_switch_freq_values_fn(u32 idx)
>  	.size = 26,
>  };
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
>  static const struct wled_var_cfg wled3_string_cfg = {
>  	.size = 8,
>  };
>  
> +static const struct wled_var_cfg wled4_string_cfg = {
> +	.size = 16,
> +};
> +
>  static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>  {
>  	if (idx >= cfg->size)
> @@ -332,6 +529,7 @@ static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>  }
>  
>  #define	WLED3	3
> +#define	WLED4	4
>  
>  static int wled_configure(struct wled *wled, int version)
>  {
> @@ -370,6 +568,34 @@ static int wled_configure(struct wled *wled, int version)
>  		},
>  	};
>  
> +	const struct wled_u32_opts wled4_opts[] = {
> +		{
> +			.name = "qcom,current-boost-limit",
> +			.val_ptr = &cfg->boost_i_limit,
> +			.cfg = &wled4_boost_i_limit_cfg,
> +		},
> +		{
> +			.name = "qcom,current-limit-microamp",
> +			.val_ptr = &cfg->string_i_limit,
> +			.cfg = &wled4_string_i_limit_cfg,
> +		},
> +		{
> +			.name = "qcom,ovp-millivolt",
> +			.val_ptr = &cfg->ovp,
> +			.cfg = &wled4_ovp_cfg,
> +		},
> +		{
> +			.name = "qcom,switching-freq",
> +			.val_ptr = &cfg->switch_freq,
> +			.cfg = &wled3_switch_freq_cfg,
> +		},
> +		{
> +			.name = "qcom,num-strings",
> +			.val_ptr = &cfg->num_strings,
> +			.cfg = &wled4_num_strings_cfg,
> +		},
> +	};
> +
>  	const struct wled_bool_opts bool_opts[] = {
>  		{ "qcom,cs-out", &cfg->cs_out_en, },
>  		{ "qcom,ext-gen", &cfg->ext_gen, },
> @@ -383,10 +609,6 @@ static int wled_configure(struct wled *wled, int version)
>  	}
>  	wled->ctrl_addr = be32_to_cpu(*prop_addr);
>  
> -	rc = of_property_read_string(dev->of_node, "label", &wled->name);
> -	if (rc)
> -		wled->name = dev->of_node->name;
> -
>  	switch (version) {
>  	case WLED3:
>  		u32_opts = wled3_opts;
> @@ -394,6 +616,22 @@ static int wled_configure(struct wled *wled, int version)
>  		*cfg = wled3_config_defaults;
>  		wled->wled_set_brightness = wled3_set_brightness;
>  		wled->max_string_count = 3;
> +		wled->sink_addr = wled->ctrl_addr;
> +		break;
> +
> +	case WLED4:
> +		u32_opts = wled4_opts;
> +		size = ARRAY_SIZE(wled4_opts);
> +		*cfg = wled4_config_defaults;
> +		wled->wled_set_brightness = wled4_set_brightness;
> +		wled->max_string_count = 4;
> +
> +		prop_addr = of_get_address(dev->of_node, 1, NULL, NULL);
> +		if (!prop_addr) {
> +			dev_err(wled->dev, "invalid IO resources\n");
> +			return -EINVAL;
> +		}
> +		wled->sink_addr = be32_to_cpu(*prop_addr);
>  		break;
>  
>  	default:
> @@ -401,6 +639,10 @@ static int wled_configure(struct wled *wled, int version)
>  		break;
>  	}
>  
> +	rc = of_property_read_string(dev->of_node, "label", &wled->name);
> +	if (rc)
> +		wled->name = dev->of_node->name;
> +
>  	for (i = 0; i < size; ++i) {
>  		rc = of_property_read_u32(dev->of_node, u32_opts[i].name, &val);
>  		if (rc == -EINVAL) {
> @@ -492,6 +734,14 @@ static int wled_probe(struct platform_device *pdev)
>  		}
>  		break;
>  
> +	case WLED4:
> +		rc = wled4_setup(wled);
> +		if (rc) {
> +			dev_err(&pdev->dev, "wled4_setup failed\n");
> +			return rc;
> +		}
> +		break;
> +
>  	default:
>  		dev_err(wled->dev, "Invalid WLED version\n");
>  		break;
> @@ -512,6 +762,8 @@ static int wled_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id wled_match_table[] = {
>  	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
> +	{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
> +	{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, wled_match_table);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 
