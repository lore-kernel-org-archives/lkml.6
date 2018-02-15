Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720658-2-8874462471414380291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720658; b=LIZgEb7CYtGIHmIxoz28Y2OTd+ok4ccVG1b2er7vloXTqUr
    watEt8E1izYu+UOO1PcTyr0NpAGfI1hYSxQwGjf4DNA0hQUrHVEZyaLU3Em96TIT
    j8R9h3WMHtwXhhlwZwFdimfRu9oYq0kQpKy23AtkEsv8aiAkhhHYV0+hVB5UgbYK
    95LsvW94S/xTCQfrctBTLgLt5+itbgraUEFSivwFFK5axC+sPVTCIE7JsnF03wK1
    kZknEQXsQI2f8vn4CLUY/d6CCTGWPeyO718PK8y7XCPLyov681L88w11l3KOB3ry
    VPFPw9DGWWPakFd3SgzIox2thTKUCoUsAEhpnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720658; bh=Ch7uMvXPvhYGE+5RDW0c1cq80N
    rEaHhonngDza9xrVg=; b=jzhfvTWcDKQOout9mbWtf9YUufQV+wSerFGJt78mQ2
    rBV75HFmBJzb8OcMwDC4lPoOiFXArIxPZnXD1cqNXiJ4CcXfTMhvNq+o6tDjDd4C
    ffmEwkU8RMTWVpoXyl5ZDgQHZMnYOuPc5HumfSvK7k4iHlpZp3CJ4TZgGlvw0JDd
    ZzdRlewmHOaaACYh9M55qG+K1hMP3wOCFcQVrWozfKQuw0ZwiYJHQvW5uJ+BUftW
    +O90VBNbmb027HkrMwGWVOWaAvuFJH/rhCuzB9s/Gcjry/nL8h0WNGtF9VuVXPGB
    0fxcH7KAssT1QX/Qpo/CT3pvrHHLM/URuV35/IqNW7Ag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162087AbeBOPVe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162080AbeBOPVb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitriy Vyukov <dvyukov@google.com>, LKP <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 026/108] x86/asm: Fix inline asm call constraints for GCC 4.4
Date: Thu, 15 Feb 2018 16:16:23 +0100
Message-Id: <20180215151226.199156719@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 520a13c530aeb5f63e011d668c42db1af19ed349 upstream.

The kernel test bot (run by Xiaolong Ye) reported that the following commit:

  f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")

is causing double faults in a kernel compiled with GCC 4.4.

Linus subsequently diagnosed the crash pattern and the buggy commit and found that
the issue is with this code:

  register unsigned int __asm_call_sp asm("esp");
  #define ASM_CALL_CONSTRAINT "+r" (__asm_call_sp)

Even on a 64-bit kernel, it's using ESP instead of RSP.  That causes GCC
to produce the following bogus code:

  ffffffff8147461d:       89 e0                   mov    %esp,%eax
  ffffffff8147461f:       4c 89 f7                mov    %r14,%rdi
  ffffffff81474622:       4c 89 fe                mov    %r15,%rsi
  ffffffff81474625:       ba 20 00 00 00          mov    $0x20,%edx
  ffffffff8147462a:       89 c4                   mov    %eax,%esp
  ffffffff8147462c:       e8 bf 52 05 00          callq  ffffffff814c98f0 <copy_user_generic_unrolled>

Despite the absurdity of it backing up and restoring the stack pointer
for no reason, the bug is actually the fact that it's only backing up
and restoring the lower 32 bits of the stack pointer.  The upper 32 bits
are getting cleared out, corrupting the stack pointer.

So change the '__asm_call_sp' register variable to be associated with
the actual full-size stack pointer.

This also requires changing the __ASM_SEL() macro to be based on the
actual compiled arch size, rather than the CONFIG value, because
CONFIG_X86_64 compiles some files with '-m32' (e.g., realmode and vdso).
Otherwise Clang fails to build the kernel because it complains about the
use of a 64-bit register (RSP) in a 32-bit file.

Reported-and-Bisected-and-Tested-by: kernel test robot <xiaolong.ye@intel.com>
Diagnosed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: LKP <lkp@01.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
Link: http://lkml.kernel.org/r/20170928215826.6sdpmwtkiydiytim@treble
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/asm.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -11,10 +11,12 @@
 # define __ASM_FORM_COMMA(x) " " #x ","
 #endif
 
-#ifdef CONFIG_X86_32
+#ifndef __x86_64__
+/* 32 bit */
 # define __ASM_SEL(a,b) __ASM_FORM(a)
 # define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
 #else
+/* 64 bit */
 # define __ASM_SEL(a,b) __ASM_FORM(b)
 # define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
 #endif
