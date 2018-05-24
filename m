Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162564-2-10479082180239985962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162563; b=jxooQGjqi04yKJDSzes3jG8kWmM/cmC8n4Mi3eHGlXWDkpmBMg
    tSftnTRLBadVG7oRuUMrSQouMTFfOPjV9szHIXHPCztvylz9OpG5ZDffH3Vodq/9
    bRl+tIert2Qp873qPMVltwjq2nv277SGbh661WFITquCXJ0eW/7rfg+oQqjW8l6X
    M6cwFGH9790oQ0PnbQ1V62zQyaHfqi/XCRV6ve6cGvma1/Vx+bbpqZCFR/s3uizm
    6UO1OAEtWP9sUeinxBk3tBMpdg++p+GXiQ7K/jVyXcV1qwNpqzwl4dlW6LiKdK5b
    BeLKwGNI9HLEuFoFfndQilZV6mA1GZOW9fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162563; bh=EQVJFzDxNd8MkCT3+rnyeqRVkJFR36
    sSA5dN6Xxcm8s=; b=GK++4Da6KQ8MyCDupRpTua94Guqe/QIkG6IelD8zmAZais
    T3yon+5LZfYBkvP8JbaBL/UISMRRQpzPAlKeXgJXYrqnKvMD+hWAQBC6ska9kn9A
    ioHCFK4ahs52brjLO1BlwA8jFlcCfNB4tAs9fiFfmus7O7WTzjGNYT+t6veiyxFp
    p2tH5nuM2pBRCVwCg8pRJ/NDPGlbAOME6N1OXvY1141rwYeq4q9wgZr1AJXS/oxU
    Kz26H9sIn56wOPuJQDCbR2fBRZWwaX9FciAMGc/DrkvE3Z1Tx00q/LdP4hu1Ne7C
    w5Q5oTWUrKWgG3P6jewbggXd4A5XQTPTF1AfK9IA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yNp51Wjn x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=yNp51Wjn x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ57nti4bGiSK4J3r8db8ZP7MLGrgp+W21Ezgi8p4rEG7P0/FSllpA91zg+/hpCKhySWLEDYrLJMY/yP4TKKxxiC9PDfdX6sbf17wrkbajqwD7hlQEXG
    2sO+zAWUyP06U4C5e8Rh6GFSKE3SZcEdpxnTrsMA38Zz9kb3uydvlYG5/LhutBvf+sg4re7CnGSW9Ute6NurgBIHbBn1otScGaVK++DgAJvLU9HVC6sJi8C7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=6mtFN2R5rmpNZnjPMXoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966805AbeEXLtU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966033AbeEXJrM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.9 11/96] s390/crc32-vx: use expoline for indirect branches
Date: Thu, 24 May 2018 11:37:54 +0200
Message-Id: <20180524093606.229986742@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 467a3bf219cee12259182c5cb4821f88fd518a51 ]

The return from the crc32_le_vgfm_16/crc32c_le_vgfm_16 and the
crc32_be_vgfm_16 functions are done with "br %r14". These are indirect
branches as well and need to use execute trampolines for CONFIG_EXPOLINE=y.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/crypto/crc32be-vx.S |    5 ++++-
 arch/s390/crypto/crc32le-vx.S |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/arch/s390/crypto/crc32be-vx.S
+++ b/arch/s390/crypto/crc32be-vx.S
@@ -12,6 +12,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -66,6 +67,8 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
+
 .text
 /*
  * The CRC-32 function(s) use these calling conventions:
@@ -202,6 +205,6 @@ ENTRY(crc32_be_vgfm_16)
 
 .Ldone:
 	VLGVF	%r2,%v2,3
-	br	%r14
+	BR_EX	%r14
 
 .previous
--- a/arch/s390/crypto/crc32le-vx.S
+++ b/arch/s390/crypto/crc32le-vx.S
@@ -13,6 +13,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -75,6 +76,7 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
 
 .text
 
@@ -263,6 +265,6 @@ crc32_le_vgfm_generic:
 
 .Ldone:
 	VLGVF	%r2,%v2,2
-	br	%r14
+	BR_EX	%r14
 
 .previous
