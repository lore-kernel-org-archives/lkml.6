Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA029ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FBC208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETJbRkPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FBC208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbeGMUXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:23:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41830 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGMUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:23:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so19676871wrr.8;
        Fri, 13 Jul 2018 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Ji2BtLLF7rrO+CFGqfxVeSMWT4rDU5srYlEIKBzdGI=;
        b=ETJbRkPBqIPiJBjPxdXajeUV1AGfdeOrdrbdcw8sskUMx7Ngc1YzAMfuSilgFLo0tZ
         G/C0u11ZCTAFODdF1vDEfLp2u1MtbbH21GHIbXnPkczLWCb2EIpXXdlCeE/UKlOxJHHE
         FMhvW/8FYC4JGqTIat5s7TL5bDzZlzsfe+4/GuocIj5EzKFRsYJ7fu9RDql9C+HV8bdF
         wr14g4ghAU1K6CmB1BiKu2uW26o2bPUbSfqsMiPQ+TDjpeCt0ukYHADzGcBiWu1CAbdk
         FsHrCtdUZJMZrT6o56SkY8V+s8ZrP55ne2t/rD8r1R1nDzejOub6SzDabzHg3uwdRuQY
         Ce6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Ji2BtLLF7rrO+CFGqfxVeSMWT4rDU5srYlEIKBzdGI=;
        b=hrkdVM6NrMLQvf3OnZTEbZV/+N8KTTx5OrybYdkZMKrB9/oqvRbh/9SRW8zVzaVdJK
         zQlAp2HHtb+v+kBfPEtDPkC6/ahtHwF2ohYGolVbx6vczAjv2aOjhiM0JDK8VWmYUE6t
         dm2HN0et8A0IFiSRJbKhYOjmWsSO7T3Y3CiAvO5KQoly5RS1i4VS5Ps7focVqUROtIll
         KmUhsfA7/BQLfR/P9VVR/Jbyos3eEwnQpgzFkkfKSAdH/Tc1tdvTdGRqSaVfoGf3mvb2
         fWru+YT98wlyIuNKPmx57Eg9y+WobfMuvAnQxQZdz9ABQ04eKW//byAG0s/eQxHjsVdI
         V8Jw==
X-Gm-Message-State: AOUpUlEwflIHwBq///FIJzfZPJcPi5RfHJYr8NSqd4OiqYbGiaLAWMzK
        8qPdg6oXIC6nViFvJOyaWGUC86N+
X-Google-Smtp-Source: AAOMgpfS84qo2lvZNHsSR9XZHwfDl4nwOc/G5Dzoxxfv3H3UblxZmMGCyMVrZl9/qt16JbRAhpHEKw==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr5964635wrf.206.1531512436216;
        Fri, 13 Jul 2018 13:07:16 -0700 (PDT)
Received: from [192.168.1.18] (con90.neoplus.adsl.tpnet.pl. [83.31.193.90])
        by smtp.gmail.com with ESMTPSA id z7-v6sm16951457wrh.85.2018.07.13.13.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:07:15 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] leds: core: Introduce generic pattern interface
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a0b874372f9ccd0491b54c79ac63b41812efef56.1531460834.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7263fcd3-4bd0-d3b1-5468-5bd6234fbd53@gmail.com>
Date:   Fri, 13 Jul 2018 22:07:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a0b874372f9ccd0491b54c79ac63b41812efef56.1531460834.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the update.

On 07/13/2018 08:21 AM, Baolin Wang wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
> 
> This adds a new optional operator that LED class drivers can implement
> if they support such functionality as well as a new device attribute to
> configure the pattern for a given LED.
> 
> [Baolin Wang did some improvements.]
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v3:
>   - Move the check in pattern_show() to of_led_classdev_register().
>   - Add more documentation to explain how to set/clear one pattern.
> 
> Changes from v2:
>   - Change kernel version to 4.19.
>   - Force user to return error pointer if failed to issue pattern_get().
>   - Use strstrip() to trim trailing newline.
>   - Other optimization.
> 
> Changes from v1:
>   - Add some comments suggested by Pavel.
>   - Change 'delta_t' can be 0.
> 
> Note: I removed the pattern repeat check and will get the repeat number by adding
> one extra file named 'pattern_repeat' according to previous discussion.
> ---
>   Documentation/ABI/testing/sysfs-class-led |   20 +++++
>   drivers/leds/led-class.c                  |  118 +++++++++++++++++++++++++++++
>   include/linux/leds.h                      |   19 +++++
>   3 files changed, 157 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
> index 5f67f7a..f4b73ad 100644
> --- a/Documentation/ABI/testing/sysfs-class-led
> +++ b/Documentation/ABI/testing/sysfs-class-led
> @@ -61,3 +61,23 @@ Description:
>   		gpio and backlight triggers. In case of the backlight trigger,
>   		it is useful when driving a LED which is intended to indicate
>   		a device in a standby like state.
> +
> +What: /sys/class/leds/<led>/pattern
> +Date:		July 2018
> +KernelVersion:	4.19
> +Description:
> +		Specify a pattern for the LED, for LED hardware that support
> +		altering the brightness as a function of time.
> +
> +		The pattern is given by a series of tuples, of brightness and
> +		duration (ms). The LED is expected to traverse the series and
> +		each brightness value for the specified duration. Duration of
> +		0 means brightness should immediately change to new value.
> +
> +		As LED hardware might have different capabilities and precision
> +		the requested pattern might be slighly adjusted by the driver
> +		and the resulting pattern of such operation should be returned
> +		when this file is read.
> +
> +		Writing non-empty string to this file will active the pattern,

