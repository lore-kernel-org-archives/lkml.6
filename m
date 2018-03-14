Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-693261-1521003817-2-1279718692836162493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521003816; b=TFPecz+VICIKkIayW9HNtBNFAvDJNad2VKvarsqeMdhQ3S3
    Uh6c2sIP8WPFDnEzuTvoOY1+d4MvLXhgGGrfCS9D9rxgp6skk1+lNiP+151GE9yd
    7VSkH7Nb9tRA6rS+fE7xr5BGphIKYTo5GKe0kVpaCV+QqAsvg6Se3ucNgBGAsvyw
    UBijnRvyJPCWcifaJ6VJhxH3gOwxefmzvy28vOsHeeTVUslpeinm5NP4mgxb1eWO
    4dn/jjrA+zERVFw/CXxdVqOnEXBKCW5xmWSkjYdFfDulJ1Eb1go8Gpc0Zpuony1l
    ISxRTUT1upIN+lkKNbq5sgGHBphQoA5VdApyoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521003816; bh=beaM37Ea2Y9zOYiQ+Ob+w7GWHN5n9Kbbsm7
    +m/nL0jo=; b=s/7F0PmVA97rzQM3A4gUbRXzTQUJk5vlBc9bI618v344QKOQJJ2
    YplCCXed2YIjRzAHS6MIw1uLxisRKxjxHPfTAD+p62uNpTZbKxlSKfQuXS9yB/uu
    cqmB8bXS88TZt8iRP5qrp5Flbbl8zkM+v1Mk3NSlUxZy3WXv1NchSi7kIC+h7w1R
    gNXL/hnJmr4UJxxdkx3UQ/V9h2uFEh6KKqn/RW4z54b64upPQEzXYrkT0y4/My8R
    7XOd6JjsT5HExD//99MZKjPyAtVqRIUyJNdfnagINyGkqhINSwjap9NOk5dHeIgx
    KSTNJr5nYOUmjVnWuf3okVX+lJbnZyiVh+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeCNFDT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 01:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeCNFDR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Mar 2018 01:03:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4C821783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Stas Sergeev <stsp@list.ru>,
        bartoldeman@gmail.com, Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/3] selftests/x86/entry_from_vm86: Add test cases for POPF
Date: Tue, 13 Mar 2018 22:03:11 -0700
Message-Id: <a16270b5cfe7832d6d00c479d0f871066cbdb52b.1521003603.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1521003603.git.luto@kernel.org>
References: <cover.1521003603.git.luto@kernel.org>
In-Reply-To: <cover.1521003603.git.luto@kernel.org>
References: <cover.1521003603.git.luto@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

POPF is currently broken -- add tests to catch the error.  This
results in:

   [RUN]	POPF with VIP set and IF clear from vm86 mode
   [INFO]	Exited vm86 mode due to STI
   [FAIL]	Incorrect return reason (started at eip = 0xd, ended at eip = 0xf)

because POPF currently fails to check IF before reporting a pending
interrupt.

This patch also makes the FAIL message a bit more informative.

Cc: stable@vger.kernel.org
Reported-by: Bart Oldeman <bartoldeman@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/entry_from_vm86.c | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index 6e85f0d0498d..ade443a88421 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -95,6 +95,10 @@ asm (
 	"int3\n\t"
 	"vmcode_int80:\n\t"
 	"int $0x80\n\t"
+	"vmcode_popf_hlt:\n\t"
+	"push %ax\n\t"
+	"popf\n\t"
+	"hlt\n\t"
 	"vmcode_umip:\n\t"
 	/* addressing via displacements */
 	"smsw (2052)\n\t"
@@ -124,8 +128,8 @@ asm (
 
 extern unsigned char vmcode[], end_vmcode[];
 extern unsigned char vmcode_bound[], vmcode_sysenter[], vmcode_syscall[],
-	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[],
-	vmcode_umip_str[], vmcode_umip_sldt[];
+	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_popf_hlt[],
+	vmcode_umip[], vmcode_umip_str[], vmcode_umip_sldt[];
 
 /* Returns false if the test was skipped. */
 static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
@@ -175,7 +179,7 @@ static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
 	    (VM86_TYPE(ret) == rettype && VM86_ARG(ret) == retarg)) {
 		printf("[OK]\tReturned correctly\n");
 	} else {
-		printf("[FAIL]\tIncorrect return reason\n");
+		printf("[FAIL]\tIncorrect return reason (started at eip = 0x%lx, ended at eip = 0x%lx)\n", eip, v86->regs.eip);
 		nerrs++;
 	}
 
@@ -264,6 +268,9 @@ int main(void)
 	v86.regs.ds = load_addr / 16;
 	v86.regs.es = load_addr / 16;
 
+	/* Use the end of the page as our stack. */
+	v86.regs.esp = 4096;
+
 	assert((v86.regs.cs & 3) == 0);	/* Looks like RPL = 0 */
 
 	/* #BR -- should deliver SIG??? */
@@ -295,6 +302,23 @@ int main(void)
 	v86.regs.eflags &= ~X86_EFLAGS_IF;
 	do_test(&v86, vmcode_sti - vmcode, VM86_STI, 0, "STI with VIP set");
 
+	/* POPF with VIP set but IF clear: should not trap */
+	v86.regs.eflags = X86_EFLAGS_VIP;
+	v86.regs.eax = 0;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_UNKNOWN, 0, "POPF with VIP set and IF clear");
+
+	/* POPF with VIP set and IF set: should trap */
+	v86.regs.eflags = X86_EFLAGS_VIP;
+	v86.regs.eax = X86_EFLAGS_IF;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_STI, 0, "POPF with VIP and IF set");
+
+	/* POPF with VIP clear and IF set: should not trap */
+	v86.regs.eflags = 0;
+	v86.regs.eax = X86_EFLAGS_IF;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_UNKNOWN, 0, "POPF with VIP clear and IF set");
+
+	v86.regs.eflags = 0;
+
 	/* INT3 -- should cause #BP */
 	do_test(&v86, vmcode_int3 - vmcode, VM86_TRAP, 3, "INT3");
 
-- 
2.14.3
