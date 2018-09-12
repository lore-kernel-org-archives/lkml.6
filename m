Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3BEC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9662620C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuZod6Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9662620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeIMBYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:24:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39565 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:24:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id v77-v6so2836165lfa.6;
        Wed, 12 Sep 2018 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o2EMZtEAplHmct5qa72hg2deLGO11tKo5ZpOhgrCP0I=;
        b=KuZod6Z7NVyHJ+XM/TKjvcCHHTtsxGGfn50kHAy1pPbczeOUQ+jEIStZCaIXNJVp5S
         HqjcBNJY9Yybuen9+oJOVSVG5V/d8uLyIZ1AScZXzyo+cmoPN4CJhgvXnUoA3ppqUNVI
         4qRzFtVMajY4USZ7gYWJm0OKGreXYeJeolEGhYilKjpwHP+ud7Qrw0meN9gqgU7UjEJN
         Yoz0D3mwflWwtQWtrEKL3CVG5vYEuWl4yXtlyvc8gqMVwudM83aYAX662GZRdI6m/XEZ
         Ajis0LfDKlDZXwpz+xnhI2G0RV8/iP5GpZq0CFeCzDYLZEkkCz3kgaXAiNozEdguHpe0
         3AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o2EMZtEAplHmct5qa72hg2deLGO11tKo5ZpOhgrCP0I=;
        b=HKL5eiiz8kKGv+DpcqLcPgpdQUI9hD9yoXfqxf3hTRW5ig0xw/nQA8CTjtNFAW8tmP
         wO0v9cWzSLRCgwSbM2i7yPd7Hfq7WZC3Iaxu7lYrU64Evipx0Rcra4/yjQU4ppcHExoc
         mZ1hiZCWNEP/Ja5ypDhPeXy8n35FopccRuHS7IoNtKDFtEANo19gJoibiFEyIcRJUd0l
         4PI/H7/9hmgqiZ1eWED+8v4BaXHZwpDzACgxsHXwKYBvQbofS//O/ELgdEvnLJYHzMdo
         hYlFUGpq6U8diO2hHON3tuVlj898sHdnoX8JlzJK5Zv4ong2OZKUK2bprjoTeGX7KKwj
         tKnQ==
X-Gm-Message-State: APzg51D6O5RLZZJqynw61Y3GRugQDnpm9vVvXEErOXi3BC1JEyq+IBc4
        QU+cmG+p2eQwTdLKxVSzmh01u3bJ
X-Google-Smtp-Source: ANB0VdaXm2pa+j+aPbGE0lIWyUJQ0V/BrlmNHkoXzJ8/0TT2FQqC4WzIGJ38qqPvhzJrFbZ/oksYqg==
X-Received: by 2002:a19:7411:: with SMTP id v17-v6mr2669150lfe.49.1536783521098;
        Wed, 12 Sep 2018 13:18:41 -0700 (PDT)
Received: from [192.168.1.18] (bgu158.neoplus.adsl.tpnet.pl. [83.28.84.158])
        by smtp.gmail.com with ESMTPSA id u191-v6sm336759lja.13.2018.09.12.13.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 13:18:40 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux> <20180910211935.GA4697@amd>
 <dd1f8dd2-d577-ab12-e67a-7ed71459055a@gmail.com> <20180912191820.GA27704@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a82e3d9c-1df8-9e73-7371-613ad550693d@gmail.com>
Date:   Wed, 12 Sep 2018 22:18:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912191820.GA27704@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 09:18 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>> [..]
>>>>> +What:		/sys/class/leds/<led>/hw_pattern
>>>>> +Date:		September 2018
>>>>> +KernelVersion:	4.20
>>>>> +Description:
>>>>> +		Specify a hardware pattern for the LED, for LED hardware that
>>>>> +		supports autonomously controlling brightness over time, according
>>>>> +		to some preprogrammed hardware patterns.
>>>>> +
>>>>> +		Since different LED hardware can have different semantics of
>>>>> +		hardware patterns, each driver is expected to provide its own
>>>>> +		description for the hardware patterns in their ABI documentation
>>>>> +		file.
>>>>> +
>>>>
>>>> So, after a full circle we're back at drivers with support for hardware
>>>> patterns should have their own ABI for setting that pattern.
>>>>
>>>> The controls for my hardware is:
>>>> * a list of brightness values
>>>> * the rate of the pattern
>>>> * a flag to indicate that the pattern should be played from start
>>>>   to end, end to start or start to end to start
>>>> * a boolean indicating if the pattern should be played once or repeated
>>>>   indefinitely.
>>>
>>> No, we are not back to full circle.
>>>
>>> Or at least we should not be.
>>>
>>> Yes, hw_pattern can have some limitation pattern does not, but if you
>>> take values from hw_pattern file and put them into pattern file, you
>>> should get the same pattern (with more power being consumed). And that
>>> property is kind of important for me, because it should keep the ABI
>>> reasonable.
>>
>> If you looked at what we agreed on with Baolin, you'd realize
>> that this property is in no way preserved.
>> This is what the whole story is about - we're introducing hw_pattern
>> because of difficulties in describing breathing pattern by a series
>> of [brightness delta_t] tuples.
>>
>> And Bjorn presented another example. I'm inclined to leave the
>> definition of hw_pattern semantics to the LED class drivers,
>> and allow them to create related sysfs files.
> 
> Please lets not do that.
> 
> We already have drivers that do that and it is complete
> nightmare. Some take binary code for the tiny CPU driving the LED.
> 
> What exactly is the problem? [brightness delta_t] can describe

You wrote:

<quote>
Yes, hw_pattern can have some limitation pattern does not, but if you
take values from hw_pattern file and put them into pattern file, you
should get the same pattern (with more power being consumed).
</quote>

The problem is that we decided to introduce hw_pattern to
to take away from drivers a responsibility for translating
a series of tuples, approximating the brightness curve,
to the values that can be written to the hardware registers.

Because this is what would need to be done to check if hw can support
given series of tuples and activate it. Actually with this approach
we wouldn't need hw_pattern at all, since pattern alone would do.
But implementation thereof is what we could call a nightmare.

What follows, your claim from the quotation is inaccurate:
values from hw_pattern written to the pattern file will not
produce the same pattern, at least in case of what was proposed
in [0] for drivers/leds/leds-sc27xx-bltc.c.

> anything single LED can do in finite time. You are right, that
> [brightness delta_t] sequence may get rather long, and it may be hard
> to turn that sequence into parameters. Are there any _interesting_
> sequences hardware can do but [brightness delta_t] can not store
> reasonably?

Please propose the implementation of pattern_set for
drivers/leds/leds-sc27xx-bltc.c breathing pattern, that will
setup breathing mode basing on the values from tuples.

Use Baolin's patch [0] for a reference of what hardware expects.

[0] https://lore.kernel.org/patchwork/patch/984246/

-- 
Best regards,
Jacek Anaszewski