s/active/activate/

> +		and empty string will disable the pattern.
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 3c7e348..0992a0e 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -74,6 +74,119 @@ static ssize_t max_brightness_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(max_brightness);
>   
> +static ssize_t pattern_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct led_pattern *pattern;
> +	size_t offset = 0;
> +	int count, n, i;
> +
> +	pattern = led_cdev->pattern_get(led_cdev, &count);
> +	if (IS_ERR(pattern))
> +		return PTR_ERR(pattern);
> +
> +	for (i = 0; i < count; i++) {
> +		n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d ",
> +			     pattern[i].brightness, pattern[i].delta_t);
> +
> +		if (offset + n >= PAGE_SIZE)
> +			goto err_nospc;
> +
> +		offset += n;
> +	}
> +
> +	buf[offset - 1] = '\n';
> +
> +	kfree(pattern);
> +	return offset;
> +
> +err_nospc:
> +	kfree(pattern);
> +	return -ENOSPC;
> +}
> +
> +static ssize_t pattern_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct led_pattern *pattern = NULL;
> +	char *sbegin, *elem, *s;
> +	unsigned long val;
> +	int ret = 0, len = 0;
> +	bool odd = true;
> +
> +	sbegin = kstrndup(buf, size, GFP_KERNEL);
> +	if (!sbegin)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Trim trailing newline, if the remaining string is empty,
> +	 * clear the pattern.
> +	 */
> +	s = strstrip(sbegin);
> +	if (!*s) {
> +		if (led_cdev->pattern_clear)
> +			ret = led_cdev->pattern_clear(led_cdev);

Why you don't require pattern_clear op to be initialized?
Without it there seems to be no other way to disable the pattern.

Please fail in led_classdev_register() if it is NULL, similarly
as when pattern_get is NULL.

> +		goto out;
> +	}
> +
> +	pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
> +	if (!pattern) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Parse out the brightness & delta_t touples */
> +	while ((elem = strsep(&s, " ")) != NULL) {
> +		ret = kstrtoul(elem, 10, &val);
> +		if (ret)
> +			goto out;
> +
> +		if (odd) {
> +			pattern[len].brightness = val;
> +		} else {
> +			pattern[len].delta_t = val;
> +			len++;
> +		}
> +
> +		odd = !odd;
> +	}
> +
> +	/*
> +	 * Fail if we didn't find any data points or last data point was partial
> +	 */
> +	if (!len || !odd) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = led_cdev->pattern_set(led_cdev, pattern, len);
> +
> +out:
> +	kfree(pattern);
> +	kfree(sbegin);
> +	return ret < 0 ? ret : size;
> +}
> +static DEVICE_ATTR_RW(pattern);
> +
> +static umode_t led_class_attrs_mode(struct kobject *kobj,
> +				    struct attribute *attr, int index)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +	if (attr == &dev_attr_brightness.attr)
> +		return attr->mode;
> +	if (attr == &dev_attr_max_brightness.attr)
> +		return attr->mode;
> +	if (attr == &dev_attr_pattern.attr && led_cdev->pattern_set)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_LEDS_TRIGGERS
>   static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
>   static struct attribute *led_trigger_attrs[] = {
> @@ -88,11 +201,13 @@ static ssize_t max_brightness_show(struct device *dev,
>   static struct attribute *led_class_attrs[] = {
>   	&dev_attr_brightness.attr,
>   	&dev_attr_max_brightness.attr,
> +	&dev_attr_pattern.attr,
>   	NULL,
>   };
>   
>   static const struct attribute_group led_group = {
>   	.attrs = led_class_attrs,
> +	.is_visible = led_class_attrs_mode,
>   };
>   
>   static const struct attribute_group *led_groups[] = {
> @@ -256,6 +371,9 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>   	char name[LED_MAX_NAME_SIZE];
>   	int ret;
>   
> +	if (led_cdev->pattern_set && !led_cdev->pattern_get)

if (led_cdev->pattern_set && (!led_cdev->pattern_get ||
                               !led_cdev->pattern_clear)

> +		return -EINVAL;
> +
>   	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
>   	if (ret < 0)
>   		return ret;
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b7e8255..acdbb2f 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -22,6 +22,7 @@
>   #include <linux/workqueue.h>
>   
>   struct device;
> +struct led_pattern;
>   /*
>    * LED Core
>    */
> @@ -88,6 +89,14 @@ struct led_classdev {
>   				     unsigned long *delay_on,
>   				     unsigned long *delay_off);
>   
> +	int (*pattern_set)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, int len);
> +
> +	int (*pattern_clear)(struct led_classdev *led_cdev);
> +
> +	struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
> +					   int *len);
> +
>   	struct device		*dev;
>   	const struct attribute_group	**groups;
>   
> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>   	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>   #endif
>   
> +/**
> + * struct led_pattern - brigheness value in a pattern
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time = 0
> + */
> +struct led_pattern {
> +	int delta_t;
> +	int brightness;
> +};
> +
>   #endif		/* __LINUX_LEDS_H_INCLUDED */
> 

-- 
Best regards,
Jacek Anaszewski
