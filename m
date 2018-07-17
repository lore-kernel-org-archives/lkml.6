Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FDAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E55A206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/dE7+oC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E55A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGQVAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:00:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39606 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:00:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so604835wmb.4;
        Tue, 17 Jul 2018 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dfz12B/0sV93KkvPkc5Pc15V+Pd0JJk9kWVxaXhvu34=;
        b=J/dE7+oCXT69qkkmccM85GH5gtUyQsNMVaTlT1lAe0Ztho+GIXDOLi9Z9nxuby0MiS
         yspfR88JlQDL47qG6ESvH0CjpibXMx/Q1OJI6UC8apkNxqZH6k20JjzllmWxUVvIMmjI
         f6VQe39pnHhjIVyyKJBkNi1SzJWZye2ZLcoFKAxlXO/+w8MnHsJBfD+GdIO3wjZ+5Z65
         UxK70i+YcC0MYkVcvhzPQysuvwsL4PjBMw3rcBSJOloHK1ntqUx4Gna0Y1ElYp8Qs62L
         YtU6mRM7DscPayumHHete7saofAaIKv0ml8yAY3WhKGSgHpOYaramYpVe0MRPfHr+oKK
         PTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dfz12B/0sV93KkvPkc5Pc15V+Pd0JJk9kWVxaXhvu34=;
        b=rGAy0OFjq89jP0PIrmBgJRJu4C6ezKCg8JdJxngUtWrFfwl+taTWEVfBL3Zscnuoh2
         KTjL21XQa6Fx9875IHnk5JpvDg2OB1W1Q4/cODR9t8qcSAnUOA+m7W3gfCthFzmhaZqg
         CYecmwy8PGfCodO7XaSdid3ql+TnQIIy2/euVljuk4yBm+yLrbQPLju8gPuGq03LAYsN
         HoLZcfgEjBIZWXimue+ibHOgWEL6LO//11zFZZEWwK7oIYqV0lSW6ty5RyfYjpNKXYQe
         UAoJ/6Q6iG53qWsAa1VHBu/9VKmBBnK6FhiaSmzPzQCY9tp/fCvnEx/D1NpzYIhllHRQ
         tuFg==
X-Gm-Message-State: AOUpUlFUuhpnrK3GM/qoCfuLKCXmUUQVQtDvSopAtcUOOBvg9bZ5TEQ4
        mBQVYu1WB9wVur8/pZDv5RpQVwx1
X-Google-Smtp-Source: AAOMgpeFdYp9USu8f1+NLcv0Eh3olFyDK1cLlLnD8yoBlc/iSI7xVnn/PTenwZmOb90qo9wm9Tl/lQ==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr2103553wme.15.1531859171626;
        Tue, 17 Jul 2018 13:26:11 -0700 (PDT)
Received: from [192.168.1.18] (dkn38.neoplus.adsl.tpnet.pl. [83.24.17.38])
        by smtp.gmail.com with ESMTPSA id x19-v6sm896371wrd.32.2018.07.17.13.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:26:10 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180716215616.GB10734@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8c07a016-d77d-4799-b005-6a9ea94954ce@gmail.com>
Date:   Tue, 17 Jul 2018 22:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180716215616.GB10734@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 11:56 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> echo pattern > trigger
>>>>> echo "1 2 3 4 5 6 7 8" > somewhere
>>>>
>>>> s/somewhere/pattern/
>>>>
>>>> pattern trigger should create "pattern" file similarly how ledtrig-timer
>>>> creates delay_{on|off} files.
>>>>
>>>
>>> I don't think this is the best way. For example, if you want more than one
>>> LED to have the same pattern, then the patterns will not be synchronized
>>> between the LEDs. The same things happens now with many of the existing
>>> triggers. For example, if I have two LEDs side-by-side using the heartbeat
>>> trigger, they may blink at the same time or they may not, which is not
>>> very nice. I think we can make something better.
> 
> Yes, synchronization would be nice -- it is really a must for RGB LEDs
> -- but I believe it is too much to ask from Baolin at the moment.
> 
>> It is virtually impossible to enforce synchronous blinking for the
>> LEDs driven by different hardware due to:
>>
>> - different hardware means via which brightness is set (MMIO, I2C, SPI,
>>    PWM and other pulsed fashion based protocols),
>> - the need for deferring brightness setting to a workqueue task to
>>    allow for setting LED brightness from atomic context,
>> - contention on locks
> 
> I disagree here. Yes, it would be hard to synchronize blinking down to
> microseconds, but it would be easy to get synchronization right down
> to miliseconds and humans will not be able to tell the difference.

There have been problems with blink interval stability close to
1ms, and thus there were some attempts of employing hr timers,
which in turn introduced a new class of issues related to
system performance etc.

>> For the LEDs driven by the same chip it would make more sense
>> to allow for synchronization, but it can be achieved on driver
>> level, with help of some subsystem level interface to indicate
>> which LEDs should be synchronized.
>>
>> However, when we start to pretend that we can synchronize the
>> devices, we must answer how accurate we can be. The accuracy
>> will decrease as blink frequency rises. We'd need to define
>> reliability limit.
> 
> We don't need _that_ ammount of overengineering. We just need to
> synchronize them well enough :-).

Well, it would be disappointing for the users to realize that
they don't get the effect advertised by the ABI documentation.

>> We've had few attempts of approaching the subject of synchronized
>> blinking but none of them proved to be good enough to be merged.
> 
> I'm sure interested person could do something like that in less than
> two weeks fulltime... It is not rocket science, just a lot of work in
> kernel...
> 
> But patterns are few years overdue and I believe we should not delay
> them any further.
> 
> So... I guess I agree with Jacek in the end :-).

How about taking Baolin's patches as of v5? Later, provided that
the pattern trigger yet to be implemented will create pattern file
on activation, we'll need to initialize default-trigger DT property,
to keep the interface unchanged.

-- 
Best regards,
Jacek Anaszewski
