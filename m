Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25612C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEED820833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQrzLQT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEED820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeI3WHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:07:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43861 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeI3WHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:07:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so9835447ljc.10;
        Sun, 30 Sep 2018 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PphHukpW6z7IwSzRcNDBicvdtpCO1yxeLGN6PRr146g=;
        b=TQrzLQT9kxao2/DUkEqk5IcPmpPXBIzEhwrFSEYOLHOnd22+JlZ3sywAByVMl1vbeZ
         NqK5Ly7uJuaAsHWYbtRkJUgdkCsU9WzO/Z8IZu26Wmpm+idH0/XjrVbEgBKZKkSDr2h+
         jHn3UqNv3NYCbl/LwOtr43n0VnuyJjPEj06pPLaS4lMtmKyvntcWIYSZ89QNo5ICZanP
         5FNC+t+TGY3YYfykS8HinpUgA84kc6VY8pzgRWvz29MKb7Z7yAtl0qGaFA4WRgI//Lsv
         BPmr6HRyo+32WS8MpAwn3vPfXNb2Es71ajFpmgsUqE88MB75PsYCzDsZutmB1M+DHvBU
         TzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PphHukpW6z7IwSzRcNDBicvdtpCO1yxeLGN6PRr146g=;
        b=mo5VsgbzUMnAfTgFWQFvVTJLy/WR7xCZUClWVL3x+ainZZNOWjquy+iTiKxxevQEau
         C0zH/F3Dy+bbStDQ5KZa/FYNXIIz6xN1QSUWdjiUNantbYUGDMCc7yW41zPrF4c1Sn0u
         HxeMB8xQwk9XBk63wUI7nVkJViCWukD/M85b1FfwwKdFQO6qZgNc+VHZUcSev9yyCBHd
         Pni9fTjKLAMYW6cjdNxOfiU/uWwUnRtHoAg+sxV6U1dDEPr/pS26kFcx3rCPjyf7GAXA
         OipB3hmmTOSfF0pChWuZxATe9fkGrDartWODKW90RHngNj6z6AWVYJl6P7u1eXxakla/
         lgEQ==
X-Gm-Message-State: ABuFfoiNxakg3GeKT9dQVT+b6tiHLUj6JdkFr7TmihkQes8XcXeySJyT
        cTZuR7Xp2dtn+X0O9yQKy3jlaaKf
X-Google-Smtp-Source: ACcGV61lxNr6mJmZ6je+1yZJeeB9T5wZ0dYI1yOt+GOQaXxC82KkatRieuiwW8Bcl8iU0S6usxW3KA==
X-Received: by 2002:a2e:240b:: with SMTP id k11-v6mr4461932ljk.139.1538321623423;
        Sun, 30 Sep 2018 08:33:43 -0700 (PDT)
Received: from [192.168.1.18] (drr162.neoplus.adsl.tpnet.pl. [83.24.203.162])
        by smtp.gmail.com with ESMTPSA id a8-v6sm2060957ljd.6.2018.09.30.08.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 08:33:42 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v13 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c91996be3f80f73c02944565461c3869619fdb1f.1538024257.git.baolin.wang@linaro.org>
Message-ID: <d3401d05-81c3-0162-4dd0-b9c7c2652baf@gmail.com>
Date:   Sun, 30 Sep 2018 17:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c91996be3f80f73c02944565461c3869619fdb1f.1538024257.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for adding the dimming support.

I've tested it and detected severe problem when
delta_t is lower than 50, i.e. UPDATE_INTERVAL.

echo "10 49 20 49" > pattern

results after a while in a system wide freeze, see the following
kernel log:

