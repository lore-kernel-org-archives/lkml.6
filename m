Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD0FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CB921741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfA1QvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:51:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729197AbfA1QvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:51:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SGhbtc069472
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:51:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qa3ye5r17-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:51:03 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 28 Jan 2019 16:51:01 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 16:50:58 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SGouVp3539248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 16:50:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A309942041;
        Mon, 28 Jan 2019 16:50:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47BE542049;
        Mon, 28 Jan 2019 16:50:56 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.97.178])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 16:50:56 +0000 (GMT)
Date:   Mon, 28 Jan 2019 17:50:54 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
In-Reply-To: <20190124125939.130763-8-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012816-0012-0000-0000-000002EE0A8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012816-0013-0000-0000-0000212549ED
Message-Id: <20190128175054.67979549@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=644 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 13:59:33 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Use this struct analog to the kvm interruption structs
> for kvm emulated floating and local interruptions.
> Further fields will be added with this series as
> required.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

While looking at this I was asking myself what guards against invalid
gisa pointer dereference e.g. when pending_irqs() is called (see below).

AFAIU we set up gisa_int.origin only if we have
css_general_characteristics.aiv. Opinions?

Anyway if it is a problem, it is a pre-existing one (should be fixed
ASAP but does not affect the validity of this patch).

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h |  6 ++++-
>  arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
>  arch/s390/kvm/kvm-s390.c         |  2 +-
>  3 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c259a67c4298..0941571d34eb 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -803,6 +803,10 @@ struct kvm_s390_vsie {
>  	struct page *pages[KVM_MAX_VCPUS];
>  };
>  

[..]

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 942cc7d33766..ee91d1de0036 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>  {
>  	return pending_irqs_no_gisa(vcpu) |
> -		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> +		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<

Unconditional call to gisa_get_ipm(), and get ipm just accesses ->ipm.

> +			IRQ_PEND_IO_ISC_7;
>  }
>  

[..]

>  void kvm_s390_gisa_init(struct kvm *kvm)
>  {
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +
>  	if (!css_general_characteristics.aiv)
>  		return;
> -	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> +	gi->origin = &kvm->arch.sie_page2->gisa;

Should stay NULL if !css_general_characteristics.aiv.

>  	kvm_s390_gisa_clear(kvm);
> -	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> +	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>  }
>  

