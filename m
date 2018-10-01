Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CD2208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="anYPC1oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CD2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeJAT4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:56:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32958 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbeJAT4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:56:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so3035906ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1ytTkeAzpv5Oi2/xdbMY1rgh6ABFauwiiR1loKJ1Ong=;
        b=anYPC1oQ9mV04DQTNBSu/yHdYqFp84XiEyMNCm9mLNU8nYYcqAxVfzGdqWflDk18Gv
         HQpOHH+q7Isc3K+6acjOGiWaRjiUfH/30Z1fJkabokfA9Hwh6I8FmyU6KhmsUyuZKOJH
         ZfAnc0ZZhWeHz9tRhSpi/CFay15gR6BakOuGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1ytTkeAzpv5Oi2/xdbMY1rgh6ABFauwiiR1loKJ1Ong=;
        b=I0HXEcH2ay3WgfkGXuk3wmRoR1cQ2brYPlZNrcwqf6i62PYysgyhQEF7ulidv/r3MS
         AfIQ1ny3x58xuOa86JvvZB9aV+uDRBqYkh9bZSUWDu1mgZpBlN4KZxLAXwnm1CPvKPCm
         cU4v+NL6rUdWhfL4pPVQVyN+5QNL6hcXE3/8LMwfAiu9QJn6lWIhc91ll4MXVJRoARVI
         ckxpMIyWcWwsrmLrnk6dDBqVhfAHe4qdrZUGIbt078BQ4sFtpHeshvaABlQuuSxf3E2P
         zRX+Hra/0/wMMw3fxp+l3ezYeHhG2ILI+2hzbKkzO2Jci9CwB08xLcpSgiFPddbeCFtw
         G+uA==
X-Gm-Message-State: ABuFfohnLpHYKg0hiIeM6pBBaZXmTXtrFpkPJw3laCuwBvE9uQG5qwSG
        +OBw74y4lt7mYRlarcDxPnUMd/EdKB0mQGm7LMn0cA==
X-Google-Smtp-Source: ACcGV61bQ8eBwS0yr5vJXEf/zeNDS81e9WiAgt8Ck2/kOnmEp+bOqjETefqFw2GHNdbUPfcTeuIOz3bUbE/k2S2SBWc=
X-Received: by 2002:a2e:c49:: with SMTP id o9-v6mr7050597ljd.16.1538399935164;
 Mon, 01 Oct 2018 06:18:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 06:18:54 -0700 (PDT)
In-Reply-To: <d3401d05-81c3-0162-4dd0-b9c7c2652baf@gmail.com>
References: <c91996be3f80f73c02944565461c3869619fdb1f.1538024257.git.baolin.wang@linaro.org>
 <d3401d05-81c3-0162-4dd0-b9c7c2652baf@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 1 Oct 2018 21:18:54 +0800
