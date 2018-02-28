Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519836821-2-888597356972982999
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836821; b=hwICcG+2arpE5MTC3wEzxIPb9JTqWIT1jXq9gfyanolOZgp
    r2M4hPyui33qcoJP0BY979chOb8WmpRZdSUExL8Z0Tkoi1TfqaoPGqOz/XX3wp3p
    6XmfohNZ8hQM0T1gmOTBVnUuwM+CnTJCkJH4CwJPcSMk2UYtDTJx3IAH09lGi2yl
    67UTeSa9XpK55VIh1HWx2pHnW5xABn9htBefp2QOI8oqU9QpQfG2uycDVpqMHZg9
    fsJk9n84pY5u8c3lVvPSQvNyYgaPNG9Pq+Emr2viqWz4m/hcVA9TTmBi4jzn8i8w
    XbOdyeS5K4HfrjMn9qGuFCGYubLelCoIEn4k3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836821; bh=+OYCI16J8/3AkQXds8y
    FCPO8HcAJo/24I5WpmSOdmHw=; b=isSsjmmpCkHIItwIroIwNqC4gXE6FloRuTP
    yaxYwr3+Vm5QkLFMhfygbblIsPoa41ZJVVk74KfO+c3oqhWHuAZSDbwx8TrWAN4o
    Zy8NxA6TC3XoAu6rPBVg5jn77be4Qz92QKAUSA8tw4tgFHE2gJH457P3oJ7J+ZQ7
    UqBTmeYIu4nKY08GMTygRReP2XH7tpbB4Mlv13VzGzScpoep1JxFH65DOJcwf6h2
    emndKlSIWAaCRg65YtevhoHzo6C6RJz9RvIJnMFcRxTuYJx2pD2/vynwctsCvxtC
    9JrjXeKsb+u8LV67og3eZAlTIrJ75sGV6tQX0geRs6n9meF7aGg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeB1P57 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:57:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34533 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933979AbeB1P54 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:57:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "Dave Martin" <Dave.Martin@arm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.579340890@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 060/254] arm64: fpsimd: Prevent registers leaking
 from dead tasks
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Martin <Dave.Martin@arm.com>

commit 071b6d4a5d343046f253a5a8835d477d93992002 upstream.

Currently, loading of a task's fpsimd state into the CPU registers
is skipped if that task's state is already present in the registers
of that CPU.

However, the code relies on the struct fpsimd_state * (and by
extension struct task_struct *) to unambiguously identify a task.

There is a particular case in which this doesn't work reliably:
when a task exits, its task_struct may be recycled to describe a
new task.

Consider the following scenario:

 1) Task P loads its fpsimd state onto cpu C.
        per_cpu(fpsimd_last_state, C) := P;
        P->thread.fpsimd_state.cpu := C;

 2) Task X is scheduled onto C and loads its fpsimd state on C.
        per_cpu(fpsimd_last_state, C) := X;
        X->thread.fpsimd_state.cpu := C;

 3) X exits, causing X's task_struct to be freed.

 4) P forks a new child T, which obtains X's recycled task_struct.
	T == X.
	T->thread.fpsimd_state.cpu == C (inherited from P).

 5) T is scheduled on C.
	T's fpsimd state is not loaded, because
	per_cpu(fpsimd_last_state, C) == T (== X) &&
	T->thread.fpsimd_state.cpu == C.

        (This is the check performed by fpsimd_thread_switch().)

So, T gets X's registers because the last registers loaded onto C
were those of X, in (2).

This patch fixes the problem by ensuring that the sched-in check
fails in (5): fpsimd_flush_task_state(T) is called when T is
forked, so that T->thread.fpsimd_state.cpu == C cannot be true.
This relies on the fact that T is not schedulable until after
copy_thread() completes.

Once T's fpsimd state has been loaded on some CPU C there may still
be other cpus D for which per_cpu(fpsimd_last_state, D) ==
&X->thread.fpsimd_state.  But D is necessarily != C in this case,
and the check in (5) must fail.

An alternative fix would be to do refcounting on task_struct.  This
would result in each CPU holding a reference to the last task whose
fpsimd state was loaded there.  It's not clear whether this is
preferable, and it involves higher overhead than the fix proposed
in this patch.  It would also move all the task_struct freeing
work into the context switch critical section, or otherwise some
deferred cleanup mechanism would need to be introduced, neither of
which seems obviously justified.

Fixes: 005f78cd8849 ("arm64: defer reloading a task's FPSIMD state to userland resume")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[will: word-smithed the comment so it makes more sense]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/process.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -269,6 +269,15 @@ int copy_thread(unsigned long clone_flag
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
+	/*
+	 * In case p was allocated the same task_struct pointer as some
+	 * other recently-exited task, make sure p is disassociated from
+	 * any cpu that may have run that now-exited task recently.
+	 * Otherwise we could erroneously skip reloading the FPSIMD
+	 * registers for p.
+	 */
+	fpsimd_flush_task_state(p);
+
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
