Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97E6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C020862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIgA4Vcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645C020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeGaIbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:31:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44137 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeGaIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:31:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so25975833oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uUIpzbpeyEYt471cC8KcgTQV8d0C2HJ/MEN72wcuvPQ=;
        b=UIgA4VccD4BkDMKnPzKtzaiqoKXw1YuNhSVcsHVso4TDNoEgOjqaXKtapoUxhEzj3f
         vaAMwtsWHH+oVa4DTTUz/IpKbaOros+JALtQL9+0Kj3qfvMd4MKjBOctBzq5njg7sTI5
         enOS60c633IuDD7otnyqMQUUXlWgPP7DxF53g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uUIpzbpeyEYt471cC8KcgTQV8d0C2HJ/MEN72wcuvPQ=;
        b=bbQM2DsKWFnGvqxIvmEDe/7bh9rN1Hy+JRfU6yU8XCsn4bb/PfhEnNdhbCjss0Kpm0
         oZw3VDOpJDdBQ/0cxZgnRkn1ouudy1p1K5rQZmk9rWPF/pvzaBDSDflDgBLLIEAGT8A9
         Q+9yEOGIoMyPRDrY3j+lbeotuD1m492va/rQ++acVNvpdJ6NYHAhLfDStt1tseMhu8Zs
         yBDkuepX8yAki3VHzBlJ79BdFlysS2PBALFbKiHCK7YE6tJzrXWbJApzD/0ZebJnHUmF
         wPdvAPqDYYAG9TzETv+YYrJWTSHmGMufGrH4oPHI7RMX3/KgHoh83PEGhxSx/4AFZJXS
         BKKQ==
X-Gm-Message-State: AOUpUlEDUCM0XZTt6n3CZDppXhRHBpAN0bnQp33JuXJCdSO6ZvaCjZg+
        VSjbPP7TyyhEsxO8gqQc2QJt3LJ0wGXFScdflkI20A==
X-Google-Smtp-Source: AAOMgpd7r537+snzcX9Ytzz9ZxOyWD/QGn2cble75MogbK07/kB0R5UqK3SwPRqrF8qSPIuB6F5tQ78DtvuYmLZjIq0=
X-Received: by 2002:aca:e142:: with SMTP id y63-v6mr22591857oig.128.1533019967524;
 Mon, 30 Jul 2018 23:52:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 23:52:46
 -0700 (PDT)
In-Reply-To: <CAMz4kuJ9hQw-GWfHc2XLV0YOQBJyVDKdNtnsn1P1Jw0jdk4DKg@mail.gmail.com>
References: <e74c21120d89dd645377761e6c9995eab6eb00ca.1532953083.git.baolin.wang@linaro.org>
 <20180731035418.GA3334@tuxbook-pro> <CAMz4kuJ9hQw-GWfHc2XLV0YOQBJyVDKdNtnsn1P1Jw0jdk4DKg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 31 Jul 2018 14:52:46 +0800
