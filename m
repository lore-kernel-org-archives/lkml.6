Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10630C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47E52720B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6fRpckB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47E52720B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeF1KY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:24:29 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38194 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeF1KY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:24:28 -0400
Received: by mail-ua0-f194.google.com with SMTP id 59-v6so3206835uas.5;
        Thu, 28 Jun 2018 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x5BQIuzmjAQHvGgL7HZMRr3qLlUoy3kJ2Vn0qEyKusg=;
        b=F6fRpckBcgAdJLY90Zatam4DKEosO4iBOlY/OvW4j5AvSmh+HdtqYFizFPEDrcCMgJ
         Ggv4BDK32MfQpIU/bzdv/RC4wAUbuO1GuoxXUjEJu1REoycOzrHnRa37LReHN+8vxX/v
         KixSgU/vSMQx6JmSgaNNsHdGxSM8PQ7BuV/+9wGVAgpIOzT4ZXTMayucg6SHF5WpR6qe
         kukrDeS5hpOQq9KS9cEjhpU5uA00AjDDvibAmrgTcXF/H3LUTsLzgO3+UxjiVDBqjGMT
         0x99A4S1NsKP/DSg/92V7ivLP5ZIW7ftS73spZ7LKCvSlfa5jxOgUvO24Qj8YDuE2quQ
         JENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x5BQIuzmjAQHvGgL7HZMRr3qLlUoy3kJ2Vn0qEyKusg=;
        b=ni+f8hxeJYAB8lb8TeVU4rs4aBwHDNh+26RYR1enxeeqx7fbYT2qiKtM/Ac8VlE7YY
         dmkcvfbrzpCYV5OM7Xg1wLrTMjk9tL0nsbHjUHXYcAI7XaEyUGKaFDsSSN+QTd4Mf9Gw
         uDmLroRseCf7wQj06H33SWyvUSs/NrMTtpgn5DwtR9qOJ8Z9ZbMck87jjPUxQspgCwHj
         q4Zzac4r6fYa4G8qjmVLmVVtkjzqjl3k+QFXli8qZSwP/1VutMoA5cltXQcSsPQAyeVX
         rYs/OMVru/vpIyhGTb+ovqq5Dk8xVQhWDqZkmtXLLHzKdS/Udmq2cFeNHivwESc4wytj
         tIEA==
X-Gm-Message-State: APt69E2b8/L7GcXNgLi6Om/1x7Lv/S/v0wC5raThim+fUU0Fm0hSqRS9
        NjpWesP4fzNRFz0NJ3Sg5TqA9oWKJGbGDidPgM4=
X-Google-Smtp-Source: AAOMgpcQR86rMrCZVQ1jfpN2NXvElVICHJb0FD9tXDf1cjh1WT1kXn4n64WQvA5NHR9c07nYtvirjEyp79x99zgfFK0=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr5392012ual.28.1530181467122;
 Thu, 28 Jun 2018 03:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 03:24:26
 -0700 (PDT)
In-Reply-To: <CAMz4kuKOnXX5cf36UZu91f7M9y6NL2Q-CkAxf=VnqawmcQ3tGg@mail.gmail.com>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
 <CAHp75Vfmr=VRtQaUWk4i8A2sws2sDS=QL3wTMfHTszrniAv-YA@mail.gmail.com> <CAMz4kuKOnXX5cf36UZu91f7M9y6NL2Q-CkAxf=VnqawmcQ3tGg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 13:24:26 +0300
Message-ID: <CAHp75VdAXR5=wmfEmF7pwOhZV+P-hOTPdCMFPvwCCqyACnQqpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] leds: core: Introduce generic pattern interface
To:     Baolin Wang <baolin.wang@linaro.org>
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

On Thu, Jun 28, 2018 at 12:18 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On 28 June 2018 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Thu, Jun 28, 2018 at 8:16 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

>>> +What: /sys/class/leds/<led>/pattern
>>> +Date: June 2018
>>> +KernelVersion: 4.18
>>
>> 4.19 ?
>
> I think this will be merged in 4.18.

