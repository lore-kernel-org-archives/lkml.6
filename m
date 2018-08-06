Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B0CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF58219A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EM1byLud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF58219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeHFEAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:00:04 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40309 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeHFEAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:00:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so19401387oie.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fl4CySQJjkmXrd4kjqbk4TPh4ql2TWX6bpzEep7gTZk=;
        b=EM1byLud0lItPNhhlgKPRZSvDdAp3OG/pJFXQXCfvEusnCZobtaP8C30sDuuuQ45mS
         qtlSFwvwV/JUNAVU14oo5WEoK7W8hKvKf5poAF0vlfG9t7Y3KAvq75O5SLDy4gSy1y2u
         CO5ugIc9Ls8gkQdOm1t1mu8e9BD/pnDCf6PK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fl4CySQJjkmXrd4kjqbk4TPh4ql2TWX6bpzEep7gTZk=;
        b=j/odB8bw+UI8IModPuSe3uKxdXq1WiKSClsn1/bRIZ/J+FRoXHXEfDrgUnEdL+HnTH
         kfypiuxLf6bj/7Z9EOYiwCoILMdsLZIkJjOs5cyOqS8KamNSwsH6TFqwgsJ9wt/3Cxrr
         lrwP13DLFjQl0MfF2tKJXYfC+zBBW2/Q4JYJ8TatH0Eli3qTRnaDna6lgGe+Ei4Aw7cE
         h4PMw4RLAXqQ1tmexGf9O2s5vBiH3Ge+Fm49f+fFnxz3lddWo+F/40vsWSIO4zeJH7zx
         YVHe1Y74O+IhalDSUXmxRio/18AUTCSeAs0WGlePhq1T2pKs+W0B0HUKKXym6Egz3uh1
         KaHA==
X-Gm-Message-State: AOUpUlFqJIAf/Wi7B0nyFS39DqnlpO+06E7QFRotjy7IUGslRQVkmbz9
        d3Sg+7ErY6mfbRSauE+hNgxe99m6gV7qI9G75lFwEQ==
X-Google-Smtp-Source: AAOMgpdgXYMREWnjpqpv6YjqM69yzwRwOWeFotcZORgA/kMbwVc01YYpr1OmHJdMtEJUANtUwWiJ0d1GYV/a3YOZN+Y=
X-Received: by 2002:aca:aacb:: with SMTP id t194-v6mr13561352oie.168.1533520399470;
 Sun, 05 Aug 2018 18:53:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 18:53:19 -0700 (PDT)
In-Reply-To: <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com>
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
 <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 Aug 2018 09:53:19 +0800
Message-ID: <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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

On 6 August 2018 at 00:10, Jacek Anaszewski <jacek.anaszewski@gmail.com> wr=
ote:
> Hi Baolin,
>
> Thank you for the fix.
>
> I've found few more details to improve, please take a look
> at my comments below.
>
> On 08/05/2018 06:04 AM, Baolin Wang wrote:
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
>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |  21 ++
>>  drivers/leds/trigger/Kconfig                       |   7 +
>>  drivers/leds/trigger/Makefile                      |   1 +
>>  drivers/leds/trigger/ledtrig-pattern.c             | 271 ++++++++++++++=
+++++++
>>  include/linux/leds.h                               |  16 ++
>>  5 files changed, 316 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pa=
ttern
>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b=
/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> new file mode 100644
>> index 0000000..40afefe
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
>> +             "brightness_1 duration_1 brightness_2 duration_2 brightnes=
s_3
>> +             duration_3 ...".
>> +
>> +What:                /sys/class/leds/<led>/repeat
>> +Date:                August 2018
>> +KernelVersion:       4.19
>> +Description:
>> +             Specify a pattern repeat number. 0 means repeat indefinite=
ly.
>
> In current implementation this file on read returns the number
> of remaining repeat intervals. I'd add that to this description.

