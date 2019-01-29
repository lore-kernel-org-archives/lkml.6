Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5448C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866B82147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfA2N1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:27:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbfA2N1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:27:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TDNIsF024087
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:27:34 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qamfabatt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:27:14 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 29 Jan 2019 13:26:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 13:26:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TDQiFO53149802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 13:26:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E63511C054;
        Tue, 29 Jan 2019 13:26:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3958A11C052;
        Tue, 29 Jan 2019 13:26:44 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.212])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 13:26:44 +0000 (GMT)
Date:   Tue, 29 Jan 2019 14:26:42 +0100
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
Subject: Re: [PATCH v6 12/13] KVM: s390: add gib_alert_irq_handler()
In-Reply-To: <20190124125939.130763-13-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-13-mimu@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012913-0012-0000-0000-000002EE708F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012913-0013-0000-0000-00002125B327
Message-Id: <20190129142642.3a94a5f1@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 13:59:38 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The patch implements a handler for GIB alert interruptions
> on the host. Its task is to alert guests that interrupts are
> pending for them.
> 
> A GIB alert interrupt statistic counter is added as well:
> 
> $ cat /proc/interrupts
>           CPU0       CPU1
>   ...
>   GAL:      23         37   [I/O] GIB Alert
>   ...
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
[..]
> +/**
> + * gisa_get_ipm_or_restore_iam - return IPM or restore GISA IAM
> + *
> + * @gi: gisa interrupt struct to work on
> + *
> + * Atomically restores the interruption alert mask if none of the
> + * relevant ISCs are pending and return the IPM.

The word 'relevant' probably reflects some previous state. It does not
bother me too much.

[..]

>  
> +static void __airqs_kick_single_vcpu(struct kvm *kvm, u8 deliverable_mask)
> +{
> +	int vcpu_id, online_vcpus = atomic_read(&kvm->online_vcpus);
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +	struct kvm_vcpu *vcpu;
> +
> +	for_each_set_bit(vcpu_id, kvm->arch.idle_mask, online_vcpus) {
> +		vcpu = kvm_get_vcpu(kvm, vcpu_id);
> +		if (psw_ioint_disabled(vcpu))
> +			continue;
> +		deliverable_mask &= (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
> +		if (deliverable_mask) {
> +			/* lately kicked but not yet running */

How about /* was kicked but didn't run yet */?

> +			if (test_and_set_bit(vcpu_id, gi->kicked_mask))
> +				return;
> +			kvm_s390_vcpu_wakeup(vcpu);
> +			return;
> +		}
> +	}
> +}
> +

[..]

> +static void process_gib_alert_list(void)
> +{
> +	struct kvm_s390_gisa_interrupt *gi;
> +	struct kvm_s390_gisa *gisa;
> +	struct kvm *kvm;
> +	u32 final, origin = 0UL;
> +
> +	do {
> +		/*
> +		 * If the NONE_GISA_ADDR is still stored in the alert list
> +		 * origin, we will leave the outer loop. No further GISA has
> +		 * been added to the alert list by millicode while processing
> +		 * the current alert list.
> +		 */
> +		final = (origin & NONE_GISA_ADDR);
> +		/*
> +		 * Cut off the alert list and store the NONE_GISA_ADDR in the
> +		 * alert list origin to avoid further GAL interruptions.
> +		 * A new alert list can be build up by millicode in parallel
> +		 * for guests not in the yet cut-off alert list. When in the
> +		 * final loop, store the NULL_GISA_ADDR instead. This will re-
> +		 * enable GAL interruptions on the host again.
> +		 */
> +		origin = xchg(&gib->alert_list_origin,
> +			      (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
> +		/*
> +		 * Loop through the just cut-off alert list and start the
> +		 * gisa timers to kick idle vcpus to consume the pending
> +		 * interruptions asap.
> +		 */
> +		while (origin & GISA_ADDR_MASK) {
> +			gisa = (struct kvm_s390_gisa *)(u64)origin;
> +			origin = gisa->next_alert;
> +			gisa->next_alert = (u32)(u64)gisa;
> +			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
> +			gi = &kvm->arch.gisa_int;
> +			if (hrtimer_active(&gi->timer))
> +				hrtimer_cancel(&gi->timer);
> +			hrtimer_start(&gi->timer, 0, HRTIMER_MODE_REL);
> +		}
> +	} while (!final);
> +
> +}
> +
>  void kvm_s390_gisa_clear(struct kvm *kvm)
>  {
>  	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>  
>  	if (!gi->origin)
>  		return;
> -	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
> -	gi->origin->next_alert = (u32)(u64)gi->origin;
> +	gisa_clear_ipm(gi->origin);

This could be a separate patch. I would like little more explanation
to this.

>  	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
>  }
>  
> @@ -2940,13 +3078,25 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>  	gi->origin = &kvm->arch.sie_page2->gisa;
>  	gi->alert.mask = 0;
>  	spin_lock_init(&gi->alert.ref_lock);
> -	kvm_s390_gisa_clear(kvm);
> +	gi->expires = 50 * 1000; /* 50 usec */

I blindly trust your choice here ;) 

> +	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	gi->timer.function = gisa_vcpu_kicker;
> +	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
> +	gi->origin->next_alert = (u32)(u64)gi->origin;
>  	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>  }
>  
>  void kvm_s390_gisa_destroy(struct kvm *kvm)
>  {
> -	kvm->arch.gisa_int.origin = NULL;
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +
> +	if (!gi->origin)
> +		return;
> +	hrtimer_cancel(&gi->timer);

I'm not sure this cancel here is sufficient. 

> +	WRITE_ONCE(gi->alert.mask, 0);
> +	while (gisa_in_alert_list(gi->origin))
> +		cpu_relax();

If you end up waiting here, I guess, it's likely that a new
timer is going to get set up right after we do
gisa->next_alert = (u32)(u64)gisa;
in  process_gib_alert_list().

> +	gi->origin = NULL;
>  }
>  
>  /**
> @@ -3037,11 +3187,23 @@ int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
>  }
>  EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
>  


Overall, there are couple of things I would prefer done differently,
but better something working today that something prefect in 6 months.
In that sense, provided my comment regarding destroy is addressed:

Acked-by: Halil Pasic <pasic@linux.ibm.com>

