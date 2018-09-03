Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3639DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AF12086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMt8EnGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AF12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeICXUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:20:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:20:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so1591634wrf.3;
        Mon, 03 Sep 2018 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mj+nVpa9F3IK5JyPCAk8FVXROKRnvjvhpldu87DYG3Y=;
        b=cMt8EnGRP0VoLGiyQ+sn+eXCRsId3PNdhIGYP2hlY8Afxzx4KHdS9TzR4c/rhEjMxM
         nEhfYQ/JA3vNll/Y6PkyO0mhSzXHJnLAVgVX7C6ToFsDM7PS6Nby41QpjElVgkYti0U6
         nJEyJACluCX7PPQpoVLHf6PJTXiuWc5EDDa6M0lq4YQraZ1dLsJeuI+3rbxqQUf+IlTR
         jFXiA7ou4642Zqdt9xhxqk+GfcuIE6PJRahzUkG8rzNkIfzVge09C7/fsf8R1UmyBSb5
         tb+4H/mbeqd+bcsPjmQ1SEr2Vn2FjnuNRtfimuYE8I3hbxKCNEzpYAQ0VSroQuVLYpbQ
         lHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mj+nVpa9F3IK5JyPCAk8FVXROKRnvjvhpldu87DYG3Y=;
        b=L0Txvq58Gld7IehhdL4qCovS4oDZVcG22kd8pOuMBjO+n3PrVPAs+ODVX/1J3GHHe4
         u1H0dmYhG5RbObFXKJA1MC2sh+cLACgRu9ibcj0/n2G+gQu0/kpi9IUT7nJRCFq4vtkp
         8Uys5ApfhIyIf00QZk1jyKa1uPWqFchRpHWY9ontYtmXMs4WUbF5PjMCp2EhSmztWrrD
         v5Bs19Sc7BrAe34BVXZ9grx8K9gHo526FiZy1bd0zp3z0R3GyT/n7NXruYDmN3XKfesA
         sr7sCeTSqQbTUzDzgT74ygp4go2mSUZCyDEbXtioB/RwpBxuzarJTZoOmfmNi/OiYXpM
         RiaQ==
X-Gm-Message-State: APzg51AL5IvDQcSyz1eg1wpljqKluix+XiD7jL2pbj/Az+d07Udgxjb7
        S59VF5aiMpm9slgmqWeX56wX4YNc
X-Google-Smtp-Source: ANB0VdaYfx0fel7P8VzjNAMKBZtfcnou2rmsUr27MkMsdDLR7TCnxdEwXzuehjsojv8hD9cMoaAUnQ==
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr18735495wrp.184.1536001133592;
        Mon, 03 Sep 2018 11:58:53 -0700 (PDT)
Received: from [192.168.1.18] (chg231.neoplus.adsl.tpnet.pl. [83.31.4.231])
        by smtp.gmail.com with ESMTPSA id o3-v6sm15004164wrn.58.2018.09.03.11.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:58:52 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] leds: core: Introduce LED pattern trigger
To:     pavel@ucw.cz, bjorn.andersson@linaro.org
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e6d4e7be537a4e4d6fce26c6d446703b1910eab9.1535700092.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ef266d4a-ba0e-cba6-ae30-ebbf730e28a2@gmail.com>
Date:   Mon, 3 Sep 2018 20:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e6d4e7be537a4e4d6fce26c6d446703b1910eab9.1535700092.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the update.

Please find my remarks below.

On 08/31/2018 09:52 AM, Baolin Wang wrote:
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
>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   44 +++
>  drivers/leds/trigger/Kconfig                       |    7 +
>  drivers/leds/trigger/Makefile                      |    1 +
>  drivers/leds/trigger/ledtrig-pattern.c             |  337 ++++++++++++++++++++
>  include/linux/leds.h                               |   16 +
>  5 files changed, 405 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> new file mode 100644
> index 0000000..f4749d1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -0,0 +1,44 @@
> +What:		/sys/class/leds/<led>/pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a software pattern for the LED, that supports altering
> +		the brightness for the specified duration with one software
> +		timer.
> +
> +		The pattern is given by a series of tuples, of brightness and
> +		duration (ms). The LED is expected to traverse the series and
> +		each brightness value for the specified duration. Duration of
> +		0 means brightness should immediately change to new value.
> +
> +		The format of the software pattern values should be:
> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +		duration_3 ...".
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
> +		description for the hardware patterns as below.

And I would cut this description here.

> +		For Spreadtrum SC27XX LED controller, it only supports 4 hardware
> +		patterns to configure the low time, rise time, high time and fall
> +		time for the breathing mode, and each stage duration unit is 125ms.
> +		So the format of the hardware pattern values should be:
> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +		 duration_3 brightness_4 duration_4".

This part should go to the separate ABI documentation file, related to
the driver for Spreadtrum SC27XX.

> +
> +What:		/sys/class/leds/<led>/repeat
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a pattern repeat number. 0 means repeat indefinitely.
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
> index 0000000..0179191
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,337 @@
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
> +	u32 last_repeat;
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

I have doubts here if it is a good idea to enforce array of tuples
as a generic interface for all hw_patterns. It may not fit well for
every hw pattern engine. It seems that the only feasible solution will
be allowing drivers to come up with their own interfaces, i.e. the
approach you proposed at first for your driver. It seems that the
ledtrig-pattern with software pattern mechanism will be just
a nice side effect of this series :-)

Unless someone will propose a better solution.

We need a broader consensus here. I'd like to hear Pavel's opinion,
since he's been always in favor of common pattern interface, and
inspired this work.

Pavel?

Best regards,
Jacek Anaszewski
