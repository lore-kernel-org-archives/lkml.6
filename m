Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA5420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FESfycqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA5420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeFTFMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:12:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41462 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeFTFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:12:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so906159pgl.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZkXjhy14wP6pfMk+lq5gZqf3uDW3LUZSceeLQNcZCJU=;
        b=FESfycqBYZxqkpG59sEiBhyDV2oRf5+jOw53aGFq7bAc+qhMf9t+kciV9rAynz7f52
         dxa5rVrgNkjz8u5CZA6Jjm5TZlcwL32qN8GlbFqAw1mzibAgLpno7OdT5RRZPu1cYpk1
         xKvVb8DKSPPmyjjnMmAo6Tt7ij3cB3P1hO5zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZkXjhy14wP6pfMk+lq5gZqf3uDW3LUZSceeLQNcZCJU=;
        b=fysXxNlp+P20Om0gEERfCHxGfKISIvebake3WmAQutRdTpC+jUWWJHXABihFTx/z+y
         9fbx6YZgFME5w/KqWRcqs1tpqslHHs0BDNYOf8u4FVQAimBF8d68p6c6xmg92rTsFxIH
         UgoEa9Aq7ivI/phpvtMCDzN/cRJGxtBXAL1eCnLoVoXpS1Gl3ZkCqZMTjYEmZliOSGD8
         UTtqfeh5WPoewJXJ+8xCzM8E86FCD3zg+KhivNTkuyGvaElwNqfYtgLoSOi9aTuvlrao
         SgWdXOVsDnJ2XPCwzbKME30okehEDY+hRaZL8N7L67SzNYiY2Cn5XD+fZBP6fwM3GzXv
         7Lnw==
X-Gm-Message-State: APt69E0Iz/9GplX2GNKJwq1l4jsSaW+yNOa7eB4FjYG5fSAnG7lZoniR
        1bHYL56vSZGq1sXvlhcypAdHtw==
X-Google-Smtp-Source: ADUXVKJPcQY4yoI7qwqGbvhSWoETGl+wwhv8LcW3Vx/aA5Tvyrf/ooMnPidYm2FNKSaD/lH/IByqKw==
X-Received: by 2002:a63:6ecd:: with SMTP id j196-v6mr17850028pgc.12.1529471520086;
        Tue, 19 Jun 2018 22:12:00 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y72-v6sm2140867pff.128.2018.06.19.22.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 22:11:59 -0700 (PDT)
Date:   Tue, 19 Jun 2018 22:14:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH V3 5/7] backlight: qcom-wled: Add support for WLED4
 peripheral
Message-ID: <20180620051417.GI15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-6-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> WLED4 peripheral is present on some PMICs like pmi8998 and
> pm660l. It has a different register map and configurations
> are also different. Add support for it.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 635 ++++++++++++++++++++++++++++--------
>  1 file changed, 503 insertions(+), 132 deletions(-)

Split this further into a patch that does structural preparation of
WLED3 support and then an addition of WLED4, the mixture makes parts of
this patch almost impossible to review. Please find some comments below.

> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
>  
>  /* WLED3 sink registers */
>  #define WLED3_SINK_REG_SYNC				0x47

Drop the 3 from this if it's common between the two.

> -#define  WLED3_SINK_REG_SYNC_MASK			0x07
> +#define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
> +#define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
>  #define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
>  #define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
>  #define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
> +#define  WLED4_SINK_REG_SYNC_LED4			BIT(3)
>  #define  WLED3_SINK_REG_SYNC_ALL			0x07
> +#define  WLED4_SINK_REG_SYNC_ALL			0x0f
>  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>  
[..]
> +static int wled4_set_brightness(struct wled *wled, u16 brightness)

Afaict this is identical to wled3_set_brightness() with the exception
that there's a minimum brightness and the base address for the
brightness registers are different.

I would suggest that you add a min_brightness to wled and that you
figure out a way to carry the brightness base register address; and by
that you squash these two functions.

> +{
> +	int rc, i;
> +	u16 low_limit = wled->max_brightness * 4 / 1000;
> +	u8 v[2];
>  
> -		rc = regmap_bulk_write(wled->regmap,
> -				wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> -				v, 2);
> -		if (rc)
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
>  			return rc;
>  	}
>  
> +	return 0;
> +}
> +
> +static int wled_module_enable(struct wled *wled, int val)
> +{
> +	int rc;
> +
> +	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
> +				WLED3_CTRL_REG_MOD_EN,
> +				WLED3_CTRL_REG_MOD_EN_MASK,
> +				WLED3_CTRL_REG_MOD_EN_MASK);

This should depend on val.

> +	return rc;
> +}
> +
> +static int wled3_sync_toggle(struct wled *wled)
> +{
> +	int rc;
> +
>  	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_SINK_REG_SYNC,
> -			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_ALL);
> -	if (rc)
> +				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
> +				WLED3_SINK_REG_SYNC_MASK,
> +				WLED3_SINK_REG_SYNC_MASK);
> +	if (rc < 0)
>  		return rc;
>  
>  	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_SINK_REG_SYNC,
> -			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_CLEAR);
> +				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
> +				WLED3_SINK_REG_SYNC_MASK,
> +				WLED3_SINK_REG_SYNC_CLEAR);
> +
>  	return rc;
>  }
>  
> -static int wled_setup(struct wled *wled)
> +static int wled4_sync_toggle(struct wled *wled)

