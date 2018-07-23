Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1174ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6033220846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ammypJMz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c9YMSN13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6033220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeGWHFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:05:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeGWHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:05:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 86679605A4; Mon, 23 Jul 2018 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325927;
        bh=PzCN+2JayvpFW0q7ArbKulGa7bsNqg/7z1gYzdguHzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ammypJMzdKtJEACX9lJhdSh7TLS/ixeceVeQGKkGKidRKt1OOmuXDBK3aSt3wmGJE
         lJbZU+HLDx8sGXamw8Hhi0N3lVCSK0ZfdkBHd+qmhrWkq9lZbFjX4GfSXJJje2QoQh
         73iXcMLNAT5aAF8X2HRxWQHsbv51f9DINoOH6BWI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2CDF2605A4;
        Mon, 23 Jul 2018 06:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325926;
        bh=PzCN+2JayvpFW0q7ArbKulGa7bsNqg/7z1gYzdguHzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c9YMSN13tjuevitn+sh/O1WBfE61+YpkJujLTqyK4tgidJTOUAP7TUMvhgc9qdC8K
         iDA0ZF8r4AuAiX8gprKfNtzdFRPqZVpclULbo9yAbtGkSALOJo5SDnHDUriRxAZSoR
         WLw5god+adh7ofPkkUAtRPrIzXqk6TJ06HU+Jysk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 11:35:26 +0530
From:   kgunda@codeaurora.org
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 7/8] backlight: qcom-wled: add support for short
 circuit handling
In-Reply-To: <1a708fea-0759-fcd0-d169-a36e21c31c28@linaro.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-8-git-send-email-kgunda@codeaurora.org>
 <1a708fea-0759-fcd0-d169-a36e21c31c28@linaro.org>
Message-ID: <56933684196ae55e470375b1288ccddb@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 19:37, Daniel Thompson wrote:
> On 09/07/18 11:22, Kiran Gunda wrote:
>> Handle the short circuit interrupt and check if the short circuit
>> interrupt is valid. Re-enable the module to check if it goes
>> away. Disable the module altogether if the short circuit event
>> persists.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>> Changes from V3:
>> 	- Added Reviewed by tag.
>> 	- Addressed minor comments from Vinod
>> 
>>   drivers/video/backlight/qcom-wled.c | 132 
>> ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 128 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 362d254..a14f1a6 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -10,6 +10,9 @@
>>    * GNU General Public License for more details.
>>    */
>>   +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/ktime.h>
>>   #include <linux/kernel.h>
>>   #include <linux/backlight.h>
>>   #include <linux/module.h>
>> @@ -64,6 +67,16 @@
>>   #define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
>>   #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
>>   +/* WLED4 specific control registers */
>> +#define WLED4_CTRL_REG_SHORT_PROTECT			0x5e
>> +#define  WLED4_CTRL_REG_SHORT_EN_MASK			BIT(7)
>> +
>> +#define WLED4_CTRL_REG_SEC_ACCESS			0xd0
>> +#define  WLED4_CTRL_REG_SEC_UNLOCK			0xa5
>> +
>> +#define WLED4_CTRL_REG_TEST1				0xe2
>> +#define  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2		0x09
>> +
>>   /* WLED4 specific sink registers */
>>   #define WLED4_SINK_REG_CURR_SINK			0x46
>>   #define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
>> @@ -113,17 +126,23 @@ struct wled_config {
>>   	bool cs_out_en;
>>   	bool ext_gen;
>>   	bool cabc;
>> +	bool external_pfet;
>>   };
>>     struct wled {
>>   	const char *name;
>>   	struct device *dev;
>>   	struct regmap *regmap;
>> +	struct mutex lock;	/* Lock to avoid race from thread irq handler */
>> +	ktime_t last_short_event;
>>   	u16 ctrl_addr;
>>   	u16 sink_addr;
>>   	u16 max_string_count;
>>   	u32 brightness;
>>   	u32 max_brightness;
>> +	u32 short_count;
>> +	bool disabled_by_short;
>> +	bool has_short_detect;
>>     	struct wled_config cfg;
>>   	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
>> @@ -174,6 +193,9 @@ static int wled_module_enable(struct wled *wled, 
>> int val)
>>   {
>>   	int rc;
>>   +	if (wled->disabled_by_short)
>> +		return -EFAULT;
> 
> EFAULT means bad address (memory fault). Perhaps EIO or maybe even
> something more exotic like ENXIO might be more appropriate?
> 
> 
>> +
>>   	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>>   				WLED_CTRL_REG_MOD_EN,
>>   				WLED_CTRL_REG_MOD_EN_MASK,
>> @@ -210,18 +232,19 @@ static int wled_update_status(struct 
>> backlight_device *bl)
>>   	    bl->props.state & BL_CORE_FBBLANK)
>>   		brightness = 0;
>>   +	mutex_lock(&wled->lock);
>>   	if (brightness) {
>>   		rc = wled->wled_set_brightness(wled, brightness);
>>   		if (rc < 0) {
>>   			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
>>   				rc);
>> -			return rc;
>> +			goto unlock_mutex;
>>   		}
>>     		rc = wled_sync_toggle(wled);
>>   		if (rc < 0) {
>>   			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
>> -			return rc;
>> +			goto unlock_mutex;
>>   		}
>>   	}
>>   @@ -229,15 +252,61 @@ static int wled_update_status(struct 
>> backlight_device *bl)
>>   		rc = wled_module_enable(wled, !!brightness);
>>   		if (rc < 0) {
>>   			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
>> -			return rc;
>> +			goto unlock_mutex;
>>   		}
>>   	}
>>     	wled->brightness = brightness;
>>   +unlock_mutex:
>> +	mutex_unlock(&wled->lock);
>> +
>>   	return rc;
>>   }
>>   +#define WLED_SHORT_DLY_MS			20
>> +#define WLED_SHORT_CNT_MAX			5
>> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC
>> +
>> +static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
>> +{
>> +	struct wled *wled = _wled;
>> +	int rc;
>> +	s64 elapsed_time;
>> +
>> +	wled->short_count++;
>> +	mutex_lock(&wled->lock);
>> +	rc = wled_module_enable(wled, false);
>> +	if (rc < 0) {
>> +		dev_err(wled->dev, "wled disable failed rc:%d\n", rc);
>> +		goto unlock_mutex;
>> +	}
>> +
>> +	elapsed_time = ktime_us_delta(ktime_get(),
>> +				      wled->last_short_event);
>> +	if (elapsed_time > WLED_SHORT_RESET_CNT_DLY_US)
>> +		wled->short_count = 0;
> 
> Shouldn't this reset to 1 (e.g. we have just seen a short).
> 
> 
> Daniel.
Ok. I will change it in the next series.
