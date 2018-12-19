Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB70C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011292080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbeLSTSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:18:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729165AbeLSTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:18:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIwfEF133260
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pfs981gnv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:10 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 19 Dec 2018 19:18:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 19:18:04 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJJI2kc1573352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:18:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B62152050;
        Wed, 19 Dec 2018 19:18:02 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 304C25204E;
        Wed, 19 Dec 2018 19:18:02 +0000 (GMT)
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
Subject: [PATCH v5 02/15] KVM: s390: coding style issue kvm_s390_gisa_init/clear()
Date:   Wed, 19 Dec 2018 20:17:43 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121919-0020-0000-0000-000002F9F02B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121919-0021-0000-0000-00002149FDD7
Message-Id: <20181219191756.57973-3-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change hepls to reduce line length and
icreases code readability.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fcb55b02990e..9a3aed608914 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2886,20 +2886,20 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
-	if (kvm->arch.gisa) {
-		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
-		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
-	}
+	if (!kvm->arch.gisa)
+		return;
+	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
+	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
+	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
 }
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
-	if (css_general_characteristics.aiv) {
-		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
-		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
-		kvm_s390_gisa_clear(kvm);
-	}
+	if (!css_general_characteristics.aiv)
+		return;
+	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
+	kvm_s390_gisa_clear(kvm);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
-- 
2.13.4

