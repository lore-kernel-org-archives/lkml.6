Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C73C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7494208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b66CAkJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7494208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeGaF3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:29:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41281 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGaF3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:29:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so6516659ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 20:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iVGcwfIe/UdqGlq/m6iIN/In2a+phIyqT2v1HaTfOKI=;
        b=b66CAkJYN2GuiP4tJVIXjCmCMK1Qp+ihep9k+U+lE+s6Cbx9kbk0l/zhp+ipI3R1ke
         keLg6YOZXLPdcvkkVSWCdJJBIVEDesar4Wjqnt7C2jX0Zu9pZry5KEVAfKXjREu9gKlh
         zFjoA02tORFuhmv/ZxbhX7EQaeCCPNhOvoM3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVGcwfIe/UdqGlq/m6iIN/In2a+phIyqT2v1HaTfOKI=;
        b=h3NdzE4I7DcHqhYtfWL/Ec5Sf0PjabaTIQPIJhkMcmwlfs6wLHzDKm0IFzoPQyn/X7
         w9JC/3jyKrSpJ+CRaVtBrNf2dmCJEUESeiXwz4Oupe6T+wVKu/G/vuW6X5iLzqZTSvgi
         FwNjGjAMHzj575BpPDbMW9xfk+X0zYpVNkLUL8WLZuex1F32ibtBA0KqtvUg9/j/LS/b
         04/OhA2QzdKRRcQsHQr7R/QyA1ivh1JlhaKA2e2KNHj3qHw+Yht1TbNk5W/jQ/hhSZgQ
         QWi4dnWcqEIhLS8qS8lI6+BMMdfwqNCTU7COjDRv8nz6YVxWbSMuiCajYOHqpleCNtc+
         d/qg==
X-Gm-Message-State: AOUpUlG09SYhf4CyUHFUyxzB4Nw0SCz2h7SULqGn46a5weWLv1BuX1TP
        40kEyoykT4Zx67Fmda3G1e89dw==
X-Google-Smtp-Source: AAOMgpe83OLAq3gXcgkzxniF3aVDrGvfftvZNrM17v+iQ1weCmy/UalGNKU/kMwjOoEd6ySkPjeAlg==
X-Received: by 2002:a17:902:b28:: with SMTP id 37-v6mr18656020plq.337.1533009067941;
        Mon, 30 Jul 2018 20:51:07 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r71-v6sm21119261pfg.43.2018.07.30.20.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 20:51:07 -0700 (PDT)
Date:   Mon, 30 Jul 2018 20:54:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, david@lechnology.com,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180731035418.GA3334@tuxbook-pro>
References: <e74c21120d89dd645377761e6c9995eab6eb00ca.1532953083.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74c21120d89dd645377761e6c9995eab6eb00ca.1532953083.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Jul 05:29 PDT 2018, Baolin Wang wrote:

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
>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
>  drivers/leds/trigger/Kconfig                       |   10 +
>  drivers/leds/trigger/Makefile                      |    1 +
>  drivers/leds/trigger/ledtrig-pattern.c             |  349 ++++++++++++++++++++
>  include/linux/leds.h                               |   19 ++
>  5 files changed, 400 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> new file mode 100644
> index 0000000..c52da34
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
> +		"brightness_1 duration_1, brightness_2 duration_2, brightness_3
> +		duration_3, ...".
> +
> +What:		/sys/class/leds/<led>/repeat
> +Date:		August 2018
> +KernelVersion:	4.19
> +Description:
> +		Specify a pattern repeat number. 0 means repeat indefinitely.

If 0 means infinity, does 1 mean "repeat 1 time"? If so how would I
specify that I want the pattern to run one time (i.e. 0 repetitions).

> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
> index a2559b4..a03afcd 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -125,6 +125,16 @@ config LEDS_TRIGGER_CAMERA
>  	  This enables direct flash/torch on/off by the driver, kernel space.
>  	  If unsure, say Y.
>  
> +config LEDS_TRIGGER_PATTERN
> +       tristate "LED Pattern Trigger"
> +       depends on LEDS_TRIGGERS
> +       help
> +         This allows LEDs blinking with an arbitrary pattern. Can be useful
> +         on embedded systems with no screen to give out a status code to
> +         a human.

While the pattern mechanism could be used to communicate some message
the use cases we've seen so far is all about enabling hardware to pulse
LEDs instead of blinking them...

> +
> +         If unsure, say N
> +
>  config LEDS_TRIGGER_PANIC
>  	bool "LED Panic Trigger"
>  	depends on LEDS_TRIGGERS
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
> index f3cfe19..c5d180e 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)     += ledtrig-pattern.o
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> new file mode 100644
> index 0000000..b709aa1
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * LED pattern trigger
> + *
> + * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
> + * the first version, Baolin Wang simplified and improved the approach.

Might be a coincidence, but parts of this patch looks pretty close to
mine...

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/timer.h>
> +
> +/*
> + * The "pattern" attribute contains at most PAGE_SIZE characters. Each line
> + * in this attribute is at least 4 characters long (a 1-digit number for the
> + * led brighntess, a space, a 1-digit number for the time, a semi-colon).
> + * Therefore, there is at most PAGE_SIZE/4 patterns.
> + */

