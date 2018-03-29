Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-768647-1522326274-2-8677978614611245267
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522326273; b=dbzuOxY7UUeowFvBw7BcdPBX9YLkiT+1q+MNwW9OZZyp+x86e8
    258RAxssYenGVz32pWSJvr+ytxBZ/xNk4m3awLMgn82X6NAJRh8WUcTEfTxwqx+W
    wjyixhmZaFu/JW+vJRKRJU7gm0ljm2E9b+7L+UxIzHjnFBMIIwkc4neePyGdsRcU
    z1tWbxugljeTeBF+kOOenfULbtYCTi+9mKIrP10bmqljHJIbMWg/Ww4LGb/iDs0u
    GBmo5eU1r+fvGsZjrhiR0hyQvETDDcLtNtS3gd/RIAwF02EX8ygCWA6cZukndybY
    34MVMsVP6m0me5Lm5XQlKa4wIbDBly426o+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522326273; bh=3mcftkEeFO/3DNUPqGwS6ahdSwGFhN
    iqdhLs3jH3THg=; b=dF7ZczUmucMBlNQMKZABnd5SKNEF9RCw4O4eJu4wWiSb8X
    iCVyCcPWhSkJ5SZBBMDEbPepzjcCxvZVdQ6bXFTKkbDZNXjwXluotXYw3qqumTUV
    l1isFiVs0BoN8O/mZR80HDGW3v08Y/0GWEnTsfBF1SpzI+ni17bRMFN/aTdlYQTR
    c6ldwDFBi8pwiIaYYchLtng8Vg3Uj9UP1qJVBTUmYpuEMWORoJECbpCXQO8VrPHC
    zHFIt4zPfhp5eNrKcUkC/lj9VLjYMdaP2JX89qf5zeRrq0j4yJvC0DILuJ/Ml1+J
    XFQBWYaNA9AEV43sN4K6Z1ZuXc0BMUyTPGc/Xzmg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfBUXcGp7spkshNgCVZIsHggVOy3MtRdHgyKhbufesa/TBcz96myozanfnup5DmM10g/74prutbcL1s5J45p9UqsVsvpvbQhbpzHaDZTrLRmx4140CTJb
    2bMXH7uu7td36KATYJ3xlmOSmTl8mb9bdKeIRyoMgVflvpYeyecMSZI+9haPtVFYF2MPBYlUIA3KajwYwIOB5gexoQYDt+tEZ9ohhbjFBq8BUUuCcUrM++5O
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=_O2MNi-qLip3vB9L1CsA:9
    a=BvLA_4xjQAIxby50:21 a=FIHrhAtSOSvqbvUZ:21 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeC2MYB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 08:24:01 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:59516 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeC2MX7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 08:23:59 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: memset.S: EVA & fault support for small_memset
Date: Thu, 29 Mar 2018 10:28:23 +0100
Message-ID: <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522326229-298554-12353-54470-2
X-BESS-VER: 2018.3-r1803262126
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191512
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

The MIPS kernel memset / bzero implementation includes a small_memset
branch which is used when the region to be set is smaller than a long (4
bytes on 32bit, 8 bytes on 64bit). The current small_memset
implementation uses a simple store byte loop to write the destination.
There are 2 issues with this implementation:

1. When EVA mode is active, user and kernel address spaces may overlap.
Currently the use of the sb instruction means kernel mode addressing is
always used and an intended write to userspace may actually overwrite
some critical kernel data.

2. If the write triggers a page fault, for example by calling
__clear_user(NULL, 2), instead of gracefully handling the fault, an OOPS
is triggered.

Fix these issues by replacing the sb instruction with the EX() macro,
which will emit EVA compatible instuctions as required. Additionally
implement a fault fixup for small_memset which sets a2 to the number of
bytes that could not be cleared (as defined by __clear_user).

Reported-by: Chuanhua Lei <chuanhua.lei@intel.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 arch/mips/lib/memset.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index a1456664d6c2..90bcdf1224ee 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -219,7 +219,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -260,6 +260,11 @@
 	jr		ra
 	andi		v1, a2, STORMASK
 
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
+
 	.endm
 
 /*
-- 
2.7.4