This is identical to wled3_sync_toggle() if you express the SYNC_MASK as
GENMASK(max-string-count, 0);

>  {
>  	int rc;
> -	int i;
>  
>  	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_OVP,
> -			WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
> -	if (rc)
> +				wled->sink_addr + WLED3_SINK_REG_SYNC,
> +				WLED4_SINK_REG_SYNC_MASK,
> +				WLED4_SINK_REG_SYNC_MASK);
> +	if (rc < 0)
>  		return rc;
>  
>  	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_ILIMIT,
> -			WLED3_CTRL_REG_ILIMIT_MASK, wled->cfg.boost_i_limit);
> +				wled->sink_addr + WLED3_SINK_REG_SYNC,
> +				WLED4_SINK_REG_SYNC_MASK,
> +				WLED3_SINK_REG_SYNC_CLEAR);
> +
> +	return rc;
> +}
> +
> +static int wled_update_status(struct backlight_device *bl)

You should be able to do the structural changes of this in one patch,
then follow up with the additions of WLED4 in a separate patch.

> +{
> +	struct wled *wled = bl_get_data(bl);
> +	u16 brightness = bl->props.brightness;
> +	int rc = 0;
> +
> +	if (bl->props.power != FB_BLANK_UNBLANK ||
> +	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> +	    bl->props.state & BL_CORE_FBBLANK)
> +		brightness = 0;
> +
> +	if (brightness) {
> +		rc = wled->wled_set_brightness(wled, brightness);
> +		if (rc < 0) {
> +			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
> +				rc);
> +			return rc;
> +		}
> +
> +		rc = wled->wled_sync_toggle(wled);
> +		if (rc < 0) {
> +			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
> +			return rc;
> +		}
> +	}
> +
> +	if (!!brightness != !!wled->brightness) {
> +		rc = wled_module_enable(wled, !!brightness);
> +		if (rc < 0) {
> +			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
> +			return rc;
> +		}
> +	}
> +
> +	wled->brightness = brightness;
> +
> +	return rc;
> +}
> +
> +static int wled3_setup(struct wled *wled)

Changes to this function should be unrelated to the addition of WLED4
support.

> +{
> +	u16 addr;
> +	u8 sink_en = 0;
> +	int rc, i, j;
> +
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + WLED3_CTRL_REG_OVP,
> +				WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
>  	if (rc)
>  		return rc;
>  
>  	rc = regmap_update_bits(wled->regmap,
> -			wled->addr + WLED3_CTRL_REG_FREQ,
> -			WLED3_CTRL_REG_FREQ_MASK, wled->cfg.switch_freq);
> +				wled->ctrl_addr + WLED3_CTRL_REG_ILIMIT,
> +				WLED3_CTRL_REG_ILIMIT_MASK,
> +				wled->cfg.boost_i_limit);
[..]
> @@ -392,15 +743,33 @@ static int wled_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	wled->regmap = regmap;
> +	wled->dev = &pdev->dev;
>  
> -	rc = wled_configure(wled, &pdev->dev);
> -	if (rc)
> -		return rc;
> +	wled->version = of_device_get_match_data(&pdev->dev);
> +	if (!wled->version) {
> +		dev_err(&pdev->dev, "Unknown device version\n");
> +		return -ENODEV;
> +	}
>  
> -	rc = wled_setup(wled);
> +	rc = wled_configure(wled);

Pass version as a parameter to wled_configure to make "version" a local
variable.

>  	if (rc)
>  		return rc;
>  
> +	if (*wled->version == WLED_PM8941) {

This would be better expressed with a select statement. And rather than
keeping track of every single version just stick to 3 and 4, if there
are further differences within version 4 let's try to encode these with
some sort of quirks or feature flags.

> +		rc = wled3_setup(wled);
> +		if (rc) {
> +			dev_err(&pdev->dev, "wled3_setup failed\n");
> +			return rc;
> +		}
> +	} else if (*wled->version == WLED_PMI8998 ||
> +			*wled->version == WLED_PM660L) {
> +		rc = wled4_setup(wled);
> +		if (rc) {
> +			dev_err(&pdev->dev, "wled4_setup failed\n");
> +			return rc;
> +		}
> +	}
> +
>  	val = WLED_DEFAULT_BRIGHTNESS;
>  	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
>  
> @@ -415,7 +784,9 @@ static int wled_probe(struct platform_device *pdev)
>  };
>  
>  static const struct of_device_id wled_match_table[] = {
> -	{ .compatible = "qcom,pm8941-wled" },
> +	{ .compatible = "qcom,pm8941-wled", .data = &version_table[0] },
> +	{ .compatible = "qcom,pmi8998-wled", .data = &version_table[1] },
> +	{ .compatible = "qcom,pm660l-wled", .data = &version_table[2] },

You can simply do .data = (void *)3 and .data = (void *)4 to pass the
WLED version to probe.

>  	{}
>  };

Regards,
Bjorn
