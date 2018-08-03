Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F95216ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBbJZY9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F95216ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeHCNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:55:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38937 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeHCNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:55:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so6168468wmq.4;
        Fri, 03 Aug 2018 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eVT+pcSMfNW5upFqAivJtTHtcTpNHlUWHNJ2ohZVWqs=;
        b=BBbJZY9bKuJGmgH6eXAzPW6cRvYJwutiI4VOHOZMoGaawINphbVoebHJNttIhcSTTZ
         k0x4FQgBEoOSQXbhoRc6rX8DOjHLQCq04Ii/vQ6O6JNwgomlXdzKMuBeDGag81WJblsF
         C0JCq2E5J64QRRjFBGK8LToYaXjvVGloNOknmqRUHKrf3lHHr/skqVvfppy+gzirfCsp
         GQxXH6EYyKeX+Id6LLCOgR23fSpLO42324uzuueITLrvI3mQmJEnSGOQgqbdihAvIMBy
         BJ+Hq6KgmrMuDMqll/cnEJRU/tWEizBEEJTpZ0ppASM5T6aosDvSO9isvOty7zrUsD87
         0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eVT+pcSMfNW5upFqAivJtTHtcTpNHlUWHNJ2ohZVWqs=;
        b=Sk6h6T7iH9Rbu5UEyyBzOmSujAYtOrPMhApAailUB8TqfsIMUJRsAXhIS8I/3yj4pF
         +fQ6aA5X3pbMHlwTA2DR6i1Bo19GIiFO3+TeSlAgJqv0D/zs2dnZ3xhim/DzDv06F+17
         sEE4wnmAWd2NVLAn2tsM+Q+/luuR/FaJ5W9nVcAl/m3u5OkslM9K4xXJVEAxfQEIKql7
         8BrNoVZdgXdW5wJlakcpqZfwFpEd/z/Wb9pvY4y7w5LQlp0Q9F/aQgHzZJh9GXfUTUBL
         JczX+D11+UJax+5rJNucgzndr2oC6ozFRHjVvYB6vgaB92tlnLFwsGyw5z5k13bsujm4
         2hUA==
X-Gm-Message-State: AOUpUlFJ8kTfiPrXuIICz92Sn1adI4Oa11XGYjRg6PGpmGCctZvr/UHO
        /yaauSF/J0Qr0KN9rXWRVsFxS1mc
X-Google-Smtp-Source: AAOMgpd+rOQV9zJcbBecHH4F9GbVpjDpHn4BSe1k6GrMtbSr00+6E+p0ODUT4agACJSHWqGtfx+vVw==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr4896063wmb.29.1533297589152;
        Fri, 03 Aug 2018 04:59:49 -0700 (PDT)
Received: from [192.168.1.18] (blh148.neoplus.adsl.tpnet.pl. [83.28.201.148])
        by smtp.gmail.com with ESMTPSA id a20-v6sm3457091wmg.23.2018.08.03.04.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 04:59:48 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1bf9aed83d1756dd4f81590297ce7e0b9972bf85.1533112637.git.baolin.wang@linaro.org>
 <34c87589-ccaf-e541-7acb-efcf3bd306f6@gmail.com>
 <CAMz4ku+33J6qxYh6e-dZk0j_NV=+bBp=K2Lqkx0rzLoqsGAtLQ@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ad88f187-962d-0098-80d4-6e9053747a24@gmail.com>