Message-ID: <CAMz4ku+6xF2wiTfEj_u4wdPLM7aFnqTAtGnVyA+BpkdgBuzHgQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 30 September 2018 at 23:33, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> Thank you for adding the dimming support.
>
> I've tested it and detected severe problem when
> delta_t is lower than 50, i.e. UPDATE_INTERVAL.
>
> echo "10 49 20 49" > pattern
>
> results after a while in a system wide freeze, see the following
> kernel log:
>
> [  210.593592] rcu: INFO: rcu_sched self-detected stall on CPU
> [  210.593601] rcu:     4-....: (21134 ticks this GP) idle=5b6/0/0x3
> softirq=4843/4843 fqs=5250
> [  210.593602] rcu:      (t=21000 jiffies g=25697 q=79)
> [  210.593605] NMI backtrace for cpu 4
> [  210.593608] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.19.0-rc1+ #156
> [  210.593609] Hardware name: Gigabyte Technology Co., Ltd.
> Z97-HD3/Z97-HD3, BIOS F6 06/11/2014
> [  210.593609] Call Trace:
> [  210.593612]  <IRQ>
> [  210.593618]  dump_stack+0x46/0x5b
> [  210.593621]  nmi_cpu_backtrace+0x90/0xa0
> [  210.593625]  ? lapic_can_unplug_cpu+0x90/0x90
> [  210.593627]  nmi_trigger_cpumask_backtrace+0x8d/0xc0
> [  210.593630]  rcu_dump_cpu_stacks+0x83/0xb3
> [  210.593632]  rcu_check_callbacks+0x5aa/0x710
> [  210.593636]  ? tick_sched_do_timer+0x50/0x50
> [  210.593638]  update_process_times+0x23/0x50
> [  210.593640]  tick_sched_handle+0x2f/0x40
> [  210.593642]  tick_sched_timer+0x32/0x70
> [  210.593644]  __hrtimer_run_queues+0xf7/0x270
> [  210.593646]  hrtimer_interrupt+0x11d/0x270
> [  210.593649]  smp_apic_timer_interrupt+0x5d/0x130
> [  210.593651]  apic_timer_interrupt+0xf/0x20
> [  210.593655] RIP: 0010:pattern_trig_timer_function+0x23/0x100
> [  210.593657] Code: ff ff eb f6 0f 1f 00 41 54 4c 8d a7 b0 df ff ff 55
> 53 48 89 fb 49 8d ac 24 18 20 00 00 48 89 ef e8 f2 d3 29 00 eb 16 8b 53
> f4 <8b> 08 39 ca 77 05 83 f9 31 77 6d 4c 89 e7 e8 aa f9 ff ff 80 7b f8
> [  210.593658] RSP: 0018:ffff8d1017903eb8 EFLAGS: 00000216 ORIG_RAX:
> ffffffffffffff13
> [  210.593659] RAX: ffff8d0fe7330010 RBX: ffff8d0fe7332050 RCX:
> 0000000000000031
> [  210.593660] RDX: 0000000000000000 RSI: 0000000000000014 RDI:
> 000000000000000a
> [  210.593661] RBP: ffff8d0fe7332018 R08: ffff8d1017903f08 R09:
> ffff8d1017903f08
> [  210.593662] R10: 0000002c1cd5e92f R11: 0000000000000000 R12:
> ffff8d0fe7330000
> [  210.593663] R13: ffffffffaa738a70 R14: 0000000000000000 R15:
> 0000000000000001
> [  210.593665]  ? apic_timer_interrupt+0xa/0x20
> [  210.593666]  ? pattern_trig_activate+0xc0/0xc0
> [  210.593669]  ? pattern_trig_timer_function+0x36/0x100
> [  210.593671]  call_timer_fn+0x26/0x130
> [  210.593672]  run_timer_softirq+0x1cc/0x400
> [  210.593674]  ? enqueue_hrtimer+0x35/0x90
> [  210.593676]  ? __hrtimer_run_queues+0x127/0x270
> [  210.593679]  ? recalibrate_cpu_khz+0x10/0x10
> [  210.593681]  __do_softirq+0x104/0x2a5
> [  210.593685]  irq_exit+0x9d/0xa0
> [  210.593687]  smp_apic_timer_interrupt+0x67/0x130
> [  210.593688]  apic_timer_interrupt+0xf/0x20
> [  210.593689]  </IRQ>
> [  210.593693] RIP: 0010:cpuidle_enter_state+0xf8/0x2a0
> [  210.593694] Code: c7 0f 1f 44 00 00 31 ff e8 65 69 95 ff 80 7c 24 03
> 00 74 12 9c 58 f6 c4 02 0f 85 8c 01 00 00 31 ff e8 7c 41 9a ff fb 4d 29
> e7 <48> ba cf f7 53 e3 a5 9b c4 20 4c 89 f8 4c 89 fd 48 f7 ea 48 c1 fd
> [  210.593695] RSP: 0018:ffffb0fc00cf7e88 EFLAGS: 00000206 ORIG_RAX:
> ffffffffffffff13
> [  210.593696] RAX: ffff8d1017920dc0 RBX: ffff8d1014b49c00 RCX:
> 000000000000001f
> [  210.593697] RDX: 0000000000000000 RSI: 000000c1514cc3a0 RDI:
> 0000000000000000
> [  210.593698] RBP: 0000000000000001 R08: fffffffbcf10adc2 R09:
> 000000000000afc7
> [  210.593699] R10: 000000000000003c R11: ffff8d101791fe68 R12:
> 0000002c1d11a32d
> [  210.593700] R13: 0000000000000001 R14: 0000000000000004 R15:
> 0000000000011a82
> [  210.593703]  ? cpuidle_enter_state+0xdb/0x2a0
> [  210.593705]  do_idle+0x1f5/0x250
> [  210.593707]  cpu_startup_entry+0x6a/0x70
> [  210.593709]  start_secondary+0x183/0x1b0
> [  210.593711]  secondary_startup_64+0xa4/0xb0
>
> Probably the best solution would be to avoid the dimming if
> delta_t is lower than UPDATE_INTERVAL.

