Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502CBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23EB21718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXBzA1Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23EB21718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeHHIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:19:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34085 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHHIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:19:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so1837473ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xf2/T00uNO4vMsHG1mxAdBklJzVT4xW0puts5XgG7vI=;
        b=OXBzA1EpzGJc/jxJaYyAMuYMSbVA4ZxH7yoNw56dWU7ufnvnA4HYSjLPb+jDx+gRkF
         pIPaRTEXpzCJ9ud2Afj7SDU8kAcLrgwNbT29CapYPz8IaMrUjZnhf1wgcrHsWnUBS3ji
         Um+rP/mniH6m1VglGowvJ4o5JvWChJdnCdbB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xf2/T00uNO4vMsHG1mxAdBklJzVT4xW0puts5XgG7vI=;
        b=t+N6DDgqhUzF8fBlHHmD/hZoozSdCyhCB7rR37ylWZoOSiSHsJwllNv9p/RFh2uvj4
         3SzH9IVXLmbtnb0yxOlnowHM8/ts1CH5sE978rnR5m4CMVZGbUrUmvdzodK4FVNvvSNq
         Hwna0Oo4LY4vFXBjDSRm93m/vtxpQOWjzFJQw7vVX9x7oB10Dj2iw6FWRcVa3f+9XcJ9
         60micNRvUmL+4kQSroGqjHJqPSPGmLus5HJndux25wfCzElDH1QW8mYG7BoVlYUnYsO9
         sZ+pb6dbh2RFRGrk/0gYPVItmOnMS1z2ZkNdvweXfS4rOmw33S1dI+gDXFAaEvjCaJ/A
         ZfVg==
X-Gm-Message-State: AOUpUlFg9v8pUsRZjn26OCh6ftWa0d9psiwui2dIGf96dMmb4ITH0WRK
        0sJWWlWSB9c0tXUtN48f8E6/W0e+281DR+9wfTI3ZA==
X-Google-Smtp-Source: AA+uWPxKFzW8GVeHsGS2Az/TGica4RdzI1MI8hCmyuDVrjxkJVs+0MkI+DdLOEqOOZB8Li/diLvcdPIX4LB3gLN8AuA=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr1465236oie.68.1533708083525;
 Tue, 07 Aug 2018 23:01:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 23:01:22 -0700 (PDT)
In-Reply-To: <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 14:01:22 +0800
Message-ID: <CAMz4kuL8ufCqbqgegozJt3P7JON0AzA9KrbvcvOB15McA5S=zA@mail.gmail.com>
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

On 8 August 2018 at 05:54, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> Thank you for addressing the review remarks.
> Since the patch set is targeted for 4.19, then we have three weeks
> before it will be merged to the for-next anyway. That said, I propose
> one more modification, please take a look below.

Sure.

