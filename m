Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D69C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D5C206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1DrJ1hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D5C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJCIH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:07:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43264 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeJCIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:07:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id p34-v6so2868110lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AaXTk0mMbdes+kAm2fYqKenFa+eIdjs5Y+taxgvYFkY=;
        b=b1DrJ1hSoUHpIoUa7Lacn+67MFFksl+9E88tjh9Qt4HKx7+/qzGf9ZDkbW2Nnf5lZg
         S4WMbuJmkLIPn0+zwGl2kyi8LpRRzFP1+bawbjam8ZdOO8PbJUANuMS/CiVoYROr0mBD
         gssafceJzOCTxE70uV5AHBiiEs/4PdJ+o70VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AaXTk0mMbdes+kAm2fYqKenFa+eIdjs5Y+taxgvYFkY=;
        b=SPdzoln0BFkbubCTjDSnifbGqZExJY6CqUx8vXJp0PMWysdWg0ZnjoFZuQTt7LcR/3
         evsb/e5oKfvUn0H/pCRVyERffAfj4GUXPsjiU01PZ2vU36s0tE4cYo2bjNmeUx2sgOQt
         JOzqY76MlYHsNkWEOBFWZ3uK6BnIRpXgF64cWO+0XmkbOYG9Gr9h9jdqZdLGksmaE6Mr
         Ui1buLM+Vv4P1Mpzkz9ZfA4swEVjQQDccvK/sNfHh/O0BrEIdg4rGoR47GaJJ1fhuECY
         Mvn0VaON4mmdUl6Zhs19tRquDXw0jfDoQVosbvxxxAZZK0Fs9wwXSk4ri5XMPkOLZVul
         U1ww==
X-Gm-Message-State: ABuFfohYXVX381kO11/T5Z0ZrdMBFOA1M3kRIdyxkIpgH4Vt/v4VzDfq
        u+rAww8u5WbfLgGBRZ/rrwhaWGiBZ/dIsObLEL1j+A==
X-Google-Smtp-Source: ACcGV62Xi7L6w039ltGcJFN9Cel0cusnrpFemlprf4F3hnlHIxvtaKIMJtjSN9utM1eSwTxbQ7FJ//WGAjrcWZddTYE=
X-Received: by 2002:a19:4acd:: with SMTP id x196-v6mr10110385lfa.130.1538529679620;
 Tue, 02 Oct 2018 18:21:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 18:21:19 -0700 (PDT)
In-Reply-To: <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 3 Oct 2018 09:21:19 +0800
Message-ID: <CAMz4kuJ4iB7pn+i29aypnbxxPK_UDjus=EiNZ2WefBB0onZPTg@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 3 October 2018 at 04:25, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> Thank you for the v14. We'll probably need v15, though :-)
>
> I added the comments in the code below.
>
> On 10/02/2018 05:43 PM, Baolin Wang wrote:
>> This patch adds one new led trigger that LED device can configure
>> the software or hardware pattern and trigger it.
>>
>> Consumers can write 'pattern' file to enable the software pattern
>> which alters the brightness for the specified duration with one
>> software timer.
>>
>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>> pattern for some LED controllers which can autonomously control
>> brightness over time, according to some preprogrammed hardware
>> patterns.
>>
>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v13:
>>  - Add duration validation for gradual dimming.
>>  - Coding style optimization.
>>
>> Changes from v12:
>>  - Add gradual dimming support for software pattern.
>>
>> Changes from v11:
>>  - Change -1 means repeat indefinitely.
>>
>> Changes from v10:
>>  - Change 'int' to 'u32' for delta_t field.
>>
>> Changes from v9:
>>  - None.
>>
>> Changes from v8:
>>  - None.
>>
>> Changes from v7:
>>  - Move the SC27XX hardware patterns description into its own ABI file.
>>
>> Changes from v6:
>>  - Improve commit message.
>>  - Optimize the description of the hw_pattern file.
>>  - Simplify some logics.
>>
>> Changes from v5:
>>  - Add one 'hw_pattern' file for hardware patterns.
>>
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
>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |  76 ++++
>>  drivers/leds/trigger/Kconfig                       |   7 +
>>  drivers/leds/trigger/Makefile                      |   1 +
>>  drivers/leds/trigger/ledtrig-pattern.c             | 431 +++++++++++++++++++++
>>  include/linux/leds.h                               |  15 +
>>  5 files changed, 530 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> new file mode 100644
>> index 0000000..22d7af7
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> @@ -0,0 +1,76 @@
>> +What:                /sys/class/leds/<led>/pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a software pattern for the LED, that supports altering
>> +             the brightness for the specified duration with one software
>> +             timer. It can do gradual dimming and constant brightness.
>> +
>> +             The pattern is given by a series of tuples, of brightness and
>> +             duration (ms). The LED is expected to traverse the series and
>> +             each brightness value for the specified duration. Duration of
>> +             0 means brightness should immediately change to new value.
>> +
>> +             1. When doing gradual dimming, the led brightness will be updated
>> +             every 50 milliseconds, so the duration of each step should not
>> +             less than 50 milliseconds.
>
> I'd like to avoid this constraint. Lowest supported delta_t should be 1.
>
> We should only prevent entering dimming mode if current delta_t
> is lower than UPDATE_INTERVAL.

I do not think so. If the pattern format is used for dimming and the
delta_t is lower than UPDATE_INTERVAL, we should return errors. Since
in this case, we can not change to constant mode.

Like you mentioned:

echo "10 49 20 49" > pattern

