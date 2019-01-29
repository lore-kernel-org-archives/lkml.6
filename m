Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F901C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342212175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfA2QHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:07:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbfA2QHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:07:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TG0aPN068663
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:07:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qarv4mut6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:07:23 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 29 Jan 2019 16:07:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 16:07:07 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TG75iJ7078244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 16:07:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 710635205F;
        Tue, 29 Jan 2019 16:07:05 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.212])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0DF0D5205A;
        Tue, 29 Jan 2019 16:07:05 +0000 (GMT)
Date:   Tue, 29 Jan 2019 17:07:03 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
In-Reply-To: <42befe0d-ad84-5e34-a05a-0ffb4fcadd56@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
        <20190128175054.67979549@oc2783563651>
        <20190129142220.3f08a1e9.cohuck@redhat.com>
        <42befe0d-ad84-5e34-a05a-0ffb4fcadd56@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012916-0028-0000-0000-00000340632A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012916-0029-0000-0000-000023FD66C4
Message-Id: <20190129170703.25a81fa5@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=412 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 16:47:10 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> 
> 
> On 29.01.19 14:22, Cornelia Huck wrote:
> > On Mon, 28 Jan 2019 17:50:54 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> >> On Thu, 24 Jan 2019 13:59:33 +0100
> >> Michael Mueller <mimu@linux.ibm.com> wrote:
> >>
> >>> Use this struct analog to the kvm interruption structs
> >>> for kvm emulated floating and local interruptions.
> >>> Further fields will be added with this series as
> >>> required.
> >>>
> >>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >>
> >> While looking at this I was asking myself what guards against invalid
> >> gisa pointer dereference e.g. when pending_irqs() is called (see below).
> >>
> >> AFAIU we set up gisa_int.origin only if we have
> >> css_general_characteristics.aiv. Opinions?
> > 
> > I think you're right that this is a (pre-existing) problem.
> > 
> >>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> >>> index 942cc7d33766..ee91d1de0036 100644
> >>> --- a/arch/s390/kvm/interrupt.c
> >>> +++ b/arch/s390/kvm/interrupt.c
> >>> @@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
> >>>   static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
> >>>   {
> >>>   	return pending_irqs_no_gisa(vcpu) |
> >>> -		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> >>> +		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
> >>
> >> Unconditional call to gisa_get_ipm(), and get ipm just accesses ->ipm.
> > 
> > All other callers of this function check for gisa != NULL first, so
> > either we should check here as well or move the check into the
> > gisa_get_ipm() function.
> 
> I suggest to use an explicit test like this.
> 
>   static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>   {
> -       return pending_irqs_no_gisa(vcpu) |
> -               gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
> -                       IRQ_PEND_IO_ISC_7;
> +       struct kvm_s390_gisa_int *gi = &vcpu->kvm->arch.gisa_int;
> +       unsigned long pending_mask;
> +
> +       pending_mask = pending_irqs_no_gisa(vcpu);
> +       if (gi->origin)
> +               pending_mask |= gisa_get_ipm(gi->origin) << 
> IRQ_PEND_IO_ISC_7;
> +       return pending_mask;
>   }
> 

Works with me! Send a stand alone patch?

Regards,
Halil

