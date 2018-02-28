Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836331-2-2312022537096073680
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
    t=1519836330; b=Ug5kr6YdJhIe39j7t0w4xvzGtn1EbwY6XJZmupAP3rC7BkX
    zbwUo1Esb7BHlVocyY9becm32CCzABW88pyTm9c8K+iWQ8Fv9bVA9MLFbWJbfbh6
    JzXZDRX9b0WgVWuPmvQhnW4zbD2mi59E7x3cLYLyd2CiIdytEm1TEgS4KixGLam8
    RDhaLZpdmDazYylCW/bvVGhT/pUvDUY+/5Wyt0wsvxqAWE3Obh2OppLw2whS8gVI
    jM9J5fE5MThM6u2/mrP4SPQrwVEawKRSwLyu6/YWQ53M2XJsgwnR03IGhtTfZHF6
    vd1sNmxX1MZt4FcyPxwc4yiAmqvToa8+eLn9QrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836330; bh=Pa6evtyhutOpFEj6eZw
    70PMj+p4oU3rr+7yu5k8IbdQ=; b=Fgay0AXnBjkg/cNinzCLSjApCHPJnbzh+QX
    xN6L8xK3iIWid/s2zEFRuar1Lt2wcaeI04/XWem8U/c6OFOnjz8UHw9TgzMyKoMa
    1N2p4iOhzBvrw6gED1Gk640krn2l5bZzLNfaY+OcbFhiLHg+t9uVUpDCqR9Uxto1
    CLh2Im9Ts8jHeMr8xFyE5AxiaiWBUhRqGF1sEI1QxAFfaYEG/RKHh6vKbHHJrgoq
    tfPw3qNwja0cnvns8YvSAWUy6GOtZWov2a18nCek1RiByFdASs0GTwODNNbOu1eZ
    ZCerNEY7fxq5tohTK5Ni2Tn8LxBxP06DsoKhnRByqpGIhhBayeA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeB1QpP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:45:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34665 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932236AbeB1QAd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.175832776@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 094/254] MIPS: prevent FP context set via ptrace
 being discarded
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

From: Paul Burton <paul.burton@imgtec.com>

commit ac9ad83bc318635ed7496e9dff30beaa522eaec7 upstream.

If a ptracee has not used the FPU and the ptracer sets its FP context
using PTRACE_POKEUSR, PTRACE_SETFPREGS or PTRACE_SETREGSET then that
context will be discarded upon either the ptracee using the FPU or a
further write to the context via ptrace. Prevent this loss by recording
that the task has "used" math once its FP context has been written to.
The context initialisation code that was present for the PTRACE_POKEUSR
case is reused for the other 2 cases to provide consistent behaviour
for the different ptrace requests.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9166/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -47,6 +47,26 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+static void init_fp_ctx(struct task_struct *target)
+{
+	/* If FP has been used then the target already has context */
+	if (tsk_used_math(target))
+		return;
+
+	/* Begin with data registers set to all 1s... */
+	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
+
+	/* ...and FCSR zeroed */
+	target->thread.fpu.fcr31 = 0;
+
+	/*
+	 * Record that the target has "used" math, such that the context
+	 * just initialised, and any modifications made by the caller,
+	 * aren't discarded.
+	 */
+	set_stopped_child_used_math(target);
+}
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -143,6 +163,7 @@ int ptrace_setfpregs(struct task_struct
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
 		return -EIO;
 
+	init_fp_ctx(child);
 	fregs = get_fpu_regs(child);
 
 	for (i = 0; i < 32; i++) {
@@ -440,6 +461,8 @@ static int fpr_set(struct task_struct *t
 
 	/* XXX fcr31  */
 
+	init_fp_ctx(target);
+
 	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
 		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 					  &target->thread.fpu,
@@ -678,12 +701,7 @@ long arch_ptrace(struct task_struct *chi
 		case FPR_BASE ... FPR_BASE + 31: {
 			union fpureg *fregs = get_fpu_regs(child);
 
-			if (!tsk_used_math(child)) {
-				/* FP not yet used  */
-				memset(&child->thread.fpu, ~0,
-				       sizeof(child->thread.fpu));
-				child->thread.fpu.fcr31 = 0;
-			}
+			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
 			if (test_thread_flag(TIF_32BIT_FPREGS)) {
 				/*
