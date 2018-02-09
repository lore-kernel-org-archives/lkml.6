Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518185017-2-12392084535185573000
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
    t=1518185016; b=VfrKk6ur4uxt1fwpfBwg8Ny2ihgNH4YqL/Nxm3thRhgq9AE
    2lDc5njjIU3WwkbevSvoEt62EPHBzgWVUjXmy8IVgBWh0dSHe6w4pipn4rNYIXFe
    owCH79OrtUzzZA/p9jMp+kQPJ/P2dv9rjiuVWoatgysBCmkqGftXJQ6g9Zhfj2h6
    ZxlLDAc55l2q2uoJBAI2h4BowgaN7M99dlhVJ78E/Ugwvz4Mcp31QIYsdjigetH3
    4eh64MreVo5s1Egof/9LGm1NqFLGJT3dn3AeY2awqNB2C8cb6TuI1a5VD4o7ZOrL
    odzzj+bY5WkMzdnfEyYtz3qBDx2AptbEFKDnOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185016; bh=/50I5DHxo0EhjPy/JEi09EoyDI
    JuygkXn93erxeozKE=; b=fqDfAWj0XDvsMuJAy8AK/7ZVNl1ly1bOrIXOHip38W
    vX68HsNwNDOn+4envtacRHGd4SNsITbTj0R11BjBA7IsVCFjBUKZZQFHhGu+cv+u
    dlPJREB0O1QJB1m5UZVk72fMfzujkL/zPZFnDlYZsubRVh9/mlAUM4M5IYWbM/kv
    QELmDlWy5dxlL6RrCDn1gqxlG54jVhL1AOzYiRZOa2fbAkcl7DH+e1dY7KV3Ah3p
    ZfyZTXEKoa5RPKESukdqBKxDnQ5DnOigY4iHN991KoqDQ6ZFdnzjQnP83KEGjyGy
    OmaoWugGGS9TyKuFitGaVW4JAP1Dig910iBA/FHLViDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeBIODQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:03:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeBINni (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alok Kataria <akataria@vmware.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 70/92] x86/paravirt: Remove noreplace-paravirt cmdline option
Date: Fri,  9 Feb 2018 14:39:39 +0100
Message-Id: <20180209133936.302304490@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>


(cherry picked from commit 12c69f1e94c89d40696e83804dd2f0965b5250cd)

The 'noreplace-paravirt' option disables paravirt patching, leaving the
original pv indirect calls in place.

That's highly incompatible with retpolines, unless we want to uglify
paravirt even further and convert the paravirt calls to retpolines.

As far as I can tell, the option doesn't seem to be useful for much
other than introducing surprising corner cases and making the kernel
vulnerable to Spectre v2.  It was probably a debug option from the early
paravirt days.  So just remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Link: https://lkml.kernel.org/r/20180131041333.2x6blhxirc2kclrq@treble
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kernel-parameters.txt |    2 --
 arch/x86/kernel/alternative.c       |   14 --------------
 2 files changed, 16 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2805,8 +2805,6 @@ bytes respectively. Such letter suffixes
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
-
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -46,17 +46,6 @@ static int __init setup_noreplace_smp(ch
 }
 __setup("noreplace-smp", setup_noreplace_smp);
 
-#ifdef CONFIG_PARAVIRT
-static int __initdata_or_module noreplace_paravirt = 0;
-
-static int __init setup_noreplace_paravirt(char *str)
-{
-	noreplace_paravirt = 1;
-	return 1;
-}
-__setup("noreplace-paravirt", setup_noreplace_paravirt);
-#endif
-
 #define DPRINTK(fmt, args...)						\
 do {									\
 	if (debug_alternative)						\
@@ -588,9 +577,6 @@ void __init_or_module apply_paravirt(str
 	struct paravirt_patch_site *p;
 	char insnbuf[MAX_PATCH_LEN];
 
-	if (noreplace_paravirt)
-		return;
-
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
