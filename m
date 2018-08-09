Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C88B21AA7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGfdwLxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C88B21AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbeHIILX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:11:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37339 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeHIILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:11:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id j205-v6so7877274oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EevTvPF19qzwlNuNUyZ5gPW2LsfqpCUiQ/C63nlsGhA=;
        b=gGfdwLxsY87d25hWwUw/UUBS/OiIkhGEqLNCRJxL/X3wTkEx7JGNZwGtKiv3lJMcqZ
         m4vl8+CuOjpyEsa2IeqzxWA3RMd4Kjrl9DeKZco1I5fj8lnrA2Qi4c6GWGLfIT0TXdnG
         P1mu3F4lmM15DQcnuNFnYCcsGVf7x+eFAnrtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EevTvPF19qzwlNuNUyZ5gPW2LsfqpCUiQ/C63nlsGhA=;
        b=GVRs3CV9CNwM3krPzHN0Z1lsD5l+roOQyUmVnlHaVsUIEFjh2l+sWg7clgcFl2JQev
         ua1P7QEnJ5c+yT/l89b++HuNXB4qUu7+75DUlzEGALktLZ0TEuRHC0s0Lq+93MTir67t
         PVW15wl9lD9MAo8t128+ej3s/Z5OGTYqj54njJs3l7r1d+NHDytl0uX2KZtNv21uP+uZ
         FA7vO6RDZHdtjD3pmq4WhCPR8fUaCEAn/ipKz+7CI51Sm1yMpD4q1L0+IvABzYb859Hf
         YouJ5puASa2jzfgRbbTaXf9IfdOocA+WbF8YO0j3DaVOJj18qmqNfaDnVACNVP8Azx4D
         pTUQ==
X-Gm-Message-State: AOUpUlFvRf6O2ADGBzhySs8+yeh5uMKmo6lwyDA9pYPlh5pYYAzUIGpF
        m82um7taL3BOw6kOIZjAu/GaFfJt+KDxs2EAZF/hkA==
X-Google-Smtp-Source: AA+uWPxxOXic0n2rDtqBSuUC39HtqhDxkMqMbQB0d5RH7PWTti2b8hKyeg0VdYqfSsgEdmdiaVukjABRw68/vVjmNRs=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr743171oih.31.1533793693643;
 Wed, 08 Aug 2018 22:48:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 22:48:12 -0700 (PDT)
In-Reply-To: <5d594e9b-9889-adc2-cc59-f4f45eea7ddb@gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <CAMz4kuL8ufCqbqgegozJt3P7JON0AzA9KrbvcvOB15McA5S=zA@mail.gmail.com>
 <5d594e9b-9889-adc2-cc59-f4f45eea7ddb@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 9 Aug 2018 13:48:12 +0800