Message-ID: <CAMz4kuKpeciThaXNN6zww0v1yxuUQkOPdsNuPj=-zw_kWUwKuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] leds: core: Introduce LED pattern trigger
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 14:22, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Bjorn,
>
> On 31 July 2018 at 11:54, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>> On Mon 30 Jul 05:29 PDT 2018, Baolin Wang wrote:
>>
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
>>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
>>>  drivers/leds/trigger/Kconfig                       |   10 +
>>>  drivers/leds/trigger/Makefile                      |    1 +
>>>  drivers/leds/trigger/ledtrig-pattern.c             |  349 ++++++++++++++++++++
>>>  include/linux/leds.h                               |   19 ++
>>>  5 files changed, 400 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>> new file mode 100644
>>> index 0000000..c52da34
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
>>> +             duration_3, ...".
>>> +
>>> +What:                /sys/class/leds/<led>/repeat
>>> +Date:                August 2018
>>> +KernelVersion:       4.19
>>> +Description:
>>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>>
>> If 0 means infinity, does 1 mean "repeat 1 time"? If so how would I
>
> Right.
>
>> specify that I want the pattern to run one time (i.e. 0 repetitions).
>
> If you set repeat to 1 to make the driver clear the  is_indefinite
> flag. So when the repeat number decreases to 0, it will stop.
>
>>
>>> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
>>> index a2559b4..a03afcd 100644
>>> --- a/drivers/leds/trigger/Kconfig
>>> +++ b/drivers/leds/trigger/Kconfig
>>> @@ -125,6 +125,16 @@ config LEDS_TRIGGER_CAMERA
>>>         This enables direct flash/torch on/off by the driver, kernel space.
>>>         If unsure, say Y.
>>>
>>> +config LEDS_TRIGGER_PATTERN
>>> +       tristate "LED Pattern Trigger"
>>> +       depends on LEDS_TRIGGERS
>>> +       help
>>> +         This allows LEDs blinking with an arbitrary pattern. Can be useful
>>> +         on embedded systems with no screen to give out a status code to
>>> +         a human.
>>
>> While the pattern mechanism could be used to communicate some message
>> the use cases we've seen so far is all about enabling hardware to pulse
>> LEDs instead of blinking them...
>
> Right. I will improve the message here.
>
>>
>>> +
>>> +         If unsure, say N
>>> +
>>>  config LEDS_TRIGGER_PANIC
>>>       bool "LED Panic Trigger"
>>>       depends on LEDS_TRIGGERS
>>> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
>>> index f3cfe19..c5d180e 100644
>>> --- a/drivers/leds/trigger/Makefile
>>> +++ b/drivers/leds/trigger/Makefile
>>> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)        += ledtrig-transient.o
>>>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)    += ledtrig-camera.o
>>>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)     += ledtrig-panic.o
>>>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)    += ledtrig-netdev.o
>>> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)     += ledtrig-pattern.o
>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
>>> new file mode 100644
>>> index 0000000..b709aa1
>>> --- /dev/null
>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>> @@ -0,0 +1,349 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/*
>>> + * LED pattern trigger
>>> + *
>>> + * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
>>> + * the first version, Baolin Wang simplified and improved the approach.
>>
>> Might be a coincidence, but parts of this patch looks pretty close to
>> mine...
>>
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/leds.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/timer.h>
>>> +
>>> +/*
>>> + * The "pattern" attribute contains at most PAGE_SIZE characters. Each line
>>> + * in this attribute is at least 4 characters long (a 1-digit number for the
>>> + * led brighntess, a space, a 1-digit number for the time, a semi-colon).
>>> + * Therefore, there is at most PAGE_SIZE/4 patterns.
>>> + */
>>
>> The brightness is a number between 0 and LED_FULL (or max_brightness)
>> and delta_t is measured in ms. So neither of these are likely to be a
>> single digit very often.
>
> OK. Will fix these comments.
>
>>
>>> +#define MAX_PATTERNS         (PAGE_SIZE / 4)
>>> +#define PATTERN_SEPARATOR    ","
>>> +
>>> +struct pattern_trig_data {
>>> +     struct led_classdev *led_cdev;
>>> +     struct led_pattern *patterns;
>>> +     struct led_pattern *curr;
>>> +     struct led_pattern *next;
>>> +     struct mutex lock;
>>> +     u32 npatterns;
>>> +     u32 repeat;
>>> +     bool is_indefinite;
>>> +     struct timer_list timer;
>>> +};
>>> +
>>> +static void pattern_trig_update_patterns(struct pattern_trig_data *data)
>>
>> I think you should just inline this logic into
>> pattern_trig_timer_function() to make it obvious that this is only
>> invoked from the timer function.
>>
>> And if you do this you can decrement data->repeat unconditionally after
>> the check for !is_indefinite && repeat == 0.
>
> OK.

We can not remove the condition, since we still should make sure the
data->curr points the fist pattern again.

