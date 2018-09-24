Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D99ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641C521486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641C521486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIXOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeIXOgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:36:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7F0B30832C1;
        Mon, 24 Sep 2018 08:35:48 +0000 (UTC)
Received: from [10.36.117.232] (ovpn-117-232.ams2.redhat.com [10.36.117.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 450E75D9C9;
        Mon, 24 Sep 2018 08:35:42 +0000 (UTC)
Subject: Re: [PATCH v10 03/26] KVM: s390: refactor crypto initialization
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <3403a255-8125-18f7-45b8-bb6a8a9f7f84@redhat.com>
Date:   Mon, 24 Sep 2018 10:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 24 Sep 2018 08:35:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2018 01:18, Tony Krowiak wrote:
> On 09/12/2018 03:42 PM, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch refactors the code that initializes and sets up the
>> crypto configuration for a guest. The following changes are
>> implemented via this patch:
>>
>> 1. Prior to the introduction of AP device virtualization, it
>>     was not necessary to provide guest access to the CRYCB
>>     unless the MSA extension 3 (MSAX3) facility was installed
>>     on the host system. With the introduction of AP device
>>     virtualization, the CRYCB must be made accessible to the
>>     guest if the AP instructions are installed on the host
>>     and are to be provided to the guest.
>>
>> 2. Introduces a flag indicating AP instructions executed on
>>     the guest shall be interpreted by the firmware. It is
>>     initialized to indicate AP instructions are to be
>>     to be interpreted and is used to set the SIE bit for
>>     each vcpu during vcpu setup.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |    2 +
>>   arch/s390/include/uapi/asm/kvm.h |    1 +
>>   arch/s390/kvm/kvm-s390.c         |   71 ++++++++++++++++++--------------------
>>   3 files changed, 37 insertions(+), 37 deletions(-)
>>
> 
> (...)
> 
>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>> index 9a50f02..8c23afc 100644
>> --- a/arch/s390/include/uapi/asm/kvm.h
>> +++ b/arch/s390/include/uapi/asm/kvm.h
>> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>>   #define KVM_S390_VM_CPU_FEAT_KSS	13
>> +#define KVM_S390_VM_CPU_FEAT_AP		14
>>   struct kvm_s390_vm_cpu_feat {
>>   	__u64 feat[16];
>>   };
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 876fbb2..d717041 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -40,6 +40,7 @@
>>   #include <asm/sclp.h>
>>   #include <asm/cpacf.h>
>>   #include <asm/timex.h>
>> +#include <asm/ap.h>
>>   #include "kvm-s390.h"
>>   #include "gaccess.h"
>>   
> 
> (...)
> 
>> @@ -2586,17 +2575,25 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>>   
>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>>   {
>> -	if (!test_kvm_facility(vcpu->kvm, 76))
>> +	/*
>> +	 * If neither the AP instructions nor the MSAX3 facility are configured
>> +	 * for the guest, there is nothing to set up.
>> +	 */
>> +	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
>> +	    !test_kvm_facility(vcpu->kvm, 76))
>>   		return;
>>   
>> +	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>   	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>>   
>> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>> +
>> +	/* Set up protected key support */
>>   	if (vcpu->kvm->arch.crypto.aes_kw)
>>   		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>>   	if (vcpu->kvm->arch.crypto.dea_kw)
>>   		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>> -
>> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>   }
>>   
>>   void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>>
> 
> The fixup! patch below modifies this patch (03/26) to illustrate how
> 
> David's recommendation will be implemented for v11 of the series. It
> 
> is one of three fixup! patches (the other two are in responses to
> 11/26
>   and 25/26) included to generate discussion in v10 rather than
> 
> waiting until v11 for comments.
> 
> -----------------------------------8<-----------------------------------
> 
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> Date: Thu, 20 Sep 2018 12:26:08 -0400
> Subject: [FIXUP v10] fixup!: KVM: s390: refactor crypto initialization
> 
> ---
>   arch/s390/include/asm/kvm_host.h |    1 +
>   arch/s390/include/uapi/asm/kvm.h |    1 -
>   arch/s390/kvm/kvm-s390.c         |    9 ++++-----
>   3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h 
> b/arch/s390/include/asm/kvm_host.h
> index 423cce7..79fa0a3 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -718,6 +718,7 @@ struct kvm_s390_crypto {
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> +	__u8 apie;
>   };
> 
>   #define APCB0_MASK_SIZE 1
> diff --git a/arch/s390/include/uapi/asm/kvm.h 
> b/arch/s390/include/uapi/asm/kvm.h
> index 8c23afc..9a50f02 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -130,7 +130,6 @@ struct kvm_s390_vm_cpu_machine {
>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>   #define KVM_S390_VM_CPU_FEAT_KSS	13
> -#define KVM_S390_VM_CPU_FEAT_AP		14
>   struct kvm_s390_vm_cpu_feat {
>   	__u64 feat[16];
>   };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d717041..ae4769b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2576,17 +2576,16 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>   {
>   	/*
> -	 * If neither the AP instructions nor the MSAX3 facility are configured
> -	 * for the guest, there is nothing to set up.
> +	 * If the AP instructions are not available and the MSAX3 facility
> +	 * is not configured for the guest, there is nothing to set up.
>   	 */
> -	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
> -	    !test_kvm_facility(vcpu->kvm, 76))
> +	if (!ap_instructions_available() && !test_kvm_facility(vcpu->kvm, 76))
>   		return;
> 
>   	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>   	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
> 
> -	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
> +	if (vcpu->kvm->arch.crypto.apie)
>   		vcpu->arch.sie_block->eca |= ECA_APIE;
> 
>   	/* Set up protected key support */
> 

Looks sane, too.

-- 

Thanks,

David / dhildenb
