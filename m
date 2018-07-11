Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7DEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06720864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Swg/JVYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbeGKLG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:06:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37976 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbeGKLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:06:26 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so48471903oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mdQ5ROx6sbMmTVS/GCPv+iL5AeFQaq1eehqtGKo9MtI=;
        b=Swg/JVYrjm+qHPPhQi91XUbpfBppyWjYsrkZVphU84lsRm7FXEYXWt+nOSXNZ3b1Pg
         UOnQV0K8OlLv1bijALA+hF7t1kpiR6lTmKPw8/QJp64HZuN9JyjeXMvZpMjFV6/1km1b
         p5VHEiH6mJkvncxqb0xxwGMnMTjuNKlJ4/BSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mdQ5ROx6sbMmTVS/GCPv+iL5AeFQaq1eehqtGKo9MtI=;
        b=uefxd6kIntjlZ4efT+0bMp2elAfILAf4d7bfyMl/Vm+1BmQaMj2JSntf69UDKKptZw
         /xziqR0mDYxXRWSaNHG4OrJTzV7mlNxQYqWnvJ/dUab/+glaNCBNK3C/Qnhc3E9P6sE8
         WKCk62/n40XVrfzwiHzyui2jp9MzVVu1qXYsbrWyAOM+KZ2BHrLF9dX53IAiG3YF3t2W
         jsHlP0J8EOK8nAckiP1UaJWvgsMu8Eg6oA4oUZxqQHBkwbyfrf4gkfP1A53DD6Wt5/kH
         x3J/fZ2JxIt4+uwQSWyRgVpCTPmETSAkoDJsDIBDLGtRXF/V6LB5pzcrX3pCcz5raLtR
         TQnA==
X-Gm-Message-State: APt69E00DwHaAhiFDbtUqO7rkpfzlEG09wx2QggpjUui7S+A+CHqJluq
        joFqnwi5qMWIB2Mh1bWHLI3YFO4LiRFNtv6Qq3+1yA==
X-Google-Smtp-Source: AAOMgpfyzJBi4UFrfBSJf5wuzIi3VqCja7/VuDZ3+S/DbqkiavCuHLLYhEOOIvNfYTeqhY2sR05uAdIufHqmNCcW8Gw=
X-Received: by 2002:aca:e142:: with SMTP id y63-v6mr33511260oig.128.1531306959415;
 Wed, 11 Jul 2018 04:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 04:02:38
 -0700 (PDT)
In-Reply-To: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 11 Jul 2018 19:02:38 +0800
Message-ID: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek and Pavel,

On 29 June 2018 at 13:03, Baolin Wang <baolin.wang@linaro.org> wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
>
> This adds a new optional operator that LED class drivers can implement
> if they support such functionality as well as a new device attribute to
> configure the pattern for a given LED.
>
> [Baolin Wang did some minor improvements.]
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Change kernel version to 4.19.
>  - Force user to return error pointer if failed to issue pattern_get().
>  - Use strstrip() to trim trailing newline.
>  - Other optimization.
>
> Changes from v1:
>  - Add some comments suggested by Pavel.
>  - Change 'delta_t' can be 0.
>
> Note: I removed the pattern repeat check and will get the repeat number by adding
> one extra file named 'pattern_repeat' according to previous discussion.
> ---

Do you have any comments for this version patch set? Thanks.

