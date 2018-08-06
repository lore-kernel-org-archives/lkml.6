Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F805C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4EB21A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMdEtpa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4EB21A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeHFNwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:52:08 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34344 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeHFNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:52:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so21614332ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RW8Zi3sWb31J5SfhpToLKZ1iep0tNeBzDRJm8ZA4oeI=;
        b=EMdEtpa+fvLTVBzD7ys/MHbVHLTCVt38yPrwlOlZZJtbM5cuNhFN+GgN3BqvPGtHJT
         6azrhBk+GTULih8qnQdsA47HN31R8AX/3ebC/dgI3luG215lxY+fU7oxTaNAo0pBtXq4
         oNp+bqQHdju+fpKoUiVGuIruRyxN5ZkQ93PbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RW8Zi3sWb31J5SfhpToLKZ1iep0tNeBzDRJm8ZA4oeI=;
        b=gdp1snoAXCnFwSafkJNM+4eg0eweLxVr2nYadZ5rUVDNsyqF6MbhgcflFANn4uEtPk
         CavXEdVhot2Hd+myC/LGwvFP34jQFPI5srhTSfYJEax2L0C0dsDW1eAq/bGkkzS2DMu3
         2ktnk3uIjzMIKgEhmeRzJmXN6+5vvRusmJyQz+qCTcvw6ID4SRiY6APeHMjKPsuwQqD1
         IMjuh8MxxkXEkxQfnpiP4zF/G7LwRmvWin748xayLy6nLKhKTHwE3MeUEyni4C8KHbdV
         7K06qKR0k8/De2AdOsBrPP6R8aGQ1HuVoehGBoF8o7pmKIt5lYEqcuuOUC15YMU12JuX
         qIHQ==
X-Gm-Message-State: AOUpUlFAK8UHfJ1rNnwbLPakWFDGs6y0u+NUoblPOYsijP33ClxKf0F5
        8YBOcueSxG14ArcyJxIsOY+vC8hLGuAVO9tBv8biOg==
X-Google-Smtp-Source: AAOMgpf/lUSaDLidTDEikOsa85yjoNt6gfyPbFqiueJJvMEOe7q62eiW4UqJUVfPkJxooIxLvkCehSP/qWmwmW+aGgE=
X-Received: by 2002:aca:c5:: with SMTP id 188-v6mr13581724oia.128.1533555805894;
 Mon, 06 Aug 2018 04:43:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 04:43:25 -0700 (PDT)
In-Reply-To: <b7407dc4-73b3-f819-2c44-03ed65999e32@gmail.com>
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
 <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com> <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
 <b7407dc4-73b3-f819-2c44-03ed65999e32@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 Aug 2018 19:43:25 +0800
Message-ID: <CAMz4kuLS63y8FFdGD7n-0SU5Y+wRvaLXM9WxckuCym1OpuF-DA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
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

On 6 August 2018 at 19:41, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 08/06/2018 03:53 AM, Baolin Wang wrote:
>> Hi Jacek,
> [...]
>>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>> @@ -0,0 +1,21 @@
>>>> +What:                /sys/class/leds/<led>/pattern
>>>> +Date:                August 2018
>>>> +KernelVersion:       4.19
>>>> +Description:
>>>> +             Specify a pattern for the LED, for LED hardware that support
>>>> +             altering the brightness as a function of time.
>>>> +
>>>> +             The pattern is given by a series of tuples, of brightness and
>>>> +             duration (ms). The LED is expected to traverse the series and
>>>> +             each brightness value for the specified duration. Duration of
>>>> +             0 means brightness should immediately change to new value.
>>>> +
>>>> +             The format of the pattern values should be:
>>>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>>>> +             duration_3 ...".
>>>> +
>>>> +What:                /sys/class/leds/<led>/repeat
>>>> +Date:                August 2018
>>>> +KernelVersion:       4.19
>>>> +Description:
>>>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>>>
>>> In current implementation this file on read returns the number
>>> of remaining repeat intervals. I'd add that to this description.
>>
>> I saw Pavel's comments that he did not suggest do this. So I will keep
>> the original description?
>
> Yes, please report always the original value.

Sure. Thanks.

>
> [...]
>>>> +static ssize_t pattern_trig_store_repeat(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      const char *buf, size_t count)
>>>> +{
>>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>>> +     unsigned long res;
>>>> +     int err;
>>>> +
>>>> +     err = kstrtoul(buf, 10, &res);
>>>> +     if (err)
>>>> +             return err;
>>>> +
>>>> +     if (!led_cdev->pattern_set)
>>>> +             del_timer_sync(&data->timer);
>>>
>>> Is there a reason for not having this check under mutex?
>>
>> We will hold the mutex in pattern_trig_timer_function(), so if we do
>> del_timer_sync() under the mutex protection, we may meet dead-lock
>> issue. Moreover, the del_timer_sync() will make sure deactivating one
>> timer is safe.
>
> Ack.
>
> --
> Best regards,
> Jacek Anaszewski



-- 
Baolin Wang
Best Regards