Message-ID: <CAMz4kuJBT2m8YpsAFufiGQFOYCgBbyf9Rrhce+396pRoW802aw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 9 August 2018 at 05:28, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 08/08/2018 08:01 AM, Baolin Wang wrote:
>> Hi Jacek,
>>
>> On 8 August 2018 at 05:54, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>> Hi Baolin,
>>>
>>> Thank you for addressing the review remarks.
>>> Since the patch set is targeted for 4.19, then we have three weeks
>>> before it will be merged to the for-next anyway. That said, I propose
>>> one more modification, please take a look below.
>>
>> Sure.
>>
>>>
>>> On 08/06/2018 02:05 PM, Baolin Wang wrote:
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
>>>> Changes from v4:
>>>>  - Change the repeat file to return the originally written number.
>>>>  - Improve comments.
>>>>  - Fix some build warnings.
>>>>
>>>> Changes from v3:
>>>>  - Reset pattern number to 0 if user provides incorrect pattern string.
>>>>  - Support one pattern.
>>>>
>>>> Changes from v2:
>>>>  - Remove hardware_pattern boolen.
>>>>  - Chnage the pattern string format.
>>>>
>>>> Changes from v1:
>>>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>>>  - Introduce hardware_pattern flag to determine if software pattern
>>>>  or hardware pattern.
>>>>  - Re-implement pattern_trig_store_pattern() function.
>>>>  - Remove pattern_get() interface.
>>>>  - Improve comments.
>>>>  - Other small optimization.
>>>> ---
>>>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   24 ++
>>>>  drivers/leds/trigger/Kconfig                       |    7 +
>>>>  drivers/leds/trigger/Makefile                      |    1 +
>>>>  drivers/leds/trigger/ledtrig-pattern.c             |  266 ++++++++++++++++++++
>>>>  include/linux/leds.h                               |   16 ++
>>>>  5 files changed, 314 insertions(+)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>> new file mode 100644
>>>> index 0000000..bc7475f
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>> @@ -0,0 +1,24 @@
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
>>>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>>>> +             duration_3 ...".
>>>> +
>>>> +What:                /sys/class/leds/<led>/repeat
>>>> +Date:                August 2018
>>>> +KernelVersion:       4.19
>>>> +Description:
>>>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>>>> +
>>>> +             This file will always return the originally written repeat
>>>> +             number.
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
>>>> index 0000000..63b94a2
>>>> --- /dev/null
>>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>>> @@ -0,0 +1,266 @@
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
>>>> +
>>>> +struct pattern_trig_data {
>>>> +     struct led_classdev *led_cdev;
>>>> +     struct led_pattern patterns[MAX_PATTERNS];
>>>> +     struct led_pattern *curr;
>>>> +     struct led_pattern *next;
>>>> +     struct mutex lock;
>>>> +     u32 npatterns;
>>>> +     u32 repeat;
>>>> +     u32 last_repeat;
>>>> +     bool is_indefinite;
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
>>>> +     if (led_cdev->pattern_set) {
>>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>>> +                                          data->npatterns, data->repeat);
>>>
>>> I think that it would be more flexible if software pattern fallback
>>> was applied in case of pattern_set failure. Otherwise, it would
>>> lead to the situation where LED class devices that support hardware
>>> blinking couldn't be applied the same set of patterns as LED class
>>> devices that don't implement pattern_set. The latter will always have to
>>> resort to using software pattern engine which will accept far greater
>>> amount of pattern combinations.
>>
>> Hmmm, I am not sure this is useful for hardware pattern, since the LED
>> hardware can be diverse which is hard to be compatible with software
>> pattern.
>>
>> For example, for our SC27XX LED, it only supports 4 hardware patterns
>> setting (low time, rising time, high time and falling time) to make it
>> work at breathing mode. If user provides 3 or 5 patterns values, it
>> will failed to issue pattern_set(). But at this time, we don't want to
>> use software pattern instead since it will be not the breathing mode
>> expected by user. I don't know if there are other special LED
>> hardware.
>
> Good point. So this is the issue we should dwell on, since the
> requested pattern effect should look similar on all devices.
> Of course in case of software pattern it will be often impossible
> to achieve the same fluency. Similarly as in case of rendering graphics
> with and without acceleration.
>
> In case of your device, I'd say that we'd need more complex description
> of breathing mode pattern. More complex than just four intervals.
> It should reflect all the intervals the hardware engine needs to perform
> to achieve the breathing effect. Can this information be inferred from
> the docs?

From our docs, it only provides registers to set the low time, rising
time, high time and falling time (value unit is 0.125s and max value
is 63 = 7.875s) to enable breathing mode. So each interval value can
be 1 ~ 63. But that is still hard for software pattern to simulate the
breathing mode performed by hardware pattern.

>
>> So I think we should let LED driver to handle this case, if failed to
>> issue pattern_set(), the LED driver can set one group default hardware
>> patterns, or turn off the LED hardware pattern or other error handling
>> method supplied by LED driver. That will not combine software pattern
>> and hardware pattern together to make things complicated.
>>
>> So what do you think?
>>
>>> In this case we need to discuss on what basis the decision will be
>>> made on whether hardware or software engine will be used.
>>>
>>> Possible options coming to mind:
>>> - an interface will be provided to determine max difference between
>>>   the settings supported by the hardware and the settings requested by
>>>   the user, that will result in aligning user's setting to the hardware
>>>   capabilities
>>> - the above alignment rate will be predefined instead
>>> - hardware engine will be used only if user requests supported settings
>>>   on the whole span of the requested pattern
>>> - in each of the above cases it would be worth to think of the
>>>   interface to show the scope of the settings supported by hardware
>>>
>>> The same issue applies to the already available timer trigger.
>>> So far the policy implemented by the drivers implementing blink_set
>>> op varies.
>>>
>>> --
>>> Best regards,
>>> Jacek Anaszewski
>>
>>
>>
>
> --
> Best regards,
> Jacek Anaszewski



-- 
Baolin Wang
Best Regards
