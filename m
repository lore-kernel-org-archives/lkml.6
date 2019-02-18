Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFDB21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQF92uXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfBRTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:22:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBRTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:22:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so9047155pfa.6;
        Mon, 18 Feb 2019 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yp8xTP7a7/GsDd05ZL5jWnO7oKWOAPuXmNzaA5yfjx4=;
        b=NQF92uXx/Aa9V2wh8L+Z9z3Os6cpDxgKGnK9Gi+AjOfZ4tM/CnY7mm2zkk2HjalBh7
         rLu+95FwmCmACx+b7+3O7YIOAOzH8KUhMtjsZ0EqxUWDDBN6WWV/bhSaFuTnXfmZKktm
         GpXihFxAWkYVeEohaUauclCSpw0wZ28sX5v2MfXGu5naeRidMv59Xe6sPcxNg3w9MBu1
         YEQ8cJ1MrbgDwn5B36DD5SaifsFViCU90f5RLHFtzoN9pCB/RPPLMo1FF3/Nn1p3BZoP
         6bGEaSHubbtjNPkSFMWYt5QxRsyUcZFNE1B/1aYzzimOz58GRP4GR+XqPxwHJ0NCLQKN
         p9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yp8xTP7a7/GsDd05ZL5jWnO7oKWOAPuXmNzaA5yfjx4=;
        b=uin/vqTuPuuAFNtIYuOY7DAsbSEKRt1j8KC5oJurBf7Vgc9FeQCpyEiE8WRizns3cG
         iIOXK6uB7tg2oTR5uOxngldt1i39XZMciTKHNOTRsY/od4qDgGyoqXlceYmpVQWt3Dxh
         0RQfCnaUgvU/nZgBxyWK5uSYBmIPWCeFaauBm6n9sm2bfdl38hEZUPw/AZYZfMYGQ2Ah
         P0KrlgTpNVWQQAvIuddN5dV2DCIFuVBwIx2nqtsZ/FFH+SzrOt2LOuDIH4XrLu2CBE7M
         LLmtqP3p2gYpoK3+KqutiVqiAzyqvTvdIwgwLWWPIXYm5Y+EPTWzru+cPrVnVsWXWFyU
         VBtg==
X-Gm-Message-State: AHQUAuYiKet0DPFnSdOCxBwDHDb4xmAdqN5suXAC5Go0k3kkGhvGTatL
        YPR6eo92C7/sXPetG498CpBQIfc1
X-Google-Smtp-Source: AHgI3IbxAeBhbSJ9G7RmdbznJ/eMxdPj9VDbv52rSR4ce87PWmMHtGzLGaJ7aLY1eswUxItCAde0wQ==
X-Received: by 2002:a62:ca48:: with SMTP id n69mr25587616pfg.162.1550517762905;
        Mon, 18 Feb 2019 11:22:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14sm20463764pgq.22.2019.02.18.11.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:22:41 -0800 (PST)
Subject: Re: [PATCH] s390/setup: fix early warning messages
To:     Cornelia Huck <cohuck@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1> <20190218182106.61b10ee4@mschwideX1>
 <20190218191655.103c81ca.cohuck@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <05e78442-07e1-9783-965f-b3d64a2c5e99@roeck-us.net>
Date:   Mon, 18 Feb 2019 11:22:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218191655.103c81ca.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cornelia,

On 2/18/19 10:16 AM, Cornelia Huck wrote:
> On Mon, 18 Feb 2019 18:21:06 +0100
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
>> On Mon, 18 Feb 2019 18:01:46 +0100
>> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>>
>>> On Mon, 18 Feb 2019 07:46:40 -0800
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>> Hi,
>>>>
>>>> On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:
>>>>> The setup_lowcore() function creates a new prefix page for the boot CPU.
>>>>> The PSW mask for the system_call, external interrupt, i/o interrupt and
>>>>> the program check handler have the DAT bit set in this new prefix page.
>>>>>
>>>>> At the time setup_lowcore is called the system still runs without virtual
>>>>> address translation, the paging_init() function creates the kernel page
>>>>> table and loads the CR13 with the kernel ASCE.
>>>>>
>>>>> Any code between setup_lowcore() and the end of paging_init() that has
>>>>> a BUG or WARN statement will create a program check that can not be
>>>>> handled correctly as there is no kernel page table yet.
>>>>>
>>>>> To allow early WARN statements initially setup the lowcore with DAT off
>>>>> and set the DAT bit only after paging_init() has completed.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>>>
>>>> This patch causes s390 qemu emulations to crash with a kernel stack overflow.
>>>> Reverting the patch fixes the problem. Crash log and bisect results below.
>>>
>>> Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
>>> with 4K mapping where the prefix page is mapped to absolute zero.
>>>
>>> Just using S390_lowcore instead of lowcore_ptr[0] does not work either
>>> because low-address protection is already active. I'll think of something.
>>>
>>> Thanks for bug report!
>>   
>> This patch should fix the problem:
>> --
>>  From d4393e82c3ec9b2fe5dba4b0d1b6eef29f8d15c8 Mon Sep 17 00:00:00 2001
>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Date: Mon, 18 Feb 2019 18:10:08 +0100
>> Subject: [PATCH] s390/setup: fix boot crash for machine without EDAT-1
>>
>> The fix to make WARN work in the early boot code created a problem
>> on older machines without EDAT-1. The setup_lowcore_dat_on function
>> uses the pointer from lowcore_ptr[0] to set the DAT bit in the new
>> PSWs. That does not work if the kernel page table is set up with
>> 4K pages as the prefix address maps to absolute zero.
>>
>> To make this work the PSWs need to be changed with via address 0 in
>> form of the S390_lowcore definition.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 94f85ed3e2 ("s390/setup: fix early warning messages")
>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> ---
>>   arch/s390/kernel/setup.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
>> index 65b22ef5141a..12934e8fbb91 100644
>> --- a/arch/s390/kernel/setup.c
>> +++ b/arch/s390/kernel/setup.c
>> @@ -451,13 +451,12 @@ static void __init setup_lowcore_dat_off(void)
>>   
>>   static void __init setup_lowcore_dat_on(void)
>>   {
>> -	struct lowcore *lc;
>> -
>> -	lc = lowcore_ptr[0];
>> -	lc->external_new_psw.mask |= PSW_MASK_DAT;
>> -	lc->svc_new_psw.mask |= PSW_MASK_DAT;
>> -	lc->program_new_psw.mask |= PSW_MASK_DAT;
>> -	lc->io_new_psw.mask |= PSW_MASK_DAT;
>> +	__ctl_clear_bit(0, 28);
>> +	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
>> +	S390_lowcore.svc_new_psw.mask |= PSW_MASK_DAT;
>> +	S390_lowcore.program_new_psw.mask |= PSW_MASK_DAT;
>> +	S390_lowcore.io_new_psw.mask |= PSW_MASK_DAT;
>> +	__ctl_set_bit(0, 28);
>>   }
>>   
>>   static struct resource code_resource = {
> 
> I could reproduce the crash under qemu/tcg and with this patch on top
> it is gone.
> 

What is your qemu command line ?

Thanks,
Guenter