[  210.593592] rcu: INFO: rcu_sched self-detected stall on CPU
[  210.593601] rcu: 	4-....: (21134 ticks this GP) idle=5b6/0/0x3
softirq=4843/4843 fqs=5250
[  210.593602] rcu: 	 (t=21000 jiffies g=25697 q=79)
[  210.593605] NMI backtrace for cpu 4
[  210.593608] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.19.0-rc1+ #156
[  210.593609] Hardware name: Gigabyte Technology Co., Ltd.
Z97-HD3/Z97-HD3, BIOS F6 06/11/2014
[  210.593609] Call Trace:
[  210.593612]  <IRQ>
[  210.593618]  dump_stack+0x46/0x5b
[  210.593621]  nmi_cpu_backtrace+0x90/0xa0
[  210.593625]  ? lapic_can_unplug_cpu+0x90/0x90
[  210.593627]  nmi_trigger_cpumask_backtrace+0x8d/0xc0
[  210.593630]  rcu_dump_cpu_stacks+0x83/0xb3
[  210.593632]  rcu_check_callbacks+0x5aa/0x710
[  210.593636]  ? tick_sched_do_timer+0x50/0x50
[  210.593638]  update_process_times+0x23/0x50
[  210.593640]  tick_sched_handle+0x2f/0x40
[  210.593642]  tick_sched_timer+0x32/0x70
[  210.593644]  __hrtimer_run_queues+0xf7/0x270
[  210.593646]  hrtimer_interrupt+0x11d/0x270
[  210.593649]  smp_apic_timer_interrupt+0x5d/0x130
[  210.593651]  apic_timer_interrupt+0xf/0x20
[  210.593655] RIP: 0010:pattern_trig_timer_function+0x23/0x100
[  210.593657] Code: ff ff eb f6 0f 1f 00 41 54 4c 8d a7 b0 df ff ff 55
53 48 89 fb 49 8d ac 24 18 20 00 00 48 89 ef e8 f2 d3 29 00 eb 16 8b 53
f4 <8b> 08 39 ca 77 05 83 f9 31 77 6d 4c 89 e7 e8 aa f9 ff ff 80 7b f8
[  210.593658] RSP: 0018:ffff8d1017903eb8 EFLAGS: 00000216 ORIG_RAX:
ffffffffffffff13
[  210.593659] RAX: ffff8d0fe7330010 RBX: ffff8d0fe7332050 RCX:
0000000000000031
[  210.593660] RDX: 0000000000000000 RSI: 0000000000000014 RDI:
000000000000000a
[  210.593661] RBP: ffff8d0fe7332018 R08: ffff8d1017903f08 R09:
ffff8d1017903f08
[  210.593662] R10: 0000002c1cd5e92f R11: 0000000000000000 R12:
ffff8d0fe7330000
[  210.593663] R13: ffffffffaa738a70 R14: 0000000000000000 R15:
0000000000000001
[  210.593665]  ? apic_timer_interrupt+0xa/0x20
[  210.593666]  ? pattern_trig_activate+0xc0/0xc0
[  210.593669]  ? pattern_trig_timer_function+0x36/0x100
[  210.593671]  call_timer_fn+0x26/0x130
[  210.593672]  run_timer_softirq+0x1cc/0x400
[  210.593674]  ? enqueue_hrtimer+0x35/0x90
[  210.593676]  ? __hrtimer_run_queues+0x127/0x270
[  210.593679]  ? recalibrate_cpu_khz+0x10/0x10
[  210.593681]  __do_softirq+0x104/0x2a5
[  210.593685]  irq_exit+0x9d/0xa0
[  210.593687]  smp_apic_timer_interrupt+0x67/0x130
[  210.593688]  apic_timer_interrupt+0xf/0x20
[  210.593689]  </IRQ>
[  210.593693] RIP: 0010:cpuidle_enter_state+0xf8/0x2a0
[  210.593694] Code: c7 0f 1f 44 00 00 31 ff e8 65 69 95 ff 80 7c 24 03
00 74 12 9c 58 f6 c4 02 0f 85 8c 01 00 00 31 ff e8 7c 41 9a ff fb 4d 29
e7 <48> ba cf f7 53 e3 a5 9b c4 20 4c 89 f8 4c 89 fd 48 f7 ea 48 c1 fd
[  210.593695] RSP: 0018:ffffb0fc00cf7e88 EFLAGS: 00000206 ORIG_RAX:
ffffffffffffff13
[  210.593696] RAX: ffff8d1017920dc0 RBX: ffff8d1014b49c00 RCX:
000000000000001f
[  210.593697] RDX: 0000000000000000 RSI: 000000c1514cc3a0 RDI:
0000000000000000
[  210.593698] RBP: 0000000000000001 R08: fffffffbcf10adc2 R09:
000000000000afc7
[  210.593699] R10: 000000000000003c R11: ffff8d101791fe68 R12:
0000002c1d11a32d
[  210.593700] R13: 0000000000000001 R14: 0000000000000004 R15:
0000000000011a82
[  210.593703]  ? cpuidle_enter_state+0xdb/0x2a0
[  210.593705]  do_idle+0x1f5/0x250
[  210.593707]  cpu_startup_entry+0x6a/0x70
[  210.593709]  start_secondary+0x183/0x1b0
[  210.593711]  secondary_startup_64+0xa4/0xb0

