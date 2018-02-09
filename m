Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185588-2-18147134835206911300
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
    t=1518185587; b=hQ1l/wG/CGDhAy1M6X9kk/b13yZTVhJzQID6Z2uE91Z0cS8
    nEkgSbFqS/HKGtK+s3QydZZCd+FBvrqIxxeqoG+DnUoMyModJ9goWZfgXRWlfEUj
    Ttp+05qvcUuLDOt2hJ5vNmfMYslll01HKHWC1JG0U0A9rKXI2X6nW3c9f/kliDRp
    n30ayQ/X+BpLlWFv0JE2BMBhNyEd6WLVgO0qNbU8Ie2SL7F/2vgPyCSl+42bwYh0
    GUkP5IAnJeg/VvYL8goBcITub8gxJ+YSEP4Gxtg2k5pZ8upLcADIHWLJc7mujhiy
    wnJY7ldtiXkZHSz1n2BWUhTtfEG/HBw9d44B3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185587; bh=UYATGTTR27JjU6D6V1WhRTZtD8
    B4JyWoC67m8pYbRoU=; b=fgWg1N1oxTY6BVOBOlolPMBOBglQ8gfPo50uVknBU7
    PiPXaVtyTIYXuODGXbBRQWARqphgVNINeR7uyYL2JtyyFbSl70evfLQb3rVmYQyB
    E/uNkQJkeVgcmoVJxsyvoIHP2l2BUdpg1pl6BwQPdrr8YpLUxtdvDwexBgVttdFz
    LS7G4LghPdHrrr6bjVbqKRGI2IEc1kgKBZigsFDu2MyXuEidvXQzFeqnh+at4CUK
    U3YlhOHNH703jIjlSC4qMVTHWow3MUPLV22bAO6k1T5ylSqnaxX5qSE9hhMpDSlq
    s9/BuyDtod4M3GaLb9rPs4RT41XUT9ggm89Qbm7yu31g==
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
        id S1752726AbeBINlv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:41:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeBINlt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Law <law@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kees Cook <keescook@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        Greg Kroah-Hartman <gregkh@linux-foundation.org>
Subject: [PATCH 4.9 35/92] x86/retpoline: Remove the esp/rsp thunk
Date: Fri,  9 Feb 2018 14:39:04 +0100
Message-Id: <20180209133933.717506516@linuxfoundation.org>
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

From: Waiman Long <longman@redhat.com>

(cherry picked from commit 1df37383a8aeabb9b418698f0bcdffea01f4b1b2)

It doesn't make sense to have an indirect call thunk with esp/rsp as
retpoline code won't work correctly with the stack pointer register.
Removing it will help compiler writers to catch error in case such
a thunk call is emitted incorrectly.

Fixes: 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
Suggested-by: Jeff Law <law@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1516658974-27852-1-git-send-email-longman@redhat.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/asm-prototypes.h |    1 -
 arch/x86/lib/retpoline.S              |    1 -
 2 files changed, 2 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -37,5 +37,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-INDIRECT_THUNK(sp)
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -36,7 +36,6 @@ GENERATE_THUNK(_ASM_DX)
 GENERATE_THUNK(_ASM_SI)
 GENERATE_THUNK(_ASM_DI)
 GENERATE_THUNK(_ASM_BP)
-GENERATE_THUNK(_ASM_SP)
 #ifdef CONFIG_64BIT
 GENERATE_THUNK(r8)
 GENERATE_THUNK(r9)
