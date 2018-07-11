Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA3C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696E2213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuwwkDUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696E2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbeGKVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:16:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeGKVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:16:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so12997958wrr.8;
        Wed, 11 Jul 2018 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HCHUZiHflqxlxRq3k/etxstrlbwkpJO5ym5VXEuQ1DA=;
        b=kuwwkDUeBSXx5+oxD+7uvgSyBYl3aBO17yaeUltsSnO7zrEDkZBuhPFBNwmLEZMLcu
         Wgg/4IhcA9yaM8lyHYqsa6O+YNHIZ9omBhu4mgQCryaI6iIJu/i8z/7HI5X/zFBJEvUS
         MHn1ueZRdOh8uiyzRRhxjN9qvuAl8JHZI7ti0OaKm7KjkrP32ZDSIFB9Xuofd0Dl7wSE
         75v7sE2pyFSKBvnbFKABOuYSXUAHTtQOlF4kZXcXwYDtfQ7Q1FYC42MS4lIR+UabNYC1
         pADI8BMU2Aksji9r+dbzMvPsaUvS+GX5lS562pO3R1SFkQRhJ1WqV2NkO1rpAEbTST/S
         FUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HCHUZiHflqxlxRq3k/etxstrlbwkpJO5ym5VXEuQ1DA=;
        b=n+I+5wO2O9W1M4qAS+n7WkZX4TRxaOdxw8cdDwetDjCMokhOBOrBRPZwAIizLMdAUr
         jrJCnGqUnCB5ak4rgTli0RSez5ZlB7HDPopVwxEYUweAWNQKW+Q0QGz5KT8mgJEyuWNz
         6+jL3Rdy2GW+JvoTqEF/nSRsrZBNrsOL6wyqdUuxdA4Zjayuzm1u+Ni84pBvSdsOV5bq
         cmMH2k+ebbD2TmNIa2+YmZb6J+AChjAAmGUZ+tXNW7sMPwfLDaCAq19atX+Jw+/ePw4t
         xYyuTz+P+rAO0uypuRa8dUvgfNnSRLreoA8ZmTDfxxMZBZP+UhOHBQ2xBw7Gi4mCTbwR
         HvrA==
X-Gm-Message-State: AOUpUlEA0tKOOYRI5JtrWokEkMQrOKyBrQbBPFaNCOZLPvrD5axbWCfi
        rbxBFK6qOfeUFOpw2tH8gFslK/5B
X-Google-Smtp-Source: AAOMgpcW95ydh3Dr+gk3ozIUwI5pXvUWpkxgmu1S1pzT7gcEHeoTJn8qu10BVPpOItN9PBrfsJLAiA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr153062wrs.137.1531343430180;
        Wed, 11 Jul 2018 14:10:30 -0700 (PDT)
Received: from [192.168.1.18] (bfv14.neoplus.adsl.tpnet.pl. [83.28.59.14])
        by smtp.gmail.com with ESMTPSA id c17-v6sm17043252wrp.54.2018.07.11.14.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 14:10:29 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Baolin Wang <baolin.wang@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
Message-ID: <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
Date:   Wed, 11 Jul 2018 23:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin.

On 07/11/2018 01:02 PM, Baolin Wang wrote:
> Hi Jacek and Pavel,
> 
> On 29 June 2018 at 13:03, Baolin Wang <baolin.wang@linaro.org> wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> Some LED controllers have support for autonomously controlling
>> brightness over time, according to some preprogrammed pattern or
>> function.
>>
>> This adds a new optional operator that LED class drivers can implement
>> if they support such functionality as well as a new device attribute to
>> configure the pattern for a given LED.
>>
>> [Baolin Wang did some minor improvements.]
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v2:
>>   - Change kernel version to 4.19.
>>   - Force user to return error pointer if failed to issue pattern_get().
>>   - Use strstrip() to trim trailing newline.
>>   - Other optimization.
>>
>> Changes from v1:
>>   - Add some comments suggested by Pavel.
>>   - Change 'delta_t' can be 0.
>>
>> Note: I removed the pattern repeat check and will get the repeat number by adding
>> one extra file named 'pattern_repeat' according to previous discussion.
>> ---
> 
> Do you have any comments for this version patch set? Thanks.

