Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE95C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854322089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854322089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJQAmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeJQAmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C633C970FE;
        Tue, 16 Oct 2018 16:50:52 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FD7F6BF7B;
        Tue, 16 Oct 2018 16:50:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 12/13] tools/headers: update kvm.h
Date:   Tue, 16 Oct 2018 18:50:10 +0200
Message-Id: <20181016165011.6607-13-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 16 Oct 2018 16:50:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pick up the latest kvm.h definitions.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 07548de5c988..a67ea86edb0b 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -719,6 +719,7 @@ struct kvm_ppc_one_seg_page_size {
 
 #define KVM_PPC_PAGE_SIZES_REAL		0x00000001
 #define KVM_PPC_1T_SEGMENTS		0x00000002
+#define KVM_PPC_NO_HASH			0x00000004
 
 struct kvm_ppc_smmu_info {
 	__u64 flags;
@@ -952,6 +953,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_PPC_NESTED_HV 160
+#define KVM_CAP_HYPERV_SEND_IPI 161
+#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 162
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.1

