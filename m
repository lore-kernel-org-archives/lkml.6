Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E399C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C962080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeLSTSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:18:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730369AbeLSTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:18:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIwewJ133212
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pfs981gtc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 19 Dec 2018 19:18:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 19:18:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJJI8Da6619412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:18:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A81852051;
        Wed, 19 Dec 2018 19:18:08 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B418D52050;
        Wed, 19 Dec 2018 19:18:07 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 06/15] KVM: s390: remove prefix kvm_s390_gisa_ from static inline functions
Date:   Wed, 19 Dec 2018 20:17:47 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121919-4275-0000-0000-000002F2F263
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121919-4276-0000-0000-00003800FA76
Message-Id: <20181219191756.57973-7-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will shorten the length of code lines.
All GISA related static inline functions are local to interrupt.c

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4ab20d2eb180..9b1fa39b6f90 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -224,22 +224,22 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
-static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
+static inline u8 get_ipm(struct kvm_s390_gisa *gisa)
 {
 	return READ_ONCE(gisa->ipm);
 }
 
-static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline int tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
@@ -253,7 +253,7 @@ static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
 	if (irq_flags & IRQ_FLAG_FLOATING)
 		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
 	if (irq_flags & IRQ_FLAG_GISA)
-		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
+		pending_irqs |= get_ipm(vcpu->kvm->arch.gisa) <<
 			IRQ_PEND_IO_ISC_7;
 	return pending_irqs;
 }
@@ -1008,7 +1008,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	}
 
 	if (vcpu->kvm->arch.gisa &&
-	    kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+	    tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
 		/*
 		 * in case an adapter interrupt was not delivered
 		 * in SIE context KVM will handle the delivery
@@ -1550,10 +1550,10 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 	if (!kvm->arch.gisa)
 		goto out;
 
-	active_mask = (isc_mask & kvm_s390_gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & get_ipm(kvm->arch.gisa) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
-		if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+		if (tac_ipm_gisc(kvm->arch.gisa, isc))
 			return isc;
 		clear_bit_inv(isc, &active_mask);
 	}
@@ -1593,7 +1593,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	/* both types of interrupts present */
 	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
 		/* classical IO int with higher priority */
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		set_ipm_gisc(kvm->arch.gisa, isc);
 		goto out;
 	}
 gisa_out:
@@ -1605,7 +1605,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 			kvm_s390_reinject_io_int(kvm, inti);
 		inti = tmp_inti;
 	} else
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		set_ipm_gisc(kvm->arch.gisa, isc);
 out:
 	return inti;
 }
@@ -1703,7 +1703,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 
 	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
 		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		set_ipm_gisc(kvm->arch.gisa, isc);
 		kfree(inti);
 		return 0;
 	}
@@ -2036,14 +2036,14 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
 	if (kvm->arch.gisa &&
-	    kvm_s390_gisa_get_ipm(kvm->arch.gisa)) {
+	    get_ipm(kvm->arch.gisa)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+			if (tac_ipm_gisc(kvm->arch.gisa, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
-- 
2.13.4