The brightness is a number between 0 and LED_FULL (or max_brightness)
and delta_t is measured in ms. So neither of these are likely to be a
single digit very often.

> +#define MAX_PATTERNS		(PAGE_SIZE / 4)
> +#define PATTERN_SEPARATOR	","
> +
> +struct pattern_trig_data {
> +	struct led_classdev *led_cdev;
> +	struct led_pattern *patterns;
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

I think you should just inline this logic into
pattern_trig_timer_function() to make it obvious that this is only
invoked from the timer function.

And if you do this you can decrement data->repeat unconditionally after
the check for !is_indefinite && repeat == 0.

> +{
> +	data->curr = data->next;
> +	if (!data->is_indefinite && data->curr == data->patterns)
> +		data->repeat--;
> +
> +	if (data->next == data->patterns + data->npatterns - 1)
> +		data->next = data->patterns;
> +	else
> +		data->next++;

How about replacing this conditional with:

	data->next = (data->next + 1) % data->npatterns;

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
> +				       struct led_classdev *led_cdev)
> +{
> +	if (!data->npatterns)
> +		return 0;
> +
> +	if (led_cdev->pattern_clear)
> +		led_cdev->pattern_clear(led_cdev);
> +
> +	if (led_cdev->pattern_set) {

In my proposal setting an empty pattern would invoke pattern_clear() and
setting a pattern would invoke pattern_set(), this allows the driver to
fail the pattern_set() without clearing the old pattern.

> +		return led_cdev->pattern_set(led_cdev, data->patterns,
> +					     data->npatterns, data->repeat);

repeat is communicated to the driver, but is_indefinite is not. At least
in my driver the latter

> +	}

I think it would be useful to put the rest in an else statement, to
clarify that the patterns is either implemented by the driver or by the
software timer. It might also make sense to group the check for
pattern_clear() and pattern_set(), as it wouldn't make sense for the
driver to implement only one of these.

> +
> +	data->curr = data->patterns;
> +	data->next = data->patterns + 1;
> +	data->timer.expires = jiffies;
> +	add_timer(&data->timer);
> +
> +	return 0;
> +}
> +
> +static ssize_t pattern_trig_show_repeat(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int err;
> +	u32 repeat;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (led_cdev->pattern_get) {
> +		err = led_cdev->pattern_get(led_cdev, data->patterns,
> +					    &data->npatterns, &data->repeat);

I don't see why "repeat" would have changed since you told the driver,
so data->repeat should have the right value already.

> +		if (err) {
> +			mutex_unlock(&data->lock);
> +			return err;
> +		}
> +	}
> +
> +	repeat = data->repeat;
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
> +	del_timer_sync(&data->timer);
> +
> +	mutex_lock(&data->lock);
> +	data->repeat = res;
> +
> +	/* 0 means repeat indefinitely */

I think that it would be better to specify indefinite by writing e.g.
"Inf" to the repeat.

Also note that it's possible that there might be hardware restrictions
that only allows specific combinations of these; e.g. the Qualcomm
hardware can only do no-repeat or repeat-forever.

> +	if (!data->repeat)
> +		data->is_indefinite = true;
> +	else
> +		data->is_indefinite = false;
> +
> +	err = pattern_trig_start_pattern(data, led_cdev);
> +	if (err) {
> +		mutex_unlock(&data->lock);
> +		return err;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +	return count;
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
> +	int err, i;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (led_cdev->pattern_get) {
> +		err = led_cdev->pattern_get(led_cdev, data->patterns,
> +					    &data->npatterns, &data->repeat);
> +		if (err) {
> +			mutex_unlock(&data->lock);
> +			return err;
> +		}
> +	}

Rather than sometimes calling pattern_get() here, how about defining
that pattern_set() should update data->patterns before returning and
just rely on data->patterns being right.

(The reason for the pattern not being the same as passed in store would
be to allow the driver to adjust the parameters to the match the
hardware requirements and present this to the user)

> +
> +	if (!data->npatterns) {
> +		mutex_unlock(&data->lock);
> +		return -EINVAL;
> +	}

Rather than failing I think you should return the empty string if the
pattern is empty.

> +
> +	for (i = 0; i < data->npatterns; i++) {
> +		count += scnprintf(buf + count, PAGE_SIZE - count,
> +				   "%d %d" PATTERN_SEPARATOR,
> +				   data->patterns[i].brightness,
> +				   data->patterns[i].delta_t);
> +	}
> +
> +	buf[count - 1] = '\n';
> +	buf[count] = '\0';
> +
> +	mutex_unlock(&data->lock);
> +	return count + 1;

As you're returning a string I think you should return the number of
chars in the string, not including the '\0'.

> +}
> +
> +static ssize_t pattern_trig_store_pattern(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int err, cr, ccount, tcr = 0;
> +
> +	del_timer_sync(&data->timer);
> +
> +	mutex_lock(&data->lock);
> +
> +	for (data->npatterns = 0; data->npatterns < MAX_PATTERNS;
> +	     data->npatterns++) {
> +		/* Characters read on one conversion */
> +		cr = 0;
> +		/* Number of successful conversions */
> +		ccount = sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "%n",
> +				&data->patterns[data->npatterns].brightness,
> +				&data->patterns[data->npatterns].delta_t, &cr);

I'm not fond of the use of sscanf() here, but at least you should make
sure that tcr doesn't go past PAGE_SIZE.

> +
> +		/* Total characters read */
> +		tcr += cr;
> +		if (cr)
> +			continue;

This loop is non-intuitive...

You loop while npatterns is less than MAX_PATTERNS and the first half
will loop if sscanf() matched the pattern otherwise you'll return from
withing the loop.

> +
> +		/* Invalid syntax or end of pattern */
> +		if (ccount == 2)

I guess you'll get here if you match the two %d, but not the
PATTERN_SEPARATOR? Wouldn't it be useful to fail here if ccount is !2.

> +			data->npatterns++;
> +
> +		err = pattern_trig_start_pattern(data, led_cdev);
> +		if (err) {
> +			mutex_unlock(&data->lock);
> +			return err;
> +		}
> +
> +		mutex_unlock(&data->lock);
> +		return count;
> +	}
> +
> +	/* Shouldn't reach that */

This means that you failed to set the pattern, so you probably shouldn't
return count - but rather -EINVAL or something.

> +	WARN(1, "MAX_NSTEP too small. Please report\n");
> +	mutex_unlock(&data->lock);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
> +		   pattern_trig_store_pattern);
> +
> +static int pattern_trig_create_sysfs_files(struct device *dev)
> +{
> +	int err;
> +
> +	err = device_create_file(dev, &dev_attr_repeat);
> +	if (err)
> +		return err;
> +
> +	err = device_create_file(dev, &dev_attr_pattern);
> +	if (err)
> +		device_remove_file(dev, &dev_attr_repeat);
> +
> +	return err;
> +}
> +
> +static void pattern_trig_remove_sysfs_files(struct device *dev)
> +{
> +	device_remove_file(dev, &dev_attr_pattern);
> +	device_remove_file(dev, &dev_attr_repeat);
> +}
> +
> +static int pattern_trig_initialize_data(struct pattern_trig_data *data)

These two functions would be better to just inline, but...

> +{
> +	data->patterns = kcalloc(MAX_PATTERNS, sizeof(struct led_pattern),
> +				 GFP_KERNEL);

...as this always allocate 1024 entries of led_pattern associated with
the pattern_trig_data you should just add 1024 entries of led_pattern to
the pattern_trig_data struct.

> +	if (!data->patterns)
> +		return -ENOMEM;
> +
> +	data->is_indefinite = true;
> +	mutex_init(&data->lock);
> +
> +	return 0;
> +}
> +
> +static void pattern_trig_clear_data(struct pattern_trig_data *data)
> +{
> +	kfree(data->patterns);
> +}
> +
> +static void pattern_trig_activate(struct led_classdev *led_cdev)
> +{
> +	struct pattern_trig_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return;
> +
> +	err = pattern_trig_initialize_data(data);
> +	if (err) {
> +		kfree(data);
> +		return;
> +	}
> +
> +	err = pattern_trig_create_sysfs_files(led_cdev->dev);
> +	if (err) {
> +		pattern_trig_clear_data(data);
> +		kfree(data);
> +		return;
> +	}
> +
> +	data->led_cdev = led_cdev;
> +	led_cdev->trigger_data = data;
> +	timer_setup(&data->timer, pattern_trig_timer_function, 0);
> +	led_cdev->activated = true;
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

This should only happen when not having using the driver based
mechanism, so put this in an else to clarify this.

> +	pattern_trig_remove_sysfs_files(led_cdev->dev);

Inline this and one doesn't have to jump around to figure out what's
going on.

> +	led_set_brightness(led_cdev, LED_OFF);
> +	pattern_trig_clear_data(data);
> +	kfree(data);
> +	led_cdev->trigger_data = NULL;
> +	led_cdev->activated = false;
> +}
> +
> +static struct led_trigger pattern_led_trigger = {
> +	.name = "pattern",
> +	.activate = pattern_trig_activate,
> +	.deactivate = pattern_trig_deactivate,
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
> index b7e8255..bea02f0 100644
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
> @@ -88,6 +89,14 @@ struct led_classdev {
>  				     unsigned long *delay_on,
>  				     unsigned long *delay_off);
>  
> +	int (*pattern_set)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, int len,
> +			   unsigned repeat);
> +	int (*pattern_get)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, int *len,
> +			   unsigned *repeat);
> +	int (*pattern_clear)(struct led_classdev *led_cdev);
> +
>  	struct device		*dev;
>  	const struct attribute_group	**groups;
>  
> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>  	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>  #endif
>  
> +/**
> + * struct led_pattern - brightness value in a pattern
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time = 0
> + */
> +struct led_pattern {
> +	int delta_t;
> +	int brightness;
> +};
> +
>  #endif		/* __LINUX_LEDS_H_INCLUDED */
> -- 
> 1.7.9.5
> 
