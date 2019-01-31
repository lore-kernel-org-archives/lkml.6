Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27E2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908C0218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfAaOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:39:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730586AbfAaOju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:39:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VEU0VI137782
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:39:49 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qc2hm1gh4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:39:48 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 31 Jan 2019 14:39:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 14:39:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VEdhvP60686584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 14:39:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D0B411C04C;
        Thu, 31 Jan 2019 14:39:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2B3911C04A;
        Thu, 31 Jan 2019 14:39:42 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.212])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 14:39:42 +0000 (GMT)
Date:   Thu, 31 Jan 2019 15:39:41 +0100
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
Subject: Re: [PATCH v7 12/15] KVM: s390: kvm_s390_gisa_clear() now clears
 the IPM only
In-Reply-To: <20190131085247.13826-13-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
        <20190131085247.13826-13-mimu@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013114-4275-0000-0000-000003086378
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013114-4276-0000-0000-000038166D58
Message-Id: <20190131153941.4b69e3bb@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 09:52:43 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Function kvm_s390_gisa_clear() now clears the Interruption
> Pending Mask of the GISA asap. If the GISA is in the alert
> list at this time it stays in the list but is removed by
> process_gib_alert_list().
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index f37dfb01c63c..341664b94491 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -249,6 +249,25 @@ static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
>  	return 0;
>  }
>  
> +/**
> + * gisa_clear_ipm - clear the GISA interruption pending mask
> + *
> + * @gisa: gisa to operate on
> + *
> + * Clear the IPM atomically with the next alert address and the IAM
> + * of the GISA unconditionally. All three fields are located in the
> + * first long word of the GISA.
> + */
> +static inline void gisa_clear_ipm(struct kvm_s390_gisa *gisa)
> +{
> +	u64 word, _word;
> +
> +	do {
> +		word = READ_ONCE(gisa->u64.word[0]);
> +		_word = word & ~(0xffUL << 24);
> +	} while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
> +}
> +
>  static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
>  	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> @@ -2926,8 +2945,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>  
>  	if (!gi->origin)
>  		return;
> -	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
> -	gi->origin->next_alert = (u32)(u64)gi->origin;
> +	gisa_clear_ipm(gi->origin);
>  	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
>  }

I'm a bit confused. Now all kvm_s390_gisa_clear() does to the gisa is
gisa_clear_ipm(). The only usage I see is triggered by
KVM_DEV_FLIC_CLEAR_IRQS. And in that context this seems appropriate.

However gisa can hold other stuff than the ipm, and in that sense
the name kvm_s390_gisa_clear() may be misleading. I ask myself
questions like who would need to reset simm and nimm on system
reset. At the moment we don't use these AFAICT, so I guess it does not
matter.

Thus not a showstopper to me:

Acked-by: Halil Pasic <pasic@linux.ibm.com>


>  
> @@ -2940,7 +2958,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>  	gi->origin = &kvm->arch.sie_page2->gisa;
>  	gi->alert.mask = 0;
>  	spin_lock_init(&gi->alert.ref_lock);
> -	kvm_s390_gisa_clear(kvm);
> +	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
> +	gi->origin->next_alert = (u32)(u64)gi->origin;
>  	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>  }
>  

