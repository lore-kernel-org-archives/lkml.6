Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2055735-1523976747-2-10178365680493780255
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523976746; b=WEYLrlvAukASyN5O/rd8LVHs0JE3gfpWrRqTZP9tgNhMHwV/ZT
    DPxp3LRs/JfAuql/+2PWsMvkknqdxb985guf11Ga9Dcqr3APLfAS1j1Pwy3cUWll
    9xRFMNgoSrp0H1vhUsQ5gD7n601O7oOW3ObuyVOnnf+Jxrow7w1KbJCnGm/9EE9i
    rvNRoPw1r9DaejD3810ocseYpRG46/X7ARa8vmYNOHK263gVIHJt/VLJoMIXqrOI
    1JRySyR1lmdPz9hbOkCldzXeeeUt9N71H8Sh+s5FboVVUyFRvAS0a4wDnic/Yusb
    5+Va2GOWYRAqF7QKYbWt5J5A725apIm28QEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523976746; bh=ZSnUofhwLHUdEc3oQlm1cqCzs3elCQ
    UBUQaQKRaAuHg=; b=mXPKwqukyrEzEkb4ouu7ZZVs8yYO3JnepKFQoAnvxgAUtt
    Ls+lh66FYjGVIrXgtKYzizLsju+1br/QWQsunxFSGrTpzhqvLpmt7BE5L6iwC/f9
    BX9JjiTZSWw1OTq2ZDmcCpFBjc9Qa97nEig9Mwc96/a+7u6GLLLKZZZnIZ3gqixN
    fLOSC9g+TVk9I7A8hhUyZ8Qe6yyuhjGiQDclG56UMSBnxvFljcKqzl7i6NsIX2ff
    KLDSdVWiWir+AnY4mXr8lXqICWvxtW5vDCU02Qci25l1WtTGSaILTNIZV2cKNOU4
    TsPwKV/j+gpZfm6KXXCrbK+1noJWy0cFZK+zCWLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUrqdamWzpoLWL5nGGAx9Xo6QpGL2qic0JgBkBy/VHQz4DgArs0Rpr1fF61QSIK+9cLTWu3/KoiNVHnNB9oXN8CguBpbLG0Nk80Pwmh30y3G3z1COin
    G0yCQqBVdfQW7HHrHnCZk/jdxuhdOJEiFMNHeC+Pz6XJnQxyOJokX3icdp6HLnoAHGhXoHzEfD4gjU75J+qRcVCt10NBt4FkuwEIu7xu1oWo52shaS/8AlMR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=HnpANbPcaXmn5rhNS74A:9
    a=Qd-Pl3kmOx3YZdV1:21 a=OAU2JCG9TKMzeOnh:21 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeDQOwZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 10:52:25 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:60610 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeDQOwZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 10:52:25 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Tue, 17 Apr 2018 15:52:21 +0100
Message-ID: <1523976741-29916-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523973590-23356-1-git-send-email-matt.redfearn@mips.com>
References: <1523973590-23356-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523976730-637138-28956-86998-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192083
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __clear_user function is defined to return the number of bytes that
could not be cleared. From the underlying memset / bzero implementation
this means setting register a2 to that number on return. Currently if a
page fault is triggered within the memset_partial block, the value
loaded into a2 on return is meaningless.

The label .Lpartial_fixup\@ is jumped to on page fault. In order to work
out how many bytes failed to copy, the exception handler should find how
many bytes left in the partial block (andi a2, STORMASK), add that to
the partial block end address (a2), and subtract the faulting address to
get the remainder. Currently it incorrectly subtracts the partial block
start address (t1), which has additionally has been clobbered to
generate a jump target in memset_partial. Fix this by adding the block
end address instead.

This issue was found with the following test code:
      int j, k;
      for (j = 0; j < 512; j++) {
        if ((k = clear_user(NULL, j)) != j) {
           pr_err("clear_user (NULL %d) returned %d\n", j, k);
        }
      }
Which now passes on Creator Ci40 (MIPS32) and Cavium Octeon II (MIPS64).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v3:
- Just fix the issue at hand

Changes in v2:
- Use James Hogan's suggestion of replacing t1 with a0 to get the
  correct remainder count.

 arch/mips/lib/memset.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 90bcdf1224ee..184819c1d5c8 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -252,7 +252,7 @@
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	LONG_ADDU	a2, a0
 	jr		ra
 	LONG_SUBU	a2, t0
 
-- 
2.7.4
