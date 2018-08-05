Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CDFC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C1A21782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/uVhSYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C1A21782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeHESQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 14:16:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeHESQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 14:16:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so9997629wrv.12;
        Sun, 05 Aug 2018 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IY25fBc5OGJ1zgyTFs+7hk4aKWQdaaraLUjFzx/PF4c=;
        b=U/uVhSYH8jS7/rWJ6Jsuw+POZ7aYZUDTd+4p7KMwX43HkdigRy4WLjb6cpybyV/zev
         Lz9aZwSxGnYYypKTAzULwl+LwMHLXwLfWIk6yhgdLaeteWy5Vjfo5i8Wa2NpLgHDzc6C
         JbFkKWJ+WNEiCkUYStW8qmZ/m2lnAnLgSBT4tVj4bf9wQASugIAlwLGJAGQ79AfOXR+X
         lxi/nVcpu+2AaruWoRaNOJ0/YcYdMvxCuRPYxr0Fl5aJtPGycfKbZX0MhfFqxaaLY3Ot
         M0vgwxH1Sv1etxuiSxb99lA+9BnITf8ty34BY4bhRcCurIK3v+Bgrs/ZnkANYGPKcPmx
         T6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IY25fBc5OGJ1zgyTFs+7hk4aKWQdaaraLUjFzx/PF4c=;
        b=CcxOTcdPRH/4Upkji5G56ZyDFI4Xk1xSC5Nz+OsSHdRd4XEGtYqQNSVSPdVxna//Pb
         HaIY1Z/yUmuk2ZE23ZulMezMgKVuG4yYySTPfWRzB4s9Tqj1OXAoVFDBRZPfGlnySeZx
         ukhfQis+OcvDYbUj0ucJLJm8yk8ZjNeD9TWQnOBbkuoiLBup04JlZU+cM61tf8uQahOL
         UoKm0U1W8GnHq64nYLQLigG+R0YUoooH35iQEX0qYFdeBivc25LATkRBSXG3zRnGwvz3
         rzGZ+Akzgsb6DetopzKeDoCO6DOC0LAnuD2VeDFSnMUrR9t8ftoLJ4epW/QnMvjDxy+f
         gNlw==
X-Gm-Message-State: AOUpUlEU66X5Dm+p23woOlOKxSDX4co9zt0uZJcrIgk2yNcSUmVTMLJa
        Ly82BoHUcNmAEJmHJ8QbZw7u81dK
X-Google-Smtp-Source: AAOMgpcpJvZsInfMBVk1gsnj3jv5kQdq0UXAlNrvgiiGBdFOVza1ytMbrlXpW9jKtqz/J822ApIVqg==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr7659564wrm.43.1533485456117;
        Sun, 05 Aug 2018 09:10:56 -0700 (PDT)
Received: from [192.168.1.18] (dkm184.neoplus.adsl.tpnet.pl. [83.24.16.184])
        by smtp.gmail.com with ESMTPSA id d42-v6sm10728734wma.0.2018.08.05.09.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 09:10:55 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com>
Date:   Sun, 5 Aug 2018 18:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the fix.

I've found few more details to improve, please take a look
at my comments below.

On 08/05/2018 06:04 AM, Baolin Wang wrote:
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
> 
> This patch adds pattern trigger that LED device can configure the
> pattern and trigger it.
> 
> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v3:
>  - Reset pattern number to 0 if user provides incorrect pattern string.
>  - Support one pattern.
> 
> Changes from v2:
>  - Remove hardware_pattern boolen.
>  - Chnage the pattern string format.
> 
> Changes from v1:
>  - Use ATTRIBUTE_GROUPS() to define attributes.
>  - Introduce hardware_pattern flag to determine if software pattern
>  or hardware pattern.
>  - Re-implement pattern_trig_store_pattern() function.
>  - Remove pattern_get() interface.
>  - Improve comments.
>  - Other small optimization.
> ---
>  .../ABI/testing/sysfs-class-led-trigger-pattern    |  21 ++
>  drivers/leds/trigger/Kconfig                       |   7 +
>  drivers/leds/trigger/Makefile                      |   1 +
>  drivers/leds/trigger/ledtrig-pattern.c             | 271 +++++++++++++++++++++
>  include/linux/leds.h                               |  16 ++
>  5 files changed, 316 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> new file mode 100644
> index 0000000..40afefe
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -0,0 +1,21 @@
> +What:		/sys/class/leds/<led>/pattern
> +Date:		August 2018
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
> +		The format of the pattern values should be:
> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +		duration_3 ...".
> +
> +What:		/sys/class/leds/<led>/repeat
> +Date:		August 2018
> +KernelVersion:	4.19
> +Description:
> +		Specify a pattern repeat number. 0 means repeat indefinitely.

