Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520825699-2-12085286783346679030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825698; b=bSUyyDww1hw1ZGkRuBBlsN6rJN/52dIXzqnzh+ET/rtuolj
    KmWg6BU0ClR2eRfHQRVWAiQyfZ/eIvaYxCAxIrQWwUQILiZ+Q3xt/an+bhiS/mic
    AksL3wMG4nMlGAe/bgwsnhma4idn5cHHj6X3NI7SdtuJz5JearhRTdBIIM8byi8s
    shERpjyYAvm/PotkCPfS2QmYLHu46q/T1U1PXJGySJn4y1h/nEMRVMYJefba3ijy
    FyBhDYtFEQPGjTUBhl9ZzZVtAecSs9CWhmtte6v9eqw/bIVf0JNvJwJ+4z1Jq/j6
    +cXFDGloN1YCmJMXgcQc2BmJr/zRsmyvwMv72xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825698; bh=ut4HCLdcfliOKAfKsBz
    PH07vBPbrWT9rRrtEU6qG8WM=; b=eoNoc9e36MRbtDqryExzF/7gSIZxTEiaDH+
    ir+69LJgJd8YhLPnWkU4eaiIfOx8qPY6USnvRmcNsYyyEQLpMfR8rhYj/UCNc3oH
    sG1Qv1RSQVVlXc5RGqypNpVKsmMBXiMk5dGU36QSEIIYpX5gLvbTy/e+iW4yK50I
    eEnmJNqiLWRX8RqqciLZTl5KUveLxMPqsnAzO2OPX6kGaOGvU3NEmqYi4HNpisiW
    U1+9GmmiUyMqBoD/SjvlRCoU17ilSpw4qndDNJAkZUFpJRJPWOk74qh2WR16qRYj
    4Tkric8Itvd5PBR52ZkgK6eUH/i4w9iLqiI99zogDcXn7pztSCQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeCLDeo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:34:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42911 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933492AbeCLDeS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:34:18 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@amacapital.net>,
        "Borislav Petkov" <bp@suse.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.347392980@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 21/76] x86: Clean up current_stack_pointer
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@amacapital.net>

commit 83653c16da91112236292871b820cb8b367220e3 upstream.

There's no good reason for it to be a macro, and x86_64 will want to
use it, so it should be in a header.

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/thread_info.h | 11 +++++++++++
 arch/x86/kernel/irq_32.c           | 13 +++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -170,6 +170,17 @@ static inline struct thread_info *curren
 	return ti;
 }
 
+static inline unsigned long current_stack_pointer(void)
+{
+	unsigned long sp;
+#ifdef CONFIG_X86_64
+	asm("mov %%rsp,%0" : "=g" (sp));
+#else
+	asm("mov %%esp,%0" : "=g" (sp));
+#endif
+	return sp;
+}
+
 #else /* !__ASSEMBLY__ */
 
 /* how to get the thread information struct from ASM */
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -69,16 +69,9 @@ static void call_on_stack(void *func, vo
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
 
-/* how to get the current stack pointer from C */
-#define current_stack_pointer ({		\
-	unsigned long sp;			\
-	asm("mov %%esp,%0" : "=g" (sp));	\
-	sp;					\
-})
-
 static inline void *current_stack(void)
 {
-	return (void *)(current_stack_pointer & ~(THREAD_SIZE - 1));
+	return (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
 }
 
 static inline int
@@ -103,7 +96,7 @@ execute_on_irq_stack(int overflow, struc
 
 	/* Save the next esp at the bottom of the stack */
 	prev_esp = (u32 *)irqstk;
-	*prev_esp = current_stack_pointer;
+	*prev_esp = current_stack_pointer();
 
 	if (unlikely(overflow))
 		call_on_stack(print_stack_overflow, isp);
@@ -156,7 +149,7 @@ void do_softirq_own_stack(void)
 
 	/* Push the previous esp onto the stack */
 	prev_esp = (u32 *)irqstk;
-	*prev_esp = current_stack_pointer;
+	*prev_esp = current_stack_pointer();
 
 	call_on_stack(__do_softirq, isp);
 }
