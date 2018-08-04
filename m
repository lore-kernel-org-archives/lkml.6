Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD06C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109EA21582
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EymsX609"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109EA21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeHDSzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:55:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34362 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeHDSzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:55:12 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so15304523ois.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Sn1N4LlV/83Phzi9YPFqz7kSntTQeKH3GAXjaUxjwo=;
        b=EymsX6095s/cppbg4QnFX9BTXsSb2L8NyGWDtNID2miZq2MBNFmFn4ADk+Z8/s8Rmg
         O5wdHlSS1/xOy65ma9d6u6cro+xSbEn1Iel479klFD+axAJA46Y1DsgekOUCsYu/MFxI
         ZshaNTanls40pdmFBxPA09K0GYt0YHO22tP4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Sn1N4LlV/83Phzi9YPFqz7kSntTQeKH3GAXjaUxjwo=;
        b=f+PHto5DDQ9Z/gUyjut5p4JymIJxPcyhDq5TmALa3X3Voz52RlL8lxTPAHBiX7RVEt
         mv9rTl+q8JEvCSS8x9PfSKPGE/uxGF0r1NqnDKXUXRB9iS7hUqo2RUc99bJCr3eNjWK7
         +SE3gaEK5Bxgif+gfhGVNw1D/6N80O2aBnCJJv1GyfMieem0GbodxV/9WdGdS+bFm0rZ
         FIITR/XD23FOR8NEpgucBczmNgokRRePJASPZuq2HUm0TCrO6PzFLQREUjI5NCV9hMEw
         lor42Fp+ZpOPHY0YSAPl+6VobwNqY3nPOIlFV0s0i4MTQT41Eu0wePWyPtCBCNcUHP8y
         gLNw==
X-Gm-Message-State: AOUpUlGR5i2xeQxHViD7N9MLUCwkfuHfsqQSXsTV6yc+nk5u3kT+HUyL
        y2PFHFqc02DX8BBpn8SkEmVzaDiHpcAEC+4DNJhW4A==
X-Google-Smtp-Source: AAOMgpd4F/JAMXdXZuP6keNjkmuCwb80DLQIyUjQDMtyY8Uy+IrNo0QVlRNCFgAMoDcxP3uTqyotu7XTvVBgPK+DLVM=
X-Received: by 2002:aca:aacb:: with SMTP id t194-v6mr8543880oie.168.1533401634845;
 Sat, 04 Aug 2018 09:53:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 09:53:54 -0700 (PDT)
In-Reply-To: <ad88f187-962d-0098-80d4-6e9053747a24@gmail.com>
References: <1bf9aed83d1756dd4f81590297ce7e0b9972bf85.1533112637.git.baolin.wang@linaro.org>
 <34c87589-ccaf-e541-7acb-efcf3bd306f6@gmail.com> <CAMz4ku+33J6qxYh6e-dZk0j_NV=+bBp=K2Lqkx0rzLoqsGAtLQ@mail.gmail.com>
 <ad88f187-962d-0098-80d4-6e9053747a24@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sun, 5 Aug 2018 00:53:54 +0800
