Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98963C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C9208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB0pTPt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329C9208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeGaMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:39:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40560 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbeGaMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:39:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so27094291oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GdSCWWGhwBCAn+JDoh1zDu0C7XfzmraQ9Aov5fqeork=;
        b=DB0pTPt+GGgOnA9kM8E3qctO3vjTuRu6aYdsK7NZUXg5S+/p95tniAnrPfVirm8jQC
         R2tXjrkH/uwNbYtL7X8MgLOzicI2We4csFWnfjXnLsBAQrWyjVEfEzHLSrYM7E73D6BA
         zKpsX6uLWF+2VffraI9h5ItXqQ/PES89aPHoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GdSCWWGhwBCAn+JDoh1zDu0C7XfzmraQ9Aov5fqeork=;
        b=rbH6fX4GCyLM0haeOkRetsIP5/fC5Lf521GG4O6tJuS3VFgfLRUWLfBTjEUBl0bKmD
         QCv8RyPUopRRlKiBydu9a8i7+yM8WelEkUTCK3rNu5K9aYvRJ7kKcncMzwXtiaaNE/zN
         j9BjzK0AEeXvVCYxLgAKnIIjYre7fBXu4TdTDKFtxNex7OwBEc+I+J6Soo4M6TLtw3+f
         esPlCRtez5lvd+BH/le7+gjRxHN5wTeATFOXEs+c9MftbDF8pSUfaVsGk33rTtQnGRxZ
         tYyWjSeJ01klLa24whi+f9pp02W7LHUByEMu9LgxgmE0OhFwMiyrWJ0t1SM0kCnNiOQB
         zZuA==
X-Gm-Message-State: AOUpUlHwDj0m9IwXztTIflRToYtjzG1fiUF0O84Lf/bNKK0lHobR/ABY
        lIGmrFf77Jf7XBD9dRuXgfxaNgqj36ZqWdBRTowqww==
X-Google-Smtp-Source: AAOMgpe5iK7KbbcVITouc7LR4DIqaqBPZw06KcJ/iMnz+mX5jIraOA4xGdDGaj5stCCLre+3iQ7UxlIBDn+EuANY0Ec=
X-Received: by 2002:aca:cdc2:: with SMTP id d185-v6mr8662874oig.350.1533034775746;
 Tue, 31 Jul 2018 03:59:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 03:59:35
 -0700 (PDT)
In-Reply-To: <c349d7f0-31f1-d167-b6a8-ecf717134623@gmail.com>
References: <e74c21120d89dd645377761e6c9995eab6eb00ca.1532953083.git.baolin.wang@linaro.org>
 <c349d7f0-31f1-d167-b6a8-ecf717134623@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 31 Jul 2018 18:59:35 +0800
Message-ID: <CAMz4ku+eYOyEU2WOM4x=ONwNRUd4gPCFx0QCytUU8YRRefNb+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 31 July 2018 at 18:53, Jacek Anaszewski <jacek.anaszewski@gmail.com> wro=
te:
> Hi Baolin,
>
> Thank you for the patch set. I have one note regarding the way how
> trigger specific sysfs attributes are created/removed, please refer
> to my comment in the code below.
>
> On 07/30/2018 02:29 PM, Baolin Wang wrote:
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
>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
>>  drivers/leds/trigger/Kconfig                       |   10 +
>>  drivers/leds/trigger/Makefile                      |    1 +
>>  drivers/leds/trigger/ledtrig-pattern.c             |  349 +++++++++++++=
+++++++
>>  include/linux/leds.h                               |   19 ++
>>  5 files changed, 400 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pa=
ttern
>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b=
/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> new file mode 100644
>> index 0000000..c52da34
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> @@ -0,0 +1,21 @@
>> +What:                /sys/class/leds/<led>/pattern
>> +Date:                August 2018
>> +KernelVersion:       4.19
>> +Description:
>> +             Specify a pattern for the LED, for LED hardware that suppo=
rt
>> +             altering the brightness as a function of time.
>> +
>> +             The pattern is given by a series of tuples, of brightness =
and
>> +             duration (ms). The LED is expected to traverse the series =
and
>> +             each brightness value for the specified duration. Duration=
 of