Probably the best solution would be to avoid the dimming if
delta_t is lower than UPDATE_INTERVAL.

Besides the above, please refer also to my comments below.

On 09/27/2018 07:04 AM, Baolin Wang wrote:
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
>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   74 ++++
>  drivers/leds/trigger/Kconfig                       |    7 +
>  drivers/leds/trigger/Makefile                      |    1 +
>  drivers/leds/trigger/ledtrig-pattern.c             |  406 ++++++++++++++++++++
>  include/linux/leds.h                               |   15 +
>  5 files changed, 503 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> new file mode 100644
> index 0000000..e84d42a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -0,0 +1,74 @@
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
> +		1. The gradual dimming format of the software pattern values
> +		should be:
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
> index 0000000..7aba30e
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,406 @@
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
> +try_again:
> +	if (!data->is_indefinite && !data->repeat) {
> +		mutex_unlock(&data->lock);
> +		return;
> +	}

Let's change try_again label to "for (;;) {" here (it seems that
above condition needs to be evaluated only on enter to this function).

> +	if (data->curr->brightness == data->next->brightness) {
> +		/* Constant brightness */
> +		led_set_brightness(data->led_cdev, data->curr->brightness);
> +		mod_timer(&data->timer,
> +			  jiffies + msecs_to_jiffies(data->curr->delta_t));
> +
> +		/* Skip the step with zero duration */
> +		pattern_trig_update_patterns(data);
> +		/* Select next step */
> +		pattern_trig_update_patterns(data);
> +	} else {
> +		/* Gradual dimming */
> +
> +		/*
> +		 * If the accumulation time is larger than current step
> +		 * duration, we should go next one and re-check if we
> +		 * repeated done.
> +		 */
> +		if (data->delta_t > data->curr->delta_t) {
> +			pattern_trig_update_patterns(data);
> +			goto try_again;

When in for (;;) loop, we can "continue" here instead.

> +		}
> +
> +		/*
> +		 * If current step duration is less than UPDATE_INTERVAL, we
> +		 * should go next one and re-check if we repeated done.
> +		 */
> +		if (data->curr->delta_t < UPDATE_INTERVAL) {
> +			pattern_trig_update_patterns(data);
> +			goto try_again;

Ditto.

> +		}
> +
> +		led_set_brightness(data->led_cdev,
> +				   pattern_trig_compute_brightness(data));
> +		mod_timer(&data->timer,
> +			  jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
> +		/* Accumulate the gradual dimming time */
> +		data->delta_t += UPDATE_INTERVAL;
> +	}

When in for (;;) loop we should "break" here.

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

I'm not sure if we discussed it earlier, but currently repeat_show
always reports initially requested repeat number, instead of the
number of remaining iterations. IMHO the latter approach would be
more useful.

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
