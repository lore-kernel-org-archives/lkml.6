Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1954995-1523973606-2-1977858740704727606
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
    1523973605; b=KMCajbqlkfs2kDIqHmZgcyoy3aldE82kf/ZaPwBDEXti9aa/hH
    EYQpkn2XLAi6/QcnSTo+ocXdYslxS1StQA/TH+OcUd9ts6RbCujhnRND7EPCsWO3
    AaQwWFko0iQuYGUFRNHxMjwjUynxyU7D6qK9+HnMxn0EvB7MGBxXhyqoaqHP7hBe
    wKCDyXvk2ZWqyxd08GTQk3AEJ9m/OzbYDZqFt9Vf8g5UB/OL4vYYn4hUIV6crkRT
    Ykj01PINNoGLYba9ZdDIB/PBhJVlPH1xkmKKEP0s/ZLcgbxM9TOU3CWMKw+3HOgT
    nKigTJ5v706SvDVWRQZb6QpPY21QqS75Ad/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523973605; bh=+xyQmeuMVe0zO4vv9aogpLVvm817+a
    XYRTA+WDf2ddk=; b=ma+FPhl/yJOwdG0kWoGNEsNaTpNQVbMdhhS8OKmMz5HnJJ
    KxbIyHmdGn/mAufTdd9CGAePdOolxb1A9ZZcvZoBnUZSwuRG3lY/2uuMZQYhpmpe
    01NEw389P8HI51b2YS2ZPrA6/6ax2nrsJ1TMOdXnd7npCbU0X73m3DVeOUTGWFVs
    ctyMUrezYmX5uH7G+gwv6GDpLeU+9xssby5UzC93pvRA5rLqhPwAbZGXTJ6bWjwq
    6N2hygY0fcoy7V4S3jlXyPAAJ0tK9gEmIVIp28ImDnNjCCAPw1WeSHGLLAhQcTjO
    NkoSQ3m2wGeNNy63qLiOui8bcQKXAfFF2NcVAeEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfDikOSl2e4I25iPDkPM72yyRVmSsVBRmR3gZyxVQjSpwdVMLDkuGK9l8l6NwUKdvoMOA7rDjvgxp41QZ2YHy+qTATBoZikuGvd6/S4x+7fkkd/yjh8OV
    mJbGkjal4QZD+GvrvsrdU5kwIW2mVCqfYCVKSraiR0u5v/mUvqcuQU1IdiP7jyCRdnhgGSS9+aTq7N79lRlVdZ25LMcpeBzTvMOvMcyHjUdcOAu8usBWiHqA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=b333JcFp3n9_ZgrTNBEA:9
    a=WBTetW907MO-OYWo:21 a=YV9GH1qvtiaQjjMw:21 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDQN7u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 09:59:50 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:54738 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbeDQN7t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 09:59:49 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Tue, 17 Apr 2018 14:59:50 +0100
Message-ID: <1523973590-23356-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180416221340.GB23881@saruman>
References: <20180416221340.GB23881@saruman>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523973580-321457-20211-1075-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192082
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

Since this code is non-trivial to read, add comments to describe the
fault handling.

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

Changes in v2:
- Use James Hogan's suggestion of replacing t1 with a0 to get the
  correct remainder count.
- Add comments to .Lpartial_fixup to aid those who next try to deciper
  this code.

 arch/mips/lib/memset.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 90bcdf1224ee..fa3bec269331 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -250,11 +250,11 @@
 
 .Lpartial_fixup\@:
 	PTR_L		t0, TI_TASK($28)
-	andi		a2, STORMASK
-	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	andi		a2, STORMASK	/* #Bytes beyond partial block */
+	LONG_L		t0, THREAD_BUADDR(t0)	/* Get faulting address */
+	LONG_ADDU	a2, a0		/* Add end address of partial block */
 	jr		ra
-	LONG_SUBU	a2, t0
+	 LONG_SUBU	a2, t0		/* a2 = partial_end + #bytes - fault */
 
 .Llast_fixup\@:
 	jr		ra
-- 
2.7.4