>> +             0 means brightness should immediately change to new value.
>> +
>> +             The format of the pattern values should be:
>> +             "brightness_1 duration_1, brightness_2 duration_2, brightn=
ess_3
>> +             duration_3, ...".
>> +
>> +What:                /sys/class/leds/<led>/repeat
>> +Date:                August 2018
>> +KernelVersion:       4.19
>> +Description:
>> +             Specify a pattern repeat number. 0 means repeat indefinite=
ly.
>> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
>> index a2559b4..a03afcd 100644
>> --- a/drivers/leds/trigger/Kconfig
>> +++ b/drivers/leds/trigger/Kconfig
>> @@ -125,6 +125,16 @@ config LEDS_TRIGGER_CAMERA
>>         This enables direct flash/torch on/off by the driver, kernel spa=
ce.
>>         If unsure, say Y.
>>
>> +config LEDS_TRIGGER_PATTERN
>> +       tristate "LED Pattern Trigger"
>> +       depends on LEDS_TRIGGERS
>> +       help
>> +         This allows LEDs blinking with an arbitrary pattern. Can be us=
eful
>> +         on embedded systems with no screen to give out a status code t=
o
>> +         a human.
>> +
>> +         If unsure, say N
>> +
>>  config LEDS_TRIGGER_PANIC
>>       bool "LED Panic Trigger"
>>       depends on LEDS_TRIGGERS
>> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefi=
le
>> index f3cfe19..c5d180e 100644
>> --- a/drivers/leds/trigger/Makefile
>> +++ b/drivers/leds/trigger/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)        +=3D ledtr=
ig-transient.o
>>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)    +=3D ledtrig-camera.o
>>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)     +=3D ledtrig-panic.o
>>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)    +=3D ledtrig-netdev.o
>> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)     +=3D ledtrig-pattern.o
>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigg=
er/ledtrig-pattern.c
>> new file mode 100644
>> index 0000000..b709aa1
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,349 @@
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
>> +/*
>> + * The "pattern" attribute contains at most PAGE_SIZE characters. Each =
line
>> + * in this attribute is at least 4 characters long (a 1-digit number fo=
r the
>> + * led brighntess, a space, a 1-digit number for the time, a semi-colon=
).
>> + * Therefore, there is at most PAGE_SIZE/4 patterns.
>> + */
>> +#define MAX_PATTERNS         (PAGE_SIZE / 4)
>> +#define PATTERN_SEPARATOR    ","
>> +
>> +struct pattern_trig_data {
>> +     struct led_classdev *led_cdev;
>> +     struct led_pattern *patterns;
>> +     struct led_pattern *curr;
>> +     struct led_pattern *next;
>> +     struct mutex lock;
>> +     u32 npatterns;
>> +     u32 repeat;
>> +     bool is_indefinite;
>> +     struct timer_list timer;
>> +};
>> +
>> +static void pattern_trig_update_patterns(struct pattern_trig_data *data=
)
>> +{
>> +     data->curr =3D data->next;
>> +     if (!data->is_indefinite && data->curr =3D=3D data->patterns)
>> +             data->repeat--;
>> +
>> +     if (data->next =3D=3D data->patterns + data->npatterns - 1)
>> +             data->next =3D data->patterns;
>> +     else
>> +             data->next++;
>> +}
>> +
>> +static void pattern_trig_timer_function(struct timer_list *t)
>> +{
>> +     struct pattern_trig_data *data =3D from_timer(data, t, timer);
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (!data->is_indefinite && !data->repeat) {
>> +             mutex_unlock(&data->lock);
>> +             return;
>> +     }
>> +
>> +     led_set_brightness(data->led_cdev, data->curr->brightness);
>> +     mod_timer(&data->timer, jiffies + msecs_to_jiffies(data->curr->del=
ta_t));
>> +     pattern_trig_update_patterns(data);
>> +
>> +     mutex_unlock(&data->lock);
>> +}
>> +
>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>> +                                    struct led_classdev *led_cdev)
>> +{
>> +     if (!data->npatterns)
>> +             return 0;
>> +
>> +     if (led_cdev->pattern_clear)
>> +             led_cdev->pattern_clear(led_cdev);
>> +
>> +     if (led_cdev->pattern_set) {
>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>> +                                          data->npatterns, data->repeat=
);
>> +     }
>> +
>> +     data->curr =3D data->patterns;
>> +     data->next =3D data->patterns + 1;
>> +     data->timer.expires =3D jiffies;
>> +     add_timer(&data->timer);
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t pattern_trig_show_repeat(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +     int err;
>> +     u32 repeat;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (led_cdev->pattern_get) {
>> +             err =3D led_cdev->pattern_get(led_cdev, data->patterns,
>> +                                         &data->npatterns, &data->repea=
t);
>> +             if (err) {
>> +                     mutex_unlock(&data->lock);
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     repeat =3D data->repeat;
>> +     mutex_unlock(&data->lock);
>> +
>> +     return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
>> +}
>> +
>> +static ssize_t pattern_trig_store_repeat(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf, size_t count)
>> +{
>> +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +     unsigned long res;
>> +     int err;
>> +
>> +     err =3D kstrtoul(buf, 10, &res);
>> +     if (err)
>> +             return err;
>> +
>> +     del_timer_sync(&data->timer);
>> +
>> +     mutex_lock(&data->lock);
>> +     data->repeat =3D res;
>> +
>> +     /* 0 means repeat indefinitely */
>> +     if (!data->repeat)
>> +             data->is_indefinite =3D true;
>> +     else
>> +             data->is_indefinite =3D false;
>> +
>> +     err =3D pattern_trig_start_pattern(data, led_cdev);
>> +     if (err) {
>> +             mutex_unlock(&data->lock);
>> +             return err;
>> +     }
>> +
>> +     mutex_unlock(&data->lock);
>> +     return count;
>> +}
>> +
>> +static DEVICE_ATTR(repeat, 0644, pattern_trig_show_repeat,
>> +                pattern_trig_store_repeat);
>> +
>> +static ssize_t pattern_trig_show_pattern(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      char *buf)
>> +{
>> +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +     ssize_t count =3D 0;
>> +     int err, i;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (led_cdev->pattern_get) {
>> +             err =3D led_cdev->pattern_get(led_cdev, data->patterns,
>> +                                         &data->npatterns, &data->repea=
t);
>> +             if (err) {
>> +                     mutex_unlock(&data->lock);
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     if (!data->npatterns) {
>> +             mutex_unlock(&data->lock);
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i =3D 0; i < data->npatterns; i++) {
>> +             count +=3D scnprintf(buf + count, PAGE_SIZE - count,
>> +                                "%d %d" PATTERN_SEPARATOR,
>> +                                data->patterns[i].brightness,
>> +                                data->patterns[i].delta_t);
>> +     }
>> +
>> +     buf[count - 1] =3D '\n';
>> +     buf[count] =3D '\0';
>> +
>> +     mutex_unlock(&data->lock);
>> +     return count + 1;
>> +}
>> +
>> +static ssize_t pattern_trig_store_pattern(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       const char *buf, size_t count)
>> +{
>> +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +     int err, cr, ccount, tcr =3D 0;
>> +
>> +     del_timer_sync(&data->timer);
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     for (data->npatterns =3D 0; data->npatterns < MAX_PATTERNS;
>> +          data->npatterns++) {
>> +             /* Characters read on one conversion */
>> +             cr =3D 0;
>> +             /* Number of successful conversions */
>> +             ccount =3D sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "%=
n",
>> +                             &data->patterns[data->npatterns].brightnes=
s,
>> +                             &data->patterns[data->npatterns].delta_t, =
&cr);
>> +
>> +             /* Total characters read */
>> +             tcr +=3D cr;
>> +             if (cr)
>> +                     continue;
>> +
>> +             /* Invalid syntax or end of pattern */
>> +             if (ccount =3D=3D 2)
>> +                     data->npatterns++;
>> +
>> +             err =3D pattern_trig_start_pattern(data, led_cdev);
>> +             if (err) {
>> +                     mutex_unlock(&data->lock);
>> +                     return err;
>> +             }
>> +
>> +             mutex_unlock(&data->lock);
>> +             return count;
>> +     }
>> +
>> +     /* Shouldn't reach that */
>> +     WARN(1, "MAX_NSTEP too small. Please report\n");
>> +     mutex_unlock(&data->lock);
>> +     return count;
>> +}
>> +
>> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
>> +                pattern_trig_store_pattern);
>> +
>> +static int pattern_trig_create_sysfs_files(struct device *dev)
>> +{
>> +     int err;
>> +
>> +     err =3D device_create_file(dev, &dev_attr_repeat);
>> +     if (err)
>> +             return err;
>> +
>> +     err =3D device_create_file(dev, &dev_attr_pattern);
>> +     if (err)
>> +             device_remove_file(dev, &dev_attr_repeat);
>
> We've recently merged patch set of Uwe Kleine-K=C3=B6nig that adds
> groups attribute to the struct led_trigger, and updates all
> triggers to use it. Please follow the new approach - refer to
> linux-next or directly to
> https://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.g=
it/log/?h=3Dfor-next.

Ah, Thanks to point out these updates which I missed. I will follow
them in next version.

>
>> +     return err;
>> +}
>> +
>> +static void pattern_trig_remove_sysfs_files(struct device *dev)
>> +{
>> +     device_remove_file(dev, &dev_attr_pattern);
>> +     device_remove_file(dev, &dev_attr_repeat);
>> +}
>> +
>> +static int pattern_trig_initialize_data(struct pattern_trig_data *data)
>> +{
>> +     data->patterns =3D kcalloc(MAX_PATTERNS, sizeof(struct led_pattern=
),
>> +                              GFP_KERNEL);
>> +     if (!data->patterns)
>> +             return -ENOMEM;
>> +
>> +     data->is_indefinite =3D true;
>> +     mutex_init(&data->lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static void pattern_trig_clear_data(struct pattern_trig_data *data)
>> +{
>> +     kfree(data->patterns);
>> +}
>> +
>> +static void pattern_trig_activate(struct led_classdev *led_cdev)
>> +{
>> +     struct pattern_trig_data *data;
>> +     int err;
>> +
>> +     data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return;
>> +
>> +     err =3D pattern_trig_initialize_data(data);
>> +     if (err) {
>> +             kfree(data);
>> +             return;
>> +     }
>> +
>> +     err =3D pattern_trig_create_sysfs_files(led_cdev->dev);
>> +     if (err) {
>> +             pattern_trig_clear_data(data);
>> +             kfree(data);
>> +             return;
>> +     }
>> +
>> +     data->led_cdev =3D led_cdev;
>> +     led_cdev->trigger_data =3D data;
>> +     timer_setup(&data->timer, pattern_trig_timer_function, 0);
>> +     led_cdev->activated =3D true;
>> +}
>> +
>> +static void pattern_trig_deactivate(struct led_classdev *led_cdev)
>> +{
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +
>> +     if (!led_cdev->activated)
>> +             return;
>> +
>> +     if (led_cdev->pattern_clear)
>> +             led_cdev->pattern_clear(led_cdev);
>> +
>> +     del_timer_sync(&data->timer);
>> +     pattern_trig_remove_sysfs_files(led_cdev->dev);
>> +     led_set_brightness(led_cdev, LED_OFF);
>> +     pattern_trig_clear_data(data);
>> +     kfree(data);
>> +     led_cdev->trigger_data =3D NULL;
>> +     led_cdev->activated =3D false;
>> +}
>> +
>> +static struct led_trigger pattern_led_trigger =3D {
>> +     .name =3D "pattern",
>> +     .activate =3D pattern_trig_activate,
>> +     .deactivate =3D pattern_trig_deactivate,
>> +};
>> +
>> +static int __init pattern_trig_init(void)
>> +{
>> +     return led_trigger_register(&pattern_led_trigger);
>> +}
>> +
>> +static void __exit pattern_trig_exit(void)
>> +{
>> +     led_trigger_unregister(&pattern_led_trigger);
>> +}
>> +
>> +module_init(pattern_trig_init);
>> +module_exit(pattern_trig_exit);
>> +
>> +MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
>> +MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org");
>> +MODULE_DESCRIPTION("LED Pattern trigger");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index b7e8255..bea02f0 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -22,6 +22,7 @@
>>  #include <linux/workqueue.h>
>>
>>  struct device;
>> +struct led_pattern;
>>  /*
>>   * LED Core
>>   */
>> @@ -88,6 +89,14 @@ struct led_classdev {
>>                                    unsigned long *delay_on,
>>                                    unsigned long *delay_off);
>>
>> +     int (*pattern_set)(struct led_classdev *led_cdev,
>> +                        struct led_pattern *pattern, int len,
>> +                        unsigned repeat);
>> +     int (*pattern_get)(struct led_classdev *led_cdev,
>> +                        struct led_pattern *pattern, int *len,
>> +                        unsigned *repeat);
>> +     int (*pattern_clear)(struct led_classdev *led_cdev);
>> +
>>       struct device           *dev;
>>       const struct attribute_group    **groups;
>>
>> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_h=
w_changed(
>>       struct led_classdev *led_cdev, enum led_brightness brightness) { }
>>  #endif
>>
>> +/**
>> + * struct led_pattern - brightness value in a pattern
>> + * @delta_t: delay until next entry, in milliseconds
>> + * @brightness: brightness at time =3D 0
>> + */
>> +struct led_pattern {
>> +     int delta_t;
>> +     int brightness;
>> +};
>> +
>>  #endif               /* __LINUX_LEDS_H_INCLUDED */
>>
>
> --
> Best regards,
> Jacek Anaszewski



--=20
Baolin Wang
Best Regards