>
>>
>>> +{
>>> +     data->curr = data->next;
>>> +     if (!data->is_indefinite && data->curr == data->patterns)
>>> +             data->repeat--;
>>> +
>>> +     if (data->next == data->patterns + data->npatterns - 1)
>>> +             data->next = data->patterns;
>>> +     else
>>> +             data->next++;
>>
>> How about replacing this conditional with:
>>
>>         data->next = (data->next + 1) % data->npatterns;
>
> Good suggestion. Will do in next version.

Re-think about this. The data->next is one pointer which points next
pattern not one index. So I think I can not do like this.

>
>>
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
>>> +                                    struct led_classdev *led_cdev)
>>> +{
>>> +     if (!data->npatterns)
>>> +             return 0;
>>> +
>>> +     if (led_cdev->pattern_clear)
>>> +             led_cdev->pattern_clear(led_cdev);
>>> +
>>> +     if (led_cdev->pattern_set) {
>>
>> In my proposal setting an empty pattern would invoke pattern_clear() and
>> setting a pattern would invoke pattern_set(), this allows the driver to
>> fail the pattern_set() without clearing the old pattern.
>
> Pavel wanted "echo none > trigger" to clear the pattern. So I am fine
> remove the 'pattern_clear' operation in this function.
>
>>
>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>> +                                          data->npatterns, data->repeat);
>>
>> repeat is communicated to the driver, but is_indefinite is not. At least
>> in my driver the latter

Sorry I missed this comments. I think the repeat number can be easily
converted to decide if is indefinite in your driver.

>>
>>> +     }
>>
>> I think it would be useful to put the rest in an else statement, to
>> clarify that the patterns is either implemented by the driver or by the
>> software timer. It might also make sense to group the check for
>> pattern_clear() and pattern_set(), as it wouldn't make sense for the
>> driver to implement only one of these.
>
> But checkpatch will complain the 'else' statement is redundant, maybe
> add some comments here to make things clear?
>
>>
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
>>> +     int err;
>>> +     u32 repeat;
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     if (led_cdev->pattern_get) {
>>> +             err = led_cdev->pattern_get(led_cdev, data->patterns,
>>> +                                         &data->npatterns, &data->repeat);
>>
>> I don't see why "repeat" would have changed since you told the driver,
>> so data->repeat should have the right value already.
>
> Some drivers don't care about the repeat, and it will always repeat
> indefinitely. So no matter what values set from userspace, driver can
> set it to 0.
>
>>
>>> +             if (err) {
>>> +                     mutex_unlock(&data->lock);
>>> +                     return err;
>>> +             }
>>> +     }
>>> +
>>> +     repeat = data->repeat;
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
>>> +     del_timer_sync(&data->timer);
>>> +
>>> +     mutex_lock(&data->lock);
>>> +     data->repeat = res;
>>> +
>>> +     /* 0 means repeat indefinitely */
>>
>> I think that it would be better to specify indefinite by writing e.g.
>> "Inf" to the repeat.
>>
>> Also note that it's possible that there might be hardware restrictions
>> that only allows specific combinations of these; e.g. the Qualcomm
>> hardware can only do no-repeat or repeat-forever.
>
> Can you set repeat to 1 to represent no-repeat and set to 0 to
> represent repeat-forever?
>
>>
>>> +     if (!data->repeat)
>>> +             data->is_indefinite = true;
>>> +     else
>>> +             data->is_indefinite = false;
>>> +
>>> +     err = pattern_trig_start_pattern(data, led_cdev);
>>> +     if (err) {
>>> +             mutex_unlock(&data->lock);
>>> +             return err;
>>> +     }
>>> +
>>> +     mutex_unlock(&data->lock);
>>> +     return count;
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
>>> +     int err, i;
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     if (led_cdev->pattern_get) {
>>> +             err = led_cdev->pattern_get(led_cdev, data->patterns,
>>> +                                         &data->npatterns, &data->repeat);
>>> +             if (err) {
>>> +                     mutex_unlock(&data->lock);
>>> +                     return err;
>>> +             }
>>> +     }
>>
>> Rather than sometimes calling pattern_get() here, how about defining
>> that pattern_set() should update data->patterns before returning and
>> just rely on data->patterns being right.
>>
>> (The reason for the pattern not being the same as passed in store would
>> be to allow the driver to adjust the parameters to the match the
>> hardware requirements and present this to the user)
>
> Hmmm, so we can remove the 'pattern_get' interface and always trust
> data->patterns.
>
>>
>>> +
>>> +     if (!data->npatterns) {
>>> +             mutex_unlock(&data->lock);
>>> +             return -EINVAL;
>>> +     }
>>
>> Rather than failing I think you should return the empty string if the
>> pattern is empty.
>
> Sure.
>
>>
>>> +
>>> +     for (i = 0; i < data->npatterns; i++) {
>>> +             count += scnprintf(buf + count, PAGE_SIZE - count,
>>> +                                "%d %d" PATTERN_SEPARATOR,
>>> +                                data->patterns[i].brightness,
>>> +                                data->patterns[i].delta_t);
>>> +     }
>>> +
>>> +     buf[count - 1] = '\n';
>>> +     buf[count] = '\0';
>>> +
>>> +     mutex_unlock(&data->lock);
>>> +     return count + 1;
>>
>> As you're returning a string I think you should return the number of
>> chars in the string, not including the '\0'.
>
> Sure.
>
>>
>>> +}
>>> +
>>> +static ssize_t pattern_trig_store_pattern(struct device *dev,
>>> +                                       struct device_attribute *attr,
>>> +                                       const char *buf, size_t count)
>>> +{
>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +     int err, cr, ccount, tcr = 0;
>>> +
>>> +     del_timer_sync(&data->timer);
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     for (data->npatterns = 0; data->npatterns < MAX_PATTERNS;
>>> +          data->npatterns++) {
>>> +             /* Characters read on one conversion */
>>> +             cr = 0;
>>> +             /* Number of successful conversions */
>>> +             ccount = sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "%n",
>>> +                             &data->patterns[data->npatterns].brightness,
>>> +                             &data->patterns[data->npatterns].delta_t, &cr);
>>
>> I'm not fond of the use of sscanf() here, but at least you should make
>> sure that tcr doesn't go past PAGE_SIZE.
>
> Yes.
>
>>
>>> +
>>> +             /* Total characters read */
>>> +             tcr += cr;
>>> +             if (cr)
>>> +                     continue;
>>
>> This loop is non-intuitive...
>>
>> You loop while npatterns is less than MAX_PATTERNS and the first half
>> will loop if sscanf() matched the pattern otherwise you'll return from
>> withing the loop.
>
> OK. Will improve this loop here in next version.
>
>>
>>> +
>>> +             /* Invalid syntax or end of pattern */
>>> +             if (ccount == 2)
>>
>> I guess you'll get here if you match the two %d, but not the
>> PATTERN_SEPARATOR? Wouldn't it be useful to fail here if ccount is !2.
>
> Yes. OK, I will fail it if ccount is !2.
>
>>
>>> +                     data->npatterns++;
>>> +
>>> +             err = pattern_trig_start_pattern(data, led_cdev);
>>> +             if (err) {
>>> +                     mutex_unlock(&data->lock);
>>> +                     return err;
>>> +             }
>>> +
>>> +             mutex_unlock(&data->lock);
>>> +             return count;
>>> +     }
>>> +
>>> +     /* Shouldn't reach that */
>>
>> This means that you failed to set the pattern, so you probably shouldn't
>> return count - but rather -EINVAL or something.
>
> Right.
>
>>
>>> +     WARN(1, "MAX_NSTEP too small. Please report\n");
>>> +     mutex_unlock(&data->lock);
>>> +     return count;
>>> +}
>>> +
>>> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
>>> +                pattern_trig_store_pattern);
>>> +
>>> +static int pattern_trig_create_sysfs_files(struct device *dev)
>>> +{
>>> +     int err;
>>> +
>>> +     err = device_create_file(dev, &dev_attr_repeat);
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     err = device_create_file(dev, &dev_attr_pattern);
>>> +     if (err)
>>> +             device_remove_file(dev, &dev_attr_repeat);
>>> +
>>> +     return err;
>>> +}
>>> +
>>> +static void pattern_trig_remove_sysfs_files(struct device *dev)
>>> +{
>>> +     device_remove_file(dev, &dev_attr_pattern);
>>> +     device_remove_file(dev, &dev_attr_repeat);
>>> +}
>>> +
>>> +static int pattern_trig_initialize_data(struct pattern_trig_data *data)
>>
>> These two functions would be better to just inline, but...
>
> Will re-consider these two functions.
>
>>
>>> +{
>>> +     data->patterns = kcalloc(MAX_PATTERNS, sizeof(struct led_pattern),
>>> +                              GFP_KERNEL);
>>
>> ...as this always allocate 1024 entries of led_pattern associated with
>> the pattern_trig_data you should just add 1024 entries of led_pattern to
>> the pattern_trig_data struct.
>
> Right.
>
>>
>>> +     if (!data->patterns)
>>> +             return -ENOMEM;
>>> +
>>> +     data->is_indefinite = true;
>>> +     mutex_init(&data->lock);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void pattern_trig_clear_data(struct pattern_trig_data *data)
>>> +{
>>> +     kfree(data->patterns);
>>> +}
>>> +
>>> +static void pattern_trig_activate(struct led_classdev *led_cdev)
>>> +{
>>> +     struct pattern_trig_data *data;
>>> +     int err;
>>> +
>>> +     data = kzalloc(sizeof(*data), GFP_KERNEL);
>>> +     if (!data)
>>> +             return;
>>> +
>>> +     err = pattern_trig_initialize_data(data);
>>> +     if (err) {
>>> +             kfree(data);
>>> +             return;
>>> +     }
>>> +
>>> +     err = pattern_trig_create_sysfs_files(led_cdev->dev);
>>> +     if (err) {
>>> +             pattern_trig_clear_data(data);
>>> +             kfree(data);
>>> +             return;
>>> +     }
>>> +
>>> +     data->led_cdev = led_cdev;
>>> +     led_cdev->trigger_data = data;
>>> +     timer_setup(&data->timer, pattern_trig_timer_function, 0);
>>> +     led_cdev->activated = true;
>>> +}
>>> +
>>> +static void pattern_trig_deactivate(struct led_classdev *led_cdev)
>>> +{
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +
>>> +     if (!led_cdev->activated)
>>> +             return;
>>> +
>>> +     if (led_cdev->pattern_clear)
>>> +             led_cdev->pattern_clear(led_cdev);
>>> +
>>> +     del_timer_sync(&data->timer);
>>
>> This should only happen when not having using the driver based
>> mechanism, so put this in an else to clarify this.
>
> OK.
>
>>
>>> +     pattern_trig_remove_sysfs_files(led_cdev->dev);
>>
>> Inline this and one doesn't have to jump around to figure out what's
>> going on.
>
> Sure. Thanks for your useful comments.
>
>>
>>> +     led_set_brightness(led_cdev, LED_OFF);
>>> +     pattern_trig_clear_data(data);
>>> +     kfree(data);
>>> +     led_cdev->trigger_data = NULL;
>>> +     led_cdev->activated = false;
>>> +}
>>> +
>>> +static struct led_trigger pattern_led_trigger = {
>>> +     .name = "pattern",
>>> +     .activate = pattern_trig_activate,
>>> +     .deactivate = pattern_trig_deactivate,
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
>>> index b7e8255..bea02f0 100644
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
>>> @@ -88,6 +89,14 @@ struct led_classdev {
>>>                                    unsigned long *delay_on,
>>>                                    unsigned long *delay_off);
>>>
>>> +     int (*pattern_set)(struct led_classdev *led_cdev,
>>> +                        struct led_pattern *pattern, int len,
>>> +                        unsigned repeat);
>>> +     int (*pattern_get)(struct led_classdev *led_cdev,
>>> +                        struct led_pattern *pattern, int *len,
>>> +                        unsigned *repeat);
>>> +     int (*pattern_clear)(struct led_classdev *led_cdev);
>>> +
>>>       struct device           *dev;
>>>       const struct attribute_group    **groups;
>>>
>>> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
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
>>> --
>>> 1.7.9.5
>>>
>
>
>
> --
> Baolin Wang
> Best Regards



-- 
Baolin Wang
Best Regards
