Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0320C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E1B27152
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENysRoKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E1B27152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935091AbeF1JTA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:19:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38162 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935055AbeF1JS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:18:58 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so4525117oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bUWPvoj483c8PhjbzUnT+/1d95q/3dlAPRWFad/4a0o=;
        b=ENysRoKnrpAHHMSHN/nk4mwR61a7dS3CCV6LWbKcBaKG1VKeB2qwWnZiKXVYwYSx6Z
         AZKJYr83Ui881ypTUrBmfgqpK08tRzGX+yRZF4KvIWqs+cQTzbzZrELOxjqaej+En8h+
         Qr3FbApb4kRi5nCdF5znUKaW3tdfm+sJ9qrLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bUWPvoj483c8PhjbzUnT+/1d95q/3dlAPRWFad/4a0o=;
        b=HLuirUpRPo0Y+jaO5z6wtY2T86yPFKsv2kToQzimgLS3IEmb3DNJxKINRwl8m0cEZ/
         r+i4/DFhmvQz9Npi4u2UNYh5AHLdeVglsDzgIUrzVdnkQDHHQFOj0PgVEbHxJwxHcXuT
         MQmisU681VspUSogkHnoQPDGw4brRR9Ws4ubWEQBQQ37i3Ro5CobkwDiKb5CRqoDeRbN
         8zc+okPK2tksHMgaey2Lp0AIuxlzqT+yEe7vZEAW/iOoxASNvx5rRxk86BaT5rA4j3NZ
         C1pLeCeVHK9AGUEC6NX+v58EEfHbDp/uOhhuQmGea+fF41QOWczg+9onMxn4LmGXXk7P
         ZMww==
X-Gm-Message-State: APt69E38rwSPs/f2gl3G4wwjYev4ss7rn0hGvxndHGNltzO9gfXeoMtY
        Z+MgEqvaWu0X7d2TE5CiBf5XeQTygKd+kjk2hL6m3w==
X-Google-Smtp-Source: AAOMgpct5dTvi+jWdinx6ap1fYpyNYFgczp9KmrVl/WU9oX9AuByNRXJ97drt6X87GUiurwlXtGCqVWVekV9MGdZyu0=
X-Received: by 2002:aca:60c4:: with SMTP id u187-v6mr4900431oib.177.1530177537297;
 Thu, 28 Jun 2018 02:18:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 02:18:56
 -0700 (PDT)
In-Reply-To: <CAHp75Vfmr=VRtQaUWk4i8A2sws2sDS=QL3wTMfHTszrniAv-YA@mail.gmail.com>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
 <CAHp75Vfmr=VRtQaUWk4i8A2sws2sDS=QL3wTMfHTszrniAv-YA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 28 Jun 2018 17:18:56 +0800
Message-ID: <CAMz4kuKOnXX5cf36UZu91f7M9y6NL2Q-CkAxf=VnqawmcQ3tGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] leds: core: Introduce generic pattern interface
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 28 June 2018 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 28, 2018 at 8:16 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> Some LED controllers have support for autonomously controlling
>> brightness over time, according to some preprogrammed pattern or
>> function.
>>
>> This adds a new optional operator that LED class drivers can implement
>> if they support such functionality as well as a new device attribute to
>> configure the pattern for a given LED.
>
>> +What: /sys/class/leds/<led>/pattern
>> +Date: June 2018
>> +KernelVersion: 4.18
>
> 4.19 ?

I think this will be merged in 4.18.

>
>> +static ssize_t pattern_show(struct device *dev,
>> +                           struct device_attribute *attr, char *buf)
>> +{
>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +       struct led_pattern *pattern;
>> +       size_t offset = 0;
>> +       int count, n, i;
>
>> +       if (!led_cdev->pattern_get)
>> +               return -EOPNOTSUPP;
>> +
>
> Perhaps just hide an attribute completely?

Driver need implement the pattern_get() interface, otherwise we can
not get any available pattern values to show.

>
>> +       pattern = led_cdev->pattern_get(led_cdev, &count);
>> +       if (IS_ERR_OR_NULL(pattern))
>> +               return PTR_ERR(pattern);
>
> Hmm.. Here you shadow NULL case by returning 0.
> Even if it's correct behaviour IS_ERR_OR_NULL is a beast to hide such
> subtle detail.
>
> It also would be good idea to check for count == 0 and bail out
> immediately. Otherwise you will print an extra blank line.

We can not check count, since count can be not initialized if failed
to call pattern_get(). So maybe force user to return error pointer,
and we just check like:
if (IS_ERR(pattern))
        return PTR_ERR(pattern);

>
>> +       for (i = 0; i < count; i++) {
>> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d",
>> +                            pattern[i].brightness, pattern[i].delta_t);
>> +
>
>> +               if (offset + n >= PAGE_SIZE)
>> +                       goto err_nospc;
>
>> +
>> +               offset += n;
>> +
>
>> +               if (i < count - 1)
>> +                       buf[offset++] = ' ';
>
> You might add this to the end of above format string and remove this
> conditional completely...

Hmmm, I do not think we need add one extra ' ' to the end of format string.

>
>> +       }
>> +
>
>> +       buf[offset++] = '\n';
>
> ...and use here something like
>
> buf[offset - 1] = '\n';

I don't think so. We need increase the offset value at the same time.

>
> (we have such patterns in the kernel)
>
>> +
>> +       kfree(pattern);
>> +       return offset;
>> +
>> +err_nospc:
>> +       kfree(pattern);
>> +       return -ENOSPC;
>> +}
>> +
>> +static ssize_t pattern_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t size)
>> +{
>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +       struct led_pattern *pattern = NULL;
>> +       unsigned long val;
>> +       char *sbegin;
>> +       char *elem;
>> +       char *s;
>> +       int ret, len = 0;
>> +       bool odd = true;
>> +
>> +       s = sbegin = kstrndup(buf, size, GFP_KERNEL);
>> +       if (!s)
>> +               return -ENOMEM;
>> +
>
>> +       /* Trim trailing newline */
>> +       s[strcspn(s, "\n")] = '\0';
>
> It's usually done via strstrip().
>
> sbegin = kstrndup();
> ...
>
> s = strstrip(sbegin);

Good idea, will change.

>
>> +
>> +       /* If the remaining string is empty, clear the pattern */
>> +       if (!s[0]) {
>
> if (!*s) ?

OK.

>
>> +               ret = led_cdev->pattern_clear(led_cdev);
>> +               goto out;
>> +       }
>> +
>> +       pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
>> +       if (!pattern) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       /* Parse out the brightness & delta_t touples */
>> +       while ((elem = strsep(&s, " ")) != NULL) {
>> +               ret = kstrtoul(elem, 10, &val);
>> +               if (ret)
>> +                       goto out;
>> +
>
>> +               if (odd) {
>
> This is effectivelly if (len % 2 == 0)

It is incorrect, we can not use len to decide the value is brightness
or delta. Here logical is to make sure we must keep <brightness
delta>, <brightness, delta> ......

>
>> +                       pattern[len].brightness = val;
>> +               } else {
>> +                       pattern[len].delta_t = val;
>> +                       len++;
>> +               }
>> +
>> +               odd = !odd;
>> +       }
>> +
>> +       /*
>> +        * Fail if we didn't find any data points or last data point was partial
>> +        */
>> +       if (!len || !odd) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>
> For partial data can we return different error code?
> Does it make sense?

Sorry I did not get you here. If user set incorrect pattern values, I
think '-EINVAL' is suitable. Thanks for your comments.

-- 
Baolin.wang
Best Regards
