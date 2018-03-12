Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826380-2-17658230548777740126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826379; b=UIxupu62Xy3KwivfivX2fpwv+o7IvBjzSAKh5vY6KyH8RyH
    bScAAfnoY4lBZi7F6bs8cuaH79TXZPilYKoOg9s0oNuh/NHwMk4cCLh75f3W4/wN
    DRs/8giAOUCdd3yNTEQxJCXgVvZi609+bA9X8KHOHV2ln7k00ULLfCnHtKycuJSS
    HKStpv3SOtR0Qo6dDblu1wzu9AiOqXl12EPUHfZVPcJIJqlFy3KbjVWjEN2h13An
    P/22lj27drQ2jyS14EwQppk5b87Q+QiUvQnXBxa4ht8rqAFN1HiKq6mIUFoRKVGf
    NPWypHXQsJ1Qi+Z/0/KI4sGgXW084CMORYAJDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826379; bh=SI+NcZaGQPTHWExOe+E
    0oDqPwWtsqjqyY1E8SXLdEJM=; b=j3CAfAKawr3G0p6Wek5IhFm7nF0AEUYozvb
    6xB84w7lo2j1daXOuBYNoy29l/Y0h3SeAuhGlU3i0z/2QyUKGm2IeIN65dPreNqY
    C9hNb17yFunot9PkwckJlFZYxxtW2fU5eeKE1ec/xuaOEQNH8zwEvY+SHwH4PzXs
    MEc1yog5WjgT4sPsUCmFzvDpwXNl7Tx39fEchDcsxmOd8A2yE4TVT1fI9ZJWNtnX
    mytChlTAeaGj8ehr2jy+EcJnzFQRGNBf2u2+RXK6WOje7tRwh/3dgLzO1kl1Z69Z
    0b2T1mo/Ehn1Zpv0aDp425Bq4znkzgg9qRKBceJooFhHrUzHVZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S932821AbeCLDoj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:44:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41125 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932634AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Borislav Petkov" <bp@alien8.de>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.331556891@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 055/104] x86/asm: Make asm/alternative.h safe from
 assembly
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit f005f5d860e0231fe212cfda8c1a3148b99609f4 upstream.

asm/alternative.h isn't directly useful from assembly, but it
shouldn't break the build.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/e5b693fcef99fe6e80341c9e97a002fb23871e91.1461698311.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/alternative.h | 4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_ALTERNATIVE_H
 #define _ASM_X86_ALTERNATIVE_H
 
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
@@ -240,4 +242,6 @@ extern void *text_poke(void *addr, const
 extern void *text_poke_smp(void *addr, const void *opcode, size_t len);
 extern void text_poke_smp_batch(struct text_poke_param *params, int n);
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_ALTERNATIVE_H */