I tried modifying uleds.c driver to support pattern ops, but
I'm getting segfault when doing "cat pattern". I didn't give
it serious testing and analysis - will do it at weekend.

It also drew my attention to the issue of desired pattern sysfs
interface semantics on uninitialized pattern. In your implementation
user seems to be unable to determine if the pattern is activated
or not. We should define the semantics for this use case and
describe it in the documentation. Possibly pattern could
return alone new line character then.

This is the code snippet I've used for testing pattern interface:

static struct led_pattern ptrn[10];
static int ptrn_len;

static int uled_pattern_clear(struct led_classdev *ldev)
{
	return 0;
}

static int uled_pattern_set(struct led_classdev *ldev,
				  struct led_pattern *pattern,
				  int len)
{
	int i;

	for (i = 0; i < len; i++) {
		ptrn[i].brightness = pattern[i].brightness;
		ptrn[i].delta_t = pattern[i].delta_t;
	}

	ptrn_len = len;

	return 0;
}

static struct led_pattern *uled_pattern_get(struct led_classdev *ldev,
						  int *len)
{
	int i;

	for (i = 0; i < ptrn_len; i++) {
		ptrn[i].brightness = 3;
		ptrn[i].delta_t = 5;
	}

	*len = ptrn_len;

	return ptrn;
}


> 
>>   Documentation/ABI/testing/sysfs-class-led |   17 +++++
>>   drivers/leds/led-class.c                  |  119 +++++++++++++++++++++++++++++
>>   include/linux/leds.h                      |   19 +++++
>>   3 files changed, 155 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
>> index 5f67f7a..e01ac55 100644
>> --- a/Documentation/ABI/testing/sysfs-class-led
>> +++ b/Documentation/ABI/testing/sysfs-class-led
>> @@ -61,3 +61,20 @@ Description:
>>                  gpio and backlight triggers. In case of the backlight trigger,
>>                  it is useful when driving a LED which is intended to indicate
>>                  a device in a standby like state.
>> +
>> +What: /sys/class/leds/<led>/pattern
>> +Date: June 2018
>> +KernelVersion: 4.19
>> +Description:
>> +       Specify a pattern for the LED, for LED hardware that support
>> +       altering the brightness as a function of time.
>> +
>> +       The pattern is given by a series of tuples, of brightness and
>> +       duration (ms). The LED is expected to traverse the series and
>> +       each brightness value for the specified duration. Duration of
>> +       0 means brightness should immediately change to new value.
>> +
>> +       As LED hardware might have different capabilities and precision
>> +       the requested pattern might be slighly adjusted by the driver
>> +       and the resulting pattern of such operation should be returned
>> +       when this file is read.
>> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
>> index 3c7e348..8a685a2 100644
>> --- a/drivers/leds/led-class.c
>> +++ b/drivers/leds/led-class.c
>> @@ -74,6 +74,123 @@ static ssize_t max_brightness_show(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RO(max_brightness);
>>
>> +static ssize_t pattern_show(struct device *dev,
>> +                           struct device_attribute *attr, char *buf)
>> +{
>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +       struct led_pattern *pattern;
>> +       size_t offset = 0;
>> +       int count, n, i;
>> +
>> +       if (!led_cdev->pattern_get)
>> +               return -EOPNOTSUPP;

Please check this in led_classdev_register() and fail
if pattern_set is initialized, but pattern_get or pattern_clear not.

>> +       pattern = led_cdev->pattern_get(led_cdev, &count);
>> +       if (IS_ERR(pattern))
>> +               return PTR_ERR(pattern);
>> +
>> +       for (i = 0; i < count; i++) {
>> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d ",
>> +                            pattern[i].brightness, pattern[i].delta_t);
>> +
>> +               if (offset + n >= PAGE_SIZE)
>> +                       goto err_nospc;
>> +
>> +               offset += n;
>> +       }
>> +
>> +       buf[offset - 1] = '\n';
>> +
>> +       kfree(pattern);
>> +       return offset;
>> +
>> +err_nospc:
>> +       kfree(pattern);
>> +       return -ENOSPC;
>> +}
>> +
>> +static ssize_t pattern_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t size)
>> +{
>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +       struct led_pattern *pattern = NULL;
>> +       unsigned long val;
>> +       char *sbegin;
>> +       char *elem;
>> +       char *s;
>> +       int ret, len = 0;
>> +       bool odd = true;
>> +
>> +       sbegin = kstrndup(buf, size, GFP_KERNEL);
>> +       if (!sbegin)
>> +               return -ENOMEM;
>> +
>> +       /*
>> +        * Trim trailing newline, if the remaining string is empty,
>> +        * clear the pattern.
>> +        */
>> +       s = strstrip(sbegin);
>> +       if (!*s) {
>> +               ret = led_cdev->pattern_clear(led_cdev);
>> +               goto out;
>> +       }
>> +
>> +       pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
>> +       if (!pattern) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       /* Parse out the brightness & delta_t touples */
>> +       while ((elem = strsep(&s, " ")) != NULL) {
>> +               ret = kstrtoul(elem, 10, &val);
>> +               if (ret)
>> +                       goto out;
>> +
>> +               if (odd) {
>> +                       pattern[len].brightness = val;
>> +               } else {
>> +                       pattern[len].delta_t = val;
>> +                       len++;
>> +               }
>> +
>> +               odd = !odd;
>> +       }
>> +
>> +       /*
>> +        * Fail if we didn't find any data points or last data point was partial
>> +        */
>> +       if (!len || !odd) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       ret = led_cdev->pattern_set(led_cdev, pattern, len);
>> +
>> +out:
>> +       kfree(pattern);
>> +       kfree(sbegin);
>> +       return ret < 0 ? ret : size;
>> +}
>> +static DEVICE_ATTR_RW(pattern);
>> +
>> +static umode_t led_class_attrs_mode(struct kobject *kobj,
>> +                                   struct attribute *attr, int index)
>> +{
>> +       struct device *dev = container_of(kobj, struct device, kobj);
>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +
>> +       if (attr == &dev_attr_brightness.attr)
>> +               return attr->mode;
>> +       if (attr == &dev_attr_max_brightness.attr)
>> +               return attr->mode;
>> +       if (attr == &dev_attr_pattern.attr && led_cdev->pattern_set)
>> +               return attr->mode;
>> +
>> +       return 0;
>> +}

