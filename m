Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824139-2-7923106054296696221
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
    t=1520824138; b=B819BV5AvjRgS3bswzgyhJGsEsSPDnxecI+5X8MVISEH5hC
    XtXcJ2uHUvpr790gIJZEVl6pTKxiI5Z3KbrF7AunPwvweBme7eZI4ldSeIFSNdNO
    I5jwcnbCY4Qwe8mP+KHTvKWEf6h9r/tJwnB/aDAiF3BjgGAFcqq5qupydxT44OHQ
    dGmobTiTU7keGo974KypkhIRTufJAvvN3F7vB7srE8DrTgHkX4UY8+fZt1WgQp3j
    fwFg5uEm351SmGISWPEybFDwLmDhE9xHwEK7AHS1a019tJvr89AoMdo2ZZUah9Yz
    bAAImPaDujks01Jq+9ySQE1vjwhjFjiiHhbZDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824138; bh=d+x761UanbI0Ekw/eIF
    22Srdby8EdD6sTOTrE1aW3Yw=; b=oYvGTawPmTJX/1+5bn7MSAovy7SNxNM1+J/
    NzOJ2lgo/qDYNHMVuf8L4T3HEeSm0kOGyfhaSWzQ43arXbR41TKhh+mKVpRSbDCU
    oRjdJ6lKYZCcbJqMWRNPmxqoZrvgNP9gXejpuQoUPunWYBMZlcda8rV7HVP5dDZh
    z4M7v5+LBsEOYAPSH/H3TiG+0spg39ijeRFROtp7MqCm5n4sZbcz063AJY+CdYDm
    sdazyS63o+YdFRcH/nYgLHX+CWHqo4pFpTjC2MzaB9QzEmNJqHLRr+vp/d7k85RL
    +rJUZu8xi46hIU69vsj4kg/cKI3h80IGNvCQufTcTM6FympEH9g==
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
        id S932821AbeCLDIC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:08:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41510 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932781AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        "Brian Gerst" <brgerst@gmail.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.987771650@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 13/76] x86/alternatives: Guard NOPs optimization
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
@@ -325,6 +325,9 @@ done:
 
 static void __init_or_module optimize_nops(struct alt_instr *a, u8 *instr)
 {
+	if (instr[0] != 0x90)
+		return;
+
 	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
 
 	DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