Date:   Fri, 3 Aug 2018 13:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+33J6qxYh6e-dZk0j_NV=+bBp=K2Lqkx0rzLoqsGAtLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 08/03/2018 10:05 AM, Baolin Wang wrote:
> Hi Jacek,
> 
> On 3 August 2018 at 05:21, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>> Hi Baolin,
>>
>> Thank you for addressing review remarks.
>>
>> I've played a bit with the interface and I have one conclusion
>> regarding pattern parsing, please refer below.
>>
>> Also one tiny optimization request in pattern_trig_activate().
>>
>> On 08/01/2018 11:01 AM, Baolin Wang wrote:
>>> Some LED controllers have support for autonomously controlling
>>> brightness over time, according to some preprogrammed pattern or
>>> function.
>>>
>>> This patch adds pattern trigger that LED device can configure the
>>> pattern and trigger it.
>>>
>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>> Changes from v1:
>>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>>  - Introduce hardware_pattern flag to determine if software pattern
>>>  or hardware pattern.
>>>  - Re-implement pattern_trig_store_pattern() function.
>>>  - Remove pattern_get() interface.
>>>  - Improve comments.
>>>  - Other small optimization.
>>> ---
>>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
>>>  drivers/leds/trigger/Kconfig                       |    7 +
>>>  drivers/leds/trigger/Makefile                      |    1 +
>>>  drivers/leds/trigger/ledtrig-pattern.c             |  273 ++++++++++++++++++++
>>>  include/linux/leds.h                               |   16 ++
>>>  5 files changed, 318 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>> new file mode 100644
>>> index 0000000..f9a4ac0
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>> @@ -0,0 +1,21 @@
>>> +What:                /sys/class/leds/<led>/pattern
>>> +Date:                August 2018
>>> +KernelVersion:       4.19
>>> +Description:
>>> +             Specify a pattern for the LED, for LED hardware that support
>>> +             altering the brightness as a function of time.
>>> +
>>> +             The pattern is given by a series of tuples, of brightness and
>>> +             duration (ms). The LED is expected to traverse the series and
>>> +             each brightness value for the specified duration. Duration of
>>> +             0 means brightness should immediately change to new value.
>>> +
>>> +             The format of the pattern values should be:
>>> +             "brightness_1 duration_1, brightness_2 duration_2, brightness_3
>>> +             duration_3 ...".
>>> +
>>> +What:                /sys/class/leds/<led>/repeat
>>> +Date:                August 2018
>>> +KernelVersion:       4.19
>>> +Description:
>>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>>> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
>>> index 4018af7..b76fc3c 100644
>>> --- a/drivers/leds/trigger/Kconfig
>>> +++ b/drivers/leds/trigger/Kconfig
>>> @@ -129,4 +129,11 @@ config LEDS_TRIGGER_NETDEV
>>>         This allows LEDs to be controlled by network device activity.
>>>         If unsure, say Y.
>>>
>>> +config LEDS_TRIGGER_PATTERN
>>> +     tristate "LED Pattern Trigger"
>>> +     help
>>> +       This allows LEDs to be controlled by a software or hardware pattern
>>> +       which is a series of tuples, of brightness and duration (ms).
>>> +       If unsure, say N
>>> +
>>>  endif # LEDS_TRIGGERS
>>> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
>>> index f3cfe19..9bcb64e 100644
>>> --- a/drivers/leds/trigger/Makefile
>>> +++ b/drivers/leds/trigger/Makefile
>>> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)        += ledtrig-transient.o
>>>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)    += ledtrig-camera.o
>>>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)     += ledtrig-panic.o
>>>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)    += ledtrig-netdev.o
>>> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)   += ledtrig-pattern.o
>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
>>> new file mode 100644
>>> index 0000000..006874b
>>> --- /dev/null
>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>> @@ -0,0 +1,273 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/*
>>> + * LED pattern trigger
>>> + *
>>> + * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
>>> + * the first version, Baolin Wang simplified and improved the approach.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/leds.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/timer.h>
>>> +
>>> +#define MAX_PATTERNS         1024
>>> +#define PATTERN_SEPARATOR    ","
>>> +
>>> +struct pattern_trig_data {
>>> +     struct led_classdev *led_cdev;
>>> +     struct led_pattern patterns[MAX_PATTERNS];
>>> +     struct led_pattern *curr;
>>> +     struct led_pattern *next;
>>> +     struct mutex lock;
>>> +     u32 npatterns;
>>> +     u32 repeat;
>>> +     bool is_indefinite;
>>> +     bool hardware_pattern;
>>> +     struct timer_list timer;
>>> +};
>>> +
>>> +static void pattern_trig_update_patterns(struct pattern_trig_data *data)
>>> +{
>>> +     data->curr = data->next;
>>> +     if (!data->is_indefinite && data->curr == data->patterns)
>>> +             data->repeat--;
>>> +
>>> +     if (data->next == data->patterns + data->npatterns - 1)
>>> +             data->next = data->patterns;
>>> +     else
>>> +             data->next++;
>>> +}
>>> +
>>> +static void pattern_trig_timer_function(struct timer_list *t)
>>> +{
>>> +     struct pattern_trig_data *data = from_timer(data, t, timer);
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     if (!data->is_indefinite && !data->repeat) {
>>> +             mutex_unlock(&data->lock);
>>> +             return;
>>> +     }
>>> +
>>> +     led_set_brightness(data->led_cdev, data->curr->brightness);
>>> +     mod_timer(&data->timer, jiffies + msecs_to_jiffies(data->curr->delta_t));
>>> +     pattern_trig_update_patterns(data);
>>> +
>>> +     mutex_unlock(&data->lock);
>>> +}
>>> +
>>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>> +                                   struct led_classdev *led_cdev)
>>> +{
>>> +     if (!data->npatterns)
>>> +             return 0;
>>> +
>>> +     if (data->hardware_pattern) {
>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>> +                                          data->npatterns, data->repeat);
>>> +     }
>>> +
>>> +     data->curr = data->patterns;
>>> +     data->next = data->patterns + 1;
>>> +     data->timer.expires = jiffies;
>>> +     add_timer(&data->timer);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t pattern_trig_show_repeat(struct device *dev,
>>> +                                     struct device_attribute *attr,
>>> +                                     char *buf)
>>> +{
>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +     u32 repeat;
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     repeat = data->repeat;
>>> +
>>> +     mutex_unlock(&data->lock);
>>> +
>>> +     return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
>>> +}
>>> +
>>> +static ssize_t pattern_trig_store_repeat(struct device *dev,
>>> +                                      struct device_attribute *attr,
>>> +                                      const char *buf, size_t count)
>>> +{
>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +     unsigned long res;
>>> +     int err;
>>> +
>>> +     err = kstrtoul(buf, 10, &res);
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     if (!data->hardware_pattern)
>>> +             del_timer_sync(&data->timer);
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     data->repeat = res;
>>> +
>>> +     /* 0 means repeat indefinitely */
>>> +     if (!data->repeat)
>>> +             data->is_indefinite = true;
>>> +     else
>>> +             data->is_indefinite = false;
>>> +
>>> +     err = pattern_trig_start_pattern(data, led_cdev);
>>> +
>>> +     mutex_unlock(&data->lock);
>>> +     return err < 0 ? err : count;;
>>> +}
>>> +
>>> +static DEVICE_ATTR(repeat, 0644, pattern_trig_show_repeat,
>>> +                pattern_trig_store_repeat);
>>> +
>>> +static ssize_t pattern_trig_show_pattern(struct device *dev,
>>> +                                      struct device_attribute *attr,
>>> +                                      char *buf)
>>> +{
>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +     ssize_t count = 0;
>>> +     int i;
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     if (!data->npatterns)
>>> +             goto out;
>>> +
>>> +     for (i = 0; i < data->npatterns; i++) {
>>> +             count += scnprintf(buf + count, PAGE_SIZE - count,
>>> +                                "%d %d" PATTERN_SEPARATOR,
>>> +                                data->patterns[i].brightness,
>>> +                                data->patterns[i].delta_t);
>>> +     }
>>> +
>>> +     buf[count - 1] = '\n';
>>> +
>>> +out:
>>> +     mutex_unlock(&data->lock);
>>> +     return count;
>>> +}
>>> +
>>> +static ssize_t pattern_trig_store_pattern(struct device *dev,
>>> +                                       struct device_attribute *attr,
>>> +                                       const char *buf, size_t count)
>>> +{
>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +     int cr, ccount, offset = 0, err = 0;
>>> +
>>> +     if (!data->hardware_pattern)
>>> +             del_timer_sync(&data->timer);
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     data->npatterns = 0;
>>> +     while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
>>> +             cr = 0;
>>> +             ccount = sscanf(buf + offset, "%d %d " PATTERN_SEPARATOR "%n",
>>> +                             &data->patterns[data->npatterns].brightness,
>>> +                             &data->patterns[data->npatterns].delta_t, &cr);
>>
>> In case user makes a typo while constructing list of pattern tuples,
>> e.g. he forgets a comma, the pattern gets silently truncated.
>>
>> User is able to detect the truncation by reading pattern file,
>> but it is not an immediate feedback anyway.
>>
>> I propose that pattern format should require number of tuples in the
>> first position which would allow to get rid of this ambiguity, since
>> we could verify if the number of parsed tuples is as intended.
> 
> OK, I understand your concern. I will fix the issue without
> introducing another pattern number. So I will not use a comma to
> separate the patterns and change the pattern format as:
> brightness1 time1 brightness2 time2 brightness3 time3 brightness4 time4 ...
> 
> Then we will easy to check out errors if user gives one incorrect
> pattern string.

It would allow to eliminate only comma related typos, but what if user
provides other than numerical character? The truncation will occur
as well.

>>> +             if (ccount != 2) {
>>> +                     err = -EINVAL;
>>> +                     goto out;
>>> +             }
>>> +
>>> +             offset += cr;
>>> +             data->npatterns++;
>>> +             /* end of pattern */
>>> +             if (!cr)
>>> +                     break;
>>> +     }
>>> +
>>> +     err = pattern_trig_start_pattern(data, led_cdev);
>>> +
>>> +out:
>>> +     mutex_unlock(&data->lock);
>>> +     return err < 0 ? err : count;
>>> +}
>>> +
>>> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
>>> +                pattern_trig_store_pattern);
>>> +
>>> +static struct attribute *pattern_trig_attrs[] = {
>>> +     &dev_attr_pattern.attr,
>>> +     &dev_attr_repeat.attr,
>>> +     NULL
>>> +};
>>> +ATTRIBUTE_GROUPS(pattern_trig);
>>> +
>>> +static int pattern_trig_activate(struct led_classdev *led_cdev)
>>> +{
>>> +     struct pattern_trig_data *data;
>>> +
>>> +     data = kzalloc(sizeof(*data), GFP_KERNEL);
>>> +     if (!data)
>>> +             return -ENOMEM;
>>> +
>>> +     if (led_cdev->pattern_set && led_cdev->pattern_clear)
>>> +             data->hardware_pattern = true;
>>
>> Instead of introducing hardware_pattern boolean, let's log warning
>> message here in case:
>>
>> if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear)
>>         dev_warn(led_cdev->dev, "Hardware pattern ops validation failed");
>>
>> And later, having this validation behind us, we can be sure that we have
>> hardware pattern support when led_cdev->pattern_set is initialized.
> 
> Hmm, I am not sure I catch your points. If we remove the
> hardware_pattern boolean, we still need to add check before
> 'del_timer_sync(&data->timer)' (In hardware pattern mode, we do not
> need to delete the timer), also we still need to add check before
> issuing pattern_set()/pattern_clear().