>
> On 08/06/2018 02:05 PM, Baolin Wang wrote:
>> Some LED controllers have support for autonomously controlling
>> brightness over time, according to some preprogrammed pattern or
>> function.
>>
>> This patch adds pattern trigger that LED device can configure the
>> pattern and trigger it.
>>
>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v4:
>>  - Change the repeat file to return the originally written number.
>>  - Improve comments.
>>  - Fix some build warnings.
>>
>> Changes from v3:
>>  - Reset pattern number to 0 if user provides incorrect pattern string.
>>  - Support one pattern.
>>
>> Changes from v2:
>>  - Remove hardware_pattern boolen.
>>  - Chnage the pattern string format.
>>
>> Changes from v1:
>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>  - Introduce hardware_pattern flag to determine if software pattern
>>  or hardware pattern.
>>  - Re-implement pattern_trig_store_pattern() function.
>>  - Remove pattern_get() interface.
>>  - Improve comments.
>>  - Other small optimization.
>> ---
>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   24 ++
>>  drivers/leds/trigger/Kconfig                       |    7 +
>>  drivers/leds/trigger/Makefile                      |    1 +
>>  drivers/leds/trigger/ledtrig-pattern.c             |  266 ++++++++++++++++++++
>>  include/linux/leds.h                               |   16 ++
>>  5 files changed, 314 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> new file mode 100644
>> index 0000000..bc7475f
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> @@ -0,0 +1,24 @@
>> +What:                /sys/class/leds/<led>/pattern
>> +Date:                August 2018
>> +KernelVersion:       4.19
>> +Description:
>> +             Specify a pattern for the LED, for LED hardware that support
>> +             altering the brightness as a function of time.
>> +
>> +             The pattern is given by a series of tuples, of brightness and
>> +             duration (ms). The LED is expected to traverse the series and
>> +             each brightness value for the specified duration. Duration of
>> +             0 means brightness should immediately change to new value.
>> +
>> +             The format of the pattern values should be:
>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>> +             duration_3 ...".
>> +
>> +What:                /sys/class/leds/<led>/repeat
>> +Date:                August 2018
>> +KernelVersion:       4.19
>> +Description:
>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>> +
>> +             This file will always return the originally written repeat
>> +             number.
>> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
>> index 4018af7..b76fc3c 100644
>> --- a/drivers/leds/trigger/Kconfig
>> +++ b/drivers/leds/trigger/Kconfig
>> @@ -129,4 +129,11 @@ config LEDS_TRIGGER_NETDEV
>>         This allows LEDs to be controlled by network device activity.
>>         If unsure, say Y.
>>
>> +config LEDS_TRIGGER_PATTERN
>> +     tristate "LED Pattern Trigger"
>> +     help
>> +       This allows LEDs to be controlled by a software or hardware pattern
>> +       which is a series of tuples, of brightness and duration (ms).
>> +       If unsure, say N
>> +
>>  endif # LEDS_TRIGGERS
>> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
>> index f3cfe19..9bcb64e 100644
>> --- a/drivers/leds/trigger/Makefile
>> +++ b/drivers/leds/trigger/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)        += ledtrig-transient.o
>>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)    += ledtrig-camera.o
>>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)     += ledtrig-panic.o
>>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)    += ledtrig-netdev.o
>> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)   += ledtrig-pattern.o
>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
>> new file mode 100644
>> index 0000000..63b94a2
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * LED pattern trigger
>> + *
>> + * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
>> + * the first version, Baolin Wang simplified and improved the approach.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/timer.h>
>> +
>> +#define MAX_PATTERNS         1024
>> +
>> +struct pattern_trig_data {
>> +     struct led_classdev *led_cdev;
>> +     struct led_pattern patterns[MAX_PATTERNS];
>> +     struct led_pattern *curr;
>> +     struct led_pattern *next;
>> +     struct mutex lock;
>> +     u32 npatterns;
>> +     u32 repeat;
>> +     u32 last_repeat;
>> +     bool is_indefinite;
>> +     struct timer_list timer;
>> +};
>> +
>> +static void pattern_trig_update_patterns(struct pattern_trig_data *data)
>> +{
>> +     data->curr = data->next;
>> +     if (!data->is_indefinite && data->curr == data->patterns)
>> +             data->repeat--;
>> +
>> +     if (data->next == data->patterns + data->npatterns - 1)
>> +             data->next = data->patterns;
>> +     else
>> +             data->next++;
>> +}
>> +
>> +static void pattern_trig_timer_function(struct timer_list *t)
>> +{
>> +     struct pattern_trig_data *data = from_timer(data, t, timer);
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (!data->is_indefinite && !data->repeat) {
>> +             mutex_unlock(&data->lock);
>> +             return;
>> +     }
>> +
>> +     led_set_brightness(data->led_cdev, data->curr->brightness);
>> +     mod_timer(&data->timer, jiffies + msecs_to_jiffies(data->curr->delta_t));
>> +     pattern_trig_update_patterns(data);
>> +
>> +     mutex_unlock(&data->lock);
>> +}
>> +
>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>> +                                   struct led_classdev *led_cdev)
>> +{
>> +     if (!data->npatterns)
>> +             return 0;
>> +
>> +     if (led_cdev->pattern_set) {
>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>> +                                          data->npatterns, data->repeat);
>
> I think that it would be more flexible if software pattern fallback
> was applied in case of pattern_set failure. Otherwise, it would
> lead to the situation where LED class devices that support hardware
> blinking couldn't be applied the same set of patterns as LED class
> devices that don't implement pattern_set. The latter will always have to
> resort to using software pattern engine which will accept far greater
> amount of pattern combinations.

Hmmm, I am not sure this is useful for hardware pattern, since the LED
hardware can be diverse which is hard to be compatible with software
pattern.

For example, for our SC27XX LED, it only supports 4 hardware patterns
setting (low time, rising time, high time and falling time) to make it
work at breathing mode. If user provides 3 or 5 patterns values, it
will failed to issue pattern_set(). But at this time, we don't want to
use software pattern instead since it will be not the breathing mode
expected by user. I don't know if there are other special LED
hardware.

So I think we should let LED driver to handle this case, if failed to
issue pattern_set(), the LED driver can set one group default hardware
patterns, or turn off the LED hardware pattern or other error handling
method supplied by LED driver. That will not combine software pattern
and hardware pattern together to make things complicated.

So what do you think?

> In this case we need to discuss on what basis the decision will be
> made on whether hardware or software engine will be used.
>
> Possible options coming to mind:
> - an interface will be provided to determine max difference between
>   the settings supported by the hardware and the settings requested by
>   the user, that will result in aligning user's setting to the hardware
>   capabilities
> - the above alignment rate will be predefined instead
> - hardware engine will be used only if user requests supported settings
>   on the whole span of the requested pattern
> - in each of the above cases it would be worth to think of the
>   interface to show the scope of the settings supported by hardware
>
> The same issue applies to the already available timer trigger.
> So far the policy implemented by the drivers implementing blink_set
> op varies.
>
> --
> Best regards,
> Jacek Anaszewski



-- 
Baolin Wang
Best Regards