In current implementation this file on read returns the number
of remaining repeat intervals. I'd add that to this description.

> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
> index 4018af7..b76fc3c 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -129,4 +129,11 @@ config LEDS_TRIGGER_NETDEV
>  	  This allows LEDs to be controlled by network device activity.
>  	  If unsure, say Y.
>  
> +config LEDS_TRIGGER_PATTERN
> +	tristate "LED Pattern Trigger"
> +	help
> +	  This allows LEDs to be controlled by a software or hardware pattern
> +	  which is a series of tuples, of brightness and duration (ms).
> +	  If unsure, say N
> +
>  endif # LEDS_TRIGGERS
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
> index f3cfe19..9bcb64e 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> new file mode 100644
> index 0000000..e5b90b7
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * LED pattern trigger
> + *
> + * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
> + * the first version, Baolin Wang simplified and improved the approach.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/timer.h>
> +
> +#define MAX_PATTERNS		1024
> +
> +struct pattern_trig_data {
> +	struct led_classdev *led_cdev;
> +	struct led_pattern patterns[MAX_PATTERNS];
> +	struct led_pattern *curr;
> +	struct led_pattern *next;
> +	struct mutex lock;
> +	u32 npatterns;
> +	u32 repeat;
> +	bool is_indefinite;
> +	struct timer_list timer;
> +};
> +
> +static void pattern_trig_update_patterns(struct pattern_trig_data *data)
> +{
> +	data->curr = data->next;
> +	if (!data->is_indefinite && data->curr == data->patterns)
> +		data->repeat--;
> +
> +	if (data->next == data->patterns + data->npatterns - 1)
> +		data->next = data->patterns;
> +	else
> +		data->next++;
> +}
> +
> +static void pattern_trig_timer_function(struct timer_list *t)
> +{
> +	struct pattern_trig_data *data = from_timer(data, t, timer);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (!data->is_indefinite && !data->repeat) {
> +		mutex_unlock(&data->lock);
> +		return;
> +	}
> +
> +	led_set_brightness(data->led_cdev, data->curr->brightness);
> +	mod_timer(&data->timer, jiffies + msecs_to_jiffies(data->curr->delta_t));
> +	pattern_trig_update_patterns(data);
> +
> +	mutex_unlock(&data->lock);
> +}
> +
> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
> +				      struct led_classdev *led_cdev)
> +{
> +	if (!data->npatterns)
> +		return 0;
> +
> +	if (led_cdev->pattern_set) {
> +		return led_cdev->pattern_set(led_cdev, data->patterns,
> +					     data->npatterns, data->repeat);
> +	}
> +
> +	data->curr = data->patterns;
> +	data->next = data->npatterns > 1 ? data->patterns + 1 : data->patterns;
> +	data->timer.expires = jiffies;
> +	add_timer(&data->timer);
> +
> +	return 0;
> +}
> +
> +static ssize_t pattern_trig_show_repeat(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)

Please fix checkpatch.pl warnings:

WARNING: Consider renaming function(s) 'pattern_trig_show_repeat' to
'repeat_show' 'pattern_trig_store_repeat' to 'repeat_store'
#209: FILE: drivers/leds/trigger/ledtrig-pattern.c:127:
+}

WARNING: Consider renaming function(s) 'pattern_trig_show_pattern' to
'pattern_show' 'pattern_trig_store_pattern' to 'pattern_store'
#276: FILE: drivers/leds/trigger/ledtrig-pattern.c:194:
+}


> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	u32 repeat;
> +
> +	mutex_lock(&data->lock);
> +
> +	repeat = data->repeat;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
> +}
> +
> +static ssize_t pattern_trig_store_repeat(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	unsigned long res;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &res);
> +	if (err)
> +		return err;
> +
> +	if (!led_cdev->pattern_set)
> +		del_timer_sync(&data->timer);

Is there a reason for not having this check under mutex?

