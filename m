Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-991961-1517918787-2-4568474109794468332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517918786; b=qHfLTkS5zWC9USRg9QRSYrOdweVcREXqONxKo7rZtDYzHmW
    sET0IwP7GeSZMF2yLl/SHULYe1yuh6SkE5nJ//Cj4JajEBveN7TWWjW2RMWDUbFz
    PPFX8DXcGHoEcOJHX2tukFH4tPfrATtDIxl6j5MQQZWWRajJPsLApqbrlEwA7YgC
    /ZA7E1qXcB3bXQ38UJd6LRKMDpHsApDTOtsCt9TL3PAwlfxXrqAVfyj6w9LUBNqK
    f2uNV52gv6gHC7B4H9nO3Zmic4fjTkDaI95LUYKUqZ0b30uACd4hq22eog9VeaSm
    RLPPbdlCLCaay3Dvy0pHn5o3++FBMdAdFLV6/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:mime-version
    :content-transfer-encoding:content-type:sender:list-id; s=
    arctest; t=1517918786; bh=/zAP53b8uxCN88Motbxo8XcnjZg2+lEXN3UTYz
    wUv9E=; b=JL7k8CM0+AG8URiuU7cNXM4tCRBK8kfDctExP+HUzeri75m9BAqYdC
    4Sym4WKkRBdgJsQYel8vqua0ufF+ipvsjtIDIhsy3Riq3BfRizfI51K3AhYcmhOI
    vqfR64FJjONm606CGSsYAB+6abq4DW7QF3aUz6NH/KuPFZJIeKf4cJghIa/c8541
    bfQo8IDtzchIuC/6GvE6yaVfqvDM4MWfHu79NDF+WuraIjS1VfxD7nhVFJZa6SDA
    RKBqeHgKeBdI0cpnE+ytJSnvTF5fIqijlKvuvjyY+GBT4Txni3equX6MP8qRBpQJ
    7wa9d/2/8fceh1E8bsEeVmgLBMIo8jPA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeBFMGY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 07:06:24 -0500
Received: from terminus.zytor.com ([65.50.211.136]:57981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbeBFMGX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 07:06:23 -0500
Date: Tue, 6 Feb 2018 04:00:34 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-6b8cf5cc9965673951f1ab3f0e3cf23d06e3e2ee@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        jpoimboe@redhat.com, torvalds@linux-foundation.org,
        brgerst@gmail.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        luto@kernel.org, peterz@infradead.org, stable@vger.kernel.org
Reply-To: dvlasenk@redhat.com, stable@vger.kernel.org, luto@kernel.org,
          peterz@infradead.org, dan.j.williams@intel.com,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, brgerst@gmail.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          jpoimboe@redhat.com
In-Reply-To: <151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64/compat: Clear registers for compat
 syscalls, to reduce speculation attack surface
Git-Commit-ID: 6b8cf5cc9965673951f1ab3f0e3cf23d06e3e2ee
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on terminus.zytor.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  6b8cf5cc9965673951f1ab3f0e3cf23d06e3e2ee
Gitweb:     https://git.kernel.org/tip/6b8cf5cc9965673951f1ab3f0e3cf23d06e3e2ee
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 5 Feb 2018 17:18:17 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 11:47:57 +0100

x86/entry/64/compat: Clear registers for compat syscalls, to reduce speculation attack surface

At entry userspace may have populated registers with values that could
otherwise be useful in a speculative execution attack. Clear them to
minimize the kernel's attack surface.

Originally-From: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64_compat.S | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 98d5358..fd65e01 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -85,15 +85,25 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
@@ -214,15 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   $0			/* pt_regs->r12 = 0 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   $0			/* pt_regs->r13 = 0 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   $0			/* pt_regs->r14 = 0 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
+	xorq	%r15, %r15		/* nospec   r15 */
 
 	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
@@ -338,15 +358,25 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
+	xorq	%r8, %r8		/* nospec   r8 */
 	pushq   $0			/* pt_regs->r9  = 0 */
+	xorq	%r9, %r9		/* nospec   r9 */
 	pushq   $0			/* pt_regs->r10 = 0 */
+	xorq	%r10, %r10		/* nospec   r10 */
 	pushq   $0			/* pt_regs->r11 = 0 */
+	xorq	%r11, %r11		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
+	xorl	%ebx, %ebx		/* nospec   rbx */
 	pushq   %rbp                    /* pt_regs->rbp */
+	xorl	%ebp, %ebp		/* nospec   rbp */
 	pushq   %r12                    /* pt_regs->r12 */
+	xorq	%r12, %r12		/* nospec   r12 */
 	pushq   %r13                    /* pt_regs->r13 */
+	xorq	%r13, %r13		/* nospec   r13 */
 	pushq   %r14                    /* pt_regs->r14 */
+	xorq	%r14, %r14		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
+	xorq	%r15, %r15		/* nospec   r15 */
 	cld
 
 	/*
