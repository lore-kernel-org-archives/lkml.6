Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8678C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbfAIQSP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:18:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731219AbfAIQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:18:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09G4Dfb031233
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 11:18:12 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwjn9wq64-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:18:12 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 9 Jan 2019 16:18:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 16:18:08 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09GI6GB5505318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 16:18:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E26A4C046;
        Wed,  9 Jan 2019 16:18:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A65D4C064;
        Wed,  9 Jan 2019 16:18:06 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.225])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 16:18:06 +0000 (GMT)
Date:   Wed, 9 Jan 2019 17:18:04 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     mimu@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function
 process_gib_alert_list()
In-Reply-To: <b5d42266-3c14-acd1-7f22-9f2cd5d7b443@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-14-mimu@linux.ibm.com>
        <20190108135919.18048dd4@oc2783563651>
        <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
        <01566362-d452-c04b-0509-cdcc758bc1e1@linux.ibm.com>
        <20190109141015.3023fb55@oc2783563651>
        <b5d42266-3c14-acd1-7f22-9f2cd5d7b443@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19010916-0028-0000-0000-0000033697DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010916-0029-0000-0000-000023F3A963
Message-Id: <20190109171804.13767bcd@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 15:49:56 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 09/01/2019 14:10, Halil Pasic wrote:
> > On Wed, 9 Jan 2019 13:14:17 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > 
> >> On 08/01/2019 16:21, Michael Mueller wrote:
> >>>
> >>>
> >>> On 08.01.19 13:59, Halil Pasic wrote:
> >>>> On Wed, 19 Dec 2018 20:17:54 +0100
> >>>> Michael Mueller <mimu@linux.ibm.com> wrote:
> >>>>
> >>>>> This function processes the Gib Alert List (GAL). It is required
> >>>>> to run when either a gib alert interruption has been received or
> >>>>> a gisa that is in the alert list is cleared or dropped.
> >>>>>
> >>>>> The GAL is build up by millicode, when the respective ISC bit is
> >>>>> set in the Interruption Alert Mask (IAM) and an interruption of
> >>>>> that class is observed.
> >>>>>
> >>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >>>>> ---
> >>>>>    arch/s390/kvm/interrupt.c | 140
> >>>>> ++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>    1 file changed, 140 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> >>>>> index 48a93f5e5333..03e7ba4f215a 100644
> >>>>> --- a/arch/s390/kvm/interrupt.c
> >>>>> +++ b/arch/s390/kvm/interrupt.c
> >>>>> @@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu
> >>>>> *vcpu, __u8 __user *buf, int len)
> >>>>>        return n;
> >>>>>    }
> >>>>> +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)
> >>>>> +{
> >>>>> +    struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> >>>>> +    struct kvm_vcpu *vcpu = NULL, *kick_vcpu[MAX_ISC + 1];
> >>>>> +    int online_vcpus = atomic_read(&kvm->online_vcpus);
> >>>>> +    u8 ioint_mask, isc_mask, kick_mask = 0x00;
> >>>>> +    int vcpu_id, kicked = 0;
> >>>>> +
> >>>>> +    /* Loop over vcpus in WAIT state. */
> >>>>> +    for (vcpu_id = find_first_bit(fi->idle_mask, online_vcpus);
> >>>>> +         /* Until all pending ISCs have a vcpu open for airqs. */
> >>>>> +         (~kick_mask & ipm) && vcpu_id < online_vcpus;
> >>>>> +         vcpu_id = find_next_bit(fi->idle_mask, online_vcpus,
> >>>>> vcpu_id)) {
> >>>>> +        vcpu = kvm_get_vcpu(kvm, vcpu_id);
> >>>>> +        if (psw_ioint_disabled(vcpu))
> >>>>> +            continue;
> >>>>> +        ioint_mask = (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
> >>>>> +        for (isc_mask = 0x80; isc_mask; isc_mask >>= 1) {
> >>>>> +            /* ISC pending in IPM ? */
> >>>>> +            if (!(ipm & isc_mask))
> >>>>> +                continue;
> >>>>> +            /* vcpu for this ISC already found ? */
> >>>>> +            if (kick_mask & isc_mask)
> >>>>> +                continue;
> >>>>> +            /* vcpu open for airq of this ISC ? */
> >>>>> +            if (!(ioint_mask & isc_mask))
> >>>>> +                continue;
> >>>>> +            /* use this vcpu (for all ISCs in ioint_mask) */
> >>>>> +            kick_mask |= ioint_mask;
> >>>>> +            kick_vcpu[kicked++] = vcpu;
> >>>>
> >>>> Assuming that the vcpu can/will take all ISCs it's currently open for
> >>>> does not seem right. We kind of rely on this assumption here, or?
> >>
> >> why does it not seem right?
> >>
> > 
> > When an interrupt is delivered a psw-swap takes place. The new-psw
> > may fence IO interrupts. Thus for example if we have the vcpu open for
> > all ISCs and 0, 1 and 2 pending, we may end up only delivering 0, if the
> > psw-swap corresponding to delivering 0 closes the vcpu for IO
> > interrupts. After guest has control, we don't have control over the rest
> > of the story.
> 
> OK I think I understand your concern, waking up a single waiting vCPU 
> per ISC is not enough.
> We must wake all vCPU in wait state having at least one matching ISC bit.
> 

That is not what I was trying to say, and IMHO generally it also ain't
true that we must. But I may be missing something.

Regards,
Halil

