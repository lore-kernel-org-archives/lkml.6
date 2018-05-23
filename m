Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-217144-1527083720-2-3203677594175259593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527083719; b=DplKBXk8JFwcOGMhOlYBs+tJCps48rPdQewrKr+0Cpv5u46ybh
    Hh/Ph9ZkGQW3u0J8inSEpzqdb9msxodZ2qNQTfS0SsN/qYdYNa/yRsvQy87dCxZ3
    wTW9WWuSPZnHBlm5R8hxosFnj0heePkqPLQZ7N/0ouTqVyqqXQmBJbiYBnFtjKQ0
    nOp6+Pe4MZrrL2yIWhy6a1F5v4e01R2xcn/gY15kBhQZka4M2j+oBDaOr/xLtC4a
    7J7DN7yLLCGvPcs++5pZ/XQBoG9Nz84Jf3bxeBoB+j04ykK/45rLFem/Jp2C9lbP
    yXDOhARS8EsMmZFszYt//IBaK5EskUh0IIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1527083719;
    bh=Fi6n7W/BSLClVcB6eVefbnIOSv/NltInLPAybino8F4=; b=AgusY1kOgXHp
    Qh3vR3jD1N+iIgcgZLHXC8VJePClU9/g4+YS075kckOwz+6TY4oregxavlvLdC7+
    TAXXsKjSkKVPccc+2Q1glcVQ3adVdojTeu1ZJL3nq6Z9eT+7OnzUmteuS37sWWkk
    RdRxXsK+JWpDvfz6znezt07df+H0Qh4vTG2TBFfj5r4+tnHxSq0XYZjWhQWO/yd7
    89Dj7fZjcLL9Qqnw7FeZWEgpoKKJUGvsfLoYij2zNRo7ubgLkSNLnZxSowchgLXQ
    kIkIoApO9M4k+V+Br8jw7U5P2XEEXEVczoLyAc9fC0uhk/bsjk+dzu8r0YpoKOka
    oq+qL6ICyg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJC9sSEBm4VYOi8TdMYF6O8yuAlBR+1NYRzVvd6l9t7oUE4RwnqK/WtB0UVZFFeT8WYHfiZqS+9b0ob85rYszTeZwT6L1xtU02Fh2XBE+2LUhdnh9EL8
    Eed9AtCKJpqB9izgPAdxYYBEb/efF17/9rGeqiOLgOi7s8RsHD2Dli1S2VKUAISqcpcMBS+MoZVk7mnUixrHyL9YYaxlqOZ2iNSDzvqzNQ3NyIb1S8xs7sRz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=FCEKRHbEWsgpfqaVivQA:9
    a=HciEscQFegiqzD54:21 a=GVWEoI3YdMHulhsR:21 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeEWNzR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 09:55:17 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:38793 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932900AbeEWNzR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 09:55:17 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] MIPS: memset.S: Fix byte_fixup for MIPSr6
Date: Wed, 23 May 2018 14:39:58 +0100
Message-ID: <1527082799-14704-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag03.mipstec.com (10.20.40.48) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527083714-637139-9382-233939-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193286
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __clear_user function is defined to return the number of bytes that
could not be cleared. From the underlying memset / bzero implementation
this means setting register a2 to that number on return. Currently if a
page fault is triggered within the MIPSr6 version of setting of initial
unaligned bytes, the value loaded into a2 on return is meaningless.

During the MIPSr6 version of the initial unaligned bytes block, register
a2 contains the number of bytes to be set beyond the initial unaligned
bytes. The t0 register is initally set to the number of unaligned bytes
- STORSIZE, effectively a negative version of the number of unaligned
bytes. This is then incremented before each byte is saved.

The label .Lbyte_fixup\@ is jumped to on page fault. Currently the value
in a2 is incorrectly replaced by 0 - t0 + 1, effectively the number of
unaligned bytes remaining. This leads to the failures being reported by
the following test code:

static int __init test_clear_user(void)
{
	int j, k;

	pr_info("\n\n\nTesting clear_user\n");
	for (j = 0; j < 512; j++) {
		if ((k = clear_user(NULL+3, j)) != j) {
			pr_err("clear_user (NULL %d) returned %d\n", j, k);
		}
	}
	return 0;
}
late_initcall(test_clear_user);

Which reports:
[    3.965439] Testing clear_user
[    3.973169] clear_user (NULL 8) returned 6
[    3.976782] clear_user (NULL 9) returned 6
[    3.980390] clear_user (NULL 10) returned 6
[    3.984052] clear_user (NULL 11) returned 6
[    3.987524] clear_user (NULL 12) returned 6

Fix this by subtracting t0 from a2 (rather than $0), effectivey giving:
unset_bytes = (#bytes - (#unaligned bytes)) - (-#unaligned bytes remaining + 1) + 1
     a2     =             a2                -              t0                   + 1

This fixes the value returned from __clear user when the number of bytes
to set is > LONGSIZE and the address is invalid and unaligned.

Unfortunately, this breaks the fixup handling for unaligned bytes after
the final long, where register a2 still contains the number of bytes
remaining to be set and the t0 register is to 0 - the number of
unaligned bytes remaining.

Because t0 is now is now subtracted from a2 rather than 0, the number of
bytes unset is reported incorrectly:

static int __init test_clear_user(void)
{
	char *test;
	int j, k;

	pr_info("\n\n\nTesting clear_user\n");
	test = vmalloc(PAGE_SIZE);

	for (j = 256; j < 512; j++) {
		if ((k = clear_user(test + PAGE_SIZE - 254, j)) != j - 254) {
			pr_err("clear_user (%px %d) returned %d\n",
				test + PAGE_SIZE - 254, j, k);
		}
	}
	return 0;
}
late_initcall(test_clear_user);

[    3.976775] clear_user (c00000000000df02 256) returned 4
[    3.981957] clear_user (c00000000000df02 257) returned 6
[    3.986425] clear_user (c00000000000df02 258) returned 8
[    3.990850] clear_user (c00000000000df02 259) returned 10
[    3.995332] clear_user (c00000000000df02 260) returned 12
[    3.999815] clear_user (c00000000000df02 261) returned 14

Fix this by ensuring that a2 is set to 0 during the set of final
unaligned bytes.

Fixes: 8c56208aff77 ("MIPS: lib: memset: Add MIPS R6 support")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v3:
New patch to fix fault handling during MIPSr6 version of setting
unaligned bytes.

Changes in v2: None

 arch/mips/lib/memset.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 1cc306520a5..fac26ce64b2 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -195,6 +195,7 @@
 #endif
 #else
 	 PTR_SUBU	t0, $0, a2
+	move		a2, zero		/* No remaining longs */
 	PTR_ADDIU	t0, 1
 	STORE_BYTE(0)
 	STORE_BYTE(1)
@@ -231,7 +232,7 @@
 
 #ifdef CONFIG_CPU_MIPSR6
 .Lbyte_fixup\@:
-	PTR_SUBU	a2, $0, t0
+	PTR_SUBU	a2, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
 #endif /* CONFIG_CPU_MIPSR6 */
-- 
2.7.4
