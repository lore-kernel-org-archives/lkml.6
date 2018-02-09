Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185552-2-7543148560495578067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185552; b=Ca9f0U1AsnrotnT5S8LBZfsSfdxQ7Yj8I6cY4vUomDQJrCi
    JUT2oBohsGNaR6mde1SU9f+pC6tVoVRhIFG4uSmB0pI0lXMDUG0WT7dXqOoeUy02
    0Wmhrgs3YilcmbKKrowCoeDRp56p2NBu8Ll1KUUkVKmFR1RrhdXzMuq93kD5Zt9n
    ZfNgh3Y/21SKZk98cJw+Np01NRT5Qhu5wTH6K7eTcwBduEy45U42QGIU/qTE+vQZ
    rTtuAIq7HkJIkFHZL+iw8NOrIwF7DiVkVB5GgGiMmyTZXlpWsaMyHwQvhCqxhMpm
    wxtgmLY/eL+kiAU70Yq8XI9Vc3BryRqrq6tz/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185552; bh=ufZPNq/U3e+4gvswkjmcBgQgBB
    ghFOHoXMWKonaW2bw=; b=qOUbo/cdk3EqxVtciImTEzGTA9MfPoO2jmSIyKknhM
    lG0PgURV4Zh9y949qk2Y91EsO+BX62UWmxPr+wwCLeibtPAqj6dQBFh6kzta7eGl
    ezWoradIoFURXfvX6Bp/vsfDQu+nx46R4t0t1GDBF18jdN8yN7jglbYhmz3J0ord
    B9qzXjD/RDoQYzTs70qMEAfMo93qVofKHzmUIMCu+FKhCx7GZHqymuUMFGLp32/n
    lNsWijh8kHPYfjgP/OYKPq+yZ/vxB6Cin9QyikHRGwnwSvXoTIEwEx67EZH705xD
    KdZg+JUj/69ELigfqoudsVrx5uhXIzl9YJjIu8NRPKCg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeBIOMQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:12:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeBINlx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, rga@amazon.de,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 4.9 36/92] KVM: x86: Make indirect calls in emulator speculation safe
Date: Fri,  9 Feb 2018 14:39:05 +0100
Message-Id: <20180209133933.771072983@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

(cherry picked from commit 1a29b5b7f347a1a9230c1e0af5b37e3e571588ab)

Replace the indirect calls with CALL_NOSPEC.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rga@amazon.de
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lkml.kernel.org/r/20180125095843.595615683@infradead.org
[dwmw2: Use ASM_CALL_CONSTRAINT like upstream, now we have it]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/emulate.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -25,6 +25,7 @@
 #include <asm/kvm_emulate.h>
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
+#include <asm/nospec-branch.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -1012,8 +1013,8 @@ static __always_inline u8 test_cc(unsign
 	void (*fop)(void) = (void *)em_setcc + 4 * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; call *%[fastop]"
-	    : "=a"(rc) : [fastop]"r"(fop), [flags]"r"(flags));
+	asm("push %[flags]; popf; " CALL_NOSPEC
+	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
 
@@ -5306,15 +5307,14 @@ static void fetch_possible_mmx_operand(s
 
 static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *))
 {
-	register void *__sp asm(_ASM_SP);
 	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
 
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
-	asm("push %[flags]; popf; call *%[fastop]; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [fastop]"+S"(fop), "+r"(__sp)
+	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
 
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
