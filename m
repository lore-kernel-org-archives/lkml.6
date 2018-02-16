Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1110653-1518816637-2-6101481578215652118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518816636; b=Jqv190Y6ffbyBtIrpkpJ+KNDGMAHdXrKNM31UsLtzhlvwt6
    WR6aKb8lrIH8ug1jS8xe/DHHHnmcs2Fr5msk6EXxSXaiap6uTkfBbxlNBb9u4xMx
    yW5agO5taBO97mYikVMJElhkyTyqJygMP++g0Y1vhX1pupA8Way8RyROFa0aYMU0
    D897Z4gLbzy3khg+MVsdHgx4mffnBwZfkymhk5vytq9KkKfFfNNhWytRydMz+BNI
    wlmtYl+5wp76Bb68GBaYeQPf9WEtHpB91bKsB943CENteWxnihwFTyzAh5AYZyYs
    2MVqqQQ4Z+xuF1Bwf/J9URfoy3JhT/aJPNbIlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518816636; bh=J8CXt7JkDnZMVP9sreNebfKEGSAFXrhqwX61+ykviX0=; b=e
    LOzSpo3EDNsCsGBBQ7sjj/YB22VKlUDXGcS2sTOCNHvKgsgxqsAt4IDOZgQ7J3wh
    /pCFZOZcEm+Z+7deChg+uF27sPwbtrM6wv85I52o2u6Edv090w2tiCo9U7VarLa9
    3jFfSp3aePADSTtC0ecPC4AfGQxvBFrJDCVxzF+CUi8yWfN4mGsgZRHxvTuX/CHO
    sAtCtKaWR/nnPGTI4F1HRQGPMdBkAeSrlFa1U05c7U4/eD9RIIoRhiOGStDmiYgK
    sq4aQCDcvUDU4lF1Zr85eZ47xAJRYsHssBWelWQIT54g0B4CKESxv51SxXtdlmkg
    qM1rb+onoaD1qmEG+Ndew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeBPV35 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 16:29:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:42944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbeBPV3z (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 16:29:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="31463398"
Subject: [PATCH 2/3] nospec: Allow index argument to have const-qualified
 type
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org
Cc: linux-arch@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 13:20:48 -0800
Message-ID: <151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/nospec.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index d6701e34424f..172a19dc35ab 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -52,7 +52,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
