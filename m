Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955834-2-1021771352647813812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955834; b=OwrjLMfqkvybfOg//iRPpNHPWFaEWY8rdVp8An3PA+Y0MGL
    qQp1hrnwho2C4GBh05+V8EaO1Z9g+mFW7b2+cw1qWbDyKoga6hHGeVEADBLl1vZP
    vJRCUTsMgV11DZVkHvIMp9oKnhOz2qb4khVufRUhkyqM+RM0XeNpzGXZrSR5U3r6
    uY1RuAkswDd4ypfadlWcMKIC+dH4o67a0I5BKtz3pd4RizmektwnWQcBTIK4kHDs
    Cak2wv67KHMcEqyY0d7wmMidrcDjtcpoAj5G8nzuGg8Jmz4RkiWlieLgxQs1tQgU
    jyZIeQR2bN+B0W4D0kyECxmtSH8UxfGZMsLe5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955834; bh=jEoF94+71W+2CgiEg+UjioAMtR
    +ZMsLkKmiEaqZYqro=; b=o/7klgXy07cE3Te8SzEDMu9gXxTv2OmyugPlzsw/Jz
    GY+7F1wgHPOT3wyYOzcJXE6EieWh8Bt4MnM/KftSTst/Qmmwrp/nSfTyKL++Wzv8
    b2EOjarlrh9zmEyCit1Njj97Wg825bsN5tu7HMJBhsZJr4pkVmlyRjrRjD6vtBX4
    a5BYZYmrLR9WXRxc35nKSXgfd304SZkr4KrQEM5YNLx8J4NGuhZM8ewVuujR3y1X
    GZgg0EapxHMligl1us+Tquyf5AWPrTusqQqiF48Sr9suY+QJhM0FBkjhzsPRTmXy
    zPl4hjuBLSP4V+zu3vkJVQTnE76903c3MP9lI5jDurzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964840AbeCMPlj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:41:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935010AbeCMPlh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 129/140] x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
Date: Tue, 13 Mar 2018 16:25:32 +0100
Message-Id: <20180313152506.861712803@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit bd89004f6305cbf7352238f61da093207ee518d6 upstream.

The objtool retpoline validation found this indirect jump. Seeing how
it's on CPU bringup before we run userspace it should be safe, annotate
it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/head_64.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,6 +23,7 @@
 #include <asm/nops.h>
 #include "../entry/calling.h"
 #include <asm/export.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -134,6 +135,7 @@ ENTRY(secondary_startup_64)
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
