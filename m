Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-389341-1524843849-2-17109875915497068841
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524843848; b=figIyjvK1HMl5wsyOQkRzCKZu7RGYo8iQIuoeCGLvXwLqJ+c6l
    V7a0RUfGkur5AFj0tR7jbDAvvvAWeoMHoCwyr2hHlQkm+/5UmXVChFGObohnbS8k
    dBBDUdySQEepaQpOzYhOy/4ww/14kreQSGzEcKct1hr1z8ZtAHFlu4uSC585MW+e
    STtD8UPEHUWcBvthMwX3/rlAyH9JPODumN6h4hbR1CWYkCdWd3LJ1frZA1spTDUE
    gGuhth8pR0PnJaVDdqrH/t9JeyARhq+pyYkM9UUNVLaESx7sTlODb6FdQLnRWSW+
    bTIn8U4R9EddIrY5CdIjvRVqPNbnXX/DdfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524843848; bh=reFXBeVQsH0s
    RrhnTdAd33ozzcGex4fQRTqZB7zXfY8=; b=O1kBaDysMQ5EvktR6Kclui6dZl+k
    +CQvHXc9q2pj/U7sxA+t3dYfu+1o/Pvs971986q6DpEGGBpXVzY/e5E0OYI80xWo
    EXk1EKPA6KWT2/4tQ5jqXWkeg3rtferVLiRaS5kPWdF3Hqtu134whxofYpH0TzSy
    MvCYkI/SlCp/DOpykqcDBHva5newW/9oiqHdh1QA6tjquRV7rwbf8mNTuq9oevWc
    anxQtp3kJcbbRZhNZUnq2QPKmntDRkpBiS72E6Gpq/4LS2okQaAs/h73595UmdRA
    xHJjKSsWwJAdaljk01U30qmNsiRJmj03lRyQbAyT2wtDaiPG/cmcGf2ytw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBppwf4cSAmyNWThAiGwgWp+awLs5ZbqdgDmTEjTg3x0EMsW2TsIVZ+QvepyYSmd2hr3XKx2CTmabse2LyfWzm9O6ewwNvTHqnBvV5O7UXX/lL8dK09n
    nm7aJbUKhoe1G+lyW7bAE4kG9V0K/gQm4TBqrw8YcN9wE7PV6CYT0YPJLXwxT5SoPdb6vzuxg0GbBxxOevpzV8KiMis29gpwVhqQGhsgP/eCeY8lJ7USHPQu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=T-18XRjMz5vK44l3gssA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758264AbeD0PoF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:44:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758479AbeD0Pnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 11:43:50 -0400
Subject: Re: [PATCH 4.9 30/74] KVM: s390: wire up bpb feature
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180427135709.899303463@linuxfoundation.org>
 <20180427135711.180231855@linuxfoundation.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Date: Fri, 27 Apr 2018 17:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180427135711.180231855@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042715-0012-0000-0000-000005CFC66A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042715-0013-0000-0000-0000194CD4BB
Message-Id: <d71c5e5b-91cf-cdb0-6a3f-a6702d5f43b3@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270150
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> 
> From: Christian Borntraeger <borntraeger@de.ibm.com>

Minus the double author and the unrelated white space change this backport looks good.


