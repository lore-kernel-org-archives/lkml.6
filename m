Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DBFC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BAA20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Wamrwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BAA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJCDLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:11:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33385 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeJCDLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:11:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so3690131wrs.0;
        Tue, 02 Oct 2018 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VIj9fu5rnuNPIVuka8SVFU/GvGnN1QlOfM0iIyBNcM=;
        b=n8WamrwrVgeUIlx+HS2dF53R+rRElMQ1gJg9WiFYwtZ43iWY/SOeav6QV+pZ2os79n
         H6opMzcB7469y7V7KItSDW9c0i7mzF9BCWATUzDfjYCnCvBrADKBbh0VT/PLIIo5iV2k
         qt7M688wwwxpXz/UZdJqyK9i36RXD52xn8RDKT+sfwa5NFfQ/ghsqDyVHnXaY8gPeSUV
         2BkB9G0Op0UqM+nPzO229fSxg9Z93atzYVTVAVc4JL8vn8dbY+BPOkydFJxNIee2MLA1
         KMy7DVjTKDcId/WLKseXs/HG7uJrvEczKOzTfI2Yfn4uxQZlaEsNjNqgp059kXwSZM68
         RU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VIj9fu5rnuNPIVuka8SVFU/GvGnN1QlOfM0iIyBNcM=;
        b=pWT6EMI5Bycx9zcRJCF0Sx/gNZLDFTf1c5H12/3+nFyepWy7aH94TxIWw1tUXXWUP4
         cZM0j3fiKqKogIxCI5IHuk7yWLBTpW8578jZt7jfaksAUK7vffZVHObsGnBPJV8jAzeZ
         6wCcVR1OkyBRHhnhjtn5/GHTYIwjfgr+KczMmSjZ7z4OMq6GPdFnO4Wv8yibD/TWti24
         HrYg9wFjLFLfc78gmFK1FYiAUJzCJhg4N6Ed2LX0fZoViznlwXJBUzAMQIWwPMKiZt9U
         35Kmmi+llV3le8aX2LDwJ474MFuryqZ3NZvQS2kWTpQM8ofx5bu0U/YCMElBqoCsP0fE
         TfVw==
X-Gm-Message-State: ABuFfogH3qXty6uTLjfniucCp3IlouXpWS2GduB7GStO4GYJ1fR+68Mg
        iIafOUp4qd9i02BJBq6qMLtpB071
X-Google-Smtp-Source: ACcGV62JLGPlZaLUrWLdwZo0U2IVpOy8+2Z4te2ko6dsmPEVSQMVTb0wJmnc86m27TrJRMvD3LK8oQ==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr12427848wrh.72.1538511960664;
        Tue, 02 Oct 2018 13:26:00 -0700 (PDT)
Received: from [192.168.1.18] (dkq108.neoplus.adsl.tpnet.pl. [83.24.20.108])
        by smtp.gmail.com with ESMTPSA id i7-v6sm18903299wrb.30.2018.10.02.13.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 13:25:59 -0700 (PDT)
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com>
Date:   Tue, 2 Oct 2018 22:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the v14. We'll probably need v15, though :-)

I added the comments in the code below.