I saw Pavel's comments that he did not suggest do this. So I will keep
the original description?

>
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
>> +       This allows LEDs to be controlled by a software or hardware patt=
ern
>> +       which is a series of tuples, of brightness and duration (ms).
>> +       If unsure, say N
>> +
>>  endif # LEDS_TRIGGERS
>> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefi=
le
>> index f3cfe19..9bcb64e 100644
>> --- a/drivers/leds/trigger/Makefile
>> +++ b/drivers/leds/trigger/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)        +=3D ledtr=
ig-transient.o
>>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)    +=3D ledtrig-camera.o
>>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)     +=3D ledtrig-panic.o
>>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)    +=3D ledtrig-netdev.o
>> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)   +=3D ledtrig-pattern.o
>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigg=
er/ledtrig-pattern.c
>> new file mode 100644
>> index 0000000..e5b90b7
>> --- /dev/null
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -0,0 +1,271 @@
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
>> +                                   struct led_classdev *led_cdev)
>> +{
>> +     if (!data->npatterns)
>> +             return 0;
>> +
>> +     if (led_cdev->pattern_set) {
>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>> +                                          data->npatterns, data->repeat=
);
>> +     }
>> +
>> +     data->curr =3D data->patterns;
>> +     data->next =3D data->npatterns > 1 ? data->patterns + 1 : data->pa=
tterns;
>> +     data->timer.expires =3D jiffies;
>> +     add_timer(&data->timer);
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t pattern_trig_show_repeat(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>
> Please fix checkpatch.pl warnings:
>
> WARNING: Consider renaming function(s) 'pattern_trig_show_repeat' to
> 'repeat_show' 'pattern_trig_store_repeat' to 'repeat_store'
> #209: FILE: drivers/leds/trigger/ledtrig-pattern.c:127:
> +}
>
> WARNING: Consider renaming function(s) 'pattern_trig_show_pattern' to
> 'pattern_show' 'pattern_trig_store_pattern' to 'pattern_store'
> #276: FILE: drivers/leds/trigger/ledtrig-pattern.c:194:
> +}

Yes, I saw the warning, but I just follow other trigger=E2=80=98s custom.
Sure, I can fix this.

