Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7E5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37252145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37252145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbeIYAuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbeIYAt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:49:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDC3DC057FA6;
        Mon, 24 Sep 2018 18:46:27 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0186BD1EE;
        Mon, 24 Sep 2018 18:46:19 +0000 (UTC)
Subject: Re: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
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
 <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
 <9263b698-1827-1b7f-28bf-75b44657dea2@redhat.com>
 <18a21cda-1da9-3bfb-7b34-80415b5457f9@linux.ibm.com>
 <172560fb-2c54-ea43-3401-f108cf2a0595@redhat.com>
 <bb2639ac-469a-a71f-8f0a-2df3c12c6ac5@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ea1e79bd-63e8-819a-3cc0-62e5321d7993@redhat.com>
Date:   Mon, 24 Sep 2018 20:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bb2639ac-469a-a71f-8f0a-2df3c12c6ac5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 24 Sep 2018 18:46:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2018 18:25, Tony Krowiak wrote:
> On 09/24/2018 07:23 AM, David Hildenbrand wrote:
>> On 22/09/2018 01:40, Tony Krowiak wrote:
>>> On 09/17/2018 04:51 AM, David Hildenbrand wrote:
>>>> Am 12.09.18 um 21:43 schrieb Tony Krowiak:
>>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>
>>>>> Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
>>>>> to enable or disable AP instruction interpretation from userspace
>>>>> via the KVM_SET_DEVICE_ATTR ioctl:
>>>>>
>>>>> * The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
>>>>>     interpretation of AP instructions executed on the guest.
>>>>>
>>>>> * The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
>>>>>     interpretation of AP instructions executed on the guest. In this
>>>>>     case the instructions will be intercepted and pass through to
>>>>>     the guest.
>>>>>
>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>> ---
>>>>>    arch/s390/include/asm/kvm_host.h |    1 +
>>>>>    arch/s390/include/uapi/asm/kvm.h |    2 ++
>>>>>    arch/s390/kvm/kvm-s390.c         |   27 +++++++++++++++++++++++----
>>>>>    3 files changed, 26 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>>> index b32bd1b..36d3531 100644
>>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>>> @@ -719,6 +719,7 @@ struct kvm_s390_crypto {
>>>>>    	__u32 crycbd;
>>>>>    	__u8 aes_kw;
>>>>>    	__u8 dea_kw;
>>>>> +	__u8 apie;
>>>>>    };
>>>>>    
>>>>>    #define APCB0_MASK_SIZE 1
>>>>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>>>>> index 8c23afc..a8dbd90 100644
>>>>> --- a/arch/s390/include/uapi/asm/kvm.h
>>>>> +++ b/arch/s390/include/uapi/asm/kvm.h
>>>>> @@ -161,6 +161,8 @@ struct kvm_s390_vm_cpu_subfunc {
>>>>>    #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
>>>>>    #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
>>>>>    #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
>>>>> +#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
>>>>> +#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
>>>>>    
>>>>>    /* kvm attributes for migration mode */
>>>>>    #define KVM_S390_VM_MIGRATION_STOP	0
>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>> index 2cdd980..286c2e0 100644
>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>> @@ -856,12 +856,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>>>>>    
>>>>>    static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>    {
>>>>> -	if (!test_kvm_facility(kvm, 76))
>>>>> -		return -EINVAL;
>>>>> -
>>>>>    	mutex_lock(&kvm->lock);
>>>>>    	switch (attr->attr) {
>>>>>    	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>> +			return -EINVAL;
>>>>>    		get_random_bytes(
>>>>>    			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
>>>>>    			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>>>> @@ -869,6 +868,8 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>    		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
>>>>>    		break;
>>>>>    	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>> +			return -EINVAL;
>>>>>    		get_random_bytes(
>>>>>    			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>>>>>    			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>> @@ -876,17 +877,31 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>    		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
>>>>>    		break;
>>>>>    	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>> +			return -EINVAL;
>>>>>    		kvm->arch.crypto.aes_kw = 0;
>>>>>    		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
>>>>>    			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>>>>    		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
>>>>>    		break;
>>>>>    	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>> +			return -EINVAL;
>>>>>    		kvm->arch.crypto.dea_kw = 0;
>>>>>    		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
>>>>>    			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>>    		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>>>>    		break;
>>>>> +	case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>>>> +		if (!ap_instructions_available()) {
>>>>> +			mutex_unlock(&kvm->lock);
>>>>> +			return -EOPNOTSUPP;
>>>>> +		}
>>>>> +		kvm->arch.crypto.apie = 1;
>>>>> +		break;
>>>>> +	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>>>>> +		kvm->arch.crypto.apie = 0;
>>>>> +		break;
>>>>>    	default:
>>>>>    		mutex_unlock(&kvm->lock);
>>>>>    		return -ENXIO;
>>>>> @@ -1493,6 +1508,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>    		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>>>>    		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>>>>    		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>>>>> +		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>>>> +		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>>>>
>>>> As also replied to the QEMU series, could we indicate
>>>> KVM_S390_VM_CRYPTO_ENABLE_APIE (and maybe
>>>> KVM_S390_VM_CRYPTO_DISABLE_APIE) only with ap_instructions_available(),
>>>> so we can avoid the additional KVM_S390_VM_CPU_FEAT_AP?
>>>>
>>>> KVM_S390_VM_CPU_FEAT_AP is right now completely unused in KVM otherwise
>>>> (never checked, we only care about apie).
>>>
>>> After much discussion with Halil and a few exchanges with you, we
>>> decided to go ahead and accept your suggestion to get rid of
>>> KVM_S390_VM_CPU_FEAT and keep the VM device attributes to enable/disable
>>> apie.
>>>
>>> To that end, I responded to patches 03/26, 11/26 and 25/26 with fixup!
>>> patches that show the KVM/kernel changes that will be necessary to get
>>> rid of KVM_S390_VM_CPU_FEAT and use apie to control ECA.28. I did that
>>> to generate discussion in v10 rather than waiting until v11 for
>>> comments. I make no guarantees that those fixup! patches will
>>> successfully apply should you have a v10 branch generated from this
>>> patch series you want to update.
>>>
>>
>> Will you also fixup this patch to expose KVM_S390_VM_CRYPTO_ENABLE_APIE
>> only if supported by HW? (ap_instructions_available)
> 
> Given that this patch DOES expose KVM_S390_VM_CRYPTO_ENABLE_APIE only if 
> supported by HW, I assume you are talking about
> KVM_S390_VM_CRYPTO_DISABLE_APIE. I didn't check 
> ap_instructions_available() for disabling APIE because I didn't
> think it necessary given that ECA.28 will be set to 0 (intercept) by 
> default, whether AP instructions are installed or not; so why not allow 
> disabling apie. I suppose from the perspective of consistency, since the 
> kvm_s390_vm_has_attr() function checks ap_instructions_available() for 
> both attributes, then it probably makes sense to add that check to 
> KVM_S390_VM_CRYPTO_DISABLE_APIE here. Then again, we could make a change 
> in ap_instructions_available() to allow KVM_S390_VM_CRYPTO_DISABLE_APIE 
> regardless of whether AP instructions are available. It boils down to 
> whether APIE needs to be dynamically disabled at some point when it has 
> been enabled. The only case I can think of where that may be necessary 
> is if a guest is migrated to a system without AP instructions. I don't 
> think that can happen and may even be protected against precisely 
> because the VM attributes won't be available on the target system due to 
> no AP instructions. What say you?
> 
>>
> 

Just so we're on the same page, I am talking about exposing, I talk
about indicating the attribute:

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 03c23045527f..40924fe05bdf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1491,6 +1491,11 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm,
struct kvm_device_attr *attr)
                case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
                        ret = 0;
                        break;
+               case KVM_S390_VM_CRYPTO_ENABLE_APIE:
+               case KVM_S390_VM_CRYPTO_DISABLE_APIE:
+                       ret = -ENXIO;
+                       if (ap_instructions_available())
+                               ret = 0;
                default:
                        ret = -ENXIO;
                        break;

KVM_S390_VM_CRYPTO_DISABLE_APIE can either be handled like
KVM_S390_VM_CRYPTO_ENABLE_APIE (return -EOPNOTSUPP) when setting or
always be allowed. I'll leave that up to you. But as it is completely
useless without ap_instructions_available() /
KVM_S390_VM_CRYPTO_ENABLE_APIE , we might as well also just not expose
it then.

-- 

Thanks,

David / dhildenb
