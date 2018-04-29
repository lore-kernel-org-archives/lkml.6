Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3121381-1524988313-2-9989194752281979952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524988312; b=TEuklAIQJGXrRnGVPpK99y9pQSi7PN89F/WQVDCQWmr9mGejbu
    4Fcv8Qqs2pKm0YI0Tm4qPp23lWp55HTC4eqqhInW0BdmcI+FVag29x+b2C3UhsPd
    0Hm/VQq9ZibjL0thfEenrlECDteKKszoee0ANgr9PYIhP2tNO0JmnlaL7o1CH9Yd
    H8u4hgVFw0Eydrzrk9QVQZT4ecT6v+MpUPCwnN8UZf5cHZX3J+cKJr4EKpbZ2CBa
    SB7xdclMW7QNzwsRQl+b6vWw+O2AdZ0Scj4+NByJlx01o8LrrD7g+5iy0468GIzG
    zw33CBjvV8Wxt1rNzr1XNoulipnarUbt+PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :references:mime-version:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524988312; bh=4J8Uh+jwLB0d
    w62tuJIySjkpP9AEq94uRsq+Mc93JOo=; b=UtMei0GqvLGBnp0BkZzeK/oHaCvi
    e2/CCEUNxIjWdkwGN3B9eWO93qQU63VI71i9fAN87yB3HEG+Oxx6dbORgZm9mnOT
    QxvuHpKVnVXgnpY0ljJeyE4V8OJPDMu9PBl7CsMfo3FWKCHVrRx0hR97HWXhM/93
    6QBZPL4qjUXAc4F5OGKmYNIiCDIHpVTCPKF51RGv2cXEpaekvQf7KYYtpUIzPZBl
    mKoGxZwKsSlPBUQ3eIdWYXJfgrwkPg0Tmsf0LdYhTEe8Xy++NKVgfs+tp9FE6T64
    0zwRKB5Yo6bJ+dy+UcdtUqBlRbH7eq3oLv1YavbTP0ISID13Y9jzJW3+/g==
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
X-CM-Envelope: MS4wfHisgY+M+dUJ00U6mqyr5dfp68hPE1OPEDxD6lpoETioFYxm5kJr2S/BB2BE5O14aVH0vlTjfjQpR+rtqFq6CVa5DIq5YeAJTQpUK5gUd6qM1VqRVxBR
    eKHKpzJP8KFUzvt140+myudQtWHrRuoZmxedWtXM8g/GKc5thBq0+BIxwZdvVkqjjSebf7L35zEL471CTytxneZ0ze5+ga7skVRetgL7n0A7YbputRHwj/8g
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pYgt6eG2Hn3diD32Eq0A:9
    a=I-nUZHcaznFeBLo4:21 a=4DFBeLtKNzJnC8ro:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeD2Hvg convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 29 Apr 2018 03:51:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752595AbeD2Hvf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Apr 2018 03:51:35 -0400
Date: Sun, 29 Apr 2018 09:51:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
In-Reply-To: <f8e1244f-d5b8-1eb9-4e71-fb4b0dd7d610@de.ibm.com>
References: <20180427135655.623669681@linuxfoundation.org>
        <20180427135656.428437126@linuxfoundation.org>
        <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
        <20180427151715.GA3876@kroah.com>
        <20180427154650.GA15121@kroah.com>
        <f8e1244f-d5b8-1eb9-4e71-fb4b0dd7d610@de.ibm.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18042907-0040-0000-0000-00000453234E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042907-0041-0000-0000-000020F73701
