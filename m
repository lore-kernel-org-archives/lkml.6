Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1799621-1528128129-2-11633822833152628072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528128124; b=R7/vwmSHRDZ/Ju/JaZzZQemTWo92TPAJdcLTiKLLTKx1atYIDI
    jJ/1e84qekM5Lu5njMPie0fybVTSaOokPvqO8VY6mSIOOY6U/gf0KEePjlP2ptXy
    mXeH68zYLQDC8Duknq+vYn27xN4COB36ceCJMaVwOXhns+kGShgCduderZwKt3+k
    t2ip1y+ZaJyU3S6n1R9zMGDyqeAj14Alb9ZPuSXrZ2v5lqV1z2YM0C2JFu0eZ36T
    iDNiimesZ3Z0cxA1ELNsGtMwijR0D4+UVBA7zubBOeWYJ7I4oSOgRzvM3+r4VZor
    uNb7CdU7PAC9M8f89Vu9BBqz4sCgPqFfR5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528128124;
    bh=giPl7DYu3nSNKpS94w1VxqbRzKw23ZxKGMaV/bVcekw=; b=SCP/5PLYfV0y
    eGH7cKILhc5NHxbuQc3T/Nnnsk/Ol5YV96XdOHmDXmHKyGBVBLlfSv2FA0Vzb8En
    28nwWfjmgtixGXIBG/HxpB3/xkEGcxPyoveMD8v0VpSVd0UUiS1oQFTCArwcv458
    ouVIsVJW6u6U5JMu7FdpsMQgWzvH3J3aO4ypXGP5e+9FJH/EyuwaTdSGhB3bQ8zT
    v8Fsip2qgxCh1OXEk2QpXex3/MtTx78fEcue/EVeEcnOwy0Yu5tVhYuvGYvdnqiV
    63Ifw+rDy43mGNwVKsa01nb3v/urUt/5N3D43rn2egIWjZw8lzbrC/0H0Ok/Itgf
    2f5RefCilQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=j1BNT6C7 header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=j1BNT6C7 header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP0P94u3xhLXbW36GcWGnhsRNXz4LzbVveZ34eW4U5SxCXNvVrfi0rr5keN14Ks38x2s23rCBBnOVzWMq799vb0jFVWaL9nr3uAHVtfawYm+AoZggNYD
    NNhdw1hhnAGN0+uiiXYfvs20Ay4W/25iXJfaN+o+0rk7a0SqZ4S4EZSdUWW8pPgsIaX/F10VOX3GewevUYOoo8NZ+pf7PL34lS0AyboZExqgzxWsYQVkjPOO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=7xzEC_bzFwYMSlg10IIA:9 a=QSkxrfPobJbTGFZB:21
    a=RNIQCBoCyyjidbSD:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeFDQCC (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 12:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeFDQCC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 12:02:02 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH -tip v5 27/27] kprobes: Remove jprobe stub API
Date: Tue,  5 Jun 2018 01:01:38 +0900
Message-Id: <152812809849.10068.9356670248264515092.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove jprobe stub APIs from linux/kprobes.h since
the jprobe implementation was completely gone.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   50 -----------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b520baa65682..e909413e4e38 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -63,7 +63,6 @@ struct pt_regs;
 struct kretprobe;
 struct kretprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
-typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
 typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
@@ -101,12 +100,6 @@ struct kprobe {
 	 */
 	kprobe_fault_handler_t fault_handler;
 
-	/*
-	 * ... called if breakpoint trap occurs in probe handler.
-	 * Return 1 if it handled break, otherwise kernel will see it.
-	 */
-	kprobe_break_handler_t break_handler;
-
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
@@ -155,24 +148,6 @@ static inline int kprobe_ftrace(struct kprobe *p)
 }
 
 /*
- * Special probe type that uses setjmp-longjmp type tricks to resume
- * execution at a specified entry with a matching prototype corresponding
- * to the probed function - a trick to enable arguments to become
- * accessible seamlessly by probe handling logic.
- * Note:
- * Because of the way compilers allocate stack space for local variables
- * etc upfront, regardless of sub-scopes within a function, this mirroring
- * principle currently works only for probes placed on function entry points.
- */
-struct jprobe {
-	struct kprobe kp;
-	void *entry;	/* probe handling code to jump to */
-};
-
-/* For backward compatibility with old code using JPROBE_ENTRY() */
-#define JPROBE_ENTRY(handler)	(handler)
-
-/*
  * Function-return probe -
  * Note:
  * User needs to provide a handler function, and initialize maxactive.
@@ -436,9 +411,6 @@ static inline void unregister_kprobe(struct kprobe *p)
 static inline void unregister_kprobes(struct kprobe **kps, int num)
 {
 }
-static inline void jprobe_return(void)
-{
-}
 static inline int register_kretprobe(struct kretprobe *rp)
 {
 	return -ENOSYS;
@@ -465,20 +437,6 @@ static inline int enable_kprobe(struct kprobe *kp)
 	return -ENOSYS;
 }
 #endif /* CONFIG_KPROBES */
-static inline int register_jprobe(struct jprobe *p)
-{
-	return -ENOSYS;
-}
-static inline int register_jprobes(struct jprobe **jps, int num)
-{
-	return -ENOSYS;
-}
-static inline void unregister_jprobe(struct jprobe *p)
-{
-}
-static inline void unregister_jprobes(struct jprobe **jps, int num)
-{
-}
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
 	return disable_kprobe(&rp->kp);
@@ -487,14 +445,6 @@ static inline int enable_kretprobe(struct kretprobe *rp)
 {
 	return enable_kprobe(&rp->kp);
 }
-static inline int disable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
-static inline int enable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
 
 #ifndef CONFIG_KPROBES
 static inline bool is_kprobe_insn_slot(unsigned long addr)