>> +{
>> +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +     u32 repeat;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     repeat =3D data->repeat;
>> +
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
>> +     if (!led_cdev->pattern_set)
>> +             del_timer_sync(&data->timer);
>
> Is there a reason for not having this check under mutex?

We will hold the mutex in pattern_trig_timer_function(), so if we do
del_timer_sync() under the mutex protection, we may meet dead-lock
issue. Moreover, the del_timer_sync() will make sure deactivating one
timer is safe.

>
>> +     mutex_lock(&data->lock);
>> +
>> +     data->repeat =3D res;
>> +
>> +     /* 0 means repeat indefinitely */
>> +     if (!data->repeat)
>> +             data->is_indefinite =3D true;
>> +     else
>> +             data->is_indefinite =3D false;
>> +
>> +     err =3D pattern_trig_start_pattern(data, led_cdev);
>> +
>> +     mutex_unlock(&data->lock);
>> +     return err < 0 ? err : count;
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
>> +     int i;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     if (!data->npatterns)
>> +             goto out;
>> +
>> +     for (i =3D 0; i < data->npatterns; i++) {
>> +             count +=3D scnprintf(buf + count, PAGE_SIZE - count,
>> +                                "%d %d ",
>> +                                data->patterns[i].brightness,
>> +                                data->patterns[i].delta_t);
>> +     }
>> +
>> +     buf[count - 1] =3D '\n';
>> +
>> +out:
>> +     mutex_unlock(&data->lock);
>> +     return count;
>> +}
>> +
>> +static ssize_t pattern_trig_store_pattern(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       const char *buf, size_t count)
>> +{
>> +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
>> +     struct pattern_trig_data *data =3D led_cdev->trigger_data;
>> +     int ccount, cr, offset =3D 0, err =3D 0;
>> +
>> +     if (!led_cdev->pattern_set)
>> +             del_timer_sync(&data->timer);
>
> Ditto.

See above comments.

>
>> +     mutex_lock(&data->lock);
>> +
>> +     data->npatterns =3D 0;
>> +     while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
>> +             cr =3D 0;
>> +             ccount =3D sscanf(buf + offset, "%d %d %n",
>> +                             &data->patterns[data->npatterns].brightnes=
s,
>> +                             &data->patterns[data->npatterns].delta_t, =
&cr);
>> +             if (ccount !=3D 2) {
>> +                     data->npatterns =3D 0;
>> +                     err =3D -EINVAL;
>> +                     goto out;
>> +             }
>> +
>> +             offset +=3D cr;
>> +             data->npatterns++;
>> +     }
>> +
>> +     err =3D pattern_trig_start_pattern(data, led_cdev);
>> +
>> +out:
>> +     mutex_unlock(&data->lock);
>> +     return err < 0 ? err : count;
>> +}
>> +
>> +static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
>> +                pattern_trig_store_pattern);
>> +
>> +static struct attribute *pattern_trig_attrs[] =3D {
>> +     &dev_attr_pattern.attr,
>> +     &dev_attr_repeat.attr,
>> +     NULL
>> +};
>> +ATTRIBUTE_GROUPS(pattern_trig);
>> +
>> +static int pattern_trig_activate(struct led_classdev *led_cdev)
>> +{
>> +     struct pattern_trig_data *data;
>> +
>> +     data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear) {
>> +             dev_warn(led_cdev->dev,
>> +                      "Hardware pattern ops validation failed\n");
>> +             led_cdev->pattern_set =3D NULL;
>> +             led_cdev->pattern_clear =3D NULL;
>> +     }
>> +
>> +     data->is_indefinite =3D true;
>> +     mutex_init(&data->lock);
>> +     data->led_cdev =3D led_cdev;
>> +     led_set_trigger_data(led_cdev, data);
>> +     timer_setup(&data->timer, pattern_trig_timer_function, 0);
>> +     led_cdev->activated =3D true;
>> +
>> +     return 0;
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
>> +     else
>> +             del_timer_sync(&data->timer);
>> +
>> +     led_set_brightness(led_cdev, LED_OFF);
>> +     kfree(data);
>> +     led_cdev->activated =3D false;
>> +}
>> +
>> +static struct led_trigger pattern_led_trigger =3D {
>> +     .name =3D "pattern",
>> +     .activate =3D pattern_trig_activate,
>> +     .deactivate =3D pattern_trig_deactivate,
>> +     .groups =3D pattern_trig_groups,
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
>> index 834683d..c54712c 100644
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
>> @@ -88,6 +89,11 @@ struct led_classdev {
>>                                    unsigned long *delay_on,
>>                                    unsigned long *delay_off);
>>
>> +     int (*pattern_set)(struct led_classdev *led_cdev,
>> +                        struct led_pattern *pattern, int len,
>> +                        unsigned repeat);
>> +     int (*pattern_clear)(struct led_classdev *led_cdev);
>> +
>>       struct device           *dev;
>>       const struct attribute_group    **groups;
>>
>> @@ -472,4 +478,14 @@ static inline void led_classdev_notify_brightness_h=
w_changed(
>>       struct led_classdev *led_cdev, enum led_brightness brightness) { }
>>  #endif
>>
>> +/**
>> + * struct led_pattern - brightness value in a pattern
>
> Since this structure describes single pattern interval and not
> the whole pattern, please change its description to:
>
> pattern interval settings
>
>> + * @delta_t: delay until next entry, in milliseconds
>
> @delta_t: pattern interval delay, in milliseconds
>
>> + * @brightness: brightness at time =3D 0
>
> @brightness: pattern interval brightness

Sure. Thanks for your comments.

>
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
