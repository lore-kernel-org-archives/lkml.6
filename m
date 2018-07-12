Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F0BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C596208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJkXtVHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C596208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbeGLMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:33:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40477 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeGLMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:33:31 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so55376265oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZkmB/rfgZktPAw/6K8TYMpsPh+Oj9DvT8dOb+EGX2N4=;
        b=iJkXtVHgiXXBLXPSuZVO+0Mu8+bBWvqqrxczTf/OibJxjw9zwvl93oAX037OiTxykW
         g/Y8sYM60MrsI7jE7R0Zpx1yH0Bq0RYQr9+hTNG7k8CNQNnY+KkIod7/AvOemi/xZ5mK
         jUOLpwTJYJGOH4dMhjZEyTa8vNcPsdMKVEKbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZkmB/rfgZktPAw/6K8TYMpsPh+Oj9DvT8dOb+EGX2N4=;
        b=MMoquJSdfHwXq9Zd68mVvPt7QEHAV2HzZheZSPXiiYtQZH2xWWBfMUQjLb1o+/WaQD
         AOBbEGL1suW7JvCNeEESaQACokOoFpIIAxy+x9L3da6jxNb0Be2xE1+e4TNSc9FwCVAe
         StnwqAtbY/1Ye+AFwV0CV5+HCdjKuAPkG6CmmSKBxTVFUmqhN5TQbhLQwbS4pDDYkaQ+
         QgCYjrZEEiaD81L4TQez2dCxZTsEJMrgctWTU1YeIQpIxYs142CI1G5an+MUzhUmqD1B
         hJsSrSEvCJYrTrOryt/N5kgqM4uAoNWtQSg3iRqxsdbhwA5S3wTZLooMRpmg3frWFRZa
         WWdA==
X-Gm-Message-State: AOUpUlE79NfPZeBx5cBlb5bb3DBFdgd9R2b1OnpI30zAnCWy+JCQCUn9
        lJRsFkkBYKAWfR9KcG+fz4Tdn6P5C5DrK5tvtq1VyA==
X-Google-Smtp-Source: AAOMgpcnnv+j+C4EovA/YeNVU8earrhZt9K3PYHSekAbr50bvU9ZSJElmtQqT3SnzfJSIsdWJph7IznYY9nfw3oA6zU=
X-Received: by 2002:aca:dd07:: with SMTP id u7-v6mr1905165oig.177.1531398250493;
 Thu, 12 Jul 2018 05:24:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 05:24:10
 -0700 (PDT)
In-Reply-To: <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com> <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 12 Jul 2018 20:24:10 +0800
Message-ID: <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
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

On 12 July 2018 at 05:10, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin.
>
>
> On 07/11/2018 01:02 PM, Baolin Wang wrote:
>>
>> Hi Jacek and Pavel,
>>
>> On 29 June 2018 at 13:03, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> Some LED controllers have support for autonomously controlling
>>> brightness over time, according to some preprogrammed pattern or
>>> function.
>>>
>>> This adds a new optional operator that LED class drivers can implement
>>> if they support such functionality as well as a new device attribute to
>>> configure the pattern for a given LED.
>>>
>>> [Baolin Wang did some minor improvements.]
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>> Changes from v2:
>>>   - Change kernel version to 4.19.
>>>   - Force user to return error pointer if failed to issue pattern_get().
>>>   - Use strstrip() to trim trailing newline.
>>>   - Other optimization.
>>>
>>> Changes from v1:
>>>   - Add some comments suggested by Pavel.
>>>   - Change 'delta_t' can be 0.
>>>
>>> Note: I removed the pattern repeat check and will get the repeat number
>>> by adding
>>> one extra file named 'pattern_repeat' according to previous discussion.
>>> ---
>>
>>
>> Do you have any comments for this version patch set? Thanks.
>
>
> I tried modifying uleds.c driver to support pattern ops, but
> I'm getting segfault when doing "cat pattern". I didn't give
> it serious testing and analysis - will do it at weekend.
>
> It also drew my attention to the issue of desired pattern sysfs
> interface semantics on uninitialized pattern. In your implementation
> user seems to be unable to determine if the pattern is activated
> or not. We should define the semantics for this use case and
> describe it in the documentation. Possibly pattern could
> return alone new line character then.

