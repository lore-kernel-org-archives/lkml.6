Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E943C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfAXNB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:01:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbfAXNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:00:09 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OCt01P143542
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q7cm23yyx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:07 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 24 Jan 2019 13:00:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 13:00:01 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0OCxxme15401204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 13:00:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF4785204F;
        Thu, 24 Jan 2019 12:59:59 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8CD5252052;
        Thu, 24 Jan 2019 12:59:59 +0000 (GMT)
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
Subject: [PATCH v6 04/13] KVM: s390: coding style kvm_s390_gisa_init/clear()
Date:   Thu, 24 Jan 2019 13:59:30 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190124125939.130763-1-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012413-0008-0000-0000-000002B565AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012413-0009-0000-0000-0000222199F9
Message-Id: <20190124125939.130763-5-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change helps to reduce line length and
increases code readability.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2a3eb9f076c3..005dbe7252e7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2885,20 +2885,20 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
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
+	kvm_s390_gisa_clear(kvm);
+	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
-- 
2.13.4

