Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3465232-1517865701-2-2715344209094429365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517865700; b=C/HGPxYMzB6Bd6w8NlrolUczCiQUSFgHTRKn7H9yUqEF+IS
    vOMpOhz1R2OdCnDgCRt4KpwAeM6LxP+0Rl3iF7Ti6GtGWyWpad0fA0YUUAxuXAs2
    ibLyCCZ9L02gk0z9dqz+Bp7RKf60yrFkE1fggR3JqqYoYDwCuNbkwOp3uWVaUK06
    HT5DBRyYJNfdNPrIH+KoxQWSQ96/AfKMYOXiH3K/SGJU5MuLY/q/VOFkUncyu6qY
    Yule3aqSH1XZ451e6aD3LZV703pph/WDgeUf3OOtbJ70svQOVHnrd0y3pSZij8Ty
    OJr0f7aoO/ZnnFT2dWxp19Xgn4oBgGqzqhXBsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517865700; bh=zCk0nvJaOFoh5kJQI+8M4cA8T+
    ZWntre8oJ5vWQ2xnk=; b=JO4cxkzrYHxV1518/GLLG+wzntJqQfJNgPuz0dB313
    qxDiz0/+GYCaBbE+vkulIG9tXfdmkxRETGkR6gCU20DB9vFQyWVfpzK37sqnGWbg
    AWZz8BWpgzl8V45z5web77JfEXfi1eEvIAhYIdNOxWTy8DXm+cgsWoFcHPhgpCSE
    arhyS4XF/mo2o/XDQHfEoVVCqoIwV7mlEPIF/EuUBGeW4lO+Z6tTepzdzHuNl/t5
    rJfxtH2g8lcqYVfS9C7QQ/hYRMPsKxHv+YXKNwsMVujgaeuSls3lup7s0pq6ehJ3
    VV0PHiri01Gd0RwzaeK8PkK7RgKkT1midLaQ58MPD3Rg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bKSmOosz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QpFUdmgl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bKSmOosz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QpFUdmgl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeBEVVi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 16:21:38 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46839 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeBEVVh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 16:21:37 -0500
X-Google-Smtp-Source: AH8x226nYSYE2OviKMZrBW3dvF9blYDr3xYurmGe9exrMmr1JTigcujeZXdKekhJujEc+tBe3bB7GA==
Date: Mon, 5 Feb 2018 22:21:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Maged Michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>,
        David Sehr <sehr@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH for 4.16 00/11] membarrier updates for 4.16
Message-ID: <20180205212132.cbyqv25c2wouf4cp@gmail.com>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Find below the interdiff of the (minor) edits I've done to the series, before 
applying them to tip:sched/urgent.

I've also tidied up some of the changelogs.

Nothing earth-shattering.

Thanks,

	Ingo

=========>

 arch/powerpc/Kconfig      | 2 +-
 arch/x86/entry/entry_32.S | 2 +-
 arch/x86/entry/entry_64.S | 2 +-
 include/linux/sched/mm.h  | 6 +++---
 init/Kconfig              | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 09b02180b8a0..a2380de50878 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,7 +140,7 @@ config PPC
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PMEM_API                if PPC64
-	select ARCH_HAS_MEMBARRIER_HOOKS
+	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d8ba23d0d77a..abee6d2b9311 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -567,7 +567,7 @@ ENTRY(entry_INT80_32)
 	RESTORE_REGS 4				# skip orig_eax/error_code
 .Lirq_return:
 	/*
-	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on iret core serialization
+	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
 	 * when returning from IPI handler and when returning from
 	 * scheduler to user-space.
 	 */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 49852d9920da..5816858c8820 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -805,7 +805,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	POP_C_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	/*
-	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on iret core serialization
+	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
 	 * when returning from IPI handler.
 	 */
 	INTERRUPT_RETURN
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index a7840f0f8832..03a169087a18 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -41,7 +41,7 @@ extern void __mmdrop(struct mm_struct *);
 static inline void mmdrop(struct mm_struct *mm)
 {
 	/*
-	 * The implicit full barrier implied by atomic_dec_and_test is
+	 * The implicit full barrier implied by atomic_dec_and_test() is
 	 * required by the membarrier system call before returning to
 	 * user-space, after storing to rq->curr.
 	 */
@@ -232,7 +232,7 @@ enum {
 	MEMBARRIER_FLAG_SYNC_CORE	= (1U << 0),
 };
 
-#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 #include <asm/membarrier.h>
 #endif
 
@@ -249,7 +249,7 @@ static inline void membarrier_execve(struct task_struct *t)
 	atomic_set(&t->mm->membarrier_state, 0);
 }
 #else
-#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 					     struct mm_struct *next,
 					     struct task_struct *tsk)
diff --git a/init/Kconfig b/init/Kconfig
index 30b65febeb23..e37f4b2a6445 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1412,7 +1412,7 @@ config USERFAULTFD
 	  Enable the userfaultfd() system call that allows to intercept and
 	  handle page faults in userland.
 
-config ARCH_HAS_MEMBARRIER_HOOKS
+config ARCH_HAS_MEMBARRIER_CALLBACKS
 	bool
 
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
