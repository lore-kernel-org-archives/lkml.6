Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA58FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA6027284
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaGd/sT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA6027284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeF1LUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:20:44 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46520 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeF1LUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:20:42 -0400
Received: by mail-ot0-f193.google.com with SMTP id v24-v6so5685841otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xFMWsZzQUOG1ZQV2usfwLEntx9mU18B1Uvv0DXPImM0=;
        b=OaGd/sT8Ec/dE0njTgTsGLCVv0cM2bYrqlYnL/PNI+hxgcfOT+W4OIrNjxU6a52qYx
         Wpw9S+hylyL+eR1Ul2GG780FEAi/HXA6pae5SIlegUR1O9TejBPC2FamCBp6/8Gjwawn
         d+Gf4ZbjLS4GOo4t5zRis8nCc0JJtrlTXD3tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xFMWsZzQUOG1ZQV2usfwLEntx9mU18B1Uvv0DXPImM0=;
        b=WLETaNnXBC2CqbXmRT7InVvP9MrYIVmA9499xowg+hh7Bw7hi8Ce/wGILCmzeADJUC
         Y6OlOuJGkaDvZaSddWwVTpmjwkn7Zclrc5Bm2jdJySyJriEMCPO+vltNwUs5H8QTQM/g
         748+a3+3dlMQFB06P0+Uq9DBMlWKbDDy5OjFxLrs18xw2Xg0Fx8zHYctx6iIyxP5u3B+
         2D4FxRHUhFpnvm+if9XeLcyIJH8wQmZDCW6OSwdyuRhwpsTvbwtQosBSkEA8ykUcIDEg
         NnsUTcih2u4IDzgwKzl44wXAqatJdNps49mCkPabmBdG7pvOsAjmgIHxqvFWwGMGlkJD
         NHtQ==
X-Gm-Message-State: APt69E1vXrr7TDrj/gj4stNDg1SDD8Rb7VIrUuHJzoSBg5tXP4GKT64s
        7axnIdSqaKWX5t4oEQy6+MVcx+17NcjFrIPwTvVsiw==
X-Google-Smtp-Source: AAOMgpd/tAJSD1A7uTiVlfoANZH46K4J/BAj+r0N81LBG+tB1Wrd1V74lf0iOlCalTDrKU4k3ovxYflPFlD05NcHm5E=
X-Received: by 2002:a9d:4c0f:: with SMTP id l15-v6mr6166553otf.26.1530184841846;
 Thu, 28 Jun 2018 04:20:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 04:20:41
 -0700 (PDT)
In-Reply-To: <CAHp75VdAXR5=wmfEmF7pwOhZV+P-hOTPdCMFPvwCCqyACnQqpw@mail.gmail.com>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
 <CAHp75Vfmr=VRtQaUWk4i8A2sws2sDS=QL3wTMfHTszrniAv-YA@mail.gmail.com>
 <CAMz4kuKOnXX5cf36UZu91f7M9y6NL2Q-CkAxf=VnqawmcQ3tGg@mail.gmail.com> <CAHp75VdAXR5=wmfEmF7pwOhZV+P-hOTPdCMFPvwCCqyACnQqpw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 28 Jun 2018 19:20:41 +0800
Message-ID: <CAMz4ku+PYqgz9HdPHkw_sR53=gY-_aetQVoZpfirt-0EAJBR_Q@mail.gmail.com>
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

On 28 June 2018 at 18:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 28, 2018 at 12:18 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 28 June 2018 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Jun 28, 2018 at 8:16 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>>>> +What: /sys/class/leds/<led>/pattern
>>>> +Date: June 2018
>>>> +KernelVersion: 4.18
>>>
>>> 4.19 ?
>>
>> I think this will be merged in 4.18.
>
> Is it bug fix? I don't see how it would make v4.18.

OK. 4.19 is fine.

