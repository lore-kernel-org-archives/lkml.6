Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443417-1521219051-2-3382007278072310869
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
    t=1521219050; b=OAu8mSkwTHYYBKsABvxbQK1uhPqU1EJq5kHq8xiqrmqDmOE
    cBdX9bCZLEWgeV+jOREl60vPz8kobjCOfjUFHCuykxuyKqEr+0KFrpGNKIUEOYd3
    PaeRTWZYZ1SNhyPsT3BF72AhMZAGC+MyGG239Nboy7JdPlDgic9mXznuDNFi9Jyd
    d7xJnbb2aN/vED2/l1DxHEX2eEB4v8GovWCSrOsJyOLApKfC6/SsvSa0y9h2s8Od
    AkzLVTYgukBnLVJoGArAKu09ArTOlgrRLlf8rjMvIgsXICiLikIKwYbwBF+0umuk
    Ro8blzC2mCs0+V1Mtcy/7jWUdKdCsHYFfTDYriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521219050; bh=IlWbi0G6RVptw4PEt7EZdT2e4x
    juL9WLclVcJfGLVO4=; b=jY6crCyEOJGyUMYiQDfDDJyussMrDwBCTShCew534S
    dihTgv0eEHZ659dKeANBh14Ht2Gik89LP450nxsAQfYOS/MehDvJ4D/A5eyBFlZX
    wboIsK/9wuDcPbZ3cPycS2V1r6faWil5Fll/qaaoOOpc70OgUhYEQ06P3UOCfVso
    kAM7R6TQ1JpA2SaEV5P3bd45WjZYtB0qXWvT6Df45j5SznkbfLAKRo78RdlxBxiH
    e4B/xT2Y9aP/0ZcIzPR49tZP9Ti1nWDEgJ0PcrfHZC5M5ZgDC9ZENYjivfZVxBuB
    jOjg4Cx1JQYcaaK/BCvru/Rx2rUc8QZk68HsKM6wY9DA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751879AbeCPQuR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 12:50:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934036AbeCPPey (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:34:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.14 003/109] x86: Treat R_X86_64_PLT32 as R_X86_64_PC32
Date: Fri, 16 Mar 2018 16:22:32 +0100
Message-Id: <20180316152330.027580286@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: H.J. Lu <hjl.tools@gmail.com>

commit b21ebf2fb4cde1618915a97cc773e287ff49173e upstream.

On i386, there are 2 types of PLTs, PIC and non-PIC.  PIE and shared
objects must use PIC PLT.  To use PIC PLT, you need to load
_GLOBAL_OFFSET_TABLE_ into EBX first.  There is no need for that on
x86-64 since x86-64 uses PC-relative PLT.

On x86-64, for 32-bit PC-relative branches, we can generate PLT32
relocation, instead of PC32 relocation, which can also be used as
a marker for 32-bit PC-relative branches.  Linker can always reduce
PLT32 relocation to PC32 if function is defined locally.   Local
functions should use PC32 relocation.  As far as Linux kernel is
concerned, R_X86_64_PLT32 can be treated the same as R_X86_64_PC32
since Linux kernel doesn't use PLT.

R_X86_64_PLT32 for 32-bit PC-relative branches has been enabled in
binutils master branch which will become binutils 2.31.

[ hjl is working on having better documentation on this all, but a few
  more notes from him:

   "PLT32 relocation is used as marker for PC-relative branches. Because
    of EBX, it looks odd to generate PLT32 relocation on i386 when EBX
    doesn't have GOT.

    As for symbol resolution, PLT32 and PC32 relocations are almost
    interchangeable. But when linker sees PLT32 relocation against a
    protected symbol, it can resolved locally at link-time since it is
    used on a branch instruction. Linker can't do that for PC32
    relocation"

  but for the kernel use, the two are basically the same, and this
  commit gets things building and working with the current binutils
  master   - Linus ]

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/machine_kexec_64.c |    1 +
 arch/x86/kernel/module.c           |    1 +
 arch/x86/tools/relocs.c            |    3 +++
 3 files changed, 5 insertions(+)

--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -542,6 +542,7 @@ int arch_kexec_apply_relocations_add(con
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			value -= (u64)address;
 			*(u32 *)location = value;
 			break;
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -191,6 +191,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -770,9 +770,12 @@ static int do_reloc64(struct section *se
 		break;
 
 	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
+		 *
+		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
 		 */
 		if (is_percpu_sym(sym, symname))
 			add_reloc(&relocs32neg, offset);
