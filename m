Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF26218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfACOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:44:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727932AbfACOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:44:15 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x03Ecs5c074331
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 09:44:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2psj6g6hru-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:44:10 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 3 Jan 2019 14:44:02 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 14:44:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x03EhxjW3604832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 14:43:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B2644204D;
        Thu,  3 Jan 2019 14:43:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFBCB42045;
        Thu,  3 Jan 2019 14:43:58 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jan 2019 14:43:58 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
To:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 3 Jan 2019 15:43:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219191756.57973-14-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010314-4275-0000-0000-000002F9229F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010314-4276-0000-0000-0000380722CB
Message-Id: <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 20:17, Michael Mueller wrote:
> This function processes the Gib Alert List (GAL). It is required
> to run when either a gib alert interruption has been received or
> a gisa that is in the alert list is cleared or dropped.
> 
> The GAL is build up by millicode, when the respective ISC bit is
> set in the Interruption Alert Mask (IAM) and an interruption of
> that class is observed.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 140 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 48a93f5e5333..03e7ba4f215a 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>   	return n;
>   }
>   
> +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)

static inline ?

> +{
> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> +	struct kvm_vcpu *vcpu = NULL, *kick_vcpu[MAX_ISC + 1];
> +	int online_vcpus = atomic_read(&kvm->online_vcpus);
> +	u8 ioint_mask, isc_mask, kick_mask = 0x00;
> +	int vcpu_id, kicked = 0;
> +
> +	/* Loop over vcpus in WAIT state. */
> +	for (vcpu_id = find_first_bit(fi->idle_mask, online_vcpus);
> +	     /* Until all pending ISCs have a vcpu open for airqs. */
> +	     (~kick_mask & ipm) && vcpu_id < online_vcpus;
> +	     vcpu_id = find_next_bit(fi->idle_mask, online_vcpus, vcpu_id)) {
> +		vcpu = kvm_get_vcpu(kvm, vcpu_id);
> +		if (psw_ioint_disabled(vcpu))
> +			continue;
> +		ioint_mask = (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
> +		for (isc_mask = 0x80; isc_mask; isc_mask >>= 1) {
> +			/* ISC pending in IPM ? */
> +			if (!(ipm & isc_mask))
> +				continue;
> +			/* vcpu for this ISC already found ? */
> +			if (kick_mask & isc_mask)
> +				continue;
> +			/* vcpu open for airq of this ISC ? */
> +			if (!(ioint_mask & isc_mask))
> +				continue;
> +			/* use this vcpu (for all ISCs in ioint_mask) */
> +			kick_mask |= ioint_mask; > +			kick_vcpu[kicked++] = vcpu;
> +		}
> +	}
> +
> +	if (vcpu && ~kick_mask & ipm)
> +		VM_EVENT(kvm, 4, "gib alert undeliverable isc mask 0x%02x",
> +			 ~kick_mask & ipm);
> +
> +	for (vcpu_id = 0; vcpu_id < kicked; vcpu_id++)
> +		kvm_s390_vcpu_wakeup(kick_vcpu[vcpu_id]);
> +
> +	return (online_vcpus != 0) ? kicked : -ENODEV;
> +}
> +
> +static void __floating_airqs_kick(struct kvm *kvm)
static inline ?

> +{
> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> +	int online_vcpus, kicked;
> +	u8 ipm_t0, ipm;
> +
> +	/* Get IPM and return if clean, IAM has been restored. */
> +	ipm = get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM);

If we do not get an IPM here, it must have been stolen by the firmware 
for delivery to the guest.
Then why restoring the IAM?

Or do I miss something?

> +	if (!ipm)
> +		return;
> +retry:
> +	ipm_t0 = ipm;
> +
> +	/* Try to kick some vcpus in WAIT state. */
> +	kicked = __try_airqs_kick(kvm, ipm);
> +	if (kicked < 0)
> +		return;
> +
> +	/* Get IPM and return if clean, IAM has been restored. */
> +	ipm = get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM);
> +	if (!ipm)
> +		return;
> +
> +	/* Start over, if new ISC bits are pending in IPM. */
> +	if ((ipm_t0 ^ ipm) & ~ipm_t0)
> +		goto retry;
> +
> +	/*
> +	 * Return as we just kicked at least one vcpu in WAIT state
> +	 * open for airqs. The IAM will be restored latest when one
> +	 * of them goes into WAIT or STOP state.
> +	 */
> +	if (kicked > 0)
> +		return;
> +
> +	/*
> +	 * No vcpu was kicked either because no vcpu was in WAIT state
> +	 * or none of the vcpus in WAIT state are open for airqs.
> +	 * Return immediately if no vcpus are in WAIT state.
> +	 * There are vcpus in RUN state. They will process the airqs
> +	 * if not closed for airqs as well. In that case the system will
> +	 * delay airqs until a vcpu decides to take airqs again.
> +	 */
> +	online_vcpus = atomic_read(&kvm->online_vcpus);
> +	if (!bitmap_weight(fi->idle_mask, online_vcpus))
> +		return;
> +
> +	/*
> +	 * None of the vcpus in WAIT state take airqs and we might
> +	 * have no running vcpus as at least one vcpu is in WAIT state
> +	 * and IPM is dirty.
> +	 */
> +	set_iam(kvm->arch.gisa, kvm->arch.iam);

I do not understand why we need to set IAM here.
The interrupt will be delivered by the firmware as soon as the PSW or 
CR6 is changed by any vCPU.
...and if this does not happen we can not deliver the interrupt anyway.

> +}
> +
> +#define NULL_GISA_ADDR 0x00000000UL
> +#define NONE_GISA_ADDR 0x00000001UL
> +#define GISA_ADDR_MASK 0xfffff000UL
> +
> +static void __maybe_unused process_gib_alert_list(void)
> +{
> +	u32 final, next_alert, origin = 0UL;
> +	struct kvm_s390_gisa *gisa;
> +	struct kvm *kvm;
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
> +		/* Loop through the just cut-off alert list. */
> +		while (origin & GISA_ADDR_MASK) {
> +			gisa = (struct kvm_s390_gisa *)(u64)origin;
> +			next_alert = gisa->next_alert;
> +			/* Unlink the GISA from the alert list. */
> +			gisa->next_alert = origin;

AFAIU this enable GISA interrupt for the guest...

> +			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
> +			/* Kick suitable vcpus */
> +			__floating_airqs_kick(kvm);

...and here we kick a VCPU for the guest.

Logically I would do it in the otherway, first kicking the vCPU then 
enabling the GISA interruption again.

If the IPM bit is cleared by the firmware during delivering the 
interrupt to the guest before we enter get_ipm() called by 
__floating_airqs_kick() we will set the IAM despite we have a running 
CPU handling the IRQ.
In the worst case we can also set the IAM with the GISA in the alert list.
Or we must accept that the firmware can deliver the IPM as soon as we 
reset the GISA next field.

> +			origin = next_alert;
> +		}
> +	} while (!final);
> +}
> +
>   static void nullify_gisa(struct kvm_s390_gisa *gisa)
>   {
>   	memset(gisa, 0, sizeof(struct kvm_s390_gisa));
> 

I think that avoiding to restore the IAM during the call to get_ipm 
inside __floating_airqs_kick() would good.

If you agree, with that:

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

