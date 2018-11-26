Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB9213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBB9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeKZVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:21:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbeKZVVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60FA73081D80;
        Mon, 26 Nov 2018 10:27:27 +0000 (UTC)
Received: from [10.36.112.66] (ovpn-112-66.ams2.redhat.com [10.36.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 918FA5C1B2;
        Mon, 26 Nov 2018 10:27:25 +0000 (UTC)
Subject: Re: [PATCH] KVM: x86: Trace changes to active TSC offset regardless
 if vCPU in guest-mode
To:     Liran Alon <liran.alon@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
References: <1543168405-16768-1-git-send-email-pbonzini@redhat.com>
 <941567E8-FA38-4947-B9F9-529039ADDCEA@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <555d670e-0622-f258-89d8-ad1bc8d747cb@redhat.com>
Date:   Mon, 26 Nov 2018 11:27:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <941567E8-FA38-4947-B9F9-529039ADDCEA@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 26 Nov 2018 10:27:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/18 22:38, Liran Alon wrote:
> 
> 
>> On 25 Nov 2018, at 19:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> For some reason, kvm_x86_ops->write_l1_tsc_offset() skipped trace
>> of change to active TSC offset in case vCPU is in guest-mode.
>> This patch changes write_l1_tsc_offset() behavior to trace any change
>> to active TSC offset to aid debugging.  The VMX code is changed to
>> look more similar to SVM, which is in my opinion nicer.
>>
>> Based on a patch by Liran Alon.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I would have applied this refactoring change on top of my original version of this patch. Easier to read and review.

Your original version of the patch is a bit different, in that it traced
the L2 TSC offset.  I think tracing the L1 TSC offset is clearer, but
then doing it for vmx entailed either rewriting the function twice, or
squashing the refactoring in this patch.

Paolo

> But I guess it’s a matter of taste…
> Anyway, code looks correct to me. Therefore:
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> 
>> ---
>> 	Untested still, but throwing it out because it seems pretty
>> 	obvious...
>>
>> arch/x86/kvm/svm.c |  9 +++++----
>> arch/x86/kvm/vmx.c | 34 +++++++++++++++++-----------------
>> 2 files changed, 22 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index a24733aade4c..0d1a74069a9e 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -1456,10 +1456,11 @@ static u64 svm_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
>> 		g_tsc_offset = svm->vmcb->control.tsc_offset -
>> 			       svm->nested.hsave->control.tsc_offset;
>> 		svm->nested.hsave->control.tsc_offset = offset;
>> -	} else
>> -		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
>> -					   svm->vmcb->control.tsc_offset,
>> -					   offset);
>> +	}
>> +
>> +	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
>> +				   svm->vmcb->control.tsc_offset - g_tsc_offset,
>> +				   offset);
>>
>> 	svm->vmcb->control.tsc_offset = offset + g_tsc_offset;
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 764c23dc444f..e7d3f7d35355 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -3466,24 +3466,24 @@ static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
>>
>> static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
>> {
>> -	u64 active_offset = offset;
>> -	if (is_guest_mode(vcpu)) {
>> -		/*
>> -		 * We're here if L1 chose not to trap WRMSR to TSC. According
>> -		 * to the spec, this should set L1's TSC; The offset that L1
>> -		 * set for L2 remains unchanged, and still needs to be added
>> -		 * to the newly set TSC to get L2's TSC.
>> -		 */
>> -		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>> -		if (nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING))
>> -			active_offset += vmcs12->tsc_offset;
>> -	} else {
>> -		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
>> -					   vmcs_read64(TSC_OFFSET), offset);
>> -	}
>> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>> +	u64 g_tsc_offset = 0;
>> +
>> +	/*
>> +	 * We're here if L1 chose not to trap WRMSR to TSC. According
>> +	 * to the spec, this should set L1's TSC; The offset that L1
>> +	 * set for L2 remains unchanged, and still needs to be added
>> +	 * to the newly set TSC to get L2's TSC.
>> +	 */
>> +	if (is_guest_mode(vcpu) &&
>> +	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
>> +		g_tsc_offset = vmcs12->tsc_offset;
>>
>> -	vmcs_write64(TSC_OFFSET, active_offset);
>> -	return active_offset;
>> +	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
>> +				   vcpu->arch.tsc_offset - g_tsc_offset,
>> +				   offset);
>> +	vmcs_write64(TSC_OFFSET, offset + g_tsc_offset);
>> +	return offset + g_tsc_offset;
>> }
>>
>> /*
>> -- 
>> 1.8.3.1
>>
> 
> 
> 

