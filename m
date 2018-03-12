Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826280-2-9570375997874196624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826280; b=gUkHDoJ9yDjreGbtIqKeF254DnT1cWCpeGQ1v2sZjTfrVpc
    1Y1vHKy28pMa5hC1+g+oqjOQfY4RM3CT/0IHsUyZ6cbnIZFctUTy5Yj8WgDipkJl
    vQHYOIFQtAJMwZ21R+VdY6qMKKqpNMJtK0ejwSsuVJRzCAnlMaqWUvXqEQdHo2VF
    b/R8znDkC8lYyMDJHqrR/kE/C6yelZK+9CFcSladkfFYCzN9K6ljnjK9j1XmkcN0
    c1/tHIW+Y/MSHa2MHiSjCS9NviZLIGDLpOkPiejuoqYiwQO/qN5OQq3pQ/aPSnsr
    QAjrZJBj0xNFcdRuZPX+cbo8rrBxyH+f1Qgxr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826280; bh=gVt4gAq3ObKwsDsU03T
    x7Gy7978/jgvIBsdtH5MI4X0=; b=c77jkkmBLH5dxmsPCvMQOeBjDNvzCPodANw
    4O+9PBLY6spwAc7SqE53HehJZTWxHJZhRN1sVhR+5CbQDaxwCSpx9mWLEj2U2equ
    qFWZJm5CO5e+SmxO+iksi2hcK54R6UosbmSYLa1Gx/uPl0r/pF5VW0i8CB0IOo6s
    8vl8PjRrZHXCaien5PEJ2Q1824hhy0TVEKvN/Zca3cd/nT9V4XFpD9v6HVMNwAn0
    SpOul+PwDC3Yo+Wn2eRYiyde+LJOwUwBvivheEOcAMsH7gM+b9yxx5eVJNKRkqpw
    oyZKdvtZryrgHkrBawf42styIl28bgCkUQy2Z6TWACAe7Bv46xw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932724AbeCLDof (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:44:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41148 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932651AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>, "Borislav Petkov" <bp@suse.de>,
        "Borislav Petkov" <bp@alien8.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.922480963@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 049/104] x86/alternatives: Guard NOPs optimization
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

From: Borislav Petkov <bp@suse.de>

commit 69df353ff305805fc16082d0c5bfa6e20fa8b863 upstream.

Take a look at the first instruction byte before optimizing the NOP -
there might be something else there already, like the ALTERNATIVE_2()
in rdtsc_barrier() which NOPs out on AMD even though we just
patched in an MFENCE.

This happens because the alternatives sees X86_FEATURE_MFENCE_RDTSC,
AMD CPUs set it, we patch in the MFENCE and right afterwards it sees
X86_FEATURE_LFENCE_RDTSC which AMD CPUs don't set and we blindly
optimize the NOP.

Checking whether at least the first byte is 0x90 prevents that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1428181662-18020-1-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/alternative.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -323,6 +323,9 @@ done:
 
 static void __init_or_module optimize_nops(struct alt_instr *a, u8 *instr)
 {
+	if (instr[0] != 0x90)
+		return;
+
 	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
 
 	DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
