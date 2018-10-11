Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF9C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573432085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXlYVLUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573432085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJLDf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:35:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41510 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJLDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:35:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id q39-v6so7647368lfi.8;
        Thu, 11 Oct 2018 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4aSP3Z+QrQ/B4ur99XYzBIco/PJXud8GY/pQ834XpH8=;
        b=eXlYVLUrTIban0uqSvetkB4i3va+67jplZvcdpr1K7NJB7b1Y/LAVLL+w2/OTi9+aP
         sJK2Lc0ZQ96B3Be3f3+GAtCuoEx9bHXCMRDPkI+FEPYp6GsGeDQ+izWg4InrBBFAE4YN
         8TPhfxiu4YE9n7VYSj+MWnwg735ZgzovgkylNdmu9UQy5gPB07P/ChJn40LSNGzWdk/V
         jtvy6fBGAbfira/1NQaSB3BmSda0G94a/Czul0EV5xooQ7CYYuXAiX3mZ91pnUz7MkJT
         5qfVAOuQfZCTYYliT0WV8cqprpIVXgPnqsbpsV7TT+1sWW+9qTtJKg9WxLrwvB/IixeA
         Najg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4aSP3Z+QrQ/B4ur99XYzBIco/PJXud8GY/pQ834XpH8=;
        b=m7lw2b0DYOA2BJ9+P8x2jbXe/r3mlSL2E+x/jSl8T0SACDBNR28qm5OeiF+DvL/tIX
         uR5CSLo/N6f2kMuCBBJa+ebs/cCpzjjW/vgzCKk7orRKxRDEh67fbyv5Rr45kEmRneCv
         s3pqA7TjwfC4wbHoW4vI9EfvUKYqz0wHarrxhb0BkTQ9erTpDVB2N7G240aq35rfV9Cq
         OqI8nyKrasNq6KWlsMDFK/GuNAU9EEGqnGgr+rVxd57y0vM5qWbL9HxYv2cGppqf6PPV
         GsiCZ+3+43pVwBrrCwB6nylkZC9beb1wK7xf84s98+pepM3/QAFSLCgaSgEJsQUsl4Oa
         B90g==
X-Gm-Message-State: ABuFfojOWJ7EhG8bbSk3ag0xq1e4aQ3frDhuFhjCVrP/4LwdE3WNkh6w
        5Bf3ya+jW7fhbQsNBc4fEsaECXG+
X-Google-Smtp-Source: ACcGV61VHeSbt8v9COG2IBficUqOKwBOY4sga4jMYAAVCjAy5Zz7SoXIgPcSLj0HgQ3GQSvWZ0yMUQ==
X-Received: by 2002:a19:98c1:: with SMTP id a184-v6mr1953486lfe.94.1539288426374;
        Thu, 11 Oct 2018 13:07:06 -0700 (PDT)
Received: from [192.168.1.18] (dkt144.neoplus.adsl.tpnet.pl. [83.24.23.144])
        by smtp.gmail.com with ESMTPSA id a4-v6sm5771419lfa.91.2018.10.11.13.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 13:07:04 -0700 (PDT)
Subject: Re: [PATCH v15 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
Date:   Thu, 11 Oct 2018 22:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 10/11/2018 06:07 AM, Baolin Wang wrote:
> This patch adds a new led trigger that LED device can employ
> software or hardware pattern engine.
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
> Changes from v14:
>  - Improve the commit message and ABI documentation.
>  - Fix some coding style issues.
>  - Do not limit the tuple's duration larger than 50 ms, and treat is
>  as a a step change of brightness.
> 
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
>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   82 ++++
>  drivers/leds/trigger/Kconfig                       |    7 +
>  drivers/leds/trigger/Makefile                      |    1 +
>  drivers/leds/trigger/ledtrig-pattern.c             |  411 ++++++++++++++++++++
>  include/linux/leds.h                               |   15 +
>  5 files changed, 516 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> new file mode 100644
> index 0000000..fb3d1e0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -0,0 +1,82 @@
> +What:		/sys/class/leds/<led>/pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a software pattern for the LED, that supports altering
> +		the brightness for the specified duration with one software
> +		timer. It can do gradual dimming and step change of brightness.
> +
> +		The pattern is given by a series of tuples, of brightness and
> +		duration (ms). The LED is expected to traverse the series and
> +		each brightness value for the specified duration. Duration of
> +		0 means brightness should immediately change to new value, and
> +		writing malformed pattern deactivates any active one.
> +
> +		1. For gradual dimming, the dimming interval now is set as 50
> +		milliseconds. So the tuple with duration less than dimming
> +		interval (50ms) is treated as a step change of brightness,
> +		i.e. the subsequent brightness will be applied without adding
> +		intervening dimming intervals.
> +
> +		The gradual dimming format of the software pattern values should be:
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
> +		we should use use zero-time lengths (the brightness must be same as
> +		the previous tuple's). So the format should be:
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
> +		to some preprogrammed hardware patterns. It deactivates any active
> +		software pattern.
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
> index 0000000..ce7acd1
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,411 @@
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
> +	/*
> +	 * If current tuple's duration is less than the dimming interval,
> +	 * we should treat it as a step change of brightness instead of
> +	 * doing gradual dimming.
> +	 */
> +	if (data->delta_t == 0 || data->curr->delta_t < UPDATE_INTERVAL)
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
> +	for (;;) {
> +		if (!data->is_indefinite && !data->repeat)
> +			break;
> +
> +		if (data->curr->brightness == data->next->brightness) {
> +			/* Step change of brightness */
> +			led_set_brightness(data->led_cdev,
> +					   data->curr->brightness);
> +			mod_timer(&data->timer,
> +				  jiffies + msecs_to_jiffies(data->curr->delta_t));
> +
> +			/* Skip the tuple with zero duration */
> +			pattern_trig_update_patterns(data);
> +			/* Select next tuple */
> +			pattern_trig_update_patterns(data);
> +		} else {
> +			/* Gradual dimming */
> +
> +			/*
> +			 * If the accumulation time is larger than current
> +			 * tuple's duration, we should go next one and re-check
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
> +
> +			/* Accumulate the gradual dimming time */
> +			data->delta_t += UPDATE_INTERVAL;
> +		}
> +
> +		break;
> +	}
> +
> +	mutex_unlock(&data->lock);
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
> +	/* At least 2 tuples for software pattern. */
> +	if (data->npatterns < 2)
> +		return -EINVAL;
> +
> +	data->delta_t = 0;
> +	data->curr = data->patterns;
> +	data->next = data->patterns + 1;
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

OK, let's abide by constant update interval for now.

Thank you for your work on this patch set throughout
all these months. We will have -rc8, so one week of testing
before sending upstream should be enough.

Patch set applied to the for-next branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