On 10/02/2018 05:43 PM, Baolin Wang wrote:
> This patch adds one new led trigger that LED device can configure
> the software or hardware pattern and trigger it.
> 
> Consumers can write 'pattern' file to enable the software pattern
> which alters the brightness for the specified duration with one
> software timer.
> 
> Moreover consumers can write 'hw_pattern' file to enable the hardware
> pattern for some LED controllers which can autonomously control
> brightness over time, according to some preprogrammed hardware
> patterns.
> 
> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v13:
>  - Add duration validation for gradual dimming.
>  - Coding style optimization.
> 
> Changes from v12:
>  - Add gradual dimming support for software pattern.
> 
> Changes from v11:
>  - Change -1 means repeat indefinitely.
> 
> Changes from v10:
>  - Change 'int' to 'u32' for delta_t field.
> 
> Changes from v9:
>  - None.
> 
> Changes from v8:
>  - None.
> 
> Changes from v7:
>  - Move the SC27XX hardware patterns description into its own ABI file.
> 
> Changes from v6:
>  - Improve commit message.
>  - Optimize the description of the hw_pattern file.
>  - Simplify some logics.
> 
> Changes from v5:
>  - Add one 'hw_pattern' file for hardware patterns.
> 
> Changes from v4:
>  - Change the repeat file to return the originally written number.
>  - Improve comments.
>  - Fix some build warnings.
> 
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
>  .../ABI/testing/sysfs-class-led-trigger-pattern    |  76 ++++
>  drivers/leds/trigger/Kconfig                       |   7 +
>  drivers/leds/trigger/Makefile                      |   1 +
>  drivers/leds/trigger/ledtrig-pattern.c             | 431 +++++++++++++++++++++
>  include/linux/leds.h                               |  15 +
>  5 files changed, 530 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> new file mode 100644
> index 0000000..22d7af7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -0,0 +1,76 @@
> +What:		/sys/class/leds/<led>/pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a software pattern for the LED, that supports altering
> +		the brightness for the specified duration with one software
> +		timer. It can do gradual dimming and constant brightness.
> +
> +		The pattern is given by a series of tuples, of brightness and
> +		duration (ms). The LED is expected to traverse the series and
> +		each brightness value for the specified duration. Duration of
> +		0 means brightness should immediately change to new value.
> +
> +		1. When doing gradual dimming, the led brightness will be updated
> +		every 50 milliseconds, so the duration of each step should not
> +		less than 50 milliseconds.

I'd like to avoid this constraint. Lowest supported delta_t should be 1.

We should only prevent entering dimming mode if current delta_t
is lower than UPDATE_INTERVAL.

I also propose to make the dimming interval configurable via sysfs
dimming_interval file.

