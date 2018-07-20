Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56424ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA82C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQdy7/ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA82C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGTOzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:55:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35965 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbeGTOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:55:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so11483992wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3aBH3Auw0nDb/jP2lXlkT5e9tLD44GenlLCmj5VqHQw=;
        b=jQdy7/kiGqbnV93zCW3Yf+Y8GbMt5ozKJWV7Kjx0qG5gMzOrxBhsOTU4M0ryG01JoV
         Cavr14LGnusNqsZonp8s9PnFvHzTupAmKVBmL21pRAhlgI74juO6J05dj9yHGoJc35B9
         1qiQGvhAo62ssMle1vDiKxvFv7bs0Hw7OyDBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3aBH3Auw0nDb/jP2lXlkT5e9tLD44GenlLCmj5VqHQw=;
        b=rutnBISG6Fwk5Dkjk9tBAbJ9x9FskhryHC/Vs31hagxfdjWwIOov65VhVFjnUmLiZH
         MZE2aV55g92u3yNpZ7mCBuMEl73GqCJcE2uAK7jjir0T1TKXJtBW3qBMhAPF1jVEPkJb
         xoIOCMnOe5R2zhVblelqOGJzbhCSh2BibPUTS958WmUfvRc1tBf5J/SPxgLD+jr70CgT
         LI3TgTgXmekcLQjElegPh1DUDofo6Dgf/EagAg4qgNh0xPgE3YSyR4wTBanIqqaCYkdk
         2vdtkiPRLfs03a1JxC6REVUXQzQu8rZtFnFOYjyx4/Ef8zX8sI4fBUW6nulHHV2YTmwH
         tSYA==
X-Gm-Message-State: AOUpUlE0OehqOqPRvNXyL5T/9lT/CSFCmcbPSJsL/szon3P3sdYcIc6H
        cmiLqcetBjtRe77SSCDrsnaPNw==
X-Google-Smtp-Source: AAOMgpc/YK4bb/PvFhjN5mTVO6kJSc6+XdJCuzJeG4rGgGjBm7NmZL1+U9Ugc6BFfCRycWJxoxqA5w==
X-Received: by 2002:a5d:4643:: with SMTP id j3-v6mr1592938wrs.52.1532095639973;
        Fri, 20 Jul 2018 07:07:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id o8-v6sm2050255wro.68.2018.07.20.07.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 07:07:18 -0700 (PDT)
Subject: Re: [PATCH V4 7/8] backlight: qcom-wled: add support for short
 circuit handling
To:     Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org,
        jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-8-git-send-email-kgunda@codeaurora.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <1a708fea-0759-fcd0-d169-a36e21c31c28@linaro.org>
Date:   Fri, 20 Jul 2018 15:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531131741-19971-8-git-send-email-kgunda@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> Handle the short circuit interrupt and check if the short circuit
> interrupt is valid. Re-enable the module to check if it goes
> away. Disable the module altogether if the short circuit event
> persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> Changes from V3:
> 	- Added Reviewed by tag.
> 	- Addressed minor comments from Vinod
> 
>   drivers/video/backlight/qcom-wled.c | 132 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 128 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 362d254..a14f1a6 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -10,6 +10,9 @@
>    * GNU General Public License for more details.
>    */
>   
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/ktime.h>
>   #include <linux/kernel.h>
>   #include <linux/backlight.h>
>   #include <linux/module.h>
> @@ -64,6 +67,16 @@
>   #define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
>   #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
>   
> +/* WLED4 specific control registers */
> +#define WLED4_CTRL_REG_SHORT_PROTECT			0x5e
> +#define  WLED4_CTRL_REG_SHORT_EN_MASK			BIT(7)
> +
> +#define WLED4_CTRL_REG_SEC_ACCESS			0xd0
> +#define  WLED4_CTRL_REG_SEC_UNLOCK			0xa5
> +
> +#define WLED4_CTRL_REG_TEST1				0xe2
> +#define  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2		0x09
> +
>   /* WLED4 specific sink registers */
>   #define WLED4_SINK_REG_CURR_SINK			0x46
>   #define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
> @@ -113,17 +126,23 @@ struct wled_config {
>   	bool cs_out_en;
>   	bool ext_gen;
>   	bool cabc;
> +	bool external_pfet;
>   };
>   
>   struct wled {
>   	const char *name;
>   	struct device *dev;
>   	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from thread irq handler */
> +	ktime_t last_short_event;
>   	u16 ctrl_addr;
>   	u16 sink_addr;
>   	u16 max_string_count;
>   	u32 brightness;
>   	u32 max_brightness;
> +	u32 short_count;
> +	bool disabled_by_short;
> +	bool has_short_detect;
>   
>   	struct wled_config cfg;
>   	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
> @@ -174,6 +193,9 @@ static int wled_module_enable(struct wled *wled, int val)
>   {
>   	int rc;
>   
> +	if (wled->disabled_by_short)
> +		return -EFAULT;

EFAULT means bad address (memory fault). Perhaps EIO or maybe even 
something more exotic like ENXIO might be more appropriate?


> +
>   	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>   				WLED_CTRL_REG_MOD_EN,
>   				WLED_CTRL_REG_MOD_EN_MASK,
> @@ -210,18 +232,19 @@ static int wled_update_status(struct backlight_device *bl)
>   	    bl->props.state & BL_CORE_FBBLANK)
>   		brightness = 0;
>   
> +	mutex_lock(&wled->lock);
>   	if (brightness) {
>   		rc = wled->wled_set_brightness(wled, brightness);
>   		if (rc < 0) {
>   			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
>   				rc);
> -			return rc;
> +			goto unlock_mutex;
>   		}
>   
>   		rc = wled_sync_toggle(wled);
>   		if (rc < 0) {
>   			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
> -			return rc;
> +			goto unlock_mutex;
>   		}
>   	}
>   
> @@ -229,15 +252,61 @@ static int wled_update_status(struct backlight_device *bl)
>   		rc = wled_module_enable(wled, !!brightness);
>   		if (rc < 0) {
>   			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
> -			return rc;
> +			goto unlock_mutex;
>   		}
>   	}
>   
>   	wled->brightness = brightness;
>   
> +unlock_mutex:
> +	mutex_unlock(&wled->lock);
> +
>   	return rc;
>   }
>   
> +#define WLED_SHORT_DLY_MS			20
> +#define WLED_SHORT_CNT_MAX			5
> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC
> +
> +static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
> +{
> +	struct wled *wled = _wled;
> +	int rc;
> +	s64 elapsed_time;
> +
> +	wled->short_count++;
> +	mutex_lock(&wled->lock);
> +	rc = wled_module_enable(wled, false);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "wled disable failed rc:%d\n", rc);
> +		goto unlock_mutex;
> +	}
> +
> +	elapsed_time = ktime_us_delta(ktime_get(),
> +				      wled->last_short_event);
> +	if (elapsed_time > WLED_SHORT_RESET_CNT_DLY_US)
> +		wled->short_count = 0;

Shouldn't this reset to 1 (e.g. we have just seen a short).


Daniel.
