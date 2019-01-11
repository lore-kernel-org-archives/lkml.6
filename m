Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D90C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEAF206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217985;
	bh=Mv2WzS3YNTlW3gUgXxfi/kM0qf7S4dkvDLPp+HgsatY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdfZYVeV9u4RGt60IOkHz9ch4s2kF5Aq61Bx/IM0KxbeEYl6E7Clcx43y1EBbs2/U
	 zTDZqI7rE+8sdF/zfK2vT64ggZU1hYuBv7jgf/B+KIN+z0b8TGVOBn+lt7zZs3CXrY
	 RTFru3hfpIVSRhQfsFnOExCz7UvIFQ6KMrLT0v9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbfAKOnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404313AbfAKOnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D816F20872;
        Fri, 11 Jan 2019 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217786;
        bh=Mv2WzS3YNTlW3gUgXxfi/kM0qf7S4dkvDLPp+HgsatY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Foc66/Orzv72DgGf9ph2wpeQ0omE7m/xrOSVxqmYO/44BmcMcCUlswnAFvJxB7XcG
         r1xcuIt4HP0915F/v9PpQJhkBjQid+RbFcQbPmgKaLl9A0VFIV3MDNrEMIljyTnP5H
         ujJKu0r6dtJc8w6Onbk0a1qXEWMKbBVE+Zuae5xE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Subject: [PATCH 4.20 41/65] Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"
Date:   Fri, 11 Jan 2019 15:15:27 +0100
Message-Id: <20190111131102.136630542@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit d412deb85a4aada382352a8202beb7af8921cd53 which is
commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.

It breaks the powerpc build, so drop it from the tree until a fix goes
upstream.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Breno Leitao <leitao@debian.org>
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/signal_32.c |   18 +++++-------------
 arch/powerpc/kernel/signal_64.c |   20 ++++----------------
 2 files changed, 9 insertions(+), 29 deletions(-)

--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1140,11 +1140,11 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct rt_sigframe __user *rt_sf;
 	struct pt_regs *regs = current_pt_regs();
-	int tm_restore = 0;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext __user *uc_transact;
 	unsigned long msr_hi;
 	unsigned long tmp;
+	int tm_restore = 0;
 #endif
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -1192,19 +1192,11 @@ SYSCALL_DEFINE0(rt_sigreturn)
 				goto bad;
 		}
 	}
-	if (!tm_restore) {
-		/*
-		 * Unset regs->msr because ucontext MSR TS is not
-		 * set, and recheckpoint was not called. This avoid
-		 * hitting a TM Bad thing at RFID
-		 */
-		regs->msr &= ~MSR_TS_MASK;
-	}
-	/* Fall through, for non-TM restore */
-#endif
 	if (!tm_restore)
-		if (do_setcontext(&rt_sf->uc, regs, 1))
-			goto bad;
+		/* Fall through, for non-TM restore */
+#endif
+	if (do_setcontext(&rt_sf->uc, regs, 1))
+		goto bad;
 
 	/*
 	 * It's not clear whether or why it is desirable to save the
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -740,23 +740,11 @@ SYSCALL_DEFINE0(rt_sigreturn)
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	}
-#endif
+	else
 	/* Fall through, for non-TM restore */
-	if (!MSR_TM_ACTIVE(msr)) {
-		/*
-		 * Unset MSR[TS] on the thread regs since MSR from user
-		 * context does not have MSR active, and recheckpoint was
-		 * not called since restore_tm_sigcontexts() was not called
-		 * also.
-		 *
-		 * If not unsetting it, the code can RFID to userspace with
-		 * MSR[TS] set, but without CPU in the proper state,
-		 * causing a TM bad thing.
-		 */
-		current->thread.regs->msr &= ~MSR_TS_MASK;
-		if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
-			goto badframe;
-	}
+#endif
+	if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
+		goto badframe;
 
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;


