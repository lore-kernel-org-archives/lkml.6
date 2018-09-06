Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D426520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+sxKzje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D426520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeIGAxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:53:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38185 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeIGAxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:53:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so12476359wmi.3;
        Thu, 06 Sep 2018 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P6QccByjGHCv5O8rvOthTdqU6QIK4nnPaDDb979JZwY=;
        b=A+sxKzjetJjJc+Mwdl2nmgHfqChvh/7LBf9CCwDh/0xbzryJHDWbTaD5s2QqNkpXaX
         S6RXDBCo6A5jIsIAXL2/Pm0if2U9r76fc52YGqWPLtJvZ4NSsJicSuzcsgbbPm7hNSfp
         KunABrYbVPHAE4F4Wqe9JjUVbGb5dQZCEMRm/E5YlQkMik3LQ5teMW/88+a63fbxTA/n
         SFh53ZDiKapGJcYywEcmxqyX0Q/SKoPlivYkd59HTZNK/1UBWX5ryQ8qhkx6aIjbgMu4
         EpXtN7Ewxr3cL3OgXpSJEJhWgULFpQ0914LPW6qPRHSbmdwQ+twtTkfFUKz/O/Xk6xvq
         EigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6QccByjGHCv5O8rvOthTdqU6QIK4nnPaDDb979JZwY=;
        b=RSppfgzeo3x5POCdxXhv0BDdXv10jfwwRP+MddHYoRy5JwP855kVlCNzmfVMcAwAas
         QocRGKt7OD5qKJSt2h2YBLykHjD/C6AzJpEO+NZ8n2OQCH5Ze0fIQiB5Q+RhnPwk9ajt
         6dt/xymsBhCVOXbsf6lFVtmbMXnXCNfoyH+FTD8UO4zmwvnI7hafKm+EnJXavPOrwPC+
         Us+cQOmrddTc7v1VzwOjqa3OCXhQX3nHgQjKFtRQgT3l8p6zg4/ap3Nl0ErMe3VLsEQq
         S8HJ+khMeKYaM3PVLWwv6/HQkYaD8j3yMU1WlF1xPFtVl9HVKtjeFBj5aVLl14lXFPCB
         mhyA==
X-Gm-Message-State: APzg51CCIAwg1JGm9kE780OM/y47G3SW6G5ZaN06tv/3Px5xIJkdSd5R
        ysy0tDis/aoBN0a/oICUQ2N7NMhy
X-Google-Smtp-Source: ANB0VdbdFRkb/pBZM+AaQNRYvpPYgGswIqgQUKD4lf4qolsds8iLXdfGTpfGBge6LjKRzi2cythJvQ==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr3431702wmd.52.1536264968277;
        Thu, 06 Sep 2018 13:16:08 -0700 (PDT)
Received: from [192.168.1.18] (bku150.neoplus.adsl.tpnet.pl. [83.28.188.150])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6062743wrb.45.2018.09.06.13.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:16:07 -0700 (PDT)
Subject: Re: [PATCH v10 2/2] leds: sc27xx: Add pattern_set/clear interfaces
 for LED controller
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536200860.git.baolin.wang@linaro.org>
 <975a9570c75fb4469c0cef55cc9ed42266f933af.1536200860.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ae29d9b4-e5f8-a00d-df74-fb20328e4634@gmail.com>
Date:   Thu, 6 Sep 2018 22:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <975a9570c75fb4469c0cef55cc9ed42266f933af.1536200860.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the patch. I really appreciate your effort.

I see one more thing I forgot to mention in the previous
review. Please take a look at my comment to pattern_set().

