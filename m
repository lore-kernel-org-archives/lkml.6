Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C625CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E052082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfA1QGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731586AbfA1QGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SG5hOA102234
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:06:38 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qa2r37mmh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:06:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Mon, 28 Jan 2019 16:04:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 16:04:12 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SG4BYU51052718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 16:04:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26E29A4040;
        Mon, 28 Jan 2019 16:04:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A754CA4053;
        Mon, 28 Jan 2019 16:04:10 +0000 (GMT)
Received: from [9.152.224.122] (unknown [9.152.224.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 16:04:10 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v6 11/13] KVM: s390: add functions to (un)register GISC
 with GISA
To:     pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-12-mimu@linux.ibm.com>
 <d9884098-9d2a-c47d-cca2-0266fa23be9c@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Mon, 28 Jan 2019 17:04:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d9884098-9d2a-c47d-cca2-0266fa23be9c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012816-4275-0000-0000-00000305F3D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012816-4276-0000-0000-00003813F800
Message-Id: <863b0635-ff88-10ca-4541-a1f27d12c758@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.01.19 16:45, Pierre Morel wrote:
> On 24/01/2019 13:59, Michael Mueller wrote:
>> Add the Interruption Alert Mask (IAM) to the architecture specific
>> kvm struct. This mask in the GISA is used to define for which ISC
>> a GIB alert will be issued.
>>
>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
>> are used to (un)register a GISC (guest ISC) with a virtual machine and
>> its GISA.
>>
>> Upon successful completion, kvm_s390_gisc_register() returns the
>> ISC to be used for GIB alert interruptions. A negative return code
>> indicates an error during registration.
>>
>> Theses functions will be used by other adapter types like AP and PCI to
>> request pass-through interruption support.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  13 +++++
>>   arch/s390/kvm/interrupt.c        | 117 
>> +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 130 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 7077762ab460..2cfff617cb21 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -781,6 +781,9 @@ struct kvm_s390_gisa {
>>               u8  reserved03[11];
>>               u32 airq_count;
>>           } g1;
>> +        struct {
>> +            u64 word[4];
>> +        } u64;
>>       };
>>   };
>> @@ -813,8 +816,15 @@ struct kvm_s390_vsie {
>>       struct page *pages[KVM_MAX_VCPUS];
>>   };
>> +struct kvm_s390_gisa_iam {
>> +    u8 mask;
>> +    spinlock_t ref_lock;
>> +    u32 ref_count[MAX_ISC + 1];
>> +};
>> +
>>   struct kvm_s390_gisa_interrupt {
>>       struct kvm_s390_gisa *origin;
>> +    struct kvm_s390_gisa_iam alert;
>>   };
>>   struct kvm_arch{
>> @@ -885,6 +895,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, 
>> unsigned long *apm,
>>   extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>>   extern char sie_exit;
>> +extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
>> +extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
>> +
>>   static inline void kvm_arch_hardware_disable(void) {}
>>   static inline void kvm_arch_check_processor_compat(void *rtn) {}
>>   static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 5efcd9e2cf8f..6bc9dab6d352 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -222,6 +222,33 @@ static inline u8 int_word_to_isc(u32 int_word)
>>    */
>>   #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * 
>> BITS_PER_BYTE)
>> +/**
>> + * gisa_set_iam - change the GISA interruption alert mask
>> + *
>> + * @gisa: gisa to operate on
>> + * @iam: new IAM value to use
>> + *
>> + * Change the IAM atomically with the next alert address and the IPM
>> + * of the GISA if the GISA is not part of the GIB alert list. All three
>> + * fields are located in the first long word of the GISA.
>> + *
>> + * Returns: 0 on success
>> + *          -EBUSY in case the gisa is part of the alert list
>> + */
>> +static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
>> +{
>> +    u64 word, _word;
>> +
>> +    do {
>> +        word = READ_ONCE(gisa->u64.word[0]);
>> +        if ((u64)gisa != word >> 32)
>> +            return -EBUSY;
>> +        _word = (word & ~0xffUL) | iam;
>> +    } while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
>> +
>> +    return 0;
>> +}
>> +
>>   static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 
>> gisc)
>>   {
>>       set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>> @@ -2911,6 +2938,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>>       if (!css_general_characteristics.aiv)
>>           return;
>>       gi->origin = &kvm->arch.sie_page2->gisa;
>> +    gi->alert.mask = 0;
>> +    spin_lock_init(&gi->alert.ref_lock);
>>       kvm_s390_gisa_clear(kvm);
>>       VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>>   }
>> @@ -2920,6 +2949,94 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
>>       kvm->arch.gisa_int.origin = NULL;
>>   }
>> +/**
>> + * kvm_s390_gisc_register - register a guest ISC
>> + *
>> + * @kvm:  the kernel vm to work with
>> + * @gisc: the guest interruption sub class to register
>> + *
>> + * The function extends the vm specific alert mask to use.
>> + * The effectve IAM mask in the GISA is updated as well
>> + * in case the GISA is not part of the GIB alert list.
>> + * It will be updated latest when the IAM gets restored
>> + * by gisa_get_ipm_or_restore_iam().
>> + *
>> + * Returns: the nonspecific ISC (NISC) the gib alert mechanism
>> + *          has registered with the channel subsystem.
>> + *          -ENODEV in case the vm uses no GISA
>> + *          -ERANGE in case the guest ISC is invalid
>> + */
>> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
>> +{
>> +    struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>> +    u8 alert_mask;
>> +
>> +    if (!gi->origin)
>> +        return -ENODEV;
>> +    if (gisc > MAX_ISC)
>> +        return -ERANGE;
>> +
>> +    spin_lock(&gi->alert.ref_lock);
>> +    if (gi->alert.ref_count[gisc] == 0) {
>> +        alert_mask = gi->alert.mask | 0x80 >> gisc;
>> +        WRITE_ONCE(gi->alert.mask, alert_mask);
> 
> not sure WRITE_ONCE is useful.

I dropped that in both routines.

> 
> 
> 
>> +    }
>> +    gi->alert.ref_count[gisc]++;
>> +    if (gi->alert.ref_count[gisc] == 1)
>> +        gisa_set_iam(gi->origin, alert_mask);
> 
> This will trigger a GAL interrupt on first AP interrupt in all cases.
> However setting the iam here is simple and the price is not so high.
> so... without the WRITE_ONCE in register and in unregister:


> 
> Acked-by: Pierre Morel<pmorel@linux.ibm.com>
> 
> Pierre
> 

Cheers,
Michael

