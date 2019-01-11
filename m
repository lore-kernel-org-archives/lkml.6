Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D281621841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217623;
	bh=iWqY+NJmh5DlIMqCtxYBPxBm831vY7eX95A9Au8rMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I8G4T9WYJlI9LaBNz/OaAo8VSTYqWn8wC7lGZcCiaCgdAckdi/V2zD4QFeX/Q5GP+
	 MDtN/dysYeIUOSQGEzBrcMLDt0HfiTCQfKdu5KCTfA4hBMK12y701sNHC1z0/sL/01
	 C80ANkG/VJzBRSYQXyiH+QZWcwRro7pNah9fQ0ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391213AbfAKOkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391197AbfAKOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011772063F;
        Fri, 11 Jan 2019 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217619;
        bh=iWqY+NJmh5DlIMqCtxYBPxBm831vY7eX95A9Au8rMV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPFDjJW4VGG0etHkXgjWWPJfvojkPnheN0TsRnbMlv5gQnQwMRJ5y2OXFCEuCAZ3h
         bYJOI6PutOFvl6erCrAM7obJnEahlBIOhW4xBIjv8k4aqtQMXyHmpftVvpYmomMwaQ
         RS0lHlGUajpkU9Mxg6z8v4I4rBzn5UjFBkCoPEWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Subject: [PATCH 4.19 128/148] Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"
Date:   Fri, 11 Jan 2019 15:15:06 +0100
Message-Id: <20190111131119.396416827@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit a9935a12768851762089fda8e5a9daaf0231808e which is
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


