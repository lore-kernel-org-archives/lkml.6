Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0FF2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="BtS6iqp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0FF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeGRWxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:53:42 -0400
Received: from vern.gendns.com ([206.190.152.46]:50178 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbeGRWxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t7TOdW9/9RnDn+X8C4kXOUgmadIzrPP1j6MNZAqDCGA=; b=BtS6iqp+ZYzKdjlTuQlDuyz48l
        SPjYunX0WzbBG3c1HDOu68GlirBw+WFX2hvwgbrgRhJOiKALsl4xsTW6FPAfmzww1S0eGKsBPftD2
        JqPdzTk9OmYk9Ubxt8p4GJkxH5QOokS1LD+m4qNYj6nZ7dGws57rtMttpuubQWrKZbPyTUTDkxy+4
        vyHAAX9tzrNmOLjrQozrEyU1uDgy4OalLNLdeHXU/ypYX5oeY7Y3y1uwbkmORsvZZUkVbFYfFZ8KM
        GIDmi2ZyMSUwpBLOuDCBBUiUp/5A+kqMv0C05cnrkPcs/JGKjCbJjWVIhUU0yUr9q8/uYzBSqcIEP
        TZjUtiAg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58658 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffuha-000tTb-JV; Wed, 18 Jul 2018 18:13:42 -0400
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
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
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
 <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
 <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <ffc9cf0e-7159-e91b-477e-253246210200@lechnology.com>
Date:   Wed, 18 Jul 2018 17:13:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 02:22 PM, Jacek Anaszewski wrote:
> On 07/18/2018 08:54 PM, Jacek Anaszewski wrote:
>> On 07/18/2018 09:56 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>>>> I believe I meant "changing patterns from kernel in response to events
>>>>>>>> is probably overkill"... or something like that.
>>>>>>>
>>>>>>> Anyway -- to clean up the confusion -- I'd like to see
>>>>>>>
>>>>>>> echo pattern > trigger
>>>>>>> echo "1 2 3 4 5 6 7 8" > somewhere
>>>>>>
>>>>>> s/somewhere/pattern/
>>>>>>
>>>>>> pattern trigger should create "pattern" file similarly how ledtrig-timer
>>>>>> creates delay_{on|off} files.
>>>
>>> Yes, that sounds reasonable. v5 still says
>>>
>>> +               Writing non-empty string to this file will activate the pattern,
>>> +               and empty string will disable the pattern.
>>>
>>> I'd deactivate the pattern by simply writing something else to the
>>> trigger file.
>>
>> Please keep in mind that this is ABI documentation for the pattern file
>> to be exposed by LED core, and not by the pattern trigger, that, as we
>> agreed, will be implemented later. In this case, I'd go for
> 
> Gosh, I got completely distracted by the recent discussion about
> pattern synchronization.
> 
> So, to recap, we need to decide if we are taking Baolin's solution
> or we're opting for implementing pattern trigger.

I think we should take Baolin's solution.

> 
> If we choose the latter, then we will also need some software
> pattern engine in the trigger, to be applied as a software pattern
> fallback for the devices without hardware pattern support.
> It will certainly delay the contribution process, provided that Baolin
> would find time for this work at all.
> 
> I'd just take v5 based solution for now (with improved semantics
> of disabling pattern - in this case my reasoning from the message
> I'm replying to is still valid),
> 
>> "echo 0 > brightness" as a command disabling pattern. The same operation
>> disables triggers, so later transition to using pattern trigger will be
>> seamless for userspace.
>>
> 

