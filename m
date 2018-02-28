Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519833974-2-119088922670901253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833973; b=wKG4wH2tnHA/Dj1FI6zIW3TNcW3OJIWMh0OMezZHMSRoIh2
    6Unn7HHMKsjtTRcj5I1avCJ4qj5A+uKhzHcSO/vjqQd9lz+XAxFfc5DheZuVHkbh
    6ADt8Ii2o7kVaiy0YUm+FLBODyctqcYcH5jr28ggI4HfipMftN+gbWIjdAurgzuL
    LVtwqmZUU1u4O9QhunuBqNcFktgPkDpeioZaoWQvDlxPpvD+vqktUXwgunsETgio
    zNcjOEk2/UdfZjKor9zb5NA2ad8Nrd5RWkNYaCTd7ObwQpM2ir9H0V4HrldqyGjz
    lqR2SdoCSchAP4NWOn5M+1z3Vd2LJ/fqQJKxY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833973; bh=50dZtgeg3JYIq120hrs
    mYUYGTdYbz9+4AKpG72YZ2d0=; b=b8NeiuEgoju/2ZB4U9TIlgj5jHc/URMaEC0
    dxjG/nUQoG1SG76ZwoQknV0bWR0TBlV1QDPuYuEtZxRoGHheR6gYvJ5G4SaPnmO7
    NuU6nroYtExFfVCe95Qxm0tEVyY/3w0jh18NnzPg2VX1+/H2JSwJ2juDUX1m4dqi
    0APHFASEP+qA546MmUSv8A5tTaqgX//XNUzSZFLByNgFPydtCJz/8Pl2CmDugL3i
    DU4ryqTEFJfqJGZZNwcQb1x37wr5YkaB+M/MhOPO+MUk8FXQF2TxZ03LBNEPNo4m
    D5A22sKJTH7f47b7j05MLMoo8mDmEpWEUpVoK2iqJpd4SCBX3fg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeB1QF7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34908 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932438AbeB1QF4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, ak@linux.intel.com,
        "Kees Cook" <keescook@google.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Rik van Riel" <riel@redhat.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Paul Turner" <pjt@google.com>, gnomes@lxorguk.ukuu.org.uk
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.33661436@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 174/254] x86/alternatives: Add missing '\n' at end of
 ALTERNATIVE inline asm
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit b9e705ef7cfaf22db0daab91ad3cd33b0fa32eb9 upstream.

Where an ALTERNATIVE is used in the middle of an inline asm block, this
would otherwise lead to the following instruction being appended directly
to the trailing ".popsection", and a failed compile.

Fixes: 9cebed423c84 ("x86, alternative: Use .pushsection/.popsection")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: ak@linux.intel.com
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/20180104143710.8961-8-dwmw@amazon.co.uk
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -124,7 +124,7 @@ static inline int alternatives_text_rese
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
-	".popsection"
+	".popsection\n"
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
@@ -135,7 +135,7 @@ static inline int alternatives_text_rese
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
-	".popsection"
+	".popsection\n"
 
 /*
  * This must be included *after* the definition of ALTERNATIVE due to
