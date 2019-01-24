Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC69C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADAC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfAXNAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:00:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727556AbfAXNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:00:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OCsxIa010209
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:34 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q7avc1j5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:30 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 24 Jan 2019 13:00:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 12:59:58 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0OCxvFD6947188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 12:59:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38C1D52052;
        Thu, 24 Jan 2019 12:59:57 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D011052051;
        Thu, 24 Jan 2019 12:59:56 +0000 (GMT)
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
Subject: [PATCH v6 02/13] KVM: s390: make bitmap declaration consitent
Date:   Thu, 24 Jan 2019 13:59:28 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190124125939.130763-1-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012413-0008-0000-0000-000002B565AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012412-0009-0000-0000-0000222199F8
Message-Id: <20190124125939.130763-3-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a consistent bitmap declaration throughout the code.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 +-
 arch/s390/kvm/interrupt.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d5d24889c3bc..3cba08f73dc6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -591,7 +591,7 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int next_rr_cpu;
-	unsigned long idle_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 	struct mutex ais_lock;
 	u8 simm;
 	u8 nimm;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 19d556512452..167a3068ef84 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2831,7 +2831,7 @@ static void store_local_irq(struct kvm_s390_local_interrupt *li,
 int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 {
 	int scn;
-	unsigned long sigp_emerg_pending[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	unsigned long pending_irqs;
 	struct kvm_s390_irq irq;
-- 
2.13.4