>>   #ifdef CONFIG_LEDS_TRIGGERS
>>   static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
>>   static struct attribute *led_trigger_attrs[] = {
>> @@ -88,11 +205,13 @@ static ssize_t max_brightness_show(struct device *dev,
>>   static struct attribute *led_class_attrs[] = {
>>          &dev_attr_brightness.attr,
>>          &dev_attr_max_brightness.attr,
>> +       &dev_attr_pattern.attr,
>>          NULL,
>>   };
>>
>>   static const struct attribute_group led_group = {
>>          .attrs = led_class_attrs,
>> +       .is_visible = led_class_attrs_mode,

This should not be needed if we'll validate pattern ops
in led_classdev_register().

>>   };
>>
>>   static const struct attribute_group *led_groups[] = {
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index b7e8255..acdbb2f 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -22,6 +22,7 @@
>>   #include <linux/workqueue.h>
>>
>>   struct device;
>> +struct led_pattern;
>>   /*
>>    * LED Core
>>    */
>> @@ -88,6 +89,14 @@ struct led_classdev {
>>                                       unsigned long *delay_on,
>>                                       unsigned long *delay_off);
>>
>> +       int (*pattern_set)(struct led_classdev *led_cdev,
>> +                          struct led_pattern *pattern, int len);
>> +
>> +       int (*pattern_clear)(struct led_classdev *led_cdev);
>> +
>> +       struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
>> +                                          int *len);
>> +
>>          struct device           *dev;
>>          const struct attribute_group    **groups;
>>
>> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>>          struct led_classdev *led_cdev, enum led_brightness brightness) { }
>>   #endif
>>
>> +/**
>> + * struct led_pattern - brigheness value in a pattern
>> + * @delta_t: delay until next entry, in milliseconds
>> + * @brightness: brightness at time = 0
>> + */
>> +struct led_pattern {
>> +       int delta_t;
>> +       int brightness;
>> +};
>> +
>>   #endif         /* __LINUX_LEDS_H_INCLUDED */
>> --
>> 1.7.9.5
>>
> 
> 
> 

-- 
Best regards,
Jacek Anaszewski
