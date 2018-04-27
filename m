Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-888376-1524868991-2-17714446748421538406
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
    1524868991; b=Wj5kWu6JLB1riwV5RrJvyhGyAdARxKddXIZENmY5UWOdh8vtvI
    wrCbM9Zg9WUc6/KMlFauWnVl38r+Vc2wGQTATNy4JcBLV7YvdZ+ig5j7jOeHfWH2
    8vMgvZ+erwA+g7IRBGG9vckd7ZbHw2pqKgfcJA+6iFf6adSf64QdGHfcV2iu1n2V
    PKKjKadCNwuEvWLCtN/+zGzYRkgjdy9KQdMFWAvt07NY9GW131WYtXTF+3TiyVpV
    u64uJwWGW8tKnOrMuWMmk+P4HxKc5OIUmMtl8H6h7kMXZDVx/AfqwbPFjauAvX9F
    aqFKcBgD2bh6vXSrgmGVZG9Zs/N6Xjb0keoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524868991; bh=
    I71cd2rTkHIvt50l8Dkrq6l4kmHYV5U/8tUKwoFZx3s=; b=dIhExm/ZTajWVdEK
    MTIFL+1jtHN+8vY7TFNosHfbBARzZdPQx4O96k/UEVaBOsYD0EJhFMv9yM2Ei5MF
    rvsh4Inn8R/QWv+gncdD/CDW6c1A3AaAajKvfaRRvcnvOwl15T7NGHbJ0YMvLveE
    xsfVWDDAXdus/0qzpbNYJQY5QELKew0ixzHphGo3dMzLDYsTds/ukLb5fDskplsn
    m17YZI30bnVhkrwVc+KAlzMRwl212R74/QovaIXdS08Bw2l2qmjAWlA1Kei1Rf/Z
    09COR22/rQGLe93Cd+i215edyIOCH7iQRfvFDJJfGxd8MdplAOQ2SF7+nlHuODIM
    LRG+EQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=fsq4FZml x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=fsq4FZml x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMKp8NJw0jKjdbmThxl8CUZRY6UAnhbbjed6oO5tmgdWPwKxMuhVmabYJBfYp7PMiC7hJ/D1OmiSmivN3+ufS9TzDp1kjPG2AIQuJBUeQvzJtJzC5kiS
    OtCXeZIZIdYfhD/i12ZcKHQzaqugB6oGYAVvaOlTapBUOGnsLmJYrPGtrKlWCJtDDDaGtCK+OPBcsEYXqEvKIChYDyRHNTHSYUP77Nm/3OPNb0cCgfw3Bk/Z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=UGG5zPGqAAAA:8
    a=VwQbUJbxAAAA:8 a=mDV3o1hIAAAA:8 a=K2-WA-AvA9sMn6rl8wcA:9
    a=17ibUXfGiVyGqR_YBevW:22 a=AjGcO6oz07-iQ99wixmX:22 a=_FVE-zBwftR9WsbkzFJk:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeD0WnE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 18:43:04 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51939 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753569AbeD0WnE (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 18:43:04 -0400
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        PaX Team <pageexec@freemail.hu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org
Subject: [PATCH v2] arm64: export tishift functions to modules
Date: Sat, 28 Apr 2018 00:42:52 +0200
Message-Id: <20180427224252.6970-1-Jason@zx2c4.com>
In-Reply-To: <20180426083147.GB27583@arm.com>
References: <20180426083147.GB27583@arm.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Otherwise modules that use these arithmetic operations will fail to
link. We accomplish this with the usual EXPORT_SYMBOL, which on most
architectures goes in the .S file but the ARM64 maintainers prefer that
insead it goes into arm64ksyms.

While we're at it, we also fix this up to use SPDX, and I personally
choose to relicense this as GPL2||BSD so that these symbols don't need
to be export_symbol_gpl, so all modules can use the routines, since
these are important general purpose compiler-generated function calls.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: PaX Team <pageexec@freemail.hu>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/arm64ksyms.c |  8 ++++++++
 arch/arm64/lib/tishift.S       | 15 ++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 66be504edb6c..d894a20b70b2 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -75,3 +75,11 @@ NOKPROBE_SYMBOL(_mcount);
 	/* arm-smccc */
 EXPORT_SYMBOL(__arm_smccc_smc);
 EXPORT_SYMBOL(__arm_smccc_hvc);
+
+	/* tishift.S */
+extern long long __ashlti3(long long a, int b);
+EXPORT_SYMBOL(__ashlti3);
+extern long long __ashrti3(long long a, int b);
+EXPORT_SYMBOL(__ashrti3);
+extern long long __lshrti3(long long a, int b);
+EXPORT_SYMBOL(__lshrti3);
diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
index d3db9b2cd479..0fdff97794de 100644
--- a/arch/arm64/lib/tishift.S
+++ b/arch/arm64/lib/tishift.S
@@ -1,17 +1,6 @@
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
-- 
2.17.0
