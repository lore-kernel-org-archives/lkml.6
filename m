Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6ACECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9172075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="dceWzxFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9172075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeGRRjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:39:20 -0400
Received: from vern.gendns.com ([206.190.152.46]:33190 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbeGRRjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YHjDNlsVbe6JNpYaQiJe/WFVun4CxzUUcKZ1SgFh42I=; b=dceWzxFtUWq+w40fUr6JS0T815
        gmbcUuxhzCp0I1wqi5T8aaVXSJza5MyXtZdxs0rby1OwUg7xtoaNZPoACed5JlaGqeryakDIWoQBM
        n6FhclrUSctU3NIw4mF7MCk9SvI98ZSbeKXQupv32YmTJNmDOyE1SLblW4Pr2/XWDBTb+hetAF7Sr
        pyU1xkNyX5or2lATd2J/MzAxyZ0NKrssCLsht0+R9J4ZehXrgE5NXAVMKR0fj1oUXO1Oaf73b3kjS
        nupxwNNct/A5XLunBuuoNYSJhztIs10ls8vxuU2QkS0uf05wT6DWhqNUhKvbxXOkpFj8+x+Fx0uMD
        bUAN289Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:56336 helo=gerda.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffpoU-000Az7-Fd; Wed, 18 Jul 2018 13:00:30 -0400
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>, Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
 <CAMz4kuJa=s19q7wQFQT1giUe0AN4hpux4PG2koUcnE7q_x7LCQ@mail.gmail.com>
 <20180718120836.GB23157@amd>
From:   David Lechner <david@lechnology.com>
Message-ID: <47b1b143-48dd-a265-c2af-254dda53a2cc@lechnology.com>
Date:   Wed, 18 Jul 2018 12:00:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718120836.GB23157@amd>
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



On 7/18/18 7:08 AM, Pavel Machek wrote:
> On Wed 2018-07-18 19:32:01, Baolin Wang wrote:
>> On 18 July 2018 at 15:56, Pavel Machek <pavel@ucw.cz> wrote:
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
>>> +               Writing non-empty string to this file will activate the pattern,
>>> +               and empty string will disable the pattern.
>>>
>>> I'd deactivate the pattern by simply writing something else to the
>>> trigger file.
>>
>> For the case we met in patch 2, it is not related with trigger things.
>> We just set some series of tuples including brightness and duration
>> (ms) to the hardware to enable the breath mode of the LED, we did not
>> trigger anything. So it is weird to write something to trigger file to
>> deactive the pattern.
> 
> Confused. I thought that "breathing mode" would be handled similar way
> to hardware blinking: userland selects pattern trigger, pattern file
> appears (similar way to delay_on/delay_off files with blinking), he
> configures it, hardware brightness follows the pattern ("breathing
> mode"). If pattern is no longer required, echo none > trigger stops
> it.
> 									Pavel
> 

I was confused too when I first read this thread. But after reviewing 
v5, it is clear that this is _not_ a trigger (and it should not be a 
trigger). This is basically the equivalent the brightness attribute - 
except that now the brightness changes over time instead of being a 
constant value. This way, the pattern can be used in conjunction with 
triggers.

For example, one might want to set the _pattern_ to something like a 
"breathe" pattern and set the _trigger_ to the power supply charging 
full trigger. This way, the LED will be off until the battery is full 
and then the LED will "breath" when the battery is full.
