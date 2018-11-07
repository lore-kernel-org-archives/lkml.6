Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4D20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAgxdEGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC4D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeKGPoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:44:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33243 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeKGPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:44:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so3675662pfk.0;
        Tue, 06 Nov 2018 22:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4GLXxDh8b89tkzFL5HQ8vxzUWGboU7Z0hIxMqhuoEmU=;
        b=mAgxdEGivp67LLleZCC2L7+GC1qdE5nNsK8zABffIPiuXj2c1PyUM0yKpGE7iD0wp/
         +81AvSH99tl2fyPuxnoE3x6ACSSQqIio2uda+szzMy7Ms0sI7oD4u4AaDFpE8ifEFE4v
         R+0qMxRP/3C0KszvWlUMbpqupfceJ7evMiebvtgDsGOEnRSGb7BOGeMazBNDTWSb9/GG
         +RQbDqyRLhopet9d3ZZsPxiI1lqNv49IDIa9nVvcvkduu+d31R9qH4A6S1xLB3FLxkHY
         Nq5ZAGICkGoQUWQp2v77e72CG3AmFycwTaiOx9pr/Ai++hvCOJrCUFozD/fEolNfYhk4
         i9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4GLXxDh8b89tkzFL5HQ8vxzUWGboU7Z0hIxMqhuoEmU=;
        b=p55Sbj/LfNWx2qlHXfH5gsvQ5jXdDApmYT1suSKMDKy4F95zK1HuREnJcEJgGF4P8V
         XwyKsm4fAsreUJTUqpoIBdqTcWkTK8R/WYcOZJR0H68pDNNZnhFY+SHjnwBplBpK0M9C
         37VtAzktpjq3qiPl0aDBu7OHTlFGsFNNMfW30M/lDfHP4rbJuo+hwd2GKz2DIWaavyMn
         1vJy7BSzBYSdHiGxu7byk60DtmLo9Mn3HEzduzBVAYxsRhm70jy9KzXXoixEtE5V8VMA
         ivAO+IUny0WhNdhty8/fnSd6jxuqj6ZTZp75GGvFBipmoucwwuEgj5s10pKeHVWHtASq
         NkKw==
X-Gm-Message-State: AGRZ1gKp66E4x9DioHIQYOCDjiok0uSTgU3omIlZKydkndHv9fbGTeA8
        6m/KszR+s6w0iryD9+QPWm0=
X-Google-Smtp-Source: AJdET5dN3QLJ4SKQ0LBdFlXISOUYtAFkxt70OrDLjRBt0V1ZoRoo5axn+jofxb3yoBo0K6pPGX9UCQ==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr535943pgi.301.1541571337560;
        Tue, 06 Nov 2018 22:15:37 -0800 (PST)
Received: from ?IPv6:2404:f801:18:404:3519:8218:cfb2:8481? ([2404:f801:9000:18:a91c:8218:cfb2:8481])
        by smtp.gmail.com with ESMTPSA id f18-v6sm93777068pfh.0.2018.11.06.22.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 22:15:37 -0800 (PST)
Subject: Re: [PATCH] KVM/VMX: Check ept_pointer before flushing ept tlb
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com
References: <20181106133043.83570-1-Tianyu.Lan@microsoft.com>
 <87lg66urwd.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <bcd1cd98-0b2f-2c3b-c1d2-a4f4ea960063@gmail.com>
Date:   Wed, 7 Nov 2018 14:15:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87lg66urwd.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly:
	Thanks for your review.

On 11/6/2018 11:50 PM, Vitaly Kuznetsov wrote:
> ltykernel@gmail.com writes:
> 
>> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>>
>> This patch is to initialize ept_pointer to INVALID_PAGE and check it
>> before flushing ept tlb. If ept_pointer is invalidated, bypass the flush
>> request.
>>
>> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>> ---
>>   arch/x86/kvm/vmx.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 4555077d69ce..edbc96cb990a 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -1580,14 +1580,22 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
>>   	/*
>>   	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
>>   	 * base of EPT PML4 table, strip off EPT configuration information.
>> +	 * If ept_pointer is invalid pointer, bypass the flush request.
>>   	 */
>>   	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
>> -		kvm_for_each_vcpu(i, vcpu, kvm)
>> +		kvm_for_each_vcpu(i, vcpu, kvm) {
>> +			if (!VALID_PAGE(to_vmx(vcpu)->ept_pointer))
>> +				return 0;
>> +
> 
> To be honest I fail to understand the reason behind the patch: instead
> of doing one unneeded flush request with ept_pointer==0 (after vCPU is
> initialized) we now do the check every time. Could you please elaborate
> on why this is needed?

The reason to introduce the check here is to avoid flushing ept tlb
without valid ept table. When nested guest boots up and only BP is
active, we should not do flush for APs and L1 hypervisor hasn't set
valid EPT table for APs.

> 
>>   			ret |= hyperv_flush_guest_mapping(
>> -				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
>> +				to_vmx(vcpu)->ept_pointer & PAGE_MASK);
> 
> I would use a local variable for 'to_vmx(vcpu)->ept_pointer' or even
> 'to_vmx(vcpu)->ept_pointer & PAGE_MASK' and use it in VALID_PAGE() - as
> lower bits are unrelated;

Yes, that makes sense. INVALID_PAGE also contains lower bits and so a 
local variable for 'to_vmx(vcpu)->ept_pointer' maybe better.


> 
> 
>> +		}
>>   	} else {
>> +		if (!VALID_PAGE(to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer))
>> +			return 0;
> 
> Ditto.
> 
>> +
>>   		ret = hyperv_flush_guest_mapping(
>> -				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
>> +			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
> 
> This doesn't belong to this patch.

I found the line exceeds 80 chars and so adjust indent. Maybe I should 
change it in a separate patch despite it's a small change.

> 
>>   	}
>>   
>>   	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
>> @@ -11568,6 +11576,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
>>   	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
>>   	vmx->pi_desc.sn = 1;
>>   
>> +	vmx->ept_pointer = INVALID_PAGE;
>> +
>>   	return &vmx->vcpu;
>>   
>>   free_vmcs:
> 
