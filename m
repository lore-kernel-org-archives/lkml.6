Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F38C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9A20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1staAEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F9A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIEXqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:46:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:46:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id o37-v6so8806339wrf.6;
        Wed, 05 Sep 2018 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UC+lEbsZCVrcHR4dwHNxdfAGuGD4rW3SMTCPIcMIdSg=;
        b=F1staAEeOv83zXlQ9Y7v8IK/DkaHEXTM5hr6YY2IRUJbVT64wTo5CGvmydefy2Pujg
         SEVTkTycFak2U0CIz8fLuiGsAYZWYur0En8V63bLM4+ZgyfaLlDk/fg1Dsb2FBF4yMXg
         8yo1OaUp8awlEWb8XwX4hbKafe2aCOeL4qq87NnfpUj2g8WVkBr1Z1j2aRYBwodLx0Y4
         A262Vh6jA0ZRoM8ayugqLBqW+VcMpdAMZRTCwbqDdpKTzVCATvkoykYMJaQBXTvQ1Win
         vjMRmb784YD9fNC2g+9VGyvJ0HmmICqIbQRpkoOlKuld8FolpRrhC4YCNjWhIYb31jdZ
         X2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UC+lEbsZCVrcHR4dwHNxdfAGuGD4rW3SMTCPIcMIdSg=;
        b=kFE2k7IA0305fwvKj/U+UhpDz2qN4TL7i8sqm8VUlJUHgGYq8wX5JWKtg9boyUTae5
         DfmuB50oCVZD7U5ipMbk/5QsoudiHMMGFP/mLDHpeVBI3Dr7uJva1Vbe990zaASqTer9
         T0n05dGVwUw5Bq3OSZ4oL1BqAplqixfNl/89IAPqih3iNqCC2l1be09NuS9ZuwzogOAU
         VaCfOqhF/I5g3NwGUFouV1VUOuDCP+58abzYUt5ZnrEn42LqGC/60e2Fq1c2/fFTub93
         pTlJUYulatVC0DirWf+NltRexrqFodZUvYdjaR2pDAS4lmK1+BJpQxvUbXwNH0CdRiUP
         aS0g==
X-Gm-Message-State: APzg51Bi2b1kk2INfHLBuZRpJREsCzyulM77tpraqIltsNDfPhF214AC
        DaZ3qNFs1kwh5pIx0K5wYny5Hdgb
X-Google-Smtp-Source: ANB0VdaF3zXMPTk1VwIjyMcptSXzxxsiAZJhhJNCAb8KLp1GwvFqjYaw/ec75nQOH8UlEM4d/nXSsg==
X-Received: by 2002:adf:b583:: with SMTP id c3-v6mr28145068wre.79.1536174881156;
        Wed, 05 Sep 2018 12:14:41 -0700 (PDT)
Received: from [192.168.1.18] (ckf221.neoplus.adsl.tpnet.pl. [83.31.81.221])
        by smtp.gmail.com with ESMTPSA id c10-v6sm5989463wrb.17.2018.09.05.12.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:14:40 -0700 (PDT)
Subject: Re: [PATCH v9 2/2] leds: sc27xx: Add pattern_set/clear interfaces for
 LED controller
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536131926.git.baolin.wang@linaro.org>
 <b079d9a27390d6589195906606e6bac143bdb95c.1536131926.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <059de1cc-e964-6976-15c6-bfb3385e1fcf@gmail.com>
Date:   Wed, 5 Sep 2018 21:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b079d9a27390d6589195906606e6bac143bdb95c.1536131926.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thanks for the v9.

On 09/05/2018 09:20 AM, Baolin Wang wrote:
> This patch implements the 'pattern_set'and 'pattern_clear'
> interfaces to support SC27XX LED breathing mode.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
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
>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   20 +++++
>  drivers/leds/leds-sc27xx-bltc.c                    |   93 ++++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> new file mode 100644
> index 0000000..391ca6e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> @@ -0,0 +1,20 @@
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
> +		Min stage duration: 1
> +		Max stage duration: 255
> +		Stage duration step: 125 ms

It seems that min and max stage duration are given in device
specific levels in contrary to the step which is given in ms.
Please keep it consistent. If I'm getting it right then duration
constraints should be given as follows:

Min stage duration: 125 ms
Max stage duration: 31875 ms

> +
> +		Thus the format of the hardware pattern values should be:
> +		"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index 9d9b7aa..bff2f8f 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -32,8 +32,13 @@
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
>  
>  struct sc27xx_led {
>  	char name[LED_MAX_NAME_SIZE];
> @@ -122,6 +127,90 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
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

What is the LED brightness after executing the above?
Is it the pattern high stage brightness?
Or maybe it is LED_OFF?

We should update LED class device brightness accordingly.

If it is set to LED_OFF then we should update LED class device
brightness here:

led->ldev.brightness = LED_OFF;

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
> +	 * Must contain 4 patterns to configure the rise time, high time, fall
> +	 * time and low time to enable the breathing mode.
> +	 */
> +	if (len != SC27XX_LEDS_PATTERN_CNT)
> +		return -EINVAL;
> +
> +	mutex_lock(&leds->priv->lock);
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +				 SC27XX_CURVE_L_MASK, pattern[0].delta_t);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +				 SC27XX_CURVE_L_MASK, pattern[1].delta_t);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +				 SC27XX_CURVE_H_MASK,
> +				 pattern[2].delta_t << SC27XX_CURVE_SHIFT);
> +	if (err)
> +		goto out;
> +
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +				 SC27XX_CURVE_H_MASK,
> +				 pattern[3].delta_t << SC27XX_CURVE_SHIFT);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
> +				 SC27XX_DUTY_MASK,
> +				 (pattern[1].brightness << SC27XX_DUTY_SHIFT) |
> +				 SC27XX_MOD_MASK);

Continuing the reasoning from my comment to pattern_clear() above -
if old brightness is not brought back after clearing the pattern,
then we should set it to high stage brightness here, to keep the
brightness level reported by the sysfs at least somehow consistent
with the pattern:

led->ldev.brightness = pattern[1].brightness;

> +	if (err)
> +		goto out;
> +
> +	/* Enable the LED breathing mode */
> +	err = regmap_update_bits(regmap, ctrl_base,
> +				 SC27XX_LED_RUN << ctrl_shift,
> +				 SC27XX_LED_RUN << ctrl_shift);
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
> @@ -140,6 +229,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
>  		led->priv = priv;
>  		led->ldev.name = led->name;
>  		led->ldev.brightness_set_blocking = sc27xx_led_set;
> +		led->ldev.pattern_set = sc27xx_led_pattern_set;
> +		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
> +		led->ldev.default_trigger = "pattern";
>  
>  		err = devm_led_classdev_register(dev, &led->ldev);
>  		if (err)
> @@ -241,4 +333,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
>  
>  MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
>  MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
>  MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski
