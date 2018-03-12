Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824554-2-3478248453116339981
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
    t=1520824554; b=N7lm7P7hRr3HACx751PBk5AYWPdfy8VSmh7YuwfRNoCFjZN
    AcA0oVCOy1qxnO6hyNjMcIA98Kj8ku4Yso6NoFjdDFb8OsVbgyrET0wCfuexBlTx
    CQRz9+eeo7D2WDquxxr8yor9bllO6MvfHFg98Na5D4bqYMCmtfBeXhQY5cT/cFBx
    /A3PNSp8sasCrm9ooL3b0tXwqCzwT3srDoADhF9kyz/HUW73/fq+HMJYytye1jf0
    Xur2KTZGnCWdOyBNDiZjFtuAtuLIOtVHj3aW82li+sAekU61reS4945DCzKqqcRZ
    2GdtDVO1uK+J1Lt2n6TsykjWIiTfxhTi+81F8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824554; bh=AcH9tCH/11YL7HD798a
    t7mvOPqwT1CUoY42OziFbsSI=; b=oGX92++rb3wBSayKV30ApEhVjLNwBRdr13m
    Trlq5GoquSMPCuRRonpMGvSzv+GnFfWx2+bLCU64OfwLL0Z2AOB0dFpch22E1mH3
    viLCDEnWBoPuhqeZxDVd+SKILG+fi9QC9RSO3NIr9LSep/EG9LlrN6RIHrBF+vIX
    ibF1hykSdYcOo/etoQWHLlP3ZbTMj8PSlFpzhjcZDqoFnlM2LDq7zYfis9SpHUnu
    L0PV4qk3KXNt+TnLo+iV9DfkY6j85nOpkKH7jXqpL/A7L0koJ5phI6hF4cIj354G
    1Uz9WcH1g6IEQOKDNtf88W7YpzmR5MFLm8x0IzYPH2aCtPpu4WA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S932843AbeCLDOw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:14:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41521 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932786AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Chuck Ebbert" <cebbert.lkml@gmail.com>,
        "Richard W.M. Jones" <rjones@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.805981601@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 15/76] x86/alternatives: Make optimize_nops()
 interrupt safe and synced
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 66c117d7fa2ae429911e60d84bf31a90b2b96189 upstream.

Richard reported the following crash:

[    0.036000] BUG: unable to handle kernel paging request at 55501e06
[    0.036000] IP: [<c0aae48b>] common_interrupt+0xb/0x38
[    0.036000] Call Trace:
[    0.036000]  [<c0409c80>] ? add_nops+0x90/0xa0
[    0.036000]  [<c040a054>] apply_alternatives+0x274/0x630

Chuck decoded:

 "  0:   8d 90 90 83 04 24       lea    0x24048390(%eax),%edx
    6:   80 fc 0f                cmp    $0xf,%ah
    9:   a8 0f                   test   $0xf,%al
 >> b:   a0 06 1e 50 55          mov    0x55501e06,%al
   10:   57                      push   %edi
   11:   56                      push   %esi

 Interrupt 0x30 occurred while the alternatives code was replacing the
 initial 0x90,0x90,0x90 NOPs (from the ASM_CLAC macro) with the
 optimized version, 0x8d,0x76,0x00. Only the first byte has been
 replaced so far, and it makes a mess out of the insn decoding."

optimize_nops() is buggy in two aspects:

- It's not disabling interrupts across the modification
- It's lacking a sync_core() call

Add both.

Fixes: 4fd4b6e5537c 'x86/alternatives: Use optimized NOPs for padding'
Reported-and-tested-by: "Richard W.M. Jones" <rjones@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: http://lkml.kernel.org/r/alpine.DEB.2.11.1509031232340.15006@nanos
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/alternative.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -325,10 +325,15 @@ done:
 
 static void __init_or_module optimize_nops(struct alt_instr *a, u8 *instr)
 {
+	unsigned long flags;
+
 	if (instr[0] != 0x90)
 		return;
 
+	local_irq_save(flags);
 	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
+	sync_core();
+	local_irq_restore(flags);
 
 	DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
 		   instr, a->instrlen - a->padlen, a->padlen);
