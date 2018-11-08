Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF10C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516F92086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koxcruOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516F92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeKHPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:46:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKHPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:46:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so8391490pgv.10;
        Wed, 07 Nov 2018 22:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0VeysKUOI2eXqNRuXILbBlboGhhuFynMvpU2qfdfBWg=;
        b=koxcruOf9/qoIPSnfew8ElYvsM7I5E0Au+eV57PkU6Nd3WqBlPfrc4lpcWoC1ZEhAH
         HUC0Pmc9NE39Sweuvboz/7qMihfuVuMhPw7UYV98iTSO2Fnjg/8Bm7G73TODOHyK6zKd
         YRY3xl5U0GqSOAOv3YsZWIIYypDdb1L5EZxIGmTS0k5NvwkQnK+m+cTg/QnYow2V4dmr
         aJk2HizFOUMbFzqxuAfwuv2zdngQn/RhZE0lDV87LV4F0FpLCmXg4EFgfG1zzlzvvh88
         UuUQn6/ahF0aGr3UAly4zs1u2pjB7uMBLvebaZbfBAxgCGcfcsSLW3OJWmk0S1nsj4Ih
         KuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0VeysKUOI2eXqNRuXILbBlboGhhuFynMvpU2qfdfBWg=;
        b=aAOmIExtYoUV3uBHM8GY4k+i1iXzAymjpKn+IRdioiHhbv2g781aEqUBpCgfBr2TZ7
         Te/QkpjIG8TpQq0sCI7o8ZuRRz2OPhHiOpj7lY9XYt5yI2ApUbmMIZoO/3UGlqQzp0vz
         l/k4/YG6R4R97t53aBvUD5By7E1usa+DYP/ICUYeBKo5QAHvIXcbI+Gr3Mrp88Dwsz5A
         DUhZExPoeqgQKkjExXiQ1w2zbqQeCUwVYCuYPGfmOrjLt8Jn68pIEXXKeJOZU6seo0gz
         x8K2EXj9gbU7UyDt7BvyFcMD+Ycdeu1WYMHQqB9B4Rw8fAzl8lDsTrNCEf9JQ4jNQnZg
         6Q4g==
X-Gm-Message-State: AGRZ1gJsyAgXK1sQ2WcfV2wusy7gRN26YCX0FomrAXO4fEhFFnWPOAp5
        Ut+qW7YLasDpl0N0Mrw7cjE=
X-Google-Smtp-Source: AJdET5cJ5ZrK8uiLYkgLqySwIn9/6ojsWfp/tHhzqXSBs4XNTY85p89JM+MECGlTNATk5HeSn4TaAw==
X-Received: by 2002:a63:6302:: with SMTP id x2mr2765711pgb.183.1541657577015;
        Wed, 07 Nov 2018 22:12:57 -0800 (PST)
Received: from ?IPv6:2404:f801:18:404:f12b:8d02:867:c7ec? ([2404:f801:9000:18:652f:8d02:867:c7ec])
        by smtp.gmail.com with ESMTPSA id s2-v6sm4305506pfk.133.2018.11.07.22.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:12:56 -0800 (PST)
Subject: Re: [PATCH] KVM/VMX: Check ept_pointer before flushing ept tlb
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com
References: <20181106133043.83570-1-Tianyu.Lan@microsoft.com>
 <87lg66urwd.fsf@vitty.brq.redhat.com>
 <bcd1cd98-0b2f-2c3b-c1d2-a4f4ea960063@gmail.com>
 <8736sdupr2.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <d577eb84-a9bc-78c6-32e5-df59cb6d9dd5@gmail.com>
Date:   Thu, 8 Nov 2018 14:12:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8736sdupr2.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2018 6:49 PM, Vitaly Kuznetsov wrote:
> Tianyu Lan <ltykernel@gmail.com> writes:
> 
>> Hi Vitaly:
>> 	Thanks for your review.
>>
>> On 11/6/2018 11:50 PM, Vitaly Kuznetsov wrote:
>>> ltykernel@gmail.com writes:
>>>
>>>> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>>>>
>>>> This patch is to initialize ept_pointer to INVALID_PAGE and check it
>>>> before flushing ept tlb. If ept_pointer is invalidated, bypass the flush
>>>> request.
>>>>
>>>
>>> To be honest I fail to understand the reason behind the patch: instead
>>> of doing one unneeded flush request with ept_pointer==0 (after vCPU is
>>> initialized) we now do the check every time. Could you please elaborate
>>> on why this is needed?
>>
>> The reason to introduce the check here is to avoid flushing ept tlb
>> without valid ept table. When nested guest boots up and only BP is
>> active, we should not do flush for APs and L1 hypervisor hasn't set
>> valid EPT table for APs.
> 
> Yes, I understand that but I'm trying to avoid additional checks on
> hotpath as during normal operation EPT pointer is always set.
>
> Could we just initialize ept_pointers_match to something like
> EPT_POINTERS_NOTSET and achive the same result?

vmx->ept_pointers_match presents match status of all vcpus' ept table. 
EPT_POINTER_NOSET should be per cpu status and so I select ept_pointer 
as check condition.

BTW, I think we may remove the check for match case which is normal 
status and all ept pointers should be set at that point. Mismatch status 
should be corner case when VM runs and this will not affect a lot.
