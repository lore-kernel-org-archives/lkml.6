Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C799FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F8A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLCVEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:04:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCVEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:04:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB3L2656594411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Dec 2018 13:02:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB3L26F3594407;
        Mon, 3 Dec 2018 13:02:06 -0800
Date:   Mon, 3 Dec 2018 13:02:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-d23650e06299e9b2d04e090ab8c625cdf24465bf@git.kernel.org>
Cc:     pbonzini@redhat.com, bigeasy@linutronix.de, rkrcmar@redhat.com,
        dhowells@redhat.com, dave.hansen@linux.intel.com, mingo@redhat.com,
        konrad.wilk@oracle.com, mingo@kernel.org, hpa@zytor.com,
        Jason@zx2c4.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        riel@surriel.com, x86@kernel.org, bp@suse.de,
        tim.c.chen@linux.intel.com, luto@kernel.org, tglx@linutronix.de
Reply-To: rkrcmar@redhat.com, dhowells@redhat.com, pbonzini@redhat.com,
          bigeasy@linutronix.de, konrad.wilk@oracle.com, mingo@redhat.com,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          kvm@vger.kernel.org, hpa@zytor.com, Jason@zx2c4.com,
          mingo@kernel.org, riel@surriel.com, x86@kernel.org,
          tglx@linutronix.de, luto@kernel.org, tim.c.chen@linux.intel.com,
          bp@suse.de
In-Reply-To: <20181128222035.2996-4-bigeasy@linutronix.de>
References: <20181128222035.2996-4-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/thread_info: Remove _TIF_ALLWORK_MASK
Git-Commit-ID: d23650e06299e9b2d04e090ab8c625cdf24465bf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d23650e06299e9b2d04e090ab8c625cdf24465bf
Gitweb:     https://git.kernel.org/tip/d23650e06299e9b2d04e090ab8c625cdf24465bf
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 28 Nov 2018 23:20:09 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 3 Dec 2018 19:00:28 +0100

x86/thread_info: Remove _TIF_ALLWORK_MASK

There is no user of _TIF_ALLWORK_MASK since commit

  21d375b6b34ff ("x86/entry/64: Remove the SYSCALL64 fast path").

Remove the unused define _TIF_ALLWORK_MASK.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181128222035.2996-4-bigeasy@linutronix.de
---
 arch/x86/include/asm/thread_info.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 82b73b75d67c..e0eccbcb8447 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -140,14 +140,6 @@ struct thread_info {
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
 #define _TIF_WORK_CTXSW_BASE						\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
