Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0F8217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeLTLuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:50:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730899AbeLTLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:50:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBKBkKIc079131
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:50:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pg7jh8s2p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:50:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 20 Dec 2018 11:50:01 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 11:49:59 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBKBnvGA34472030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 11:49:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65AC85204F;
        Thu, 20 Dec 2018 11:49:57 +0000 (GMT)
Received: from [9.152.224.123] (unknown [9.152.224.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F3F7C52050;
        Thu, 20 Dec 2018 11:49:56 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-6-mimu@linux.ibm.com>
 <20181220120614.65acacac.cohuck@redhat.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Thu, 20 Dec 2018 12:49:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181220120614.65acacac.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122011-0016-0000-0000-0000023925C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122011-0017-0000-0000-0000329180E2
Message-Id: <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.12.18 12:06, Cornelia Huck wrote:
> On Wed, 19 Dec 2018 20:17:46 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> Use a single function with parameter irq_flags to differentiate
>> between cases.
>>
>> New irq flag:
>>     IRQ_FLAG_LOCAL: include vcpu local interruptions pending
>>     IRQ_FLAG_FLOATING: include vcpu floating interruptions pending
>>     IRQ_FLAG_GISA: include GISA interruptions pending in IPM
> 
> I presume that means that irqs may be in more than one set? Or are gisa
> irqs not considered floating irqs, because they use a different
> mechanism?

Currently, the interruptions managed in GISA are floating only. But
that might change in future. The idea is not to subsume IRQ_FLAG_GISA
in IRQ_FLAG_FLOATING but to be able to address the right set of 
procedures to determine the irq pending set for a given subset of irq
types that have different implementations.

There might be a better name for IRQ_FLAG_FLOATING then?

> 
>>
>> New irq masks:
>>     IRQ_MASK_ALL: include all types
>>     IRQ_MASK_NO_GISA: include all types but GISA
>>
>> Examples:
>>     pending_irqs(vcpu, IRQ_MASK_ALL)
>>     pending_irqs(vcpu, IRQ_MASK_NO_GISA)
>>
>> There will be more irq flags with upcoming patches.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 33 +++++++++++++++++++++------------
>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 093b568b6356..4ab20d2eb180 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -31,6 +31,13 @@
>>   #define PFAULT_DONE 0x0680
>>   #define VIRTIO_PARAM 0x0d00
>>   
>> +#define IRQ_FLAG_LOCAL    0x8000 /* include local interruption pending mask */
>> +#define IRQ_FLAG_FLOATING 0x4000 /* include float interruption pending mask */
>> +#define IRQ_FLAG_GISA     0x2000 /* include GISA interruption pending mask */
>> +
>> +#define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
>> +#define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
>> +
>>   /* handle external calls via sigp interpretation facility */
>>   static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>>   {
>> @@ -237,16 +244,18 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
>>   	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>>   }
>>   
>> -static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>> +static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
> 
> Any deeper reason why this is a u16? 16 bits should be enough for
> everyone? :)

I want to use the 8 bits for the IRQ type and the other 8 for additional 
controls, see: "KVM: s390: restore IAM in get_ipm() when IPM is clean"

> 
>>   {
>> -	return vcpu->kvm->arch.float_int.pending_irqs |
>> -		vcpu->arch.local_int.pending_irqs;
>> -}
>> +	unsigned long pending_irqs = 0;
>>   
>> -static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>> -{
>> -	return pending_irqs_no_gisa(vcpu) |
>> -		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
>> +	if (irq_flags & IRQ_FLAG_LOCAL)
>> +		pending_irqs |= vcpu->arch.local_int.pending_irqs;
>> +	if (irq_flags & IRQ_FLAG_FLOATING)
>> +		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
>> +	if (irq_flags & IRQ_FLAG_GISA)
>> +		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
>> +			IRQ_PEND_IO_ISC_7;
>> +	return pending_irqs;
>>   }
>>   
>>   static inline int isc_to_irq_type(unsigned long isc)
>> @@ -275,7 +284,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
>>   {
>>   	unsigned long active_mask;
>>   
>> -	active_mask = pending_irqs(vcpu);
>> +	active_mask = pending_irqs(vcpu, IRQ_MASK_ALL);
>>   	if (!active_mask)
>>   		return 0;
>>   
>> @@ -343,7 +352,7 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
>>   
>>   static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>>   {
>> -	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_IO_MASK))
>> +	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_IO_MASK))
> 
> I/O interrupts are always floating, so you probably could check for
> only floating (excluding gisa) irqs here.

That's right.

> 
>>   		return;
>>   	else if (psw_ioint_disabled(vcpu))
>>   		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);Store Data
>> @@ -353,7 +362,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>>   

