Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826118-2-18293688173433677926
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
    t=1520826118; b=K0Q/L6izHaas6E+/tPGRkKj7Yxwd0VXewJ146q64miyWiL3
    Sw9FooROtYKla4IMKrXwz35kyxAopCz/9LEIzrarmNUh2a4OmiHmHTmpA1MQMyRe
    C6H7d5FB31TnxCkhomfgnuRulLu1jE+jrtm+3fx+TPV4/+8mCTd6L7T5LP6lzMsy
    xox9QlzCAo1q6REeZMTXvz3n2Z/0eTevOhsyH7EMhU/lmcwSoHk7dKJ/s7HVrtMV
    b8W29mqzyMMYvX9WBU1RliQBHFU9fYYz7EtpXay8lvPLrJnt3uu+djHKcxkHiZBQ
    4AtQ0j9QWmRp2AGw2IlJ3qIciTulx7peR+JQEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826118; bh=ePzKX4Zdbo4+4NG7Q03
    oiubIa1b8KCs0g0lWnq7mmxA=; b=f3YkIi3WDCfjlM/VrFFuepRaIt6MpVCpX9u
    4ezFe5Js+FHtt+xw/5pJRuL0gWC5uTOQJyPEVVJHSnFl9pFRFzZOutPlEPoMx2JX
    yUlmZXM7KMgo8wf3ov5l/kpmeMcMRovRGKSlGPkUBwuvka1om28AiKPrKCH0Rcx9
    fy8SKfAo5uszC2uZtHJXflKo2RT7g0Z/JBsPwAYJBtzWcZSySF14hqU5qmnzkjlI
    ojx03NeZ+mEpfmLtNRe283BtWB6JGlEx87IZ7gCFEJTWCk6IfyrZ5sxzgeoaCFnA
    9zXRSVWlHz8zDrZNPOu2TgT7Htoic8zz9WcvcUF+ObR+F9Lx6fQ==
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
        id S932694AbeCLDly (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:41:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41169 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932665AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.933529292@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 032/104] x86, cpu: Expand cpufeature facility to
 include cpu bugs
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

commit 65fc985b37dc241c4db7cd32adcbc989193fe3c8 upstream.

We add another 32-bit vector at the end of the ->x86_capability
bitvector which collects bugs present in CPUs. After all, a CPU bug is a
kind of a capability, albeit a strange one.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/1363788448-31325-2-git-send-email-bp@alien8.de
Signed-off-by: H. Peter Anvin <hpa@zytor.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 13 +++++++++++++
 arch/x86/include/asm/processor.h  |  2 +-
 arch/x86/kernel/alternative.c     |  2 +-
 arch/x86/kernel/cpu/common.c      |  4 ++++
 4 files changed, 19 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -7,6 +7,7 @@
 #include <asm/required-features.h>
 
 #define NCAPINTS	10	/* N 32-bit words worth of info */
+#define NBUGINTS	1	/* N 32-bit bug flags */
 
 /*
  * Note: If the comment begins with a quoted string, that string is used
@@ -208,6 +209,11 @@
 #define X86_FEATURE_INVPCID	(9*32+10) /* Invalidate Processor Context ID */
 #define X86_FEATURE_RTM		(9*32+11) /* Restricted Transactional Memory */
 
+/*
+ * BUG word(s)
+ */
+#define X86_BUG(x)		(NCAPINTS*32 + (x))
+
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
 #include <asm/asm.h>
@@ -397,6 +403,13 @@ static __always_inline __pure bool __sta
 #define static_cpu_has(bit) boot_cpu_has(bit)
 #endif
 
+#define cpu_has_bug(c, bit)	cpu_has(c, (bit))
+#define set_cpu_bug(c, bit)	set_cpu_cap(c, (bit))
+#define clear_cpu_bug(c, bit)	clear_cpu_cap(c, (bit));
+
+#define static_cpu_has_bug(bit)	static_cpu_has((bit))
+#define boot_cpu_has_bug(bit)	cpu_has_bug(&boot_cpu_data, (bit))
+
 #endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
 
 #endif /* _ASM_X86_CPUFEATURE_H */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -86,7 +86,7 @@ struct cpuinfo_x86 {
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
 	int			cpuid_level;
-	__u32			x86_capability[NCAPINTS];
+	__u32			x86_capability[NCAPINTS + NBUGINTS];
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -359,7 +359,7 @@ void __init_or_module apply_alternatives
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insnbuf));
-		BUG_ON(a->cpuid >= NCAPINTS*32);
+		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 		if (!boot_cpu_has(a->cpuid)) {
 			if (a->padlen > 1)
 				optimize_nops(a, instr);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -954,6 +954,10 @@ static void __cpuinit identify_cpu(struc
 		/* AND the already accumulated flags with these */
 		for (i = 0; i < NCAPINTS; i++)
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
+
+		/* OR, i.e. replicate the bug flags */
+		for (i = NCAPINTS; i < NCAPINTS + NBUGINTS; i++)
+			c->x86_capability[i] |= boot_cpu_data.x86_capability[i];
 	}
 
 	/* Init Machine Check Exception if available. */
