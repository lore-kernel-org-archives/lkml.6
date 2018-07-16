Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A677ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FC020850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg4/FgSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FC020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeGPU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:58:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45633 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:58:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so20504583wrs.12;
        Mon, 16 Jul 2018 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u3BvmQQOYwE7NHk4EGSQAgQg3V8kx8y7ZGKXlL72nnM=;
        b=Hg4/FgSHKqcxhgc4aDDM6gzm3sx2+uPiSaEpy2LOc+MK9bnwZNxXy7at4GtT+px3wi
         RIAFWnjFSRid+11r+q6M0nlM/A9zmCD3u0njC6e9DpruJCBql8y173WsH6Fch09WpcjY
         TpbvBQsR87PJluxV8rGpy92iVyITXT9aGs4xHzFl0QrZlCclchzJF/dZ8L9SCnda04uN
         N50C9c5lZ78IKoGBKJpyeRmTtryVYVSAp9HOvW4R3BGc6SSMrWISZVbZVuGqVkIbz2xe
         fYFW+QfHY8nmBcXe29ODs9zhe1w1CKXYlO5nxAavBSTsUoYpse+Jgjjx3tm7jX9Rn2YH
         OSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u3BvmQQOYwE7NHk4EGSQAgQg3V8kx8y7ZGKXlL72nnM=;
        b=J0u90nGvQNnPs3FuvuffWKC3zBExjXQTQeaaV94cc6LIRSk/Re5mNml3UYAz5unLas
         ZMCnPnJlHZshl6pdnZ1dfAdATjFdYckPluZb6K37iZ0zff111k8MpPod7KYiNIvOlMSZ
         p+Kp7T5fVLF5fIw+2UB8Q7kEIIvRSR8+OakzHXoMNwzpBiiFeLNS3ru2D2l/ItJm+vKG
         dLr4cF1eh1TkgC4Oi5dRWBawSqdQEHQAiLmRo7C1m1J8Dh0I7OX+P8wUmM9m5B+KNkvL
         hhBLbdrEx+DkcXUoaWvcwaM+ezoVa8VVquP0ZsnxeyjDXuIPM4+wuakDr6vSRbFW6Tbt
         Q4KA==
X-Gm-Message-State: AOUpUlFeY5vEh0GMLgfKhpwPDRNR42Ni6lK4gvBrRTARZTkgzb02QrRs
        tsqq3LSsrtgPIrAKHaAS4jvlbs4v
X-Google-Smtp-Source: AAOMgpdwPCdJhfkTHesFGKNeJ7WEnf1o5J1i29Wzz/s5Q78VD6wqNoSw2p6cNKTYpIDbwpeanMMVBQ==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr13580696wrg.183.1531772954984;
        Mon, 16 Jul 2018 13:29:14 -0700 (PDT)
Received: from [192.168.1.18] (ckk14.neoplus.adsl.tpnet.pl. [83.31.86.14])
        by smtp.gmail.com with ESMTPSA id 73-v6sm7845555wmo.21.2018.07.16.13.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 13:29:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
Date:   Mon, 16 Jul 2018 22:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 07/16/2018 03:00 AM, David Lechner wrote:
> On 07/15/2018 07:22 AM, Jacek Anaszewski wrote:
>> On 07/15/2018 12:39 AM, Pavel Machek wrote:
>>> On Sun 2018-07-15 00:29:25, Pavel Machek wrote:
>>>> On Sun 2018-07-15 00:02:57, Jacek Anaszewski wrote:
>>>>> Hi Pavel,
>>>>>
>>>>> On 07/14/2018 11:20 PM, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>>> It also drew my attention to the issue of desired pattern sysfs
>>>>>>>> interface semantics on uninitialized pattern. In your 
>>>>>>>> implementation
>>>>>>>> user seems to be unable to determine if the pattern is activated
>>>>>>>> or not. We should define the semantics for this use case and
>>>>>>>> describe it in the documentation. Possibly pattern could
>>>>>>>> return alone new line character then.
>>>>>>
>>>>>> Let me take a step back: we have triggers.. like LED blinking.
>>>>>>
>>>>>> How is that going to interact with patterns? We probably want the
>>>>>> patterns to be ignored in that case...?
>>>>>>
>>>>>> Which suggest to me that we should treat patterns as a trigger. I
>>>>>> believe we do something similar with blinking already.
>>>>>>
>>>>>> Then it is easy to determine if pattern is active, and pattern
>>>>>> vs. trigger issue is solved automatically.
>>>>>
>>>>> I'm all for it. I proposed this approach during the previous
>>>>> discussions related to possible pattern interface implementations,
>>>>> but you seemed not to be so enthusiastic in [0].
>>>>>
>>>>> [0] https://lkml.org/lkml/2017/4/7/350
>>>>
>>>> Hmm. Reading my own email now, I can't decipher it.
>>>>
>>>> I believe I meant "changing patterns from kernel in response to events
>>>> is probably overkill"... or something like that.
>>>
>>> Anyway -- to clean up the confusion -- I'd like to see
>>>
>>> echo pattern > trigger
>>> echo "1 2 3 4 5 6 7 8" > somewhere
>>
>> s/somewhere/pattern/
>>
>> pattern trigger should create "pattern" file similarly how ledtrig-timer
>> creates delay_{on|off} files.
>>
> 
> I don't think this is the best way. For example, if you want more than one
> LED to have the same pattern, then the patterns will not be synchronized
> between the LEDs. The same things happens now with many of the existing
> triggers. For example, if I have two LEDs side-by-side using the heartbeat
> trigger, they may blink at the same time or they may not, which is not
> very nice. I think we can make something better.

It is virtually impossible to enforce synchronous blinking for the
LEDs driven by different hardware due to:

- different hardware means via which brightness is set (MMIO, I2C, SPI,
   PWM and other pulsed fashion based protocols),
- the need for deferring brightness setting to a workqueue task to
   allow for setting LED brightness from atomic context,
- contention on locks

For the LEDs driven by the same chip it would make more sense
to allow for synchronization, but it can be achieved on driver
level, with help of some subsystem level interface to indicate
which LEDs should be synchronized.

However, when we start to pretend that we can synchronize the
devices, we must answer how accurate we can be. The accuracy
will decrease as blink frequency rises. We'd need to define
reliability limit.

For different devices, this limit will be different, and it will also
depend on the CPU speed.

We've had few attempts of approaching the subject of synchronized
blinking but none of them proved to be good enough to be merged.

Frankly speaking I doubt it is good task for the system like Linux.

> Perhaps a way to do this would be to use configfs to create a pattern
> trigger that can be shared by multiple LEDs. Like this:
> 
>      mkdir /sys/kernel/config/leds/triggers/my-nice-pattern
>      echo "1 2 3 4" > 
> /sys/kernel/config/leds/triggers/my-nice-pattern/pattern
>      echo my-nice-pattern > /sys/class/leds/led0/trigger
>      echo my-nice-pattern > /sys/class/leds/led1/trigger
> 
> 
> Please CC me on any future revisions of this series. I would like to 
> test it.
> 

-- 
Best regards,
Jacek Anaszewski