On 09/06/2018 04:37 AM, Baolin Wang wrote:
> This patch implements the 'pattern_set'and 'pattern_clear'
> interfaces to support SC27XX LED breathing mode.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v9:
>  - Optimize the ABI documentation file.
>  - Update the brightness value in hardware pattern mode.
> 
> Changes from v8:
>  - Optimize the ABI documentation file.
> 
> Changes from v7:
>  - Add its own ABI documentation file.
> 
> Changes from v6:
>  - None.
> 
> Changes from v5:
>  - None.
> 
> Changes from v4:
>  - None.
> 
> Changes from v3:
>  - None.
> 
> Changes from v2:
>  - None.
> 
> Changes from v1:
>  - Remove pattern_get interface.
> ---
>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   22 +++++
>  drivers/leds/leds-sc27xx-bltc.c                    |  103 ++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> new file mode 100644
> index 0000000..d8056d5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> @@ -0,0 +1,22 @@
> +What:		/sys/class/leds/<led>/hw_pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a hardware pattern for the SC27XX LED. For the SC27XX
> +		LED controller, it only supports 4 stages to make a single
> +		hardware pattern, which is used to configure the rise time,
> +		high time, fall time and low time for the breathing mode.
> +
> +		For the breathing mode, the SC27XX LED only expects one brightness
> +		for the high stage. To be compatible with the hardware pattern
> +		format, we should set brightness as 0 for rise stage, fall
> +		stage and low stage.
> +
> +		Min stage duration: 125 ms
> +		Max stage duration: 31875 ms
> +
> +		Since the stage duration step is 125 ms, the duration must be
> +		a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
> +
> +		Thus the format of the hardware pattern values should be:
> +		"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index 9d9b7aa..558a325 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -32,8 +32,15 @@
>  #define SC27XX_DUTY_MASK	GENMASK(15, 0)
>  #define SC27XX_MOD_MASK		GENMASK(7, 0)
>  
> +#define SC27XX_CURVE_SHIFT	8
> +#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
> +#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
> +
>  #define SC27XX_LEDS_OFFSET	0x10
>  #define SC27XX_LEDS_MAX		3
> +#define SC27XX_LEDS_PATTERN_CNT	4
> +/* Stage duration step, in milliseconds */
> +#define SC27XX_LEDS_STEP	125
>  
>  struct sc27xx_led {
>  	char name[LED_MAX_NAME_SIZE];
> @@ -122,6 +129,98 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
>  	return err;
>  }
>  
> +static int sc27xx_led_pattern_clear(struct led_classdev *ldev)
> +{
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	struct regmap *regmap = leds->priv->regmap;
> +	u32 base = sc27xx_led_get_offset(leds);
> +	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
> +	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
> +	int err;
> +
> +	mutex_lock(&leds->priv->lock);
> +
> +	/* Reset the rise, high, fall and low time to zero. */
> +	regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
> +	regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
> +
> +	err = regmap_update_bits(regmap, ctrl_base,
> +			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
> +
> +	ldev->brightness = LED_OFF;
> +
> +	mutex_unlock(&leds->priv->lock);
> +
> +	return err;
> +}
> +
> +static int sc27xx_led_pattern_set(struct led_classdev *ldev,
> +				  struct led_pattern *pattern,
> +				  int len, u32 repeat)
> +{
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 base = sc27xx_led_get_offset(leds);
> +	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
> +	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
> +	struct regmap *regmap = leds->priv->regmap;
> +	int err;
> +
> +	/*
> +	 * Must contain 4 tuples to configure the rise time, high time, fall
> +	 * time and low time to enable the breathing mode.
> +	 */
> +	if (len != SC27XX_LEDS_PATTERN_CNT)
> +		return -EINVAL;
> +
> +	mutex_lock(&leds->priv->lock);

Please add below macros at the top of the file and the function
shown. It will allow to nicely align the value provided by
the user to the nearest delta_t step. We have similar thing
in led_class_flash.c (led_clamp_align()), that was adopted from
v4l2-ctrls.c.

#define SC27XX_DELTA_T_MIN SC27XX_LEDS_STEP
#define SC27XX_DELTA_T_MAX (SC27XX_LEDS_STEP * 255)

static void sc27xx_led_clamp_align_delta_t(u32 *delta_t)
{
	u32 v, offset, t = *delta_t;

	v = t + SC27XX_LEDS_STEP / 2;
	v = clamp(v, SC27XX_DELTA_T_MIN, SC27XX_DELTA_T_MAX);
	offset = v - SC27XX_DELTA_T_MIN;
	offset = SC27XX_LEDS_STEP * (offset / SC27XX_LEDS_STEP);
	*delta_t = SC27XX_DELTA_T_MIN + offset;
}

Then call the function for each delta_t before writing it to the device:

sc27xx_led_clamp_align_delta_t(&pattern[0].delta_t);
sc27xx_led_clamp_align_delta_t(&pattern[1].delta_t);
sc27xx_led_clamp_align_delta_t(&pattern[2].delta_t);
sc27xx_led_clamp_align_delta_t(&pattern[3].delta_t);

Also, regarding PATCH v8 1/2, please change the types of properties
in struct led_pattern as follows:

+struct led_pattern {
+	u32 delta_t;
+	enum led_brightness brightness;
+};
+

Best regards,
Jacek Anaszewski

> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +				 SC27XX_CURVE_L_MASK,
> +				 pattern[0].delta_t / SC27XX_LEDS_STEP);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +				 SC27XX_CURVE_L_MASK,
> +				 pattern[1].delta_t / SC27XX_LEDS_STEP);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +				 SC27XX_CURVE_H_MASK,
> +				 (pattern[2].delta_t / SC27XX_LEDS_STEP) <<
> +				 SC27XX_CURVE_SHIFT);
> +	if (err)
> +		goto out;
> +
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +				 SC27XX_CURVE_H_MASK,
> +				 (pattern[3].delta_t / SC27XX_LEDS_STEP) <<
> +				 SC27XX_CURVE_SHIFT);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
> +				 SC27XX_DUTY_MASK,
> +				 (pattern[1].brightness << SC27XX_DUTY_SHIFT) |
> +				 SC27XX_MOD_MASK);
> +	if (err)
> +		goto out;
> +
> +	/* Enable the LED breathing mode */
> +	err = regmap_update_bits(regmap, ctrl_base,
> +				 SC27XX_LED_RUN << ctrl_shift,
> +				 SC27XX_LED_RUN << ctrl_shift);
> +	if (!err)
> +		ldev->brightness = pattern[1].brightness;
> +
> +out:
> +	mutex_unlock(&leds->priv->lock);
> +
> +	return err;
> +}
> +
>  static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
>  {
>  	int i, err;
> @@ -140,6 +239,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
>  		led->priv = priv;
>  		led->ldev.name = led->name;
>  		led->ldev.brightness_set_blocking = sc27xx_led_set;
> +		led->ldev.pattern_set = sc27xx_led_pattern_set;
> +		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
> +		led->ldev.default_trigger = "pattern";
>  
>  		err = devm_led_classdev_register(dev, &led->ldev);
>  		if (err)
> @@ -241,4 +343,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
>  
>  MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
>  MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
>  MODULE_LICENSE("GPL v2");
> 