>  Documentation/ABI/testing/sysfs-class-led |   17 +++++
>  drivers/leds/led-class.c                  |  119 +++++++++++++++++++++++++++++
>  include/linux/leds.h                      |   19 +++++
>  3 files changed, 155 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
> index 5f67f7a..e01ac55 100644
> --- a/Documentation/ABI/testing/sysfs-class-led
> +++ b/Documentation/ABI/testing/sysfs-class-led
> @@ -61,3 +61,20 @@ Description:
>                 gpio and backlight triggers. In case of the backlight trigger,
>                 it is useful when driving a LED which is intended to indicate
>                 a device in a standby like state.
> +
> +What: /sys/class/leds/<led>/pattern
> +Date: June 2018
> +KernelVersion: 4.19
> +Description:
> +       Specify a pattern for the LED, for LED hardware that support
> +       altering the brightness as a function of time.
> +
> +       The pattern is given by a series of tuples, of brightness and
> +       duration (ms). The LED is expected to traverse the series and
> +       each brightness value for the specified duration. Duration of
> +       0 means brightness should immediately change to new value.
> +
> +       As LED hardware might have different capabilities and precision
> +       the requested pattern might be slighly adjusted by the driver
> +       and the resulting pattern of such operation should be returned
> +       when this file is read.
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 3c7e348..8a685a2 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -74,6 +74,123 @@ static ssize_t max_brightness_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(max_brightness);
>
> +static ssize_t pattern_show(struct device *dev,
> +                           struct device_attribute *attr, char *buf)
> +{
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +       struct led_pattern *pattern;
> +       size_t offset = 0;
> +       int count, n, i;
> +
> +       if (!led_cdev->pattern_get)
> +               return -EOPNOTSUPP;
> +
> +       pattern = led_cdev->pattern_get(led_cdev, &count);
> +       if (IS_ERR(pattern))
> +               return PTR_ERR(pattern);
> +
> +       for (i = 0; i < count; i++) {
> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d ",
> +                            pattern[i].brightness, pattern[i].delta_t);
> +
> +               if (offset + n >= PAGE_SIZE)
> +                       goto err_nospc;
> +
> +               offset += n;
> +       }
> +
> +       buf[offset - 1] = '\n';
> +
> +       kfree(pattern);
> +       return offset;
> +
> +err_nospc:
> +       kfree(pattern);
> +       return -ENOSPC;
> +}
> +
> +static ssize_t pattern_store(struct device *dev,
> +                            struct device_attribute *attr,
> +                            const char *buf, size_t size)
> +{
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +       struct led_pattern *pattern = NULL;
> +       unsigned long val;
> +       char *sbegin;
> +       char *elem;
> +       char *s;
> +       int ret, len = 0;
> +       bool odd = true;
> +
> +       sbegin = kstrndup(buf, size, GFP_KERNEL);
> +       if (!sbegin)
> +               return -ENOMEM;
> +
> +       /*
> +        * Trim trailing newline, if the remaining string is empty,
> +        * clear the pattern.
> +        */
> +       s = strstrip(sbegin);
> +       if (!*s) {
> +               ret = led_cdev->pattern_clear(led_cdev);
> +               goto out;
> +       }
> +
> +       pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
> +       if (!pattern) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       /* Parse out the brightness & delta_t touples */
> +       while ((elem = strsep(&s, " ")) != NULL) {
> +               ret = kstrtoul(elem, 10, &val);
> +               if (ret)
> +                       goto out;
> +
> +               if (odd) {
> +                       pattern[len].brightness = val;
> +               } else {
> +                       pattern[len].delta_t = val;
> +                       len++;
> +               }
> +
> +               odd = !odd;
> +       }
> +
> +       /*
> +        * Fail if we didn't find any data points or last data point was partial
> +        */
> +       if (!len || !odd) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       ret = led_cdev->pattern_set(led_cdev, pattern, len);
> +
> +out:
> +       kfree(pattern);
> +       kfree(sbegin);
> +       return ret < 0 ? ret : size;
> +}
> +static DEVICE_ATTR_RW(pattern);
> +
> +static umode_t led_class_attrs_mode(struct kobject *kobj,
> +                                   struct attribute *attr, int index)
> +{
> +       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +
> +       if (attr == &dev_attr_brightness.attr)
> +               return attr->mode;
> +       if (attr == &dev_attr_max_brightness.attr)
> +               return attr->mode;
> +       if (attr == &dev_attr_pattern.attr && led_cdev->pattern_set)
> +               return attr->mode;
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_LEDS_TRIGGERS
>  static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
>  static struct attribute *led_trigger_attrs[] = {
> @@ -88,11 +205,13 @@ static ssize_t max_brightness_show(struct device *dev,
>  static struct attribute *led_class_attrs[] = {
>         &dev_attr_brightness.attr,
>         &dev_attr_max_brightness.attr,
> +       &dev_attr_pattern.attr,
>         NULL,
>  };
>
>  static const struct attribute_group led_group = {
>         .attrs = led_class_attrs,
> +       .is_visible = led_class_attrs_mode,
>  };
>
>  static const struct attribute_group *led_groups[] = {
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b7e8255..acdbb2f 100644
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
> @@ -88,6 +89,14 @@ struct led_classdev {
>                                      unsigned long *delay_on,
>                                      unsigned long *delay_off);
>
> +       int (*pattern_set)(struct led_classdev *led_cdev,
> +                          struct led_pattern *pattern, int len);
> +
> +       int (*pattern_clear)(struct led_classdev *led_cdev);
> +
> +       struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
> +                                          int *len);
> +
>         struct device           *dev;
>         const struct attribute_group    **groups;
>
> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>         struct led_classdev *led_cdev, enum led_brightness brightness) { }
>  #endif
>
> +/**
> + * struct led_pattern - brigheness value in a pattern
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time = 0
> + */
> +struct led_pattern {
> +       int delta_t;
> +       int brightness;
> +};
> +
>  #endif         /* __LINUX_LEDS_H_INCLUDED */
> --
> 1.7.9.5
>



-- 
Baolin Wang
Best Regards
