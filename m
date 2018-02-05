Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855023-2-11741680212721964117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855023; b=w8gm0GHFNkxPNgiXin1Wu67YKljOL9WELXoxgrXrgmkDRu4
    qKWDnzBUZq+o93ufIMSr9D54dkiz/mBNxX1G/OhiBQ4LU3Bpph0V8eSvVyDkoZPk
    6SWtMzgUmashK6H8wpn870SrIll0k4aSRKyFv2ZMu/AmLir6XtyF2uWKnC67jM9X
    8M+3wz4YJpiFh+qTVfGG2+qke4lI6OulShPqwRb9oCx01MyNFtoGuW5juNCdO1UP
    mCa60aDX/Ra3fSER8uIHMZQH62J6NlBM3muN3zfok9ZewMXcuCjavOpdSjQWKJgk
    GQhI2zzaqwToaNbFv2wGRgxMKkxZ/w3Q9lVeLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855023; bh=tUOidZBzB+h3cf2k/ciWTfo30Z
    EDQ16WeAm3X802jrg=; b=KsTLgI3miAQw3WH27QWIS6syM7/Gc3w7W2cpkGM2eL
    JKRz3pyYahI8KFLgJK70F5Xl4lPksB8J+jfgoNKDjXWgW0aweXRAlIfLPpvjrXYh
    zfXOFFCwn7ZPOEFBmlVSuQeo07b2ZC96gq71PFRQbvZenqXPVHCo1HNTJceLjxwC
    DWwRYHliNYDtbMQzy6sMGvXaGey0Lus7tO71dXEUeeaOUUBSt4eGHAptO/0NNwj8
    1ZHdfQUsCeFKueXRfPWdXFJA85gIcoLW3hCjkfsGEDrYZae3UJpgLwruyTucGehH
    MyrzzUa29oGKhKjFqIl+niU9UYnwaQG+M9hR1XSPuGew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeBESXj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:23:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbeBESXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:23:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, riel@redhat.com,
        ak@linux.intel.com, peterz@infradead.org,
        David Woodhouse <dwmw2@infradead.org>, jikos@kernel.org,
        luto@amacapital.net, dave.hansen@intel.com,
        torvalds@linux-foundation.org, keescook@google.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        tim.c.chen@linux.intel.com, pjt@google.com,
        gregkh@linux-foundation.org
Subject: [PATCH 4.14 16/64] x86/nospec: Fix header guards names
Date: Mon,  5 Feb 2018 10:22:35 -0800
Message-Id: <20180205182139.233497002@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@suse.de

commit 7a32fc51ca938e67974cbb9db31e1a43f98345a9

... to adhere to the _ASM_X86_ naming scheme.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-3-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/nospec-branch.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __NOSPEC_BRANCH_H__
-#define __NOSPEC_BRANCH_H__
+#ifndef _ASM_X86_NOSPEC_BRANCH_H_
+#define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
@@ -232,4 +232,4 @@ static inline void indirect_branch_predi
 }
 
 #endif /* __ASSEMBLY__ */
-#endif /* __NOSPEC_BRANCH_H__ */
+#endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
