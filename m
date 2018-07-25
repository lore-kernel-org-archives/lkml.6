Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FFC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6E020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6E020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeGYO5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:57:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39058 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeGYO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:57:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A91015BE;
        Wed, 25 Jul 2018 06:45:17 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C0433F906;
        Wed, 25 Jul 2018 06:45:17 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 610331AE0946; Wed, 25 Jul 2018 14:45:17 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, steve.mcintyre@arm.com, dave.martin@arm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
Date:   Wed, 25 Jul 2018 14:45:12 +0100
Message-Id: <1532526312-26993-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm/ defines a SIGMINSTKSZ of 2k, so we should use the same value
for compat tasks.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/compat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..cee28a05ee98 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -159,6 +159,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 }
 
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
+#define COMPAT_MINSIGSTKSZ	2048
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
-- 
2.1.4

