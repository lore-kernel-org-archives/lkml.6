Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009CECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 04:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FF320869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 04:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZLOgo8UI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jBBbS2Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FF320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeJUNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 09:12:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeJUNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 09:12:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E459B60C1B; Sun, 21 Oct 2018 04:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540097973;
        bh=ov1MMhPy5NbWb10AaaVYkL/Ob5SQoAGhu6LDuUBKjRU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=ZLOgo8UIFsO2oMpv7n/F4PPjmm+h3WdLz0GGImZc6GMbB1t8tzfUD7I+H29lGOiwB
         ftoXJJYysUowK9KC3I0rUcxgIfAMonNlycu6gTFvtNXaeaM38YsKj8+FHgsQPAr5Z1
         SeJOk0tvjN94Esdiy+oWZe3KMvcz1loaq1s9MC4A=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8865C60159;
        Sun, 21 Oct 2018 04:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540097972;
        bh=ov1MMhPy5NbWb10AaaVYkL/Ob5SQoAGhu6LDuUBKjRU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=jBBbS2VuX5SJaFDkq/5qru+/TEhmeYuKRD6gIGrlJuDZT6mxX5z3DRLV3dmrxea5J
         xxGOZbIEoaaZqv6NgkffOr35mRBAFCKmu9PB6Aut2zkxuf3vgkk3S6Esd/uZ7cpRM1
         kShqqZ31sB/fCPbW5V9ofCrCe3ODFeFBh0fgiUs8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8865C60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>, tsoni@codeaurora.org,
        Anton Vorontsov <anton@enomsg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>, devicetree@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Cross <ccross@android.com>,
        Joe Perches <joe@perches.com>, tkjos@google.com
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20181020052535.GA155509@joelaf.mtv.corp.google.com>
 <1d3ddbe3-d3ac-aa3e-fc9e-36739ddd0c91@codeaurora.org>
 <20181020162719.GA49955@joelaf.mtv.corp.google.com>
 <15ec736d-bd54-5519-4b99-47dd161bc556@codeaurora.org>
Message-ID: <92075d3d-1ea9-d746-384a-1b61ceefcb70@codeaurora.org>
Date:   Sun, 21 Oct 2018 10:29:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15ec736d-bd54-5519-4b99-47dd161bc556@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2018 9:16 AM, Sai Prakash Ranjan wrote:
> On 10/20/2018 9:57 PM, Joel Fernandes wrote:
>> On Sat, Oct 20, 2018 at 12:02:37PM +0530, Sai Prakash Ranjan wrote:
>>> On 10/20/2018 10:55 AM, Joel Fernandes wrote:
>>>> On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
>>>>> Hi,
>>>>>
>>>>> This patch series adds Event tracing support to pstore and is 
>>>>> continuation
>>>>> to the RFC patch introduced to add a new tracing facility for register
>>>>> accesses called Register Trace Buffer(RTB). Since we decided to not 
>>>>> introduce
>>>>> a separate framework to trace register accesses and use existing 
>>>>> framework
>>>>> like tracepoints, I have moved from RFC. Details of the RFC in link 
>>>>> below:
>>>>>
>>>>> Link: 
>>>>> https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/ 
>>>>>
>>>>>
>>>>> MSR tracing example given by Steven was helpful in using 
>>>>> tracepoints for
>>>>> register accesses instead of using separate trace. But just having 
>>>>> these
>>>>> IO traces would not help much unless we could have them in some 
>>>>> persistent
>>>>> ram buffer for debugging unclocked access or some kind of bus hang 
>>>>> or an
>>>>> unexpected reset caused by some buggy driver which happens a lot 
>>>>> during
>>>>> initial development stages. By analyzing the last few entries of 
>>>>> this buffer,
>>>>> we could identify the register access which is causing the issue.
>>>>
>>>> Hi Sai,
>>>>
>>>> I wanted to see if I could make some time to get your patches 
>>>> working. We are
>>>> hitting usecases that need something like this as well. Basically 
>>>> devices
>>>> hanging and then the ramdump does not tell us much, so in this case 
>>>> pstore
>>>> events can be really helpful. This usecase came up last year as well.
>>>>
>>>> Anyway while I was going through your patches, I cleaned up some 
>>>> pstore code
>>>> as well and I have 3 more patches on top of yours for this clean up. 
>>>> I prefer
>>>> we submit the patches together and sync our work together so that 
>>>> there is
>>>> least conflict.
>>>>
>>>> Here's my latest tree:
>>>> https://github.com/joelagnel/linux-kernel/commits/pstore-events
>>>> (note that I have only build tested the patches since I just wrote 
>>>> them and
>>>> its quite late in the night here ;-))
>>>>
>>>
>>> Hi Joel,
>>>
>>> Thanks for looking into this. Sure, I will be happy to sync up with 
>>> you on
>>
>> Thanks. And added a fourth patch in the tree too.
>>
>>> this. I can test your additional patches on top of my pstore patches. 
>>> BTW,
>>> I'm still stuck at copying binary record into pstore and then extract it
>>> during read time. Seems like I'm missing something.
>>
>> Sure, push your latest somewhere and let me know. I'll try to get you 
>> unstuck.
>>
> 
> Thanks Joel, I will push my changes and let you know in some time.
> 

Hi Joel,

Here's my tree:
https://github.com/saiprakash-ranjan/linux/commits/pstore-events

I have one patch extra on top of your patches. Nothing much on binary 
record storage in this patch, only removed kmalloc in pstore event call 
to avoid loop.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
