Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F235C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB6A21779
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er/TBlx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB6A21779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeHDXoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:44:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53284 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbeHDXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:44:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so9873724wmh.3;
        Sat, 04 Aug 2018 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pCDinJY1SqB74nDGBzdrwuXR0szqwT+hvKtb7e1QPr8=;
        b=er/TBlx1tCDCW1J3NqIvdSRW55McR0I7GeLnCZk4gWFnVkv+dh2bLR0YMX90Rv55kh
         9joWamqGashutesZsKF8TJsNo2bIHcxPSLcawAwjMmsNSPFAOysibv4xaUOPAW897vQO
         1cgrbVF4fRv6xHsUEYDiMXhjr8EDbCT7VA5f20vtSr6XFD4snhFnnX/15nLRI8LolVFI
         jZ9efrmXx6cTFqcewtCBJaajH6vpv2MUvoP3MAsFWJb7AA4kUxlJHepKQyQEjkHazBXR
         ENrs8OCcbhAQuwWBQHzNgxjN50fsW5t/PKv+K0jt75eaujd4Zofw2b5oERI0OcAE6ztt
         5CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCDinJY1SqB74nDGBzdrwuXR0szqwT+hvKtb7e1QPr8=;
        b=uJtUZyRJHo50W1mnVmDV0qxZK50Odh8VhqwyxNGuOULpoTH46PyJpctmHZB2ASTRfC
         SL3E2GZpOR11KELxt5VBpoy89Pjj8LvoP23I6EzPX/1EJuueEajY2mT/3RuH5+wLhGI6
         WLIun7ZaHaaU3RgwKejIK0lxDs3XVhtYMjYTNpYcu/vq9MTpfId3JLr0SerDhHOMy2kC
         S4HfGI4ajVRq4OBbThb9qZ83J+FAmr6D1fmM28X+NAV486aWj5qjNbeDTa57UE+uSTqm
         PYVrbonVanATQPF7fBZ+wJsNozFzbBg0+RGWrhv9BFFJkRolec5mA3XqCXmAIF/C/dB7
         hXLQ==
X-Gm-Message-State: AOUpUlEWYLdaWFY5R8QIQdonWWkCLpSyCiJu3hE0rc8NxXPCfPW2Xx21
        J+DYHEOL1Wo1SqZLzvB94RSCs3MZ
X-Google-Smtp-Source: AAOMgpcX+EBiamYMRTWkUMvmNg2m/1O+vRGdL5rZ74xVXQVVYH2pCOWg13iyx06U6iu5GW8kZh3dTw==
X-Received: by 2002:a1c:f306:: with SMTP id q6-v6mr7920259wmq.111.1533418919654;
        Sat, 04 Aug 2018 14:41:59 -0700 (PDT)
Received: from [192.168.1.18] (bky33.neoplus.adsl.tpnet.pl. [83.28.192.33])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2175130wmf.12.2018.08.04.14.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 14:41:58 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <66b08912a2f9f9f013913162f65abc8f94c066cf.1533400193.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8c392d63-15b6-b6fb-f92d-b33ec616883c@gmail.com>
Date:   Sat, 4 Aug 2018 23:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <66b08912a2f9f9f013913162f65abc8f94c066cf.1533400193.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the new version of the patch set.

On 08/04/2018 06:51 PM, Baolin Wang wrote:
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
>  drivers/leds/trigger/ledtrig-pattern.c             | 270 +++++++++++++++++++++
>  include/linux/leds.h                               |  16 ++
>  5 files changed, 315 insertions(+)
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
> index 0000000..4e20454
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,270 @@
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
> +
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
> +
> +	mutex_lock(&data->lock);
> +
> +	data->npatterns = 0;
> +	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
> +		cr = 0;
> +		ccount = sscanf(buf + offset, "%d %d %n",
> +				&data->patterns[data->npatterns].brightness,
> +				&data->patterns[data->npatterns].delta_t, &cr);

Providing non numerical character indeed returns error, but afterwards
reading the pattern shows the sequence up to the moment of parsing
error, whereas it should return only new line character.

Moreover, providing improperly formatted pattern causes strange
behavior, where the last correct pattern is played, ending with
brightness 0, followed by max_brightness.

Please compare my tests with use of uleds tool (tools/leds),
which has max_brightness set to 100.

First list is the uledmon context, which reports timestamps along with
brightness changes, and the second one are operations on such
created 'vvv' LED class device.

~/repos/linux-leds/tools/leds$ sudo ./uledmon  vvv
[2826.191274292] 0
[2858.196038411] 1
[2859.231074491] 2
[2868.588010743] 1
[2869.599084809] 2
[2870.623084418] 3
[2875.620029346] 1
[2876.639073381] 2
[2877.663067682] 3
[2878.687097689] 1
[2879.711090613] 2
[2880.735108176] 3
[2881.759108250] 1
[2882.783080242] 2
[2883.807089762] 3
[2908.564080809] 1
[2909.599076585] 2
[2960.843029216] 1
[2961.887101380] 2
[2962.911079383] 3
[2977.067044920] 1
[2978.079073263] 2
[3016.882015017] 1
[3017.887077037] 2
[3018.911095103] 3
[3019.936081843] 0
[3020.956094064] 100
[3033.650032016] 1
[3034.655079947] 2
[3035.679085288] 3
[3036.704048558] 0
[3037.725068257] 100


$/sys/class/leds/vvv# echo "pattern" > trigger
$/sys/class/leds/vvv# echo "1 1000 2 10f00 3 1000" > pattern

bash: echo: write error: Invalid argument
$/sys/class/leds/vvv# cat pattern
1 1000 2 10
$/sys/class/leds/vvv# echo 1 > repeat
$/sys/class/leds/vvv# echo "1 1000 2 1000 3 1000" > pattern

$/sys/class/leds/vvv# echo 1 > repeat

$/sys/class/leds/vvv# echo 3 > repeat

$/sys/class/leds/vvv# echo "1 1000 2 1000 3 dd1000" > pattern

bash: echo: write error: Invalid argument
$/sys/class/leds/vvv# cat pattern
1 1000 2 1000
$/sys/class/leds/vvv# echo 1 > repeat

$/sys/class/leds/vvv#
$/sys/class/leds/vvv#
$/sys/class/leds/vvv# echo "1 1000 2 1000 3 1000 3" > pattern

bash: echo: write error: Invalid argument
$/sys/class/leds/vvv# cat pattern
1 1000 2 1000 3 1000
$/sys/class/leds/vvv# echo 1 > repeat
$/sys/class/leds/vvv# echo "1 1000 2 1000 3 bb" > pattern

bash: echo: write error: Invalid argument
$/sys/class/leds/vvv# cat pattern
1 1000 2 1000
$/sys/class/leds/vvv# echo 1 > repeat

$/sys/class/leds/vvv# echo "" > pattern
$/sys/class/leds/vvv# echo 1 > repeat

$/sys/class/leds/vvv# echo "1 1000" > pattern

$/sys/class/leds/vvv# echo "1 1000" > pattern

> +		if (ccount != 2) {
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
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time = 0
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
