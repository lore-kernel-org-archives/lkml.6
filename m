Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB81C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8511E2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfA2PrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:47:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbfA2PrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:47:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TFigXC106672
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:47:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qasm68mrv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:47:15 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Tue, 29 Jan 2019 15:47:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 15:47:12 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TFlBKd7405998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 15:47:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0104A4059;
        Tue, 29 Jan 2019 15:47:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88CEBA4051;
        Tue, 29 Jan 2019 15:47:10 +0000 (GMT)
Received: from [9.152.224.122] (unknown [9.152.224.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 15:47:10 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-8-mimu@linux.ibm.com>
 <20190128175054.67979549@oc2783563651>
 <20190129142220.3f08a1e9.cohuck@redhat.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Tue, 29 Jan 2019 16:47:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129142220.3f08a1e9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012915-0028-0000-0000-00000340608A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012915-0029-0000-0000-000023FD6417
Message-Id: <42befe0d-ad84-5e34-a05a-0ffb4fcadd56@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=453 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.01.19 14:22, Cornelia Huck wrote:
> On Mon, 28 Jan 2019 17:50:54 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Thu, 24 Jan 2019 13:59:33 +0100
>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>
>>> Use this struct analog to the kvm interruption structs
>>> for kvm emulated floating and local interruptions.
>>> Further fields will be added with this series as
>>> required.
>>>
>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>
>> While looking at this I was asking myself what guards against invalid
>> gisa pointer dereference e.g. when pending_irqs() is called (see below).
>>
>> AFAIU we set up gisa_int.origin only if we have
>> css_general_characteristics.aiv. Opinions?
> 
> I think you're right that this is a (pre-existing) problem.
> 
>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>> index 942cc7d33766..ee91d1de0036 100644
>>> --- a/arch/s390/kvm/interrupt.c
>>> +++ b/arch/s390/kvm/interrupt.c
>>> @@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>>>   static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>>>   {
>>>   	return pending_irqs_no_gisa(vcpu) |
>>> -		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
>>> +		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
>>
>> Unconditional call to gisa_get_ipm(), and get ipm just accesses ->ipm.
> 
> All other callers of this function check for gisa != NULL first, so
> either we should check here as well or move the check into the
> gisa_get_ipm() function.

I suggest to use an explicit test like this.

  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
  {
-       return pending_irqs_no_gisa(vcpu) |
-               gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
-                       IRQ_PEND_IO_ISC_7;
+       struct kvm_s390_gisa_int *gi = &vcpu->kvm->arch.gisa_int;
+       unsigned long pending_mask;
+
+       pending_mask = pending_irqs_no_gisa(vcpu);
+       if (gi->origin)
+               pending_mask |= gisa_get_ipm(gi->origin) << 
IRQ_PEND_IO_ISC_7;
+       return pending_mask;
  }

Michael


> 
>>
>>> +			IRQ_PEND_IO_ISC_7;
>>>   }
>>>     
> 

