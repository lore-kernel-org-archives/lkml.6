Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D9C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E89223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E89223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeKLVui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:50:38 -0500
Received: from foss.arm.com ([217.140.101.70]:34562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbeKLVuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:50:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF2EE1688;
        Mon, 12 Nov 2018 03:57:40 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D64DD3F5A0;
        Mon, 12 Nov 2018 03:57:38 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v6 06/24] arm64: ptrace: Provide definitions for PMR values
Date:   Mon, 12 Nov 2018 11:56:57 +0000
Message-Id: <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce fixed values for PMR that are going to be used to mask and
unmask interrupts by priority. These values are chosent in such a way
that a single bit (GIC_PMR_UNMASKED_BIT) encodes the information whether
interrupts are masked or not.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/ptrace.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index fce22c4..ce6998c 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,12 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
 
+/* PMR values used to mask/unmask interrupts */
+#define GIC_PRIO_IRQON		0xf0
+#define GIC_PRIO_STATUS_SHIFT	6
+#define GIC_PRIO_STATUS_BIT	(1 << GIC_PRIO_STATUS_SHIFT)
+#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON ^ GIC_PRIO_STATUS_BIT)
+
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_IL_BIT		(1 << 20)
 
-- 
1.9.1

