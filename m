Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26AFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 05:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D8220839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 05:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Txylhr6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D8220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHaJ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 05:56:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35098 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHaJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 05:56:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so19748007oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wAVuE453FAccITB0z3SW2E3HPbKxgtUT3+8NfBTTGd4=;
        b=Txylhr6+uTwutS6+og+u1gesAEIO6lxUSmMYNrZ9muFq2VSHNyb1bam/OSBiz4n2vk
         oJ5sK+WrAqdUL8XoUqCLmJB3VpJXq8zh/oygbNbdeJ5FRkPPkxveKm08gKB/6oh9NraH
         8Q6tIx2VY6GHoYYMsGFkxW49gQe+ucxbxT8fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wAVuE453FAccITB0z3SW2E3HPbKxgtUT3+8NfBTTGd4=;
        b=XjR3LosdzDatZkyampzqV5h75dBfLWBjd+lfiv0cLFV61GsK3C1jpula/oz6Dw7JjW
         KaUbaDG+JRmf2JnYo/daPb84iXl3zVr0As//8g3ATkLaXvtV+bk1vjXqKU6PMWmXqwvV
         X7ZmjYEkwM4A8J9EWrk0IBQoejZGwlD665y/SUoFRm3eT9u/Y71EPjjeb1ZkQhVMXSC0
         +iFvucldmbVWn1GjTv6WcLEaLK/M+Zzg4diDFG7Wcfv0xK+tc71m1YaIG8SgbGPgZBHZ
         rhXR91+bq0B2rnQSkYWCGW2tVz/3yHad+ueX/JYO/WC4ombhDoxfb5OT/otAOQyhIb08
         hCEQ==
X-Gm-Message-State: APzg51Ao1X04XN9Gb7X9GMas6m/ZMqmCV2CD8kGhRXXZxPeEblHS349+
        lgEtglnmkDsNvOJ8Fq3tx2+HoKUjvdFN31zfkTXY0w==
X-Google-Smtp-Source: ANB0VdYSwOke//yWAe5ivJCUAnnmOuA0GT0aJuVQSxNWkqDfoItcom6kyRyaNIFemtZ9iZXlczTAu6QSuEMXUbkUHRA=
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr6120474oia.280.1535694651976;
 Thu, 30 Aug 2018 22:50:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:54a:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 22:50:51 -0700 (PDT)
In-Reply-To: <fb17f587-7ef5-6738-1da4-a048b0b17c98@gmail.com>
References: <f8f1439338464103cc9a4b4a93b590a9635c7fcb.1535614434.git.baolin.wang@linaro.org>
 <fb17f587-7ef5-6738-1da4-a048b0b17c98@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 31 Aug 2018 13:50:51 +0800
Message-ID: <CAMz4kuJLoBdGEGkDzcFUcz3HxjUJX63Sjv9U7jpTPRUFYCaXKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] leds: core: Introduce LED pattern trigger
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

On 31 August 2018 at 03:55, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 08/30/2018 09:40 AM, Baolin Wang wrote:
>> Some LED controllers have support for autonomously controlling
>> brightness over time, according to some preprogrammed pattern or
>> function.
>
> I think that this commit message should be rearranged, so that
> the software pattern was mentioned in the first place. Please keep
> in mind that LED triggers are defined as kernel based sources of
> LED events in the first place.

Sure.