> +	mutex_lock(&data->lock);
> +
> +	data->repeat = res;
> +
> +	/* 0 means repeat indefinitely */
> +	if (!data->repeat)
> +		data->is_indefinite = true;
> +	else
> +		data->is_indefinite = false;
> +
> +	err = pattern_trig_start_pattern(data, led_cdev);
> +
> +	mutex_unlock(&data->lock);
> +	return err < 0 ? err : count;
> +}
> +
> +static DEVICE_ATTR(repeat, 0644, pattern_trig_show_repeat,
> +		   pattern_trig_store_repeat);
> +
> +static ssize_t pattern_trig_show_pattern(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	ssize_t count = 0;
> +	int i;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (!data->npatterns)
> +		goto out;
> +
> +	for (i = 0; i < data->npatterns; i++) {
> +		count += scnprintf(buf + count, PAGE_SIZE - count,
> +				   "%d %d ",
> +				   data->patterns[i].brightness,
> +				   data->patterns[i].delta_t);
> +	}
> +
> +	buf[count - 1] = '\n';
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return count;
> +}
> +
> +static ssize_t pattern_trig_store_pattern(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int ccount, cr, offset = 0, err = 0;
> +
> +	if (!led_cdev->pattern_set)
> +		del_timer_sync(&data->timer);

Ditto.

> +	mutex_lock(&data->lock);
> +
> +	data->npatterns = 0;
> +	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
> +		cr = 0;
> +		ccount = sscanf(buf + offset, "%d %d %n",
> +				&data->patterns[data->npatterns].brightness,
> +				&data->patterns[data->npatterns].delta_t, &cr);
> +		if (ccount != 2) {
> +			data->npatterns = 0;
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		offset += cr;
> +		data->npatterns++;
> +	}
> +
> +	err = pattern_trig_start_pattern(data, led_cdev);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return err < 0 ? err : count;
> +}
> +
> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
> +		   pattern_trig_store_pattern);
> +
> +static struct attribute *pattern_trig_attrs[] = {
> +	&dev_attr_pattern.attr,
> +	&dev_attr_repeat.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(pattern_trig);
> +
> +static int pattern_trig_activate(struct led_classdev *led_cdev)
> +{
> +	struct pattern_trig_data *data;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear) {
> +		dev_warn(led_cdev->dev,
> +			 "Hardware pattern ops validation failed\n");
> +		led_cdev->pattern_set = NULL;
> +		led_cdev->pattern_clear = NULL;
> +	}
> +
> +	data->is_indefinite = true;
> +	mutex_init(&data->lock);
> +	data->led_cdev = led_cdev;
> +	led_set_trigger_data(led_cdev, data);
> +	timer_setup(&data->timer, pattern_trig_timer_function, 0);
> +	led_cdev->activated = true;
> +
> +	return 0;
> +}
> +
> +static void pattern_trig_deactivate(struct led_classdev *led_cdev)
> +{
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +
> +	if (!led_cdev->activated)
> +		return;
> +
> +	if (led_cdev->pattern_clear)
> +		led_cdev->pattern_clear(led_cdev);
> +	else
> +		del_timer_sync(&data->timer);
> +
> +	led_set_brightness(led_cdev, LED_OFF);
> +	kfree(data);
> +	led_cdev->activated = false;
> +}
> +
> +static struct led_trigger pattern_led_trigger = {
> +	.name = "pattern",
> +	.activate = pattern_trig_activate,
> +	.deactivate = pattern_trig_deactivate,
> +	.groups = pattern_trig_groups,
> +};
> +
> +static int __init pattern_trig_init(void)
> +{
> +	return led_trigger_register(&pattern_led_trigger);
> +}
> +
> +static void __exit pattern_trig_exit(void)
> +{
> +	led_trigger_unregister(&pattern_led_trigger);
> +}
> +
> +module_init(pattern_trig_init);
> +module_exit(pattern_trig_exit);
> +
> +MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org");
> +MODULE_DESCRIPTION("LED Pattern trigger");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 834683d..c54712c 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -22,6 +22,7 @@
>  #include <linux/workqueue.h>
>  
>  struct device;
> +struct led_pattern;
>  /*
>   * LED Core
>   */
> @@ -88,6 +89,11 @@ struct led_classdev {
>  				     unsigned long *delay_on,
>  				     unsigned long *delay_off);
>  
> +	int (*pattern_set)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, int len,
> +			   unsigned repeat);
> +	int (*pattern_clear)(struct led_classdev *led_cdev);
> +
>  	struct device		*dev;
>  	const struct attribute_group	**groups;
>  
> @@ -472,4 +478,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>  	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>  #endif
>  
> +/**
> + * struct led_pattern - brightness value in a pattern

Since this structure describes single pattern interval and not
the whole pattern, please change its description to:

pattern interval settings

> + * @delta_t: delay until next entry, in milliseconds

@delta_t: pattern interval delay, in milliseconds

> + * @brightness: brightness at time = 0

@brightness: pattern interval brightness

> + */
> +struct led_pattern {
> +	int delta_t;
> +	int brightness;
> +};
> +
>  #endif		/* __LINUX_LEDS_H_INCLUDED */
> 

-- 
Best regards,
Jacek Anaszewski
