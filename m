Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000B1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9FD20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hdz50E9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9FD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIGH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:29:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38532 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeIGH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:29:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id x197-v6so24610838oix.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=via2vtYsBTaftEUCX6rQPAWSsfaRKJPRmGji35pWP/c=;
        b=Hdz50E9vOLfJzc7+ymUJKAlzLVn+7t56ygwwFL3wSmU55n6PtTsAlFFOG0u7EiZgpm
         4YuJgZaLPnHbFV6132FkstVa5E54zdnPMezKbc7oMcXVLbA8Vrs3UN3Z+RFxFquZ/XCv
         UoDqiWhwOZVvvj270jtaim2CKuCBpI7vAGwy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=via2vtYsBTaftEUCX6rQPAWSsfaRKJPRmGji35pWP/c=;
        b=Mjn/SBsbHxr6G5vxE7AluDLgdALu5bKngSjHitFsDHIXujywIP3Dv3eAJQk5KyWA2c
         MOsjKppBDzAS+zoQWOwAQns6rtDB9Kt1Ctu5W5ZHeM8Tssrp+1q/58DWKQMqBcf+KtrT
         WfsaO9a/MbaNbTGDz2H0vMt4xjStXCZBrWe5vWAvMGPkZqkb8uFTjdKAt4Ru34PPZoHg
         ZRBnlLQgIJxASfaWe6CPE6uz2XA1lx28j5TZpNosIWSPaAKLu9yk9QLaqT/xGl0nT30c
         fDn2vU7Ej50+ZIqN+2pmILw4UFSlfmwYJIaCOE6JRgjhTxZG5/scnLt0tyMRbFDclw/4
         xExQ==
X-Gm-Message-State: APzg51CBBne2Us4h4m5cDf6nADGYozeBpcfp0fx3Ezt/iGf6Lh1uK+JW
        rAV8Vh5ObC/oRNUbSNdUk8d1sxfw13+viKmuo4K8qw==
X-Google-Smtp-Source: ANB0VdZfIwSnkmFY0kSzllqzN4Uh/P5Apde9ljP/KJoFObN2DuUwQRyNsznfU7eR/FXnNX/WoW1uOMe+5DmZLaDzpAs=
X-Received: by 2002:aca:5b57:: with SMTP id p84-v6mr5803864oib.109.1536288664648;
 Thu, 06 Sep 2018 19:51:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 19:51:04 -0700 (PDT)
In-Reply-To: <20180906211605.GA16899@amd>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536200860.git.baolin.wang@linaro.org>
 <975a9570c75fb4469c0cef55cc9ed42266f933af.1536200860.git.baolin.wang@linaro.org>
 <20180906211605.GA16899@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 7 Sep 2018 10:51:04 +0800
Message-ID: <CAMz4kuKVqmHgq6h3Oj=5HmfXNv9SefOM0g9Y6gSqTJ6Bq=H0Vg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] leds: sc27xx: Add pattern_set/clear interfaces
 for LED controller
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 7 September 2018 at 05:16, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> new file mode 100644
>> index 0000000..d8056d5
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> @@ -0,0 +1,22 @@
>> +What:                /sys/class/leds/<led>/hw_pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a hardware pattern for the SC27XX LED. For the SC27XX
>> +             LED controller, it only supports 4 stages to make a single
>> +             hardware pattern, which is used to configure the rise time,
>> +             high time, fall time and low time for the breathing mode.
>> +
>> +             For the breathing mode, the SC27XX LED only expects one brightness
>> +             for the high stage. To be compatible with the hardware pattern
>> +             format, we should set brightness as 0 for rise stage, fall
>> +             stage and low stage.
>> +
>> +             Min stage duration: 125 ms
>> +             Max stage duration: 31875 ms
>> +
>> +             Since the stage duration step is 125 ms, the duration must be
>> +             a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
>> +
>> +             Thus the format of the hardware pattern values should be:
>> +             "0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
>
> If I'm not mistaken, this is:
>
>                 "0 rise_duration brightness high_duration brightness
>                 fall_duration 0 low_duration".
>
> Right?

Hmmm, for SC27XX led, there is no need to set brightness for rise and
fall stage.

>
> With that fixed:
>
> Acked-by: Pavel Machek <pavel@ucw.c>

Thanks.

-- 
Baolin Wang
Best Regards
