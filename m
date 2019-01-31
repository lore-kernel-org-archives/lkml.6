Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11905C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E154D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfAaIyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:54:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730442AbfAaIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:26 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V8hsiZ111749
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:25 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qbtrer9xf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Jan 2019 08:53:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 08:53:20 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V8rJLk57213002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 08:53:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A8E342047;
        Thu, 31 Jan 2019 08:53:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB6CE42041;
        Thu, 31 Jan 2019 08:53:18 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 08:53:18 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v7 06/15] KVM: s390: remove kvm_s390_ from gisa static inline functions
Date:   Thu, 31 Jan 2019 09:52:37 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013108-0008-0000-0000-000002B935BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0009-0000-0000-000022253768
Message-Id: <20190131085247.13826-7-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will shorten the length of code lines. All GISA related
static inline functions are local to interrupt.c.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index cb48736867ed..942cc7d33766 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -217,22 +217,22 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
-static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
+static inline u8 gisa_get_ipm(struct kvm_s390_gisa *gisa)
 {
 	return READ_ONCE(gisa->ipm);
 }
 
-static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline void gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
+static inline int gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
@@ -246,7 +246,7 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
 	return pending_irqs_no_gisa(vcpu) |
-		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
+		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
@@ -999,7 +999,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	}
 
 	if (vcpu->kvm->arch.gisa &&
-	    kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+	    gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
 		/*
 		 * in case an adapter interrupt was not delivered
 		 * in SIE context KVM will handle the delivery
@@ -1541,10 +1541,10 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 	if (!kvm->arch.gisa)
 		goto out;
 
-	active_mask = (isc_mask & kvm_s390_gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
-		if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+		if (gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
 			return isc;
 		clear_bit_inv(isc, &active_mask);
 	}
@@ -1584,7 +1584,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	/* both types of interrupts present */
 	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
 		/* classical IO int with higher priority */
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
 		goto out;
 	}
 gisa_out:
@@ -1596,7 +1596,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 			kvm_s390_reinject_io_int(kvm, inti);
 		inti = tmp_inti;
 	} else
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
 out:
 	return inti;
 }
@@ -1694,7 +1694,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 
 	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
 		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
-		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
 		kfree(inti);
 		return 0;
 	}
@@ -2025,15 +2025,14 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
-	if (kvm->arch.gisa &&
-	    kvm_s390_gisa_get_ipm(kvm->arch.gisa)) {
+	if (kvm->arch.gisa && gisa_get_ipm(kvm->arch.gisa)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+			if (gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
-- 
2.13.4

