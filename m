Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeBVMFz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:05:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753609AbeBVMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:05:52 -0500
Date: Thu, 22 Feb 2018 13:05:41 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@schleppi
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18022212-0040-0000-0000-000004367FDB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022212-0041-0000-0000-000020D898DA
Message-Id: <alpine.LFD.2.21.1802221304430.1603@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the kvm_arch_irq_routing_update() prototype outside of
ifdef CONFIG_HAVE_KVM_EVENTFD guards to fix the following sparse warning:

arch/s390/kvm/../../../virt/kvm/irqchip.c:171:28: warning: symbol 'kvm_arch_irq_routing_update' was not declared. Should it be static?

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ed3d4ddbaff3..6930c63126c7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1105,7 +1105,6 @@ static inline void kvm_irq_routing_update(struct kvm *kvm)
 {
 }
 #endif
-void kvm_arch_irq_routing_update(struct kvm *kvm);
 
 static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
@@ -1114,6 +1113,8 @@ static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 
 #endif /* CONFIG_HAVE_KVM_EVENTFD */
 
+void kvm_arch_irq_routing_update(struct kvm *kvm);
+
 static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.13.4
