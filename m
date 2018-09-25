Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8188EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5DE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeIYTjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:39:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729198AbeIYTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:39:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PDOfmW067485
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:31:28 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqmyhbjfx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:31:27 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 25 Sep 2018 07:31:26 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 07:31:23 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PDVKKw24051878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 06:31:20 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CC1B6E056;
        Tue, 25 Sep 2018 07:31:20 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC686E04C;
        Tue, 25 Sep 2018 07:31:17 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.207.102])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Sep 2018 07:31:17 -0600 (MDT)
Subject: Re: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
To:     David Hildenbrand <david@redhat.com>,
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
 <ea1e79bd-63e8-819a-3cc0-62e5321d7993@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 25 Sep 2018 09:31:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ea1e79bd-63e8-819a-3cc0-62e5321d7993@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092513-0012-0000-0000-000016BB6C66
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009769; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093447; UDB=6.00565149; IPR=6.00873484;
 MB=3.00023497; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 13:31:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092513-0013-0000-0000-000054874037
Message-Id: <7f77492a-6561-b116-9c27-b54f549d7d9a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 02:46 PM, David Hildenbrand wrote:
> On 24/09/2018 18:25, Tony Krowiak wrote:
>> On 09/24/2018 07:23 AM, David Hildenbrand wrote:
>>> On 22/09/2018 01:40, Tony Krowiak wrote:
>>>> On 09/17/2018 04:51 AM, David Hildenbrand wrote:
>>>>> Am 12.09.18 um 21:43 schrieb Tony Krowiak:
>>>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>>
>>>>>> Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
>>>>>> to enable or disable AP instruction interpretation from userspace
>>>>>> via the KVM_SET_DEVICE_ATTR ioctl:
>>>>>>
>>>>>> * The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
>>>>>>      interpretation of AP instructions executed on the guest.
>>>>>>
>>>>>> * The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
>>>>>>      interpretation of AP instructions executed on the guest. In this
>>>>>>      case the instructions will be intercepted and pass through to
>>>>>>      the guest.
>>>>>>
>>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>> ---
>>>>>>     arch/s390/include/asm/kvm_host.h |    1 +
>>>>>>     arch/s390/include/uapi/asm/kvm.h |    2 ++
>>>>>>     arch/s390/kvm/kvm-s390.c         |   27 +++++++++++++++++++++++----
>>>>>>     3 files changed, 26 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>>>> index b32bd1b..36d3531 100644
>>>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>>>> @@ -719,6 +719,7 @@ struct kvm_s390_crypto {
>>>>>>     	__u32 crycbd;
>>>>>>     	__u8 aes_kw;
>>>>>>     	__u8 dea_kw;
>>>>>> +	__u8 apie;
>>>>>>     };
>>>>>>     
>>>>>>     #define APCB0_MASK_SIZE 1
>>>>>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>>>>>> index 8c23afc..a8dbd90 100644
>>>>>> --- a/arch/s390/include/uapi/asm/kvm.h
>>>>>> +++ b/arch/s390/include/uapi/asm/kvm.h
>>>>>> @@ -161,6 +161,8 @@ struct kvm_s390_vm_cpu_subfunc {
>>>>>>     #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
>>>>>>     #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
>>>>>>     #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
>>>>>> +#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
>>>>>> +#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
>>>>>>     
>>>>>>     /* kvm attributes for migration mode */
>>>>>>     #define KVM_S390_VM_MIGRATION_STOP	0
>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>> index 2cdd980..286c2e0 100644
>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>> @@ -856,12 +856,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>>>>>>     
>>>>>>     static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     {
>>>>>> -	if (!test_kvm_facility(kvm, 76))
>>>>>> -		return -EINVAL;
>>>>>> -
>>>>>>     	mutex_lock(&kvm->lock);
>>>>>>     	switch (attr->attr) {
>>>>>>     	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		get_random_bytes(
>>>>>>     			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>>>>> @@ -869,6 +868,8 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
>>>>>>     		break;
>>>>>>     	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		get_random_bytes(
>>>>>>     			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>>> @@ -876,17 +877,31 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
>>>>>>     		break;
>>>>>>     	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		kvm->arch.crypto.aes_kw = 0;
>>>>>>     		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>>>>>     		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
>>>>>>     		break;
>>>>>>     	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		kvm->arch.crypto.dea_kw = 0;
>>>>>>     		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>>>     		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>>>>>     		break;
>>>>>> +	case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>>>>> +		if (!ap_instructions_available()) {
>>>>>> +			mutex_unlock(&kvm->lock);
>>>>>> +			return -EOPNOTSUPP;
>>>>>> +		}
>>>>>> +		kvm->arch.crypto.apie = 1;
>>>>>> +		break;
>>>>>> +	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>>>>>> +		kvm->arch.crypto.apie = 0;
>>>>>> +		break;
>>>>>>     	default:
>>>>>>     		mutex_unlock(&kvm->lock);
>>>>>>     		return -ENXIO;
>>>>>> @@ -1493,6 +1508,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>>>>>     		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>>>>>     		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>>>>>> +		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>>>>> +		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>>>>>
>>>>> As also replied to the QEMU series, could we indicate
>>>>> KVM_S390_VM_CRYPTO_ENABLE_APIE (and maybe
>>>>> KVM_S390_VM_CRYPTO_DISABLE_APIE) only with ap_instructions_available(),
>>>>> so we can avoid the additional KVM_S390_VM_CPU_FEAT_AP?
>>>>>
>>>>> KVM_S390_VM_CPU_FEAT_AP is right now completely unused in KVM otherwise
>>>>> (never checked, we only care about apie).
>>>>
>>>> After much discussion with Halil and a few exchanges with you, we
>>>> decided to go ahead and accept your suggestion to get rid of
>>>> KVM_S390_VM_CPU_FEAT and keep the VM device attributes to enable/disable
>>>> apie.
>>>>
>>>> To that end, I responded to patches 03/26, 11/26 and 25/26 with fixup!
>>>> patches that show the KVM/kernel changes that will be necessary to get
>>>> rid of KVM_S390_VM_CPU_FEAT and use apie to control ECA.28. I did that
>>>> to generate discussion in v10 rather than waiting until v11 for
>>>> comments. I make no guarantees that those fixup! patches will
>>>> successfully apply should you have a v10 branch generated from this
>>>> patch series you want to update.
>>>>
>>>
>>> Will you also fixup this patch to expose KVM_S390_VM_CRYPTO_ENABLE_APIE
>>> only if supported by HW? (ap_instructions_available)
>>
>> Given that this patch DOES expose KVM_S390_VM_CRYPTO_ENABLE_APIE only if
>> supported by HW, I assume you are talking about
>> KVM_S390_VM_CRYPTO_DISABLE_APIE. I didn't check
>> ap_instructions_available() for disabling APIE because I didn't
>> think it necessary given that ECA.28 will be set to 0 (intercept) by
>> default, whether AP instructions are installed or not; so why not allow
>> disabling apie. I suppose from the perspective of consistency, since the
>> kvm_s390_vm_has_attr() function checks ap_instructions_available() for
>> both attributes, then it probably makes sense to add that check to
>> KVM_S390_VM_CRYPTO_DISABLE_APIE here. Then again, we could make a change
>> in ap_instructions_available() to allow KVM_S390_VM_CRYPTO_DISABLE_APIE
>> regardless of whether AP instructions are available. It boils down to
>> whether APIE needs to be dynamically disabled at some point when it has
>> been enabled. The only case I can think of where that may be necessary
>> is if a guest is migrated to a system without AP instructions. I don't
>> think that can happen and may even be protected against precisely
>> because the VM attributes won't be available on the target system due to
>> no AP instructions. What say you?
>>
>>>
>>
> 
> Just so we're on the same page, I am talking about exposing, I talk
> about indicating the attribute:
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 03c23045527f..40924fe05bdf 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1491,6 +1491,11 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm,
> struct kvm_device_attr *attr)
>                  case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>                          ret = 0;
>                          break;
> +               case KVM_S390_VM_CRYPTO_ENABLE_APIE:
> +               case KVM_S390_VM_CRYPTO_DISABLE_APIE:
> +                       ret = -ENXIO;
> +                       if (ap_instructions_available())
> +                               ret = 0;
>                  default:
>                          ret = -ENXIO;
>                          break;
> 
> KVM_S390_VM_CRYPTO_DISABLE_APIE can either be handled like
> KVM_S390_VM_CRYPTO_ENABLE_APIE (return -EOPNOTSUPP) when setting or
> always be allowed. I'll leave that up to you. But as it is completely
> useless without ap_instructions_available() /
> KVM_S390_VM_CRYPTO_ENABLE_APIE , we might as well also just not expose
> it then.

We are on the same page.

> 