Message-ID: <CAMz4kuJhHXpp7KeuUNfhrm+HrNEJf-AQtQKQb7UFSUTPqHQ93Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 3 August 2018 at 19:59, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 08/03/2018 10:05 AM, Baolin Wang wrote:
>> Hi Jacek,
>>
>> On 3 August 2018 at 05:21, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>> Hi Baolin,
>>>
>>> Thank you for addressing review remarks.
>>>
>>> I've played a bit with the interface and I have one conclusion
>>> regarding pattern parsing, please refer below.
>>>
>>> Also one tiny optimization request in pattern_trig_activate().
>>>
>>> On 08/01/2018 11:01 AM, Baolin Wang wrote:
>>>> Some LED controllers have support for autonomously controlling
>>>> brightness over time, according to some preprogrammed pattern or
>>>> function.
>>>>
>>>> This patch adds pattern trigger that LED device can configure the
>>>> pattern and trigger it.
>>>>
>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>> ---
>>>> Changes from v1:
>>>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>>>  - Introduce hardware_pattern flag to determine if software pattern
>>>>  or hardware pattern.
>>>>  - Re-implement pattern_trig_store_pattern() function.
>>>>  - Remove pattern_get() interface.
>>>>  - Improve comments.
>>>>  - Other small optimization.
>>>> ---
>>>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
>>>>  drivers/leds/trigger/Kconfig                       |    7 +
>>>>  drivers/leds/trigger/Makefile                      |    1 +
>>>>  drivers/leds/trigger/ledtrig-pattern.c             |  273 ++++++++++++++++++++
>>>>  include/linux/leds.h                               |   16 ++
>>>>  5 files changed, 318 insertions(+)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>> new file mode 100644
>>>> index 0000000..f9a4ac0
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>> @@ -0,0 +1,21 @@
>>>> +What:                /sys/class/leds/<led>/pattern
>>>> +Date:                August 2018
>>>> +KernelVersion:       4.19
>>>> +Description:
>>>> +             Specify a pattern for the LED, for LED hardware that support
>>>> +             altering the brightness as a function of time.
>>>> +
>>>> +             The pattern is given by a series of tuples, of brightness and
>>>> +             duration (ms). The LED is expected to traverse the series and
>>>> +             each brightness value for the specified duration. Duration of
>>>> +             0 means brightness should immediately change to new value.
>>>> +
>>>> +             The format of the pattern values should be:
>>>> +             "brightness_1 duration_1, brightness_2 duration_2, brightness_3
>>>> +             duration_3 ...".
>>>> +
>>>> +What:                /sys/class/leds/<led>/repeat
>>>> +Date:                August 2018
>>>> +KernelVersion:       4.19
>>>> +Description:
>>>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>>>> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
>>>> index 4018af7..b76fc3c 100644
>>>> --- a/drivers/leds/trigger/Kconfig
>>>> +++ b/drivers/leds/trigger/Kconfig
>>>> @@ -129,4 +129,11 @@ config LEDS_TRIGGER_NETDEV
>>>>         This allows LEDs to be controlled by network device activity.
>>>>         If unsure, say Y.
>>>>
>>>> +config LEDS_TRIGGER_PATTERN
>>>> +     tristate "LED Pattern Trigger"
>>>> +     help
>>>> +       This allows LEDs to be controlled by a software or hardware pattern
>>>> +       which is a series of tuples, of brightness and duration (ms).
>>>> +       If unsure, say N
>>>> +
>>>>  endif # LEDS_TRIGGERS
>>>> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
>>>> index f3cfe19..9bcb64e 100644
>>>> --- a/drivers/leds/trigger/Makefile
>>>> +++ b/drivers/leds/trigger/Makefile
>>>> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)        += ledtrig-transient.o
>>>>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)    += ledtrig-camera.o
>>>>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)     += ledtrig-panic.o
>>>>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)    += ledtrig-netdev.o
>>>> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)   += ledtrig-pattern.o
>>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
>>>> new file mode 100644
>>>> index 0000000..006874b
>>>> --- /dev/null
>>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>>> @@ -0,0 +1,273 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +/*
>>>> + * LED pattern trigger
>>>> + *
>>>> + * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
>>>> + * the first version, Baolin Wang simplified and improved the approach.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/leds.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/timer.h>
>>>> +
>>>> +#define MAX_PATTERNS         1024
>>>> +#define PATTERN_SEPARATOR    ","
>>>> +
>>>> +struct pattern_trig_data {
>>>> +     struct led_classdev *led_cdev;
>>>> +     struct led_pattern patterns[MAX_PATTERNS];
>>>> +     struct led_pattern *curr;
>>>> +     struct led_pattern *next;
>>>> +     struct mutex lock;
>>>> +     u32 npatterns;
>>>> +     u32 repeat;
>>>> +     bool is_indefinite;
>>>> +     bool hardware_pattern;
>>>> +     struct timer_list timer;
>>>> +};
>>>> +
>>>> +static void pattern_trig_update_patterns(struct pattern_trig_data *data)
>>>> +{
>>>> +     data->curr = data->next;
>>>> +     if (!data->is_indefinite && data->curr == data->patterns)
>>>> +             data->repeat--;
>>>> +
>>>> +     if (data->next == data->patterns + data->npatterns - 1)
>>>> +             data->next = data->patterns;
>>>> +     else
>>>> +             data->next++;
>>>> +}
>>>> +
>>>> +static void pattern_trig_timer_function(struct timer_list *t)
>>>> +{
>>>> +     struct pattern_trig_data *data = from_timer(data, t, timer);
>>>> +
>>>> +     mutex_lock(&data->lock);
>>>> +
>>>> +     if (!data->is_indefinite && !data->repeat) {
>>>> +             mutex_unlock(&data->lock);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     led_set_brightness(data->led_cdev, data->curr->brightness);
>>>> +     mod_timer(&data->timer, jiffies + msecs_to_jiffies(data->curr->delta_t));
>>>> +     pattern_trig_update_patterns(data);
>>>> +
>>>> +     mutex_unlock(&data->lock);
>>>> +}
>>>> +
>>>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>>> +                                   struct led_classdev *led_cdev)
>>>> +{
>>>> +     if (!data->npatterns)
>>>> +             return 0;
>>>> +
>>>> +     if (data->hardware_pattern) {
>>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>>> +                                          data->npatterns, data->repeat);
>>>> +     }
>>>> +
>>>> +     data->curr = data->patterns;
>>>> +     data->next = data->patterns + 1;
>>>> +     data->timer.expires = jiffies;
>>>> +     add_timer(&data->timer);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static ssize_t pattern_trig_show_repeat(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     char *buf)
>>>> +{
>>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>>> +     u32 repeat;
>>>> +
>>>> +     mutex_lock(&data->lock);
>>>> +
>>>> +     repeat = data->repeat;
>>>> +
>>>> +     mutex_unlock(&data->lock);
>>>> +
>>>> +     return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
>>>> +}
>>>> +
>>>> +static ssize_t pattern_trig_store_repeat(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      const char *buf, size_t count)
>>>> +{
>>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>>> +     unsigned long res;
>>>> +     int err;
>>>> +
>>>> +     err = kstrtoul(buf, 10, &res);
>>>> +     if (err)
>>>> +             return err;
>>>> +
>>>> +     if (!data->hardware_pattern)
>>>> +             del_timer_sync(&data->timer);
>>>> +
>>>> +     mutex_lock(&data->lock);
>>>> +
>>>> +     data->repeat = res;
>>>> +
>>>> +     /* 0 means repeat indefinitely */
>>>> +     if (!data->repeat)
>>>> +             data->is_indefinite = true;
>>>> +     else
>>>> +             data->is_indefinite = false;
>>>> +
>>>> +     err = pattern_trig_start_pattern(data, led_cdev);
>>>> +
>>>> +     mutex_unlock(&data->lock);
>>>> +     return err < 0 ? err : count;;
>>>> +}
>>>> +
>>>> +static DEVICE_ATTR(repeat, 0644, pattern_trig_show_repeat,
>>>> +                pattern_trig_store_repeat);
>>>> +
>>>> +static ssize_t pattern_trig_show_pattern(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      char *buf)
>>>> +{
>>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>>> +     ssize_t count = 0;
>>>> +     int i;
>>>> +
>>>> +     mutex_lock(&data->lock);
>>>> +
>>>> +     if (!data->npatterns)
>>>> +             goto out;
>>>> +
>>>> +     for (i = 0; i < data->npatterns; i++) {
>>>> +             count += scnprintf(buf + count, PAGE_SIZE - count,
>>>> +                                "%d %d" PATTERN_SEPARATOR,
>>>> +                                data->patterns[i].brightness,
>>>> +                                data->patterns[i].delta_t);
>>>> +     }
>>>> +
>>>> +     buf[count - 1] = '\n';
>>>> +
>>>> +out:
>>>> +     mutex_unlock(&data->lock);
>>>> +     return count;
>>>> +}
>>>> +
>>>> +static ssize_t pattern_trig_store_pattern(struct device *dev,
>>>> +                                       struct device_attribute *attr,
>>>> +                                       const char *buf, size_t count)
>>>> +{
>>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>>> +     int cr, ccount, offset = 0, err = 0;
>>>> +
>>>> +     if (!data->hardware_pattern)
>>>> +             del_timer_sync(&data->timer);
>>>> +
>>>> +     mutex_lock(&data->lock);
>>>> +
>>>> +     data->npatterns = 0;
>>>> +     while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
>>>> +             cr = 0;
>>>> +             ccount = sscanf(buf + offset, "%d %d " PATTERN_SEPARATOR "%n",
>>>> +                             &data->patterns[data->npatterns].brightness,
>>>> +                             &data->patterns[data->npatterns].delta_t, &cr);
>>>
>>> In case user makes a typo while constructing list of pattern tuples,
>>> e.g. he forgets a comma, the pattern gets silently truncated.
>>>
>>> User is able to detect the truncation by reading pattern file,
>>> but it is not an immediate feedback anyway.
>>>
>>> I propose that pattern format should require number of tuples in the
>>> first position which would allow to get rid of this ambiguity, since
>>> we could verify if the number of parsed tuples is as intended.
>>
>> OK, I understand your concern. I will fix the issue without
>> introducing another pattern number. So I will not use a comma to
>> separate the patterns and change the pattern format as:
>> brightness1 time1 brightness2 time2 brightness3 time3 brightness4 time4 ...
>>
>> Then we will easy to check out errors if user gives one incorrect
>> pattern string.
>
> It would allow to eliminate only comma related typos, but what if user
> provides other than numerical character? The truncation will occur
> as well.

It will return -EINVAL error instead of the truncation.
echo "  50 100 100 100 50 100 0 100  " > pattern  --- Correct pattern string
echo "a 100 100 100 50 100 0 100 " > pattern  --- Incorrect pattern
string, will return error
echo "50 100 100 100 50 100 0 100  50" > pattern  --- Incorrect
pattern string, will return error

So It will not truncate the string if user provides one incorrect
pattern string.

But if we use one comma as the pattern separator, it will introduce
complexity to valid below cases with sccanf function:
echo "50 100, 100 100, 50 100, 0 100" > pattern
echo "50 100, 100 100, 50 100, 0 100," > pattern
echo "50 100, 100 100, 50 100, 0 100,   " > pattern
echo "50 100, 100 100, 50 100, 0 100 200" > pattern
echo "50 100, 100 100, 50 100 100, 0 100" > pattern
echo "50 100, 100 100, 50 100, 0 100 200," > pattern
echo "50 100, 100 100, 50 100, 0 100 200   " > pattern

So could you try the new version I send out, I think it will cover the
cases you mentioned.

>>>> +             if (ccount != 2) {
>>>> +                     err = -EINVAL;
>>>> +                     goto out;
>>>> +             }
>>>> +
>>>> +             offset += cr;
>>>> +             data->npatterns++;
>>>> +             /* end of pattern */
>>>> +             if (!cr)
>>>> +                     break;
>>>> +     }
>>>> +
>>>> +     err = pattern_trig_start_pattern(data, led_cdev);
>>>> +
>>>> +out:
>>>> +     mutex_unlock(&data->lock);
>>>> +     return err < 0 ? err : count;
>>>> +}
>>>> +
>>>> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
>>>> +                pattern_trig_store_pattern);
>>>> +
>>>> +static struct attribute *pattern_trig_attrs[] = {
>>>> +     &dev_attr_pattern.attr,
>>>> +     &dev_attr_repeat.attr,
>>>> +     NULL
>>>> +};
>>>> +ATTRIBUTE_GROUPS(pattern_trig);
>>>> +
>>>> +static int pattern_trig_activate(struct led_classdev *led_cdev)
>>>> +{
>>>> +     struct pattern_trig_data *data;
>>>> +
>>>> +     data = kzalloc(sizeof(*data), GFP_KERNEL);
>>>> +     if (!data)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     if (led_cdev->pattern_set && led_cdev->pattern_clear)
>>>> +             data->hardware_pattern = true;
>>>
>>> Instead of introducing hardware_pattern boolean, let's log warning
>>> message here in case:
>>>
>>> if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear)
>>>         dev_warn(led_cdev->dev, "Hardware pattern ops validation failed");
>>>
>>> And later, having this validation behind us, we can be sure that we have
>>> hardware pattern support when led_cdev->pattern_set is initialized.
>>
>> Hmm, I am not sure I catch your points. If we remove the
>> hardware_pattern boolean, we still need to add check before
>> 'del_timer_sync(&data->timer)' (In hardware pattern mode, we do not
>> need to delete the timer), also we still need to add check before
>> issuing pattern_set()/pattern_clear().
>
> If both pattern_set and pattern_get ops are initialized then we are
> in the hardware pattern mode.
>
> I forgot to nullify pattern_{set|get} ops in the proposed check above,
> so it should be:
>
> if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear) {
>         dev_warn(led_cdev->dev, "Hardware pattern ops validation failed");
>         led_cdev->pattern_set = led_cdev->pattern_get = NULL;
> }
>
> From this moment the state of pattern_set alone describes the
> mode we are in.
> No need to introduce another variable for that.

OK, will do. Thanks for your comments.


-- 
Baolin Wang
Best Regards