Message-Id: <20180429095127.59f76a1e@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804290078
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 17:53:46 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 04/27/2018 05:46 PM, Greg Kroah-Hartman wrote:
> > On Fri, Apr 27, 2018 at 05:17:15PM +0200, Greg Kroah-Hartman wrote:  
> >> On Fri, Apr 27, 2018 at 05:10:04PM +0200, Christian Borntraeger wrote:  
> >>>
> >>>
> >>> On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:  
> >>>> 4.4-stable review patch.  If anyone has any objections, please let me know.
> >>>>
> >>>> ------------------
> >>>>
> >>>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >>>>
> >>>>
> >>>> From: Christian Borntraeger <borntraeger@de.ibm.com>  
> >>
> >> Ick, that is wrong right there, my scripts messed up, this should not
> >> have 2 author lines :(
> >>
> >> I'll go look at all of these, odds are it made the same error
> >> everywhere...  
> > 
> > Yes, I've now fixed that up in the queue.  
> 
> As this patch backport was also functionally incorrect and Martin is already away
> do you want me to send an updated version?

Checked my 4.4 backport git branch and indeed the hunk is misplaced.
Sometime I wonder about the patch tool and the hickups it can produce.

My take on the replacement patch looks as follows:

---
>From 82f20b6237a8d04378c8f4a1614bf32a6c8d8a8b Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 14:44:34 +0100
Subject: [PATCH 03/18] KVM: s390: wire up bpb feature
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60 ]

The new firmware interfaces for branch prediction behaviour changes
are transparently available for the guest. Nevertheless, there is
new state attached that should be migrated and properly resetted.
Provide a mechanism for handling reset, migration and VSIE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[Changed capability number to 152. - Radim]
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 ++-
 arch/s390/include/uapi/asm/kvm.h |  3 +++
 arch/s390/kvm/kvm-s390.c         | 12 ++++++++++++
 include/uapi/linux/kvm.h         |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e9a983f40a24..7d9c5917da2b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -136,7 +136,8 @@ struct kvm_s390_sie_block {
 	__u16	ipa;			/* 0x0056 */
 	__u32	ipb;			/* 0x0058 */
 	__u32	scaoh;			/* 0x005c */
-	__u8	reserved60;		/* 0x0060 */
+#define FPF_BPBC 	0x20
+	__u8	fpf;			/* 0x0060 */
 	__u8	ecb;			/* 0x0061 */
 	__u8    ecb2;                   /* 0x0062 */
 #define ECB3_AES 0x04
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index ef1a5fcc6c66..3aec52253c04 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -151,6 +151,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_ARCH0  (1UL << 4)
 #define KVM_SYNC_PFAULT (1UL << 5)
 #define KVM_SYNC_VRS    (1UL << 6)
+#define KVM_SYNC_BPBC	(1UL << 10)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -168,6 +169,8 @@ struct kvm_sync_regs {
 	__u64 vrs[32][2];	/* vector registers */
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;	/* only valid with vector registers */
+	__u8 bpbc : 1;		/* bp mode */
+	__u8 reserved2 : 7;
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 23e3f5d77a24..ca03c847127a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -257,6 +257,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_VECTOR_REGISTERS:
 		r = MACHINE_HAS_VX;
 		break;
+	case KVM_CAP_S390_BPB:
+		r = test_facility(82);
+		break;
 	default:
 		r = 0;
 	}
@@ -1262,6 +1265,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 				    KVM_SYNC_CRS |
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT;
+	if (test_kvm_facility(vcpu->kvm, 82))
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_BPBC;
 	if (test_kvm_facility(vcpu->kvm, 129))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
 
@@ -1327,6 +1332,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	current->thread.fpu.fpc = 0;
 	vcpu->arch.sie_block->gbea = 1;
 	vcpu->arch.sie_block->pp = 0;
+	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
@@ -2145,6 +2151,11 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
 			kvm_clear_async_pf_completion_queue(vcpu);
 	}
+	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
+	    test_kvm_facility(vcpu->kvm, 82)) {
+		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
+		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
+	}
 	kvm_run->kvm_dirty_regs = 0;
 }
 
@@ -2162,6 +2173,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
 	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
 	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
+	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 03f3618612aa..376d0ab5b9f2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
 #define KVM_CAP_SPLIT_IRQCHIP 121
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
+#define KVM_CAP_S390_BPB 152
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.13.5
