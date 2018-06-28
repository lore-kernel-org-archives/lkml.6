Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94286C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F9927161
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHP7ZSbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F9927161
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeF1JZZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:25:25 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46457 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935099AbeF1JZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:25:21 -0400
Received: by mail-ot0-f194.google.com with SMTP id v24-v6so5360844otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ub1dGQqf9dcs3eVGZlmMCVfZFcz6xx38dCW76Mm0B+o=;
        b=gHP7ZSbDL21zw83sVEtixl9HpJnq0IH3G6DpJQXMxgpoEbN2yTYCGSNLnRZCtU1Upz
         1DzKoXcvrRY5afiM5PKyV94+tq22HMBYAAkVIBl5F1jWqHcmVBoR4boNEvrWkV1GRP8h
         TUhFPdo0LZ9egyNW6mlfOVWLD99qdwy5dZNRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ub1dGQqf9dcs3eVGZlmMCVfZFcz6xx38dCW76Mm0B+o=;
        b=D1YtnHcTus0Ui/RJvRoObDaALu430Y2/Lcpk/Q0ttPG7nXP6q+MxXDubB1H2AjJyv3
         h2IuI/wthBQwI/Fzzw1Upc57Dru3JOJ7CzoG6oyDCOWT7k04hqGR6zqMoHmHbIJBXTJ5
         v76c0Bx6OFsyM8s/H6Isodz7JhLhOaJMD645Eq96cg81+kNdFEfWok13Ej/hlMMthLtj
         u2ypECm6AkS5mlz9rgcCyO/yT0Q0jVOGM9nQmZFtcuEuYF6PTzKygohaTxATqb7OI4W8
         cWqmk0yVS++Lu5tyuf1SwTEEsypA5+XakNNAqDXxrCDtEgdT5shEAA9SHqnRCgC92XX9
         X41w==
X-Gm-Message-State: APt69E17vBKbV6TpY6+Q6SfdTgVaY6vB1IkX6IAxB/5bqYYk3tAuvdUQ
        yCmEJDr6m6zWcnlWw06+S1lqs23mFx8ryE3tNVLiNw==
X-Google-Smtp-Source: AAOMgpe0ZMAQswnsHKGusX86b42/XlleuySHHsnN9nyVFQ9X49avceuCulJHrA3I4rsk44pXklJxMmucsDarV/EWcro=
X-Received: by 2002:a9d:2687:: with SMTP id l7-v6mr5847510otb.141.1530177920457;
 Thu, 28 Jun 2018 02:25:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 02:25:19
 -0700 (PDT)
In-Reply-To: <CAMz4kuKOnXX5cf36UZu91f7M9y6NL2Q-CkAxf=VnqawmcQ3tGg@mail.gmail.com>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
 <CAHp75Vfmr=VRtQaUWk4i8A2sws2sDS=QL3wTMfHTszrniAv-YA@mail.gmail.com> <CAMz4kuKOnXX5cf36UZu91f7M9y6NL2Q-CkAxf=VnqawmcQ3tGg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 28 Jun 2018 17:25:19 +0800
Message-ID: <CAMz4kuKr0=ecQepmfjy7H4XDp6MW86LyA03kjY50DR+Ma=SVdg@mail.gmail.com>
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

On 28 June 2018 at 17:18, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Andy,
>
> On 28 June 2018 at 16:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Thu, Jun 28, 2018 at 8:16 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> Some LED controllers have support for autonomously controlling
>>> brightness over time, according to some preprogrammed pattern or
>>> function.
>>>
>>> This adds a new optional operator that LED class drivers can implement
>>> if they support such functionality as well as a new device attribute to
>>> configure the pattern for a given LED.
>>
>>> +What: /sys/class/leds/<led>/pattern
>>> +Date: June 2018
>>> +KernelVersion: 4.18
>>
>> 4.19 ?
>
> I think this will be merged in 4.18.
>
>>
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
>
>>
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
>
>>
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
>
>>
>>> +       }
>>> +
>>
>>> +       buf[offset++] = '\n';
>>
>> ...and use here something like
>>
>> buf[offset - 1] = '\n';
>
> I don't think so. We need increase the offset value at the same time.
>
>>
>> (we have such patterns in the kernel)
>>
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
>>> +       s = sbegin = kstrndup(buf, size, GFP_KERNEL);
>>> +       if (!s)
>>> +               return -ENOMEM;
>>> +
>>
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

Wait, we can not use strstrip() here, strstrip() is used to remove
leading and trailing whitespace, this is not the case what we handled
here.

>
>>
>>> +
>>> +       /* If the remaining string is empty, clear the pattern */
>>> +       if (!s[0]) {
>>
>> if (!*s) ?
>
> OK.
>
>>
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
>>
>>> +               if (odd) {
>>
>> This is effectivelly if (len % 2 == 0)
>
> It is incorrect, we can not use len to decide the value is brightness
> or delta. Here logical is to make sure we must keep <brightness
> delta>, <brightness, delta> ......
>
>>
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
> think '-EINVAL' is suitable. Thanks for your comments.
>
> --
> Baolin.wang
> Best Regards



-- 
Baolin.wang
Best Regards