>
>>
>> This patch adds pattern trigger that LED device can configure the
>> pattern and trigger it.
>>
>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
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
>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   41 +++
>>  drivers/leds/trigger/Kconfig                       |    7 +
>>  drivers/leds/trigger/Makefile                      |    1 +
>>  drivers/leds/trigger/ledtrig-pattern.c             |  344 ++++++++++++++++++++
>>  include/linux/leds.h                               |   16 +
>>  5 files changed, 409 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> new file mode 100644
>> index 0000000..dda8bbc
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> @@ -0,0 +1,41 @@
>> +What:                /sys/class/leds/<led>/pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a software pattern for the LED, that supports altering
>> +             the brightness for the specified duration with one software
>> +             timer.
>> +
>> +             The pattern is given by a series of tuples, of brightness and
>> +             duration (ms). The LED is expected to traverse the series and
>> +             each brightness value for the specified duration. Duration of
>> +             0 means brightness should immediately change to new value.
>> +
>> +             The format of the software pattern values should be:
>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>> +             duration_3 ...".
>> +
>> +What:                /sys/class/leds/<led>/hw_pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a hardware pattern for the LED, for LED hardware that
>> +             supports altering the brightness as a function of time.
>> +
>> +             The pattern is given by a series of tuples, of brightness and
>> +             duration (ms). The LED is expected to traverse the series and
>> +             each brightness value for the specified duration. Duration of
>> +             0 means brightness should immediately change to new value.
>> +
>> +             The format of the hardware pattern values should be:
>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>> +             duration_3 ...".
>
> hw_pattern interface should have separate description for each driver
> supporting it. This is why we are to have a separate file for it.
> So, here I'd just mention that each driver is expected to provide its
> own ABI documentation for hw_pattern.
>
> E.g. in case of sc27xx you should describe the specific semantics of
> each tuple, which will refer to a breathing curve settings.

Sure. Will do.

>
>> +
>> +What:                /sys/class/leds/<led>/repeat
>> +Date:                September 2018
>> +KernelVersion:       4.20
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
>> index 0000000..efbd5ef
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,344 @@
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
>> +     u32 repeat;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     repeat = data->last_repeat;
>> +
>> +     mutex_unlock(&data->lock);
>> +
>> +     return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
>> +}
>> +
>> +static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
>> +                         const char *buf, size_t count)
>> +{
>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>> +     unsigned long res;
>> +     int err;
>> +
>> +     err = kstrtoul(buf, 10, &res);
>> +     if (err)
>> +             return err;
>> +
>> +     /*
>> +      * Clear previous patterns' performence firstly, and remove the timer
>> +      * without mutex lock to avoid dead lock.
>> +      */
>> +     del_timer_sync(&data->timer);
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (data->is_hw_pattern)
>> +             led_cdev->pattern_clear(led_cdev);
>> +
>> +     data->last_repeat = data->repeat = res;
>> +
>> +     /* 0 means repeat indefinitely */
>> +     if (!data->repeat)
>> +             data->is_indefinite = true;
>> +     else
>> +             data->is_indefinite = false;
>
> data->is_indefinite = !data->repeat;

OK.

>
>> +
>> +     err = pattern_trig_start_pattern(led_cdev);
>> +
>> +     mutex_unlock(&data->lock);
>> +     return err < 0 ? err : count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(repeat);
>> +
>> +static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
>> +                                       char *buf, bool hw_pattern)
>> +{
>> +     ssize_t count = 0;
>> +     int i;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (!data->npatterns || (data->is_hw_pattern ^ hw_pattern))
>> +             goto out;
>> +
>> +     for (i = 0; i < data->npatterns; i++) {
>> +             count += scnprintf(buf + count, PAGE_SIZE - count,
>> +                                "%d %d ",
>> +                                data->patterns[i].brightness,
>> +                                data->patterns[i].delta_t);
>> +     }
>> +
>> +     buf[count - 1] = '\n';
>> +
>> +out:
>> +     mutex_unlock(&data->lock);
>> +     return count;
>> +}
>> +
>> +static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
>> +                                        const char *buf, size_t count,
>> +                                        bool hw_pattern)
>> +{
>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>> +     int ccount, cr, offset = 0, err = 0;
>> +
>> +     /*
>> +      * Clear previous patterns' performence firstly, and remove the timer
>> +      * without mutex lock to avoid dead lock.
>> +      */
>> +     del_timer_sync(&data->timer);
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (data->is_hw_pattern)
>> +             led_cdev->pattern_clear(led_cdev);
>> +
>> +     if (hw_pattern)
>> +             data->is_hw_pattern = true;
>> +     else
>> +             data->is_hw_pattern = false;
>
> Why not just:
>
> data->is_hw_pattern = hw_pattern;

Right. Will simplify this logic. Thanks.

-- 
Baolin Wang
Best Regards
