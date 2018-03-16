Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214008-2-332429548190654725
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
    t=1521214007; b=VqenS/TcRPDxSEgy3hsUxcG/1ib8Rc4sV2xt9CvVphIQzeF
    DjLyG2uGAkM51bzJFMbCwwYedgbI4NlZ+zVE3oWQx//Q8KFse8/+wyT8On5+e8rr
    /3BJHvCEqW8Pi7XJVylSPAaqy7+fP/SHJ+dzcJ4q3uoXClKevv29ZB/E0G3NqUpf
    gB2S/mfKQqPKX+9ySmkydItcYUDDv+g+v/Wy7CMCT8hVKuqzS7OtqeKv/yoBoCIn
    cNjF117mjborv6PmxttN+EsRiWE0HEHzkIvcIsBuNnCwXflS/5OXJDUA8rU6vXUv
    jnIUF2kJRUUXKAXJYcUk2/xe2D9A12nEMkLMeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214007; bh=bFG6tGdpZxoPNyKCLCBJB723Xu
    R1YMTv/kRDreDiSNE=; b=GXpn5aXIZRPbDmLrAE1L6ExgWN5RoMX+lE4PCscvne
    RpIhUjTvmyYQ2gPbKR/ykKrK6NjW2mchLv40e9ZEjPuAyAKQXbM0ZLKYQylAgpdk
    vjAl31KsFizrKSPZ8YaXxkNlzChwVaK09NY2ATBIhiX18/ZmiPR4mVLDdIA9HyfK
    ZiJF/rMGbTmiL0FCGU0FL0IVnOyqN4PEOiPYPJrpjgDI2JKSturbzCOUa7msVGXY
    66BzoABcpZYWkXJiN2q4ASHKRRhzpBchDXcFzFFnjo9Gm0sUmM0rHdJlac7HDZZU
    mQPpen+EZ2V6IB+yELbJq2NY8+kGSSaLpbZJ9UgZg0Lw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S1754058AbeCPP0m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbeCPP0j (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3.18 16/25] x86: Treat R_X86_64_PLT32 as R_X86_64_PC32
Date: Fri, 16 Mar 2018 16:23:03 +0100
Message-Id: <20180316152233.419132991@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -516,6 +516,7 @@ int arch_kexec_apply_relocations_add(con
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			value -= (u64)address;
 			*(u32 *)location = value;
 			break;
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -186,6 +186,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -769,9 +769,12 @@ static int do_reloc64(struct section *se
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
