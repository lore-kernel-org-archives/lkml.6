Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185420-2-11066492770534391385
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
    t=1518185420; b=EinUxsrdj7GS+gtNBKHN9ZdlRWnj1fkK9qwwWq6oVO0R+Jz
    Z7IUo37lJ4xDZ6w8wJfhWdtm+MLlqI89XI3Dz0/iTmlp9VGjypiw3zrrWUhGQcGN
    7eHTgOVTutleQxJQ7+JiJQOhXwY5fN17IwXakwW/TukomWi++fQB/SceB2Oz6DD/
    U1rg/1S/4FemWnYC/aC40cqG3Nbn18rgLDsnMFcx9vD8cNpZJtuSoTKIOerjbn6M
    5DS9yBJbCUYwysXypOSZFBwmckD2ZZBQdUCUCtuCjp5/kNLiWkgfgv6HrQDV+4uH
    QXyIPO4ypkv9bODfA/t+FhLjqRG0ws8Pk40sOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185420; bh=24pVcP+X0bTcsFthuFt9lhOU4d
    U5hkQUAF7uWMxMC8Q=; b=OH/QcwYwGyRQoREgimww/D9Wx2pvjJLgDb+2BjAgdp
    N3AiWftN2t01AADyRQ8pLc6XgX1M0eTwJYwxQskAb20h1aUxyBGdgpEDEHrvHrJ7
    w9MCQw6V6tuRvwtqMH3rWOtReGNyH+RQ5c4MnMxaHrQmUE2WrRKIZOGFlUQNFAm9
    Meh4ytBxMSpDf+eFevUyZMoG7AsjXkdb9duVzWdwuIkR0sS3A8m/4V03RF2ax9H3
    EsygVcnwGcFQXLK5NTRL6SbfsUzPI0CZSI3GjcdRGXXP3FcgXB2RzdgYlthGdWm6
    77ZmzDpyFrJbgdGcLLycTRsKEVFSKVsyt8JtG5IqIg3w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeBINmS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINmQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, karahmed@amazon.de, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        gregkh@linux-foundation.org
Subject: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
Date: Fri,  9 Feb 2018 14:39:12 +0100
Message-Id: <20180209133934.259299920@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit fec9434a12f38d3aeafeb75711b71d8a1fdef621)

Also, for CPUs which don't speculate at all, don't report that they're
vulnerable to the Spectre variants either.

Leave the cpu_no_meltdown[] match table with just X86_VENDOR_AMD in it
for now, even though that could be done with a simple comparison, on the
assumption that we'll have more to add.

Based on suggestions from Dave Hansen and Alan Cox.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-6-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   48 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -44,6 +44,8 @@
 #include <asm/pat.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
+#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
@@ -838,6 +840,41 @@ static void identify_cpu_without_cpuid(s
 #endif
 }
 
+static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PENWELL,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PINEVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_CENTAUR,	5 },
+	{ X86_VENDOR_INTEL,	5 },
+	{ X86_VENDOR_NSC,	5 },
+	{ X86_VENDOR_ANY,	4 },
+	{}
+};
+
+static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+	{ X86_VENDOR_AMD },
+	{}
+};
+
+static bool __init cpu_vulnerable_to_meltdown(struct cpuinfo_x86 *c)
+{
+	u64 ia32_cap = 0;
+
+	if (x86_match_cpu(cpu_no_meltdown))
+		return false;
+
+	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	/* Rogue Data Cache Load? No! */
+	if (ia32_cap & ARCH_CAP_RDCL_NO)
+		return false;
+
+	return true;
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -884,11 +921,12 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
-	if (c->x86_vendor != X86_VENDOR_AMD)
-		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
-
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+	if (!x86_match_cpu(cpu_no_speculation)) {
+		if (cpu_vulnerable_to_meltdown(c))
+			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+	}
 
 	fpu__init_system(c);
 
