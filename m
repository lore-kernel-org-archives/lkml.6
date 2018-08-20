Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E954C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83305208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83305208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTNsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:48:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTNsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:48:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B440EEFC3AEEB;
        Mon, 20 Aug 2018 18:32:48 +0800 (CST)
Received: from localhost.localdomain (10.143.28.90) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Mon, 20 Aug 2018 18:32:43 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <gengdongjiu@huawei.com>
Subject: [PATCH] arm64: KVM: rename the capability to set guest SError syndrome
Date:   Mon, 20 Aug 2018 14:37:31 -0400
Message-ID: <1534790251-15847-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the documentation description, this capability's name is
KVM_CAP_ARM_SET_SERROR_ESR, but in the header file this
capability's name is KVM_CAP_ARM_INJECT_SERROR_ESR, so it
is better to use a same name.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
In the Documentation/virtual/kvm/api.txt:

+8.19 KVM_CAP_ARM_SET_SERROR_ESR

In the include/uapi/linux/kvm.h:
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 156

So in above two files, the capability's name is not same, it
is better to use a same name.
---
 arch/arm64/kvm/reset.c   | 2 +-
 include/uapi/linux/kvm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e37c78b..57dc6be 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -77,7 +77,7 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PMU_V3:
 		r = kvm_arm_support_pmu_v3();
 		break;
-	case KVM_CAP_ARM_INJECT_SERROR_ESR:
+	case KVM_CAP_ARM_SET_SERROR_ESR:
 		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 07548de..fab7525 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -951,7 +951,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_TLBFLUSH 155
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
-#define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_ARM_SET_SERROR_ESR 158
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

