Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E720C2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E720C2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHTQu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:50:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41547 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbeHTQu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:50:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 887A62886BB48;
        Mon, 20 Aug 2018 21:34:42 +0800 (CST)
Received: from localhost.localdomain (10.143.28.90) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Mon, 20 Aug 2018 21:34:37 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <gengdongjiu@huawei.com>
Subject: [PATCH] KVM: Documentation: rename the capability of KVM_CAP_ARM_SET_SERROR_ESR
Date:   Mon, 20 Aug 2018 17:39:25 -0400
Message-ID: <1534801165-41525-1-git-send-email-gengdongjiu@huawei.com>
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
capability's name is KVM_CAP_ARM_INJECT_SERROR_ESR, so change
the documentation description to make it same.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
In the Documentation/virtual/kvm/api.txt:

+8.19 KVM_CAP_ARM_SET_SERROR_ESR

In the include/uapi/linux/kvm.h:
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 156

So in above two files, the capability's name is not same, it
is better to use a same name.
---
 Documentation/virtual/kvm/api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0acdbac..c664064 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -909,10 +909,10 @@ Serviceability (RAS) Specification").
 
 SError exceptions always have an ESR value. Some CPUs have the ability to
 specify what the virtual SError's ESR value should be. These systems will
-advertise KVM_CAP_ARM_SET_SERROR_ESR. In this case exception.has_esr will
+advertise KVM_CAP_ARM_INJECT_SERROR_ESR. In this case exception.has_esr will
 always have a non-zero value when read, and the agent making an SError pending
 should specify the ISS field in the lower 24 bits of exception.serror_esr. If
-the system supports KVM_CAP_ARM_SET_SERROR_ESR, but user-space sets the events
+the system supports KVM_CAP_ARM_INJECT_SERROR_ESR, but user-space sets the events
 with exception.has_esr as zero, KVM will choose an ESR.
 
 Specifying exception.has_esr on a system that does not support it will return
@@ -4749,7 +4749,7 @@ hypercalls:
 HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
 HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
 
-8.19 KVM_CAP_ARM_SET_SERROR_ESR
+8.19 KVM_CAP_ARM_INJECT_SERROR_ESR
 
 Architectures: arm, arm64
 
-- 
2.7.4