> The gradual dimming format of the
> +		software pattern values should be:
> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +		duration_3 ...". For example:
> +
> +		echo 0 1000 255 2000 > pattern
> +
> +		It will make the LED go gradually from zero-intensity to max (255)
> +		intensity in 1000 milliseconds, then back to zero intensity in 2000
> +		milliseconds:
> +
> +		LED brightness
> +		    ^
> +		255-|       / \            / \            /
> +		    |      /    \         /    \         /
> +		    |     /       \      /       \      /
> +		    |    /          \   /          \   /
> +		  0-|   /             \/             \/
> +		    +---0----1----2----3----4----5----6------------> time (s)
> +
> +		2. To make the LED go instantly from one brigntess value to another,
> +		we should use use zero-time lengths. So the format should be:
> +		"brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
> +		brightness_2 0 ...". For example:
> +
> +		echo 0 1000 0 0 255 2000 255 0 > pattern
> +
> +		It will make the LED stay off for one second, then stay at max brightness
> +		for two seconds:
> +
> +		LED brightness
> +		    ^
> +		255-|        +---------+    +---------+
> +		    |        |         |    |         |
> +		    |        |         |    |         |
> +		    |        |         |    |         |
> +		  0-|   -----+         +----+         +----
> +		    +---0----1----2----3----4----5----6------------> time (s)
> +
> +What:		/sys/class/leds/<led>/hw_pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a hardware pattern for the LED, for LED hardware that
> +		supports autonomously controlling brightness over time, according
> +		to some preprogrammed hardware patterns.
> +
> +		Since different LED hardware can have different semantics of
> +		hardware patterns, each driver is expected to provide its own
> +		description for the hardware patterns in their ABI documentation
> +		file.
> +
> +What:		/sys/class/leds/<led>/repeat
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a pattern repeat number. -1 means repeat indefinitely,
> +		other negative numbers and number 0 are invalid.
> +
> +		This file will always return the originally written repeat
> +		number.
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
> index 0000000..92a0fd0
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,431 @@
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
> +/*
> + * When doing gradual dimming, the led brightness will be updated
> + * every 50 milliseconds.
> + */
> +#define UPDATE_INTERVAL		50
> +
> +struct pattern_trig_data {
> +	struct led_classdev *led_cdev;
> +	struct led_pattern patterns[MAX_PATTERNS];
> +	struct led_pattern *curr;
> +	struct led_pattern *next;
> +	struct mutex lock;
> +	u32 npatterns;
> +	int repeat;
> +	int last_repeat;
> +	int delta_t;
> +	bool is_indefinite;
> +	bool is_hw_pattern;
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
> +
> +	data->delta_t = 0;
> +}
> +
> +static int pattern_trig_compute_brightness(struct pattern_trig_data *data)
> +{
> +	int step_brightness;
> +
> +	if (data->delta_t == 0)
> +		return data->curr->brightness;
> +
> +	step_brightness = abs(data->next->brightness - data->curr->brightness);
> +	step_brightness = data->delta_t * step_brightness / data->curr->delta_t;
> +
> +	if (data->next->brightness > data->curr->brightness)
> +		return data->curr->brightness + step_brightness;
> +	else
> +		return data->curr->brightness - step_brightness;
> +}
> +
> +static void pattern_trig_timer_function(struct timer_list *t)
> +{
> +	struct pattern_trig_data *data = from_timer(data, t, timer);
> +
> +	mutex_lock(&data->lock);
> +
> +	for (; ;) {

This whitespace between semicolons looks odd. Please remove it.

> +		if (!data->is_indefinite && !data->repeat)
> +			break;
> +
> +		if (data->curr->brightness == data->next->brightness) {
> +			/* Constant brightness */
> +			led_set_brightness(data->led_cdev,
> +					   data->curr->brightness);
> +			mod_timer(&data->timer,
> +				  jiffies + msecs_to_jiffies(data->curr->delta_t));
> +
> +			/* Skip the step with zero duration */
> +			pattern_trig_update_patterns(data);
> +			/* Select next step */
> +			pattern_trig_update_patterns(data);
> +			break;
> +		} else {
> +			/* Gradual dimming */
> +
> +			/*
> +			 * If the accumulation time is larger than current
> +			 * step duration, we should go next one and re-check
> +			 * if we repeated done.
> +			 */
> +			if (data->delta_t > data->curr->delta_t) {
> +				pattern_trig_update_patterns(data);
> +				continue;
> +			}
> +
> +			led_set_brightness(data->led_cdev,
> +					   pattern_trig_compute_brightness(data));
> +			mod_timer(&data->timer,
> +				  jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
> +			/* Accumulate the gradual dimming time */
> +			data->delta_t += UPDATE_INTERVAL;
> +			break;
> +		}

Why two "break" statements instead of one here?

> +	}
> +
> +	mutex_unlock(&data->lock);
> +}
> +
> +static bool pattern_trig_is_sane(struct pattern_trig_data *data)
> +{
> +	int i;
> +
> +	/* At least 2 steps for software pattern. */
> +	if (data->npatterns < 2)
> +		return false;
> +
> +	/*
> +	 * No need valid the duration for constant brightness, just
> +	 * return true.
> +	 */
> +	if (data->patterns[0].brightness == data->patterns[1].brightness)
> +		return true;
> +
> +	/*
> +	 * Should valid the duration if is less than 50 ms for gradual
> +	 * dimming mode.
> +	 */
> +	for (i = 0; i < data->npatterns; i++) {
> +		if (data->patterns[i].delta_t < UPDATE_INTERVAL)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
> +{
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +
> +	if (!data->npatterns)
> +		return 0;
> +
> +	if (data->is_hw_pattern) {
> +		return led_cdev->pattern_set(led_cdev, data->patterns,
> +					     data->npatterns, data->repeat);
> +	}
> +
> +	if (!pattern_trig_is_sane(data))
> +		return -EINVAL;
> +
> +	data->delta_t = 0;
> +	data->curr = data->patterns;
> +	data->next = data->npatterns > 1 ? data->patterns + 1 : data->patterns;
> +	data->timer.expires = jiffies;
> +	add_timer(&data->timer);
> +
> +	return 0;
> +}
> +
> +static ssize_t repeat_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int repeat;
> +
> +	mutex_lock(&data->lock);
> +
> +	repeat = data->last_repeat;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", repeat);
> +}
> +
> +static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int err, res;
> +
> +	err = kstrtos32(buf, 10, &res);
> +	if (err)
> +		return err;
> +
> +	/* Number 0 and negative numbers except -1 are invalid. */
> +	if (res < -1 || res == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Clear previous patterns' performence firstly, and remove the timer
> +	 * without mutex lock to avoid dead lock.
> +	 */
> +	del_timer_sync(&data->timer);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (data->is_hw_pattern)
> +		led_cdev->pattern_clear(led_cdev);
> +
> +	data->last_repeat = data->repeat = res;
> +	/* -1 means repeat indefinitely */
> +	if (data->repeat == -1)
> +		data->is_indefinite = true;
> +	else
> +		data->is_indefinite = false;
> +
> +	err = pattern_trig_start_pattern(led_cdev);
> +
> +	mutex_unlock(&data->lock);
> +	return err < 0 ? err : count;
> +}
> +
> +static DEVICE_ATTR_RW(repeat);
> +
> +static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
> +					  char *buf, bool hw_pattern)
> +{
> +	ssize_t count = 0;
> +	int i;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (!data->npatterns || (data->is_hw_pattern ^ hw_pattern))
> +		goto out;
> +
> +	for (i = 0; i < data->npatterns; i++) {
> +		count += scnprintf(buf + count, PAGE_SIZE - count,
> +				   "%d %u ",
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
> +static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
> +					   const char *buf, size_t count,
> +					   bool hw_pattern)
> +{
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int ccount, cr, offset = 0, err = 0;
> +
> +	/*
> +	 * Clear previous patterns' performence firstly, and remove the timer
> +	 * without mutex lock to avoid dead lock.
> +	 */
> +	del_timer_sync(&data->timer);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (data->is_hw_pattern)
> +		led_cdev->pattern_clear(led_cdev);
> +
> +	data->is_hw_pattern = hw_pattern;
> +	data->npatterns = 0;
> +
> +	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
> +		cr = 0;
> +		ccount = sscanf(buf + offset, "%d %u %n",
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
> +	err = pattern_trig_start_pattern(led_cdev);
> +	if (err)
> +		data->npatterns = 0;
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return err < 0 ? err : count;
> +}
> +
> +static ssize_t pattern_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +
> +	return pattern_trig_show_patterns(data, buf, false);
> +}
> +
> +static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +	return pattern_trig_store_patterns(led_cdev, buf, count, false);
> +}
> +
> +static DEVICE_ATTR_RW(pattern);
> +
> +static ssize_t hw_pattern_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +
> +	return pattern_trig_show_patterns(data, buf, true);
> +}
> +
> +static ssize_t hw_pattern_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +	return pattern_trig_store_patterns(led_cdev, buf, count, true);
> +}
> +
> +static DEVICE_ATTR_RW(hw_pattern);
> +
> +static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
> +				       struct attribute *attr, int index)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +	if (attr == &dev_attr_repeat.attr || attr == &dev_attr_pattern.attr)
> +		return attr->mode;
> +	else if (attr == &dev_attr_hw_pattern.attr && led_cdev->pattern_set)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute *pattern_trig_attrs[] = {
> +	&dev_attr_pattern.attr,
> +	&dev_attr_hw_pattern.attr,
> +	&dev_attr_repeat.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pattern_trig_group = {
> +	.attrs = pattern_trig_attrs,
> +	.is_visible = pattern_trig_attrs_mode,
> +};
> +
> +static const struct attribute_group *pattern_trig_groups[] = {
> +	&pattern_trig_group,
> +	NULL,
> +};
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
> +	data->last_repeat = -1;
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
> +
> +	del_timer_sync(&data->timer);
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
> index 834683d..7393a31 100644
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
> @@ -88,6 +89,10 @@ struct led_classdev {
>  				     unsigned long *delay_on,
>  				     unsigned long *delay_off);
>  
> +	int (*pattern_set)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, u32 len, int repeat);
> +	int (*pattern_clear)(struct led_classdev *led_cdev);
> +
>  	struct device		*dev;
>  	const struct attribute_group	**groups;
>  
> @@ -472,4 +477,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>  	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>  #endif
>  
> +/**
> + * struct led_pattern - pattern interval settings
> + * @delta_t: pattern interval delay, in milliseconds
> + * @brightness: pattern interval brightness
> + */
> +struct led_pattern {
> +	u32 delta_t;
> +	int brightness;
> +};
> +
>  #endif		/* __LINUX_LEDS_H_INCLUDED */
> 

-- 
Best regards,
Jacek Anaszewski
