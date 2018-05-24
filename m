Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155710-2-14653902135296229171
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
    1527155708; b=h6f2y54Q+mBWs4IA0lwImC9XiO8NIRiu2G58Jiz/8Sn8JEfemj
    ohz0FwFkfRElPOkh10+5/aJ+kHCZboxexdfUAe5+3iSPE9O20KGLFEyE/TIFRsk1
    KRmwqwmbeUTB6nuJiDKdjnG77Pk7KukuMTHMPoIsXWtDKU0245T3T9Kewm1hUwFd
    uIe22mXkuYED+arquH3x8xoWkhZXUrxQFzRoBJ+O1S+6N+LzYl/KxvMQ7t0w11YP
    aWPzJlXrvpQ7ZMXyBfAP0a5+pBQhXLMdu/5TzNw4f+wF/pB90zSLWCf5YSb9dXta
    udhoAlzDurpQ4Jop0yexGTM7TGQChN10NIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155708; bh=gqSbt0WU/1EdKoD4zCDWujRWzxu1sn
    NRlxm1cgvVCwQ=; b=RFLmKuVgtCPqeuxhLC7PoPQRGghZCLOaQ/xgnJazLA+XdR
    ffSwqmW41AtMSJWWoojiCDtLhH7skTgrx4gZr4SOvpZYsFFaFGHA/rDaapdMOVgb
    b98o4eRr6o0jjJx0IB2w7vj1qvDpziSxEa5lV2cE631T6ccBtNrP0+H+IaQRnOJ8
    1gVzVtEONJEdDrZrqP5zbBUQBvLa1MWStEwBG82d7BQdNVmCEo6QtKyEbmfpBeG/
    bv3AmOihyU7dxKcZbKwQhZDOhX3emEriRn4FivYNvOZaFFlDhl1nnM6rvzuhzQbm
    hscfUg84Y+xCl1GghDWYw6MCYmIxv8MrC2/D+ImQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=bVN8tyxu x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=bVN8tyxu x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIgGGBKqrQaIVxyIedv+Vh2GaPsZD8k7Io7c+QQeaQVVoq3hDk+ghikGVN+JOlbrmj6uKsc7sibgNDeRFdlIhLUKwwd4kEZpqt2NU03j1SC9TINYX+nI
    UUJfxoncbC4o4iXjflbUNS2AwfigKUSztcGr6lVkOSTo4+f/Pms4t7WRAGoXFrErWe6FRz+8Fw/du3I8cPEK/NTrRZ/yE577lnBmc9Uxl6TAJy8K3UuadEDu
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=6mtFN2R5rmpNZnjPMXoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968265AbeEXJzG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968334AbeEXJy7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:54:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.14 039/165] s390/crc32-vx: use expoline for indirect branches
Date: Thu, 24 May 2018 11:37:25 +0200
Message-Id: <20180524093623.559269891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -13,6 +13,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -67,6 +68,8 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
+
 .text
 /*
  * The CRC-32 function(s) use these calling conventions:
@@ -203,6 +206,6 @@ ENTRY(crc32_be_vgfm_16)
 
 .Ldone:
 	VLGVF	%r2,%v2,3
-	br	%r14
+	BR_EX	%r14
 
 .previous
--- a/arch/s390/crypto/crc32le-vx.S
+++ b/arch/s390/crypto/crc32le-vx.S
@@ -14,6 +14,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -76,6 +77,7 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
 
 .text
 
@@ -264,6 +266,6 @@ crc32_le_vgfm_generic:
 
 .Ldone:
 	VLGVF	%r2,%v2,2
-	br	%r14
+	BR_EX	%r14
 
 .previous