I am not sure I get your points correctly. If user writes values to
pattern interface which means we activated the pattern.
If I am wrong, could you elaborate on the issue you concerned? Thanks.

>
> This is the code snippet I've used for testing pattern interface:
>
> static struct led_pattern ptrn[10];
> static int ptrn_len;
>
> static int uled_pattern_clear(struct led_classdev *ldev)
> {
>         return 0;
> }
>
> static int uled_pattern_set(struct led_classdev *ldev,
>                                   struct led_pattern *pattern,
>                                   int len)
> {
>         int i;
>
>         for (i = 0; i < len; i++) {
>                 ptrn[i].brightness = pattern[i].brightness;
>                 ptrn[i].delta_t = pattern[i].delta_t;
>         }
>
>         ptrn_len = len;
>
>         return 0;
> }
>
> static struct led_pattern *uled_pattern_get(struct led_classdev *ldev,
>                                                   int *len)
> {
>         int i;
>
>         for (i = 0; i < ptrn_len; i++) {
>                 ptrn[i].brightness = 3;
>                 ptrn[i].delta_t = 5;
>         }
>
>         *len = ptrn_len;
>
>         return ptrn;
>
> }

The reason you met segfault when doing "cat pattern" is you should not
return one static pattern array, since in pattern_show() it will help
to free the pattern memory, could you change to return one pattern
pointer with dynamic allocation like my patch 2?

