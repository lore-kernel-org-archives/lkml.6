Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B32CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8B72084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8B72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJDU7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:32 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GN-0002ic-TO; Thu, 04 Oct 2018 16:06:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/11] x86/entry: remove _TIF_ALLWORK_MASK
Date:   Thu,  4 Oct 2018 16:05:37 +0200
Message-Id: <20181004140547.13014-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no user of _TIF_ALLWORK_MASK since commit 21d375b6b34ff
("x86/entry/64: Remove the SYSCALL64 fast path").
Remove unused define _TIF_ALLWORK_MASK.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/thread_info.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2ff2a30a264f4..cd6920674b905 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -136,14 +136,6 @@ struct thread_info {
 	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT |	\
 	 _TIF_NOHZ)
 
-/* work to do on any return to user space */
-#define _TIF_ALLWORK_MASK						\
-	(_TIF_SYSCALL_TRACE | _TIF_NOTIFY_RESUME | _TIF_SIGPENDING |	\
-	 _TIF_NEED_RESCHED | _TIF_SINGLESTEP | _TIF_SYSCALL_EMU |	\
-	 _TIF_SYSCALL_AUDIT | _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE |	\
-	 _TIF_PATCH_PENDING | _TIF_NOHZ | _TIF_SYSCALL_TRACEPOINT |	\
-	 _TIF_FSCHECK)
-
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
-- 
2.19.0

