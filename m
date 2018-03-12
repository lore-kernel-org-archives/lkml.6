Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824114-2-3583074515316040502
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
    t=1520824112; b=dwvUbLTPfICkAsAESqbubxqduMeU4ar+rGOAIUcDyntGM+r
    f7aZrhXNJ3kfLtcM4lNx/zqUriKPUKxb7p06hvlh8KsaftOmfBrx0nuSIefJFZRJ
    zNMVRYeLZj86mTXPGskQQWzptDLldfsGiv2JAmQSEP79/U1KOXhba6rQn9woIZdt
    0ZlKAx7j65zo2y3Hs0kK1ce4793EDaWGyRNwOK/LF9KPCt3U4hwQEzXxcqC4w8kT
    8S04frkuOrIP1Qo738rJgY7ltosvIaMPeHbSreoVLHxjswnlgYIU7wXY+a/NAuqH
    RNHXK4nTjng+EuFwfMJZ1HuAUZ13U+dAsGKRocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824112; bh=LyuQtZFPp1glsgxWLqM
    3xDnDkNJL4iyM4+Nd59p2ovo=; b=YT0Z0LJnrmw5J1x/d2rJA8HB6Nzad0Rub7T
    V32jkCdm4i0DcJuXrlz04upqG8OUKQdAryvSGDB13GkVHbpVP0r9sp/UfJCJnOpu
    3OcvFyLRtXZKCZ3ZEKrrpvRVhp1Cgd8xDJkakmKZ57eu0w6Xkz5qvIi7lkXii66w
    F4J62XAcbNRO+Ve9SjWpZ3zoELiU4nzYGsGoU3gK9/4qxqx9TwmAQuZLSbLUwFsj
    FFHg1x3Pd7tNeHq4tRDvaWnjxcm+TTTNk7LGZARln557lkzmjaleuoIJKbOOkf6K
    Ggg5IVsSUXdDvecZo8TiaIgIA0LwNipYJiHnPeeGPFGEE2/ZXZQ==
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
        id S932462AbeCLDIE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:08:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41529 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932788AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, keescook@google.com,
        "Brian Gerst" <brgerst@gmail.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Eduardo Valentin" <eduval@amazon.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, hughd@google.com,
        "Greg KH" <gregkh@linuxfoundation.org>, aliguori@amazon.com,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        daniel.gruss@iaik.tugraz.at, "Will Deacon" <will.deacon@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.447521300@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 05/76] x86/cpufeatures: Add X86_BUG_CPU_INSECURE
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

commit a89f040fa34ec9cd682aed98b8f04e3c47d998bd upstream.

Many x86 CPUs leak information to user space due to missing isolation of
user space and kernel space page tables. There are many well documented
ways to exploit that.

The upcoming software migitation of isolating the user and kernel space
page tables needs a misfeature flag so code can be made runtime
conditional.

Add the BUG bits which indicates that the CPU is affected and add a feature
bit which indicates that the software migitation is enabled.

Assume for now that _ALL_ x86 CPUs are affected by this. Exceptions can be
made later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: assign the first available bug number]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -241,6 +241,7 @@
 #define X86_BUG_COMA		X86_BUG(2) /* Cyrix 6x86 coma */
 #define X86_BUG_AMD_TLB_MMATCH	X86_BUG(3) /* AMD Erratum 383 */
 #define X86_BUG_AMD_APIC_C1E	X86_BUG(4) /* AMD Erratum 400 */
+#define X86_BUG_CPU_INSECURE	X86_BUG(5) /* CPU is insecure and needs kernel page table isolation */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -804,6 +804,9 @@ static void __init early_identify_cpu(st
 		this_cpu->c_bsp_init(c);
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
+
+	/* Assume for now that ALL x86 CPUs are insecure */
+	setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
 }
 
 void __init early_cpu_init(void)