>>
>>>   Documentation/ABI/testing/sysfs-class-led |   17 +++++
>>>   drivers/leds/led-class.c                  |  119
>>> +++++++++++++++++++++++++++++
>>>   include/linux/leds.h                      |   19 +++++
>>>   3 files changed, 155 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led
>>> b/Documentation/ABI/testing/sysfs-class-led
>>> index 5f67f7a..e01ac55 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-led
>>> +++ b/Documentation/ABI/testing/sysfs-class-led
>>> @@ -61,3 +61,20 @@ Description:
>>>                  gpio and backlight triggers. In case of the backlight
>>> trigger,
>>>                  it is useful when driving a LED which is intended to
>>> indicate
>>>                  a device in a standby like state.
>>> +
>>> +What: /sys/class/leds/<led>/pattern
>>> +Date: June 2018
>>> +KernelVersion: 4.19
>>> +Description:
>>> +       Specify a pattern for the LED, for LED hardware that support
>>> +       altering the brightness as a function of time.
>>> +
>>> +       The pattern is given by a series of tuples, of brightness and
>>> +       duration (ms). The LED is expected to traverse the series and
>>> +       each brightness value for the specified duration. Duration of
>>> +       0 means brightness should immediately change to new value.
>>> +
>>> +       As LED hardware might have different capabilities and precision
>>> +       the requested pattern might be slighly adjusted by the driver
>>> +       and the resulting pattern of such operation should be returned
>>> +       when this file is read.
>>> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
>>> index 3c7e348..8a685a2 100644
>>> --- a/drivers/leds/led-class.c
>>> +++ b/drivers/leds/led-class.c
>>> @@ -74,6 +74,123 @@ static ssize_t max_brightness_show(struct device
>>> *dev,
>>>   }
>>>   static DEVICE_ATTR_RO(max_brightness);
>>>
>>> +static ssize_t pattern_show(struct device *dev,
>>> +                           struct device_attribute *attr, char *buf)
>>> +{
>>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +       struct led_pattern *pattern;
>>> +       size_t offset = 0;
>>> +       int count, n, i;
>>> +
>>> +       if (!led_cdev->pattern_get)
>>> +               return -EOPNOTSUPP;
>
>
> Please check this in led_classdev_register() and fail
> if pattern_set is initialized, but pattern_get or pattern_clear not.

Sure.

>>> +       pattern = led_cdev->pattern_get(led_cdev, &count);
>>> +       if (IS_ERR(pattern))
>>> +               return PTR_ERR(pattern);
>>> +
>>> +       for (i = 0; i < count; i++) {
>>> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d ",
>>> +                            pattern[i].brightness, pattern[i].delta_t);
>>> +
>>> +               if (offset + n >= PAGE_SIZE)
>>> +                       goto err_nospc;
>>> +
>>> +               offset += n;
>>> +       }
>>> +
>>> +       buf[offset - 1] = '\n';
>>> +
>>> +       kfree(pattern);
>>> +       return offset;
>>> +
>>> +err_nospc:
>>> +       kfree(pattern);
>>> +       return -ENOSPC;
>>> +}
>>> +
>>> +static ssize_t pattern_store(struct device *dev,
>>> +                            struct device_attribute *attr,
>>> +                            const char *buf, size_t size)
>>> +{
>>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +       struct led_pattern *pattern = NULL;
>>> +       unsigned long val;
>>> +       char *sbegin;
>>> +       char *elem;
>>> +       char *s;
>>> +       int ret, len = 0;
>>> +       bool odd = true;
>>> +
>>> +       sbegin = kstrndup(buf, size, GFP_KERNEL);
>>> +       if (!sbegin)
>>> +               return -ENOMEM;
>>> +
>>> +       /*
>>> +        * Trim trailing newline, if the remaining string is empty,
>>> +        * clear the pattern.
>>> +        */
>>> +       s = strstrip(sbegin);
>>> +       if (!*s) {
>>> +               ret = led_cdev->pattern_clear(led_cdev);
>>> +               goto out;
>>> +       }
>>> +
>>> +       pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
>>> +       if (!pattern) {
>>> +               ret = -ENOMEM;
>>> +               goto out;
>>> +       }
>>> +
>>> +       /* Parse out the brightness & delta_t touples */
>>> +       while ((elem = strsep(&s, " ")) != NULL) {
>>> +               ret = kstrtoul(elem, 10, &val);
>>> +               if (ret)
>>> +                       goto out;
>>> +
>>> +               if (odd) {
>>> +                       pattern[len].brightness = val;
>>> +               } else {
>>> +                       pattern[len].delta_t = val;
>>> +                       len++;
>>> +               }
>>> +
>>> +               odd = !odd;
>>> +       }
>>> +
>>> +       /*
>>> +        * Fail if we didn't find any data points or last data point was
>>> partial
>>> +        */
>>> +       if (!len || !odd) {
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
>>> +
>>> +       ret = led_cdev->pattern_set(led_cdev, pattern, len);
>>> +
>>> +out:
>>> +       kfree(pattern);
>>> +       kfree(sbegin);
>>> +       return ret < 0 ? ret : size;
>>> +}
>>> +static DEVICE_ATTR_RW(pattern);
>>> +
>>> +static umode_t led_class_attrs_mode(struct kobject *kobj,
>>> +                                   struct attribute *attr, int index)
>>> +{
>>> +       struct device *dev = container_of(kobj, struct device, kobj);
>>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +
>>> +       if (attr == &dev_attr_brightness.attr)
>>> +               return attr->mode;
>>> +       if (attr == &dev_attr_max_brightness.attr)
>>> +               return attr->mode;
>>> +       if (attr == &dev_attr_pattern.attr && led_cdev->pattern_set)
>>> +               return attr->mode;
>>> +
>>> +       return 0;
>>> +}
>
>
>>>   #ifdef CONFIG_LEDS_TRIGGERS
>>>   static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
>>>   static struct attribute *led_trigger_attrs[] = {
>>> @@ -88,11 +205,13 @@ static ssize_t max_brightness_show(struct device
>>> *dev,
>>>   static struct attribute *led_class_attrs[] = {
>>>          &dev_attr_brightness.attr,
>>>          &dev_attr_max_brightness.attr,
>>> +       &dev_attr_pattern.attr,
>>>          NULL,
>>>   };
>>>
>>>   static const struct attribute_group led_group = {
>>>          .attrs = led_class_attrs,
>>> +       .is_visible = led_class_attrs_mode,
>
>
> This should not be needed if we'll validate pattern ops
> in led_classdev_register().

I am afraid we can not remove it. If the driver did not supply
pattern_set/get/clear, we should not still show the pattern interfaces
for userspace. Or am I missed anything?

Thanks for your comments.

-- 
Baolin Wang
Best Regards