Is it bug fix? I don't see how it would make v4.18.

>>> +static ssize_t pattern_show(struct device *dev,
>>> +                           struct device_attribute *attr, char *buf)
>>> +{
>>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +       struct led_pattern *pattern;
>>> +       size_t offset = 0;
>>> +       int count, n, i;
>>
>>> +       if (!led_cdev->pattern_get)
>>> +               return -EOPNOTSUPP;
>>> +
>>
>> Perhaps just hide an attribute completely?
>
> Driver need implement the pattern_get() interface, otherwise we can
> not get any available pattern values to show.

It doesn't contradict with what I said. I proposed to just hide an
attribute from sysfs completely if there is no such callbacks
available.

>>> +       pattern = led_cdev->pattern_get(led_cdev, &count);
>>> +       if (IS_ERR_OR_NULL(pattern))
>>> +               return PTR_ERR(pattern);
>>
>> Hmm.. Here you shadow NULL case by returning 0.
>> Even if it's correct behaviour IS_ERR_OR_NULL is a beast to hide such
>> subtle detail.
>>
>> It also would be good idea to check for count == 0 and bail out
>> immediately. Otherwise you will print an extra blank line.
>
> We can not check count, since count can be not initialized if failed
> to call pattern_get(). So maybe force user to return error pointer,
> and we just check like:
> if (IS_ERR(pattern))
>         return PTR_ERR(pattern);

My question is can be counter 0 by some reason?

>>> +       for (i = 0; i < count; i++) {
>>> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d",
>>> +                            pattern[i].brightness, pattern[i].delta_t);
>>> +
>>
>>> +               if (offset + n >= PAGE_SIZE)
>>> +                       goto err_nospc;
>>
>>> +
>>> +               offset += n;
>>> +
>>
>>> +               if (i < count - 1)
>>> +                       buf[offset++] = ' ';
>>
>> You might add this to the end of above format string and remove this
>> conditional completely...
>
> Hmmm, I do not think we need add one extra ' ' to the end of format string.

Why not? You do it anyway for all except last, but...

>>> +       buf[offset++] = '\n';
>>
>> ...and use here something like
>>
>> buf[offset - 1] = '\n';
>
> I don't think so. We need increase the offset value at the same time.

Nope, you don't need it. here we replace trailing space by '\n'.

>> (we have such patterns in the kernel)

...look at existing patterns in the kernel.

>>> +       /* Trim trailing newline */
>>> +       s[strcspn(s, "\n")] = '\0';
>>
>> It's usually done via strstrip().
>>
>> sbegin = kstrndup();
>> ...
>>
>> s = strstrip(sbegin);
>
> Good idea, will change.

Replying to your another message. And who cares about leading spaces?
Is it wrong to have them? Why?

>>> +       /* Parse out the brightness & delta_t touples */
>>> +       while ((elem = strsep(&s, " ")) != NULL) {
>>> +               ret = kstrtoul(elem, 10, &val);
>>> +               if (ret)
>>> +                       goto out;
>>> +
>>
>>> +               if (odd) {
>>
>> This is effectivelly if (len % 2 == 0)
>
> It is incorrect, we can not use len to decide the value is brightness
> or delta. Here logical is to make sure we must keep <brightness
> delta>, <brightness, delta> ......

Right, the problem is the format itself I suppose.
It's too error prone for one attribute.

What about to change it like

"brightness delta[, brightness delta[, ...]]"

and then you do

...elem = strsep(&s, ",")...

sscanf("%d %d") == 2

?

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
>>> +        * Fail if we didn't find any data points or last data point was partial
>>> +        */
>>> +       if (!len || !odd) {
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
>>
>> For partial data can we return different error code?
>> Does it make sense?
>
> Sorry I did not get you here. If user set incorrect pattern values, I
> think '-EINVAL' is suitable.

OK.

-- 
With Best Regards,
Andy Shevchenko
