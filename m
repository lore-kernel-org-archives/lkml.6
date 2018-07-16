Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063BECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA16720835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="j2m4Y7QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA16720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeGPBZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:25:28 -0400
Received: from vern.gendns.com ([206.190.152.46]:57050 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeGPBZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i22EtgCQg1kRVzrTUJhc8QySf+WZecLqFEQPnGYJkLI=; b=j2m4Y7QPdlfP0TTUpJUj5ZKCXI
        v1HDOPSfvl8CDuIBhyIk3U5kdEBB9uzYjqy/7JNVCNPr6gSN5SWvFBjhPDAg0XzKexvuVXet777iE
        Gy8fPcFGSaQXgD8/sBenJaa1s387mKG1GX9kdWUOGv4wL/zDk8TV+wm1e0fOHVP2p8JqsjwyMqzmN
        Gm5+74+gAWlu3dEUp0JlikhBYfKBCKLtEKRZES0jWfIsjWfVGjU2B2su78S9/J4LmuWY1MUQMKPcT
        GgRBCg4iwi2mT8/FFcGTVCwnkpZqc0R4fMpfsZdw6Rzrnve6jlMhmbxXDljEOEU9HlxSUCl1t7Ly3
        zbM+YGLA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59146 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fersP-009U3A-IF; Sun, 15 Jul 2018 21:00:33 -0400
Subject: Re: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern
 interface
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
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
From:   David Lechner <david@lechnology.com>
Message-ID: <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
Date:   Sun, 15 Jul 2018 20:00:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 07/15/2018 07:22 AM, Jacek Anaszewski wrote:
> On 07/15/2018 12:39 AM, Pavel Machek wrote:
>> On Sun 2018-07-15 00:29:25, Pavel Machek wrote:
>>> On Sun 2018-07-15 00:02:57, Jacek Anaszewski wrote:
>>>> Hi Pavel,
>>>>
>>>> On 07/14/2018 11:20 PM, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>>> It also drew my attention to the issue of desired pattern sysfs
>>>>>>> interface semantics on uninitialized pattern. In your implementation
>>>>>>> user seems to be unable to determine if the pattern is activated
>>>>>>> or not. We should define the semantics for this use case and
>>>>>>> describe it in the documentation. Possibly pattern could
>>>>>>> return alone new line character then.
>>>>>
>>>>> Let me take a step back: we have triggers.. like LED blinking.
>>>>>
>>>>> How is that going to interact with patterns? We probably want the
>>>>> patterns to be ignored in that case...?
>>>>>
>>>>> Which suggest to me that we should treat patterns as a trigger. I
>>>>> believe we do something similar with blinking already.
>>>>>
>>>>> Then it is easy to determine if pattern is active, and pattern
>>>>> vs. trigger issue is solved automatically.
>>>>
>>>> I'm all for it. I proposed this approach during the previous
>>>> discussions related to possible pattern interface implementations,
>>>> but you seemed not to be so enthusiastic in [0].
>>>>
>>>> [0] https://lkml.org/lkml/2017/4/7/350
>>>
>>> Hmm. Reading my own email now, I can't decipher it.
>>>
>>> I believe I meant "changing patterns from kernel in response to events
>>> is probably overkill"... or something like that.
>>
>> Anyway -- to clean up the confusion -- I'd like to see
>>
>> echo pattern > trigger
>> echo "1 2 3 4 5 6 7 8" > somewhere
> 
> s/somewhere/pattern/
> 
> pattern trigger should create "pattern" file similarly how ledtrig-timer
> creates delay_{on|off} files.
> 

I don't think this is the best way. For example, if you want more than one
LED to have the same pattern, then the patterns will not be synchronized
between the LEDs. The same things happens now with many of the existing
triggers. For example, if I have two LEDs side-by-side using the heartbeat
trigger, they may blink at the same time or they may not, which is not
very nice. I think we can make something better.

Perhaps a way to do this would be to use configfs to create a pattern
trigger that can be shared by multiple LEDs. Like this:

     mkdir /sys/kernel/config/leds/triggers/my-nice-pattern
     echo "1 2 3 4" > /sys/kernel/config/leds/triggers/my-nice-pattern/pattern
     echo my-nice-pattern > /sys/class/leds/led0/trigger
     echo my-nice-pattern > /sys/class/leds/led1/trigger


Please CC me on any future revisions of this series. I would like to test it.