We can not enter dimming, meanwhile the pattern format is not used for
constant brightness, so should return errors for the invalid pattern
values.

> I also propose to make the dimming interval configurable via sysfs
> dimming_interval file.

So the dimming_interva range is [1, 50] milliseconds?

I am fine with this. Pavel, do you also agree with adding one new file
to set the dimming interval or keep it as simple now?

>
>> The gradual dimming format of the
>> +             software pattern values should be:
>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>> +             duration_3 ...". For example:
>> +
>> +             echo 0 1000 255 2000 > pattern
>> +
>> +             It will make the LED go gradually from zero-intensity to max (255)
>> +             intensity in 1000 milliseconds, then back to zero intensity in 2000
>> +             milliseconds:
>> +
>> +             LED brightness
>> +                 ^
>> +             255-|       / \            / \            /
>> +                 |      /    \         /    \         /
>> +                 |     /       \      /       \      /
>> +                 |    /          \   /          \   /
>> +               0-|   /             \/             \/
>> +                 +---0----1----2----3----4----5----6------------> time (s)
>> +
>> +             2. To make the LED go instantly from one brigntess value to another,
>> +             we should use use zero-time lengths. So the format should be:
>> +             "brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
>> +             brightness_2 0 ...". For example:
>> +
>> +             echo 0 1000 0 0 255 2000 255 0 > pattern
>> +
>> +             It will make the LED stay off for one second, then stay at max brightness
>> +             for two seconds:
>> +
>> +             LED brightness
>> +                 ^
>> +             255-|        +---------+    +---------+
>> +                 |        |         |    |         |
>> +                 |        |         |    |         |
>> +                 |        |         |    |         |
>> +               0-|   -----+         +----+         +----
>> +                 +---0----1----2----3----4----5----6------------> time (s)
>> +
>> +What:                /sys/class/leds/<led>/hw_pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a hardware pattern for the LED, for LED hardware that
>> +             supports autonomously controlling brightness over time, according
>> +             to some preprogrammed hardware patterns.
>> +
>> +             Since different LED hardware can have different semantics of
>> +             hardware patterns, each driver is expected to provide its own
>> +             description for the hardware patterns in their ABI documentation
>> +             file.
>> +
>> +What:                /sys/class/leds/<led>/repeat
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a pattern repeat number. -1 means repeat indefinitely,
>> +             other negative numbers and number 0 are invalid.
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
>> index 0000000..92a0fd0
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,431 @@
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
>> +/*
>> + * When doing gradual dimming, the led brightness will be updated
>> + * every 50 milliseconds.
>> + */
>> +#define UPDATE_INTERVAL              50
>> +
>> +struct pattern_trig_data {
>> +     struct led_classdev *led_cdev;
>> +     struct led_pattern patterns[MAX_PATTERNS];
>> +     struct led_pattern *curr;
>> +     struct led_pattern *next;
>> +     struct mutex lock;
>> +     u32 npatterns;
>> +     int repeat;
>> +     int last_repeat;
>> +     int delta_t;
>> +     bool is_indefinite;
>> +     bool is_hw_pattern;
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
>> +
>> +     data->delta_t = 0;
>> +}
>> +
>> +static int pattern_trig_compute_brightness(struct pattern_trig_data *data)
>> +{
>> +     int step_brightness;
>> +
>> +     if (data->delta_t == 0)
>> +             return data->curr->brightness;
>> +
>> +     step_brightness = abs(data->next->brightness - data->curr->brightness);
>> +     step_brightness = data->delta_t * step_brightness / data->curr->delta_t;
>> +
>> +     if (data->next->brightness > data->curr->brightness)
>> +             return data->curr->brightness + step_brightness;
>> +     else
>> +             return data->curr->brightness - step_brightness;
>> +}
>> +
>> +static void pattern_trig_timer_function(struct timer_list *t)
>> +{
>> +     struct pattern_trig_data *data = from_timer(data, t, timer);
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     for (; ;) {
>
> This whitespace between semicolons looks odd. Please remove it.

Sure.

>
>> +             if (!data->is_indefinite && !data->repeat)
>> +                     break;
>> +
>> +             if (data->curr->brightness == data->next->brightness) {
>> +                     /* Constant brightness */
>> +                     led_set_brightness(data->led_cdev,
>> +                                        data->curr->brightness);
>> +                     mod_timer(&data->timer,
>> +                               jiffies + msecs_to_jiffies(data->curr->delta_t));
>> +
>> +                     /* Skip the step with zero duration */
>> +                     pattern_trig_update_patterns(data);
>> +                     /* Select next step */
>> +                     pattern_trig_update_patterns(data);
>> +                     break;
>> +             } else {
>> +                     /* Gradual dimming */
>> +
>> +                     /*
>> +                      * If the accumulation time is larger than current
>> +                      * step duration, we should go next one and re-check
>> +                      * if we repeated done.
>> +                      */
>> +                     if (data->delta_t > data->curr->delta_t) {
>> +                             pattern_trig_update_patterns(data);
>> +                             continue;
>> +                     }
>> +
>> +                     led_set_brightness(data->led_cdev,
>> +                                        pattern_trig_compute_brightness(data));
>> +                     mod_timer(&data->timer,
>> +                               jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
>> +                     /* Accumulate the gradual dimming time */
>> +                     data->delta_t += UPDATE_INTERVAL;
>> +                     break;
>> +             }
>
> Why two "break" statements instead of one here?

Yes, can remove one. Sorry for the quick version patch set without
much self-checking in the night. Thanks for your comments.

-- 
Baolin Wang
Best Regards
