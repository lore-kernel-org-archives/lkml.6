Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-735701-1523808674-2-7546489334467664029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523808673; b=Xo8NYb0cMTq8FvZlnpvRSxwfIBEVPAGE+rc1qJcEXBUMPXuLSG
    RXJIXA5H39l3Bm04uF/3JYJ5AcHovqHRb/un8ebLsr3aDvB71GsonhyrgRzjEdWM
    QmqslnL8KFRH2Ig0ate6eKLcZeTxkpJUtWGtTXYL80UlEw4nDHlFWDkBayAxxC3k
    /DZcK9Cj2hsEaj7Igq/lf7rtQ1RdFmpHikQ7Wp9fX7cGD0Ah/jEF8vExa5ZVMBwE
    FVhEg1Eom2iOay06OpdX1l7gI5t8mkUced2mIxEh1j0EBUlEafe/SMpFumstDK6P
    /rYXXbtUHgqFb9GXlOwMDK3rjtlY1YnL0lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523808673; bh=0z2v1ZgehmgxlLKBRUHHjRt/h1Ql8B
    i9FT31l5NRnqQ=; b=kK3ijfrA9Phr7kS7Rn6adifcl+MFP97KMelf3rFOOU9wu7
    WkcOQhLxGmGeCfSi+IQ6TZTs6+fRmkD2PP452gNU+RvrtopvqSRTKpxjyufubZC7
    YxJgyjt+9YRyPjq57e04HsDK/zsyBO/gb3QG8XSHKBX5FvHaa+If98GUFlw7s7h4
    xwtCM/3lpdf255FZJHS6t4wYISRxSnCQNFR/t1EazMCg1m7/ab4yqle/GP/sfrP4
    3bhvSCcuXOVIXvyof6T7t6zTGBUU6vRLjAPez6/jwAc37FjE6gxc/mNWjgOjGSY+
    rEshgZLDTvvEKjft5Y0kZpuupvxN9rIIFnxYjsQw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=zQQEdwvV x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=zQQEdwvV x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHcOxUjBf5FSVqifubp9/s6baRlZqp4vry0SgMDs4idRWKj3rx6rBKJ4cyMxzQ6WvQ1LtaWm9MUk5i1LCA9I6YQpNh+HyRkcSBQwABBj9IYHO4BT4l1
    fyK9IDUudh1x3yGHq6Imv46wPDuDESFPnK9KmzHLeZGptguhWBwqiJOlS11HfokUdCDT3d7QtPGqUrldkJWvmhcbowAtePQZaztdlztGSI6eV4afWWKl4xid
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=UGG5zPGqAAAA:8
    a=VwQbUJbxAAAA:8 a=mDV3o1hIAAAA:8 a=js1UHFgtukuQFD87j0YA:9
    a=17ibUXfGiVyGqR_YBevW:22 a=AjGcO6oz07-iQ99wixmX:22 a=_FVE-zBwftR9WsbkzFJk:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeDOQLI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 12:11:08 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52523 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752371AbeDOQLH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 12:11:07 -0400
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        PaX Team <pageexec@freemail.hu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org
Subject: [PATCH] arm64: export tishift functions to modules
Date: Sun, 15 Apr 2018 18:04:16 +0200
Message-Id: <20180415160416.28161-1-Jason@zx2c4.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Otherwise modules that use these arithmetic operations will fail to
link. We accomplish this with EXPORT_SYMBOL in the .S file, but because
of symbol versioning, we actually need to have a declaration of these
too in C. So, we introduce asm-prototypes.h, which is the same file name
and technique used for similar reasons in the m68k arch tree.

While we're at it, we also fix this up to use SPDX, and I personally
choose to relicense this as GPL2||BSD so that these symbols don't need
to be export_symbol_gpl, so all modules can use the routines, since
these are important general purpose compiler-generated function calls.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: PaX Team <pageexec@freemail.hu>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/asm-prototypes.h | 11 +++++++++++
 arch/arm64/lib/tishift.S                | 19 ++++++-------------
 2 files changed, 17 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/include/asm/asm-prototypes.h

diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..8f1919e44f51
--- /dev/null
+++ b/arch/arm64/include/asm/asm-prototypes.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+ *
+ * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+/* These functions are defined in lib/tishift.S, but need to be declared
+ * here so that symbol versioning picks them up.
+ */
+extern long long __ashlti3(long long a, int b);
+extern long long __ashrti3(long long a, int b);
+extern long long __lshrti3(long long a, int b);
diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
index d3db9b2cd479..3bca433973cb 100644
--- a/arch/arm64/lib/tishift.S
+++ b/arch/arm64/lib/tishift.S
@@ -1,20 +1,10 @@
-/*
- * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
 #include <linux/linkage.h>
+#include <asm-generic/export.h>
 
 ENTRY(__ashlti3)
 	cbz	x2, 1f
@@ -36,6 +26,7 @@ ENTRY(__ashlti3)
 	mov	x0, x2
 	ret
 ENDPROC(__ashlti3)
+EXPORT_SYMBOL(__ashlti3)
 
 ENTRY(__ashrti3)
 	cbz	x2, 1f
@@ -57,6 +48,7 @@ ENTRY(__ashrti3)
 	mov	x1, x2
 	ret
 ENDPROC(__ashrti3)
+EXPORT_SYMBOL(__ashrti3)
 
 ENTRY(__lshrti3)
 	cbz	x2, 1f
@@ -78,3 +70,4 @@ ENTRY(__lshrti3)
 	mov	x1, x2
 	ret
 ENDPROC(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
-- 
2.17.0