If both pattern_set and pattern_get ops are initialized then we are
in the hardware pattern mode.

I forgot to nullify pattern_{set|get} ops in the proposed check above,
so it should be:

if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear) {
	dev_warn(led_cdev->dev, "Hardware pattern ops validation failed");
	led_cdev->pattern_set = led_cdev->pattern_get = NULL;
}

From this moment the state of pattern_set alone describes the
mode we are in.
No need to introduce another variable for that.

Best regards,
Jacek Anaszewski

> So I think introducing one boolean will make code easy to understand
> what pattern mode (software pattern or hardware pattern) is using.
> Thanks.
> 
>>
>>> +     else
>>> +             data->hardware_pattern = false;
>>> +
>>> +     data->is_indefinite = true;
>>> +     mutex_init(&data->lock);
>>> +     data->led_cdev = led_cdev;
>>> +     led_set_trigger_data(led_cdev, data);
>>> +     timer_setup(&data->timer, pattern_trig_timer_function, 0);
>>> +     led_cdev->activated = true;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void pattern_trig_deactivate(struct led_classdev *led_cdev)
>>> +{
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +
>>> +     if (!led_cdev->activated)
>>> +             return;
>>> +
>>> +     if (data->hardware_pattern)
>>> +             led_cdev->pattern_clear(led_cdev);
>>> +     else
>>> +             del_timer_sync(&data->timer);
>>> +
>>> +     led_set_brightness(led_cdev, LED_OFF);
>>> +     kfree(data);
>>> +     led_cdev->activated = false;
>>> +}
>>> +
>>> +static struct led_trigger pattern_led_trigger = {
>>> +     .name = "pattern",
>>> +     .activate = pattern_trig_activate,
>>> +     .deactivate = pattern_trig_deactivate,
>>> +     .groups = pattern_trig_groups,
>>> +};
>>> +
>>> +static int __init pattern_trig_init(void)
>>> +{
>>> +     return led_trigger_register(&pattern_led_trigger);
>>> +}
>>> +
>>> +static void __exit pattern_trig_exit(void)
>>> +{
>>> +     led_trigger_unregister(&pattern_led_trigger);
>>> +}
>>> +
>>> +module_init(pattern_trig_init);
>>> +module_exit(pattern_trig_exit);
>>> +
>>> +MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
>>> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org");
>>> +MODULE_DESCRIPTION("LED Pattern trigger");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>>> index 834683d..c54712c 100644
>>> --- a/include/linux/leds.h
>>> +++ b/include/linux/leds.h
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/workqueue.h>
>>>
>>>  struct device;
>>> +struct led_pattern;
>>>  /*
>>>   * LED Core
>>>   */
>>> @@ -88,6 +89,11 @@ struct led_classdev {
>>>                                    unsigned long *delay_on,
>>>                                    unsigned long *delay_off);
>>>
>>> +     int (*pattern_set)(struct led_classdev *led_cdev,
>>> +                        struct led_pattern *pattern, int len,
>>> +                        unsigned repeat);
>>> +     int (*pattern_clear)(struct led_classdev *led_cdev);
>>> +
>>>       struct device           *dev;
>>>       const struct attribute_group    **groups;
>>>
>>> @@ -472,4 +478,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>>>       struct led_classdev *led_cdev, enum led_brightness brightness) { }
>>>  #endif
>>>
>>> +/**
>>> + * struct led_pattern - brightness value in a pattern
>>> + * @delta_t: delay until next entry, in milliseconds
>>> + * @brightness: brightness at time = 0
>>> + */
>>> +struct led_pattern {
>>> +     int delta_t;
>>> +     int brightness;
>>> +};
>>> +
>>>  #endif               /* __LINUX_LEDS_H_INCLUDED */
>>>
>>
>> --
>> Best regards,
>> Jacek Anaszewski
> 
> 
> 
