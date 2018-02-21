Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217874-2-2104366361812062272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217874; b=D2F2XQpDP8lndMi7EzSn8pe0VGA1nWnDnAMC2aDHCNCfirS
    4Y72ApkP63Y9vREBTP1Dtb2OC2RQXm7Jq7By+cuIhMCLPY7txG4Y2txfDomStJLW
    kw3+BL2z6tg2HulkBfm8FqxH+V0DMwEBoM8F+pL/pg7f0yiNiU7KLObYdIRsdhI4
    S63FF7kezqVZ/SLqqUERcYbssQ1OdWAMj10iqSfW2RcztWwEyuLdic0lk5N3wjJv
    bsGqOmVutZ72VdiD2cf1S+SZCArGRgeyWnVntT+I793jHc8RLRhLSg6KflL+qYXn
    l8DD2lxnINe7nntiNlgFWPjxlGG7Jrc1B4zy04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217874; bh=xpPMz7Zu3rooys2CZ6B0oLx4R4
    A3BgAv7o5nrC9Bm0g=; b=LtcY7MsCH/NXt4kE4qK0TRSjbJuPzr3RNQaUSAwCSh
    j2JFk5OFbcfLxQmqf/HkPsW+0CpXyIj92OZ2ZIYPGkwYzdQ67IDybZK8jUvWvi/L
    +p6wV/zMfipfPNhE+cogbOthkOiiLE8wog05Fu/Kc3we+r66WY99s7xFKbj4ftJs
    ruYvOLlyszfYygA/HzFRQFTsRc3TqIInEOmWiHQd52SnpaewK8HBh7Um0LXpdaFs
    PbVuloPZEhhEQFCq7JMlWZlnIUvrdDFrYenL6mXt65oMeUoIDsqigsiumscTZZYd
    5ulq1vROGlMnxP1b+ka0aS8OEaW/0LQdXRuQ3NNPl2Jw==
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
        id S934749AbeBUM5u (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:57:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeBUM5s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:57:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        kvm@vger.kernel.org, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 53/77] x86/speculation: Correct Speculation Control microcode blacklist again
Date: Wed, 21 Feb 2018 13:49:02 +0100
Message-Id: <20180221124434.454607702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit d37fc6d360a404b208547ba112e7dabb6533c7fc upstream.

Arjan points out that the Intel document only clears the 0xc2 microcode
on *some* parts with CPUID 506E3 (INTEL_FAM6_SKYLAKE_DESKTOP stepping 3).
For the Skylake H/S platform it's OK but for Skylake E3 which has the
same CPUID it isn't (yet) cleared.

So removing it from the blacklist was premature. Put it back for now.

Also, Arjan assures me that the 0x84 microcode for Kaby Lake which was
featured in one of the early revisions of the Intel document was never
released to the public, and won't be until/unless it is also validated
as safe. So those can change to 0x80 which is what all *other* versions
of the doc have identified.

Once the retrospective testing of existing public microcodes is done, we
should be back into a mode where new microcodes are only released in
batches and we shouldn't even need to update the blacklist for those
anyway, so this tweaking of the list isn't expected to be a thing which
keeps happening.

Requested-by: Arjan van de Ven <arjan.van.de.ven@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1518449255-2182-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -75,13 +75,14 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
