Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0BDECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6820F2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f0AtiPI9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ouAE8hmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6820F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeIRPZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:25:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeIRPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:25:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D3AC60866; Tue, 18 Sep 2018 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537264437;
        bh=5/qk4oFNAb8MuZ1rw9AitjS5V48qdgMQxreBQirXhnU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f0AtiPI9ju77rFRTTL1bExfq1/3c1PO2LYGv+0AXJyGeJMO5HAoIZ5rDiwjRubhdr
         VMJJrHZ5Iu1tv1Z6Dh4F4NhSu0TQgUAm8tqS7PL5WkkZZ29QsET/9LRnSAcd2qSRZW
         7fbaDxDM4xxfa9e8M09ZyOdBDiKAt0pHUGaWf4iM=
Received: from [10.79.129.80] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9D72602F1;
        Tue, 18 Sep 2018 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537264436;
        bh=5/qk4oFNAb8MuZ1rw9AitjS5V48qdgMQxreBQirXhnU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ouAE8hmgiMZl6SuX4/gAzE/PmFFju5saWpfYi7xAch02V/E4yQ5j69bq6wz7MblMr
         6szhrCu3Sh1uOyWcdYFmLRXFORb1jKpVEXu61QYQWxcWY7t1juW0b6tRHR6D/xstNs
         i3qaEUO1euRYrsdqqnWZODvVarbZgHAm+uEv4oPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9D72602F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20180917213304.44476-1-mka@chromium.org>
 <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
 <ebea1697-cf33-675b-172c-3e80303a9ee9@codeaurora.org>
 <20180918072037.GA4442@kroah.com>
 <ccc91067-9718-8eb8-c197-b9c560daa5ce@codeaurora.org>
 <20180918091702.GA10846@kroah.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <2e5ca973-ea52-5d6f-2f78-294c7be577bd@codeaurora.org>
Date:   Tue, 18 Sep 2018 15:23:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918091702.GA10846@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 2:47 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 02:35:02PM +0530, Sai Prakash Ranjan wrote:
>> On 9/18/2018 12:50 PM, Greg Kroah-Hartman wrote:
>>> On Tue, Sep 18, 2018 at 12:28:39PM +0530, Sai Prakash Ranjan wrote:
>>>> On 9/18/2018 11:41 AM, Jiri Slaby wrote:
>>>>> On 09/17/2018, 11:33 PM, Matthias Kaehlcke wrote:
>>>>>> sysrq_handle_crash() dereferences a NULL pointer on purpose to force
>>>>>> an exception, the local variable 'killer' is assigned to NULL and
>>>>>> dereferenced later. Clang detects the NULL pointer dereference at compile
>>>>>> time and emits a BRK instruction (on arm64) instead of the expected NULL
>>>>>> pointer exception. Change 'killer' to a global variable (and rename it
>>>>>> to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
>>>>>> detecting the condition. By default global variables are initialized
>>>>>> with zero/NULL in C, therefore an explicit initialization is not needed.
>>>>>>
>>>>>> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>>>> Suggested-by: Evan Green <evgreen@chromium.org>
>>>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>>>> ---
>>>>>>     drivers/tty/sysrq.c | 6 +++---
>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>>>>>> index 06ed20dd01ba..49fa8e758690 100644
>>>>>> --- a/drivers/tty/sysrq.c
>>>>>> +++ b/drivers/tty/sysrq.c
>>>>>> @@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
>>>>>>     #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
>>>>>>     #endif /* CONFIG_VT */
>>>>>> +char *sysrq_killer;
>>>>>> +
>>>>>>     static void sysrq_handle_crash(int key)
>>>>>>     {
>>>>>> -	char *killer = NULL;
>>>>>> -
>>>>>>     	/* we need to release the RCU read lock here,
>>>>>>     	 * otherwise we get an annoying
>>>>>>     	 * 'BUG: sleeping function called from invalid context'
>>>>>> @@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
>>>>>>     	rcu_read_unlock();
>>>>>>     	panic_on_oops = 1;	/* force panic */
>>>>>>     	wmb();
>>>>>> -	*killer = 1;
>>>>>> +	*sysrq_killer = 1;
>>>>>
>>>>> Just because a static analyzer is wrong? Oh wait, even compiler is
>>>>> wrong. At least make it a static global. Or what about OPTIMIZER_HIDE_VAR?
>>>>>
>>>>
>>>> static global does not work, clang still inserts brk. As for
>>>> OPTIMIZE_HIDE_VAR, it seems to work.
>>>> But, I dont think it is defined for clang in which case it defaults to using
>>>> barrier(). There is already one wmb(), so will it be right?
>>>
>>> Ick, why is this needed at all?  Why are we trying to "roll our own
>>> panic" in this code?
>>>
>>
>> Hi Greg, do you mean like why there is a killer var at all or why this
>> change is required?
> 
> I understand you are using a compiler that thinks it wants to protect
> yourself from your code and tries to "fix" it for you.  That's fine, and
> is up to the compiler writers (personally that seems not a good idea.)
> 
> My question is why we just don't call panic() here instead of trying to
> duplicate the logic of that function here.  Why is that happening?
> 

It seems fine to call panic() here. Dont no why they chose to have a 
null pointer dereference.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