>>>> +static ssize_t pattern_show(struct device *dev,
>>>> +                           struct device_attribute *attr, char *buf)
>>>> +{
>>>> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>> +       struct led_pattern *pattern;
>>>> +       size_t offset = 0;
>>>> +       int count, n, i;
>>>
>>>> +       if (!led_cdev->pattern_get)
>>>> +               return -EOPNOTSUPP;
>>>> +
>>>
>>> Perhaps just hide an attribute completely?
>>
>> Driver need implement the pattern_get() interface, otherwise we can
>> not get any available pattern values to show.
>
> It doesn't contradict with what I said. I proposed to just hide an
> attribute from sysfs completely if there is no such callbacks
> available.

Ah, I got your points now. But the pattern is RW and we can not hide
it if only pattern_get() is not supplied without considering
pattern_set().

>
>>>> +       pattern = led_cdev->pattern_get(led_cdev, &count);
>>>> +       if (IS_ERR_OR_NULL(pattern))
>>>> +               return PTR_ERR(pattern);
>>>
>>> Hmm.. Here you shadow NULL case by returning 0.
>>> Even if it's correct behaviour IS_ERR_OR_NULL is a beast to hide such
>>> subtle detail.
>>>
>>> It also would be good idea to check for count == 0 and bail out
>>> immediately. Otherwise you will print an extra blank line.
>>
>> We can not check count, since count can be not initialized if failed
>> to call pattern_get(). So maybe force user to return error pointer,
>> and we just check like:
>> if (IS_ERR(pattern))
>>         return PTR_ERR(pattern);
>
> My question is can be counter 0 by some reason?

I am not sure, but I still think checking the return error pointer is
the common way to handle.

>>>> +       for (i = 0; i < count; i++) {
>>>> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d",
>>>> +                            pattern[i].brightness, pattern[i].delta_t);
>>>> +
>>>
>>>> +               if (offset + n >= PAGE_SIZE)
>>>> +                       goto err_nospc;
>>>
>>>> +
>>>> +               offset += n;
>>>> +
>>>
>>>> +               if (i < count - 1)
>>>> +                       buf[offset++] = ' ';
>>>
>>> You might add this to the end of above format string and remove this
>>> conditional completely...
>>
>> Hmmm, I do not think we need add one extra ' ' to the end of format string.
>
> Why not? You do it anyway for all except last, but...

Previous whitespace is used to break up the brightness value and
delta_t value, but it is useless to add one extra ' ' to the end of
format string.

>
>>>> +       buf[offset++] = '\n';
>>>
>>> ...and use here something like
>>>
>>> buf[offset - 1] = '\n';
>>
>> I don't think so. We need increase the offset value at the same time.
>
> Nope, you don't need it. here we replace trailing space by '\n'.

But why we need add one extra useless space?

>
>>> (we have such patterns in the kernel)
>
> ...look at existing patterns in the kernel.
>
>>>> +       /* Trim trailing newline */
>>>> +       s[strcspn(s, "\n")] = '\0';
>>>
>>> It's usually done via strstrip().
>>>
>>> sbegin = kstrndup();
>>> ...
>>>
>>> s = strstrip(sbegin);
>>
>> Good idea, will change.
>
> Replying to your another message. And who cares about leading spaces?
> Is it wrong to have them? Why?

OK, will use strstrip() to remove leading and trailing space firstly.

>
>>>> +       /* Parse out the brightness & delta_t touples */
>>>> +       while ((elem = strsep(&s, " ")) != NULL) {
>>>> +               ret = kstrtoul(elem, 10, &val);
>>>> +               if (ret)
>>>> +                       goto out;
>>>> +
>>>
>>>> +               if (odd) {
>>>
>>> This is effectivelly if (len % 2 == 0)
>>
>> It is incorrect, we can not use len to decide the value is brightness
>> or delta. Here logical is to make sure we must keep <brightness
>> delta>, <brightness, delta> ......
>
> Right, the problem is the format itself I suppose.
> It's too error prone for one attribute.

The format was decided by previous discussion, so I still like to keep
the original approach here.

>
> What about to change it like
>
> "brightness delta[, brightness delta[, ...]]"
>
> and then you do
>
> ...elem = strsep(&s, ",")...
>
> sscanf("%d %d") == 2
>
> ?
>
>>>> +                       pattern[len].brightness = val;
>>>> +               } else {
>>>> +                       pattern[len].delta_t = val;
>>>> +                       len++;
>>>> +               }
>>>> +
>>>> +               odd = !odd;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Fail if we didn't find any data points or last data point was partial
>>>> +        */
>>>> +       if (!len || !odd) {
>>>> +               ret = -EINVAL;
>>>> +               goto out;
>>>> +       }
>>>
>>> For partial data can we return different error code?
>>> Does it make sense?
>>
>> Sorry I did not get you here. If user set incorrect pattern values, I
>> think '-EINVAL' is suitable.
>
> OK.
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Baolin.wang
Best Regards