> 
> [ Upstream commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60 ]
> 
> The new firmware interfaces for branch prediction behaviour changes
> are transparently available for the guest. Nevertheless, there is
> new state attached that should be migrated and properly resetted.
> Provide a mechanism for handling reset, migration and VSIE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [Changed capability number to 152. - Radim]
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/s390/include/asm/kvm_host.h |    3 ++-
>  arch/s390/include/uapi/asm/kvm.h |    5 ++++-
>  arch/s390/kvm/kvm-s390.c         |   13 ++++++++++++-
>  arch/s390/kvm/vsie.c             |   10 ++++++++++
>  include/uapi/linux/kvm.h         |    1 +
>  5 files changed, 29 insertions(+), 3 deletions(-)
> 
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -181,7 +181,8 @@ struct kvm_s390_sie_block {
>  	__u16	ipa;			/* 0x0056 */
>  	__u32	ipb;			/* 0x0058 */
>  	__u32	scaoh;			/* 0x005c */
> -	__u8	reserved60;		/* 0x0060 */
> +#define FPF_BPBC 	0x20
> +	__u8	fpf;			/* 0x0060 */
>  	__u8	ecb;			/* 0x0061 */
>  	__u8    ecb2;                   /* 0x0062 */
>  #define ECB3_AES 0x04
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -197,6 +197,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_VRS    (1UL << 6)
>  #define KVM_SYNC_RICCB  (1UL << 7)
>  #define KVM_SYNC_FPRS   (1UL << 8)
> +#define KVM_SYNC_BPBC	(1UL << 10)
>  /* definition of registers in kvm_run */
>  struct kvm_sync_regs {
>  	__u64 prefix;	/* prefix register */
> @@ -217,7 +218,9 @@ struct kvm_sync_regs {
>  	};
>  	__u8  reserved[512];	/* for future vector expansion */
>  	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
> -	__u8 padding[52];	/* riccb needs to be 64byte aligned */
> +	__u8 bpbc : 1;		/* bp mode */
> +	__u8 reserved2 : 7;
> +	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
>  	__u8 riccb[64];		/* runtime instrumentation controls block */
>  };
>  
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -401,6 +401,9 @@ int kvm_vm_ioctl_check_extension(struct
>  	case KVM_CAP_S390_RI:
>  		r = test_facility(64);
>  		break;
> +	case KVM_CAP_S390_BPB:
> +		r = test_facility(82);
> +		break;
>  	default:
>  		r = 0;
>  	}
> @@ -1713,6 +1716,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *
>  	kvm_s390_set_prefix(vcpu, 0);
>  	if (test_kvm_facility(vcpu->kvm, 64))
>  		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
> +	if (test_kvm_facility(vcpu->kvm, 82))
> +		vcpu->run->kvm_valid_regs |= KVM_SYNC_BPBC;
>  	/* fprs can be synchronized via vrs, even if the guest has no vx. With
>  	 * MACHINE_HAS_VX, (load|store)_fpu_regs() will work with vrs format.
>  	 */
> @@ -1829,7 +1834,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
>  	if (test_fp_ctl(current->thread.fpu.fpc))
>  		/* User space provided an invalid FPC, let's clear it */
>  		current->thread.fpu.fpc = 0;
> -
>  	save_access_regs(vcpu->arch.host_acrs);
>  	restore_access_regs(vcpu->run->s.regs.acrs);
>  	gmap_enable(vcpu->arch.enabled_gmap);
> @@ -1877,6 +1881,7 @@ static void kvm_s390_vcpu_initial_reset(
>  	current->thread.fpu.fpc = 0;
>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> +	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>  	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>  	kvm_clear_async_pf_completion_queue(vcpu);
>  	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> @@ -2744,6 +2749,11 @@ static void sync_regs(struct kvm_vcpu *v
>  		if (riccb->valid)
>  			vcpu->arch.sie_block->ecb3 |= 0x01;
>  	}
> +	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
> +	    test_kvm_facility(vcpu->kvm, 82)) {
> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
> +		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
> +	}
>  
>  	kvm_run->kvm_dirty_regs = 0;
>  }
> @@ -2762,6 +2772,7 @@ static void store_regs(struct kvm_vcpu *
>  	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
>  	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
>  	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
> +	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>  }
>  
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -217,6 +217,12 @@ static void unshadow_scb(struct kvm_vcpu
>  	memcpy(scb_o->gcr, scb_s->gcr, 128);
>  	scb_o->pp = scb_s->pp;
>  
> +	/* branch prediction */
> +	if (test_kvm_facility(vcpu->kvm, 82)) {
> +		scb_o->fpf &= ~FPF_BPBC;
> +		scb_o->fpf |= scb_s->fpf & FPF_BPBC;
> +	}
> +
>  	/* interrupt intercept */
>  	switch (scb_s->icptcode) {
>  	case ICPT_PROGI:
> @@ -259,6 +265,7 @@ static int shadow_scb(struct kvm_vcpu *v
>  	scb_s->ecb3 = 0;
>  	scb_s->ecd = 0;
>  	scb_s->fac = 0;
> +	scb_s->fpf = 0;
>  
>  	rc = prepare_cpuflags(vcpu, vsie_page);
>  	if (rc)
> @@ -316,6 +323,9 @@ static int shadow_scb(struct kvm_vcpu *v
>  			prefix_unmapped(vsie_page);
>  		scb_s->ecb |= scb_o->ecb & 0x10U;
>  	}
> +	/* branch prediction */
> +	if (test_kvm_facility(vcpu->kvm, 82))
> +		scb_s->fpf |= scb_o->fpf & FPF_BPBC;
>  	/* SIMD */
>  	if (test_kvm_facility(vcpu->kvm, 129)) {
>  		scb_s->eca |= scb_o->eca & 0x00020000U;
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -870,6 +870,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_S390_USER_INSTR0 130
>  #define KVM_CAP_MSI_DEVID 131
>  #define KVM_CAP_PPC_HTM 132
> +#define KVM_CAP_S390_BPB 152
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 
> 