Thanks for your testing. Yes, I will valid the delta_t value when user
use the gradual dimming, and add some comments in ABI to make it
clear, that we should not set delta_t lower than UPDATE_INTERVAL for
gradual dimming.

>
> Besides the above, please refer also to my comments below.
>
> On 09/27/2018 07:04 AM, Baolin Wang wrote:
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
>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   74 ++++
>>  drivers/leds/trigger/Kconfig                       |    7 +
>>  drivers/leds/trigger/Makefile                      |    1 +
>>  drivers/leds/trigger/ledtrig-pattern.c             |  406 ++++++++++++++++++++
>>  include/linux/leds.h                               |   15 +
>>  5 files changed, 503 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> new file mode 100644
>> index 0000000..e84d42a
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> @@ -0,0 +1,74 @@
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
>> +             1. The gradual dimming format of the software pattern values
>> +             should be:
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
>> index 0000000..7aba30e
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,406 @@
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
>> +try_again:
>> +     if (!data->is_indefinite && !data->repeat) {
>> +             mutex_unlock(&data->lock);
>> +             return;
>> +     }
>
> Let's change try_again label to "for (;;) {" here (it seems that
> above condition needs to be evaluated only on enter to this function).

Sure.

>
>> +     if (data->curr->brightness == data->next->brightness) {
>> +             /* Constant brightness */
>> +             led_set_brightness(data->led_cdev, data->curr->brightness);
>> +             mod_timer(&data->timer,
>> +                       jiffies + msecs_to_jiffies(data->curr->delta_t));
>> +
>> +             /* Skip the step with zero duration */
>> +             pattern_trig_update_patterns(data);
>> +             /* Select next step */
>> +             pattern_trig_update_patterns(data);
>> +     } else {
>> +             /* Gradual dimming */
>> +
>> +             /*
>> +              * If the accumulation time is larger than current step
>> +              * duration, we should go next one and re-check if we
>> +              * repeated done.
>> +              */
>> +             if (data->delta_t > data->curr->delta_t) {
>> +                     pattern_trig_update_patterns(data);
>> +                     goto try_again;
>
> When in for (;;) loop, we can "continue" here instead.

Yes.

>
>> +             }
>> +
>> +             /*
>> +              * If current step duration is less than UPDATE_INTERVAL, we
>> +              * should go next one and re-check if we repeated done.
>> +              */
>> +             if (data->curr->delta_t < UPDATE_INTERVAL) {
>> +                     pattern_trig_update_patterns(data);
>> +                     goto try_again;
>
> Ditto.
>
>> +             }
>> +
>> +             led_set_brightness(data->led_cdev,
>> +                                pattern_trig_compute_brightness(data));
>> +             mod_timer(&data->timer,
>> +                       jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
>> +             /* Accumulate the gradual dimming time */
>> +             data->delta_t += UPDATE_INTERVAL;
>> +     }
>
> When in for (;;) loop we should "break" here.

Yes.

>
>> +     mutex_unlock(&data->lock);
>> +}
>> +
>> +static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
>> +{
>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>> +
>> +     if (!data->npatterns)
>> +             return 0;
>> +
>> +     if (data->is_hw_pattern) {
>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>> +                                          data->npatterns, data->repeat);
>> +     }
>> +
>> +     data->delta_t = 0;
>> +     data->curr = data->patterns;
>> +     data->next = data->npatterns > 1 ? data->patterns + 1 : data->patterns;
>> +     data->timer.expires = jiffies;
>> +     add_timer(&data->timer);
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t repeat_show(struct device *dev, struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>> +     int repeat;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     repeat = data->last_repeat;
>
> I'm not sure if we discussed it earlier, but currently repeat_show
> always reports initially requested repeat number, instead of the
> number of remaining iterations. IMHO the latter approach would be
> more useful.

That's what we discussed before and had a consensus about this. Please see:
https://lore.kernel.org/patchwork/patch/971746/

Thanks.

-- 
Baolin Wang
Best Regards
