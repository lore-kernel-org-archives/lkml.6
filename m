Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619120-1525105371-2-4901310991899807940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525105370; b=Ykcm8iryY/mheeo4m7aUnwnM1CZBHK8VFJEUwIBpo0LhXdYDjB
    P/MJ9vXsIk5l6GA6TOVrKtWpeb6CDPJJ8ExhPEaUPTFg6GvD5kbvzmXWLe1fFZnf
    0DCespdldISkIt2kUbz4fLi7w652xCvuCh/vf/mSUlK7Qxgz3kOmjnWtb1DI4603
    aTr6i82G/L8g9lCQFxLAjJToxaTnt0vapXyUsLh5kzB0Dv5PTbDOuJlOpmbtSyNh
    8Rka1S0WkecEMP2s8ha07ym5GYYE54Ypla6R3S2VPBUtflBCaQUY4PT+0KfNA7Zb
    3JewB5EzN/KiL/bBtojVt00kmtHFdbT4EtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525105370; bh=
    wSfBe5aHhuUedNOcOFQxQfl6PqxUJqdQxQ1thPm3dzA=; b=YV/rr+AA3fpxHnbK
    yUV8hHl3Pr4Vtm3vi32hGBA89Zhxr0ZjOtTK02Vswvf40Df5kUG/azFjs8gK5h9w
    9tCuy0OE0JxhW8f0YvLGuAoapCgUFF7g4Yhoo0YgcVphdOpaukJU9BXWQZJ0AT8s
    wyGc6+Jx/63t2SIQNeFv89vUu6EAqpKiQLlNi0CzkprnB3cZ5zcj1Afl5X4NtMMa
    24S5gnPMSVl9iEZmCelBUKQX0B9+m57L5scqE4FOsXku5lU8BrWkoYlJnJVFM4xD
    5Jt4zqEyj40TiGn0F5Ip4ucUvEXkgVLx970Hu+xLItlFkFRA5AG9WRBRTedAC75b
    FtA7mQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=aIHpeAmN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=aIHpeAmN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbObNHI5kIS49uJNda+cS5IL+A+XO1gqaGRM8AbMRgtMcViVBkOf6X10iuNJNjqDnYXFJ8p/oEIrChihLfcy3Qurp71y4ZMQQsQlbbpy3GzXJcnkO1S
    9+wTbrXyCQhB31fYqK1k63UGWwEbgfbXWD+3nEkBVWXMdHoqPXQoCMwdMtZZCbpjRdX2jpblASzIoE8TAsc2CykZ/uRFLORS1nQDC1YtQicoa8UlFBSf2kBP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=BRfX-kF5JHxRc2FuUgcA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755045AbeD3QWf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 12:22:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbeD3QVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 12:21:41 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit constant
Date: Mon, 30 Apr 2018 12:23:36 -0400
Message-Id: <20180430162339.17143-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=434
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300156
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Latest binutils release (2.29.1) will no longer allow proper computation
of GDT entries on 32-bits, with warning:

arch/x86/xen/xen-pvh.S: Assembler messages:
arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)

Use explicit value of the entry instead of using GDT_ENTRY() macro.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org
---
 arch/x86/xen/xen-pvh.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index e1a5fbe..934f7d4 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -145,11 +145,11 @@ gdt_start:
 	.quad 0x0000000000000000            /* NULL descriptor */
 	.quad 0x0000000000000000            /* reserved */
 #ifdef CONFIG_X86_64
-	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
+	.quad 0x00af9a000000ffff            /* __BOOT_CS */
 #else
-	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
+	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
 #endif
-	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
+	.quad 0x00cf92000000ffff            /* __BOOT_DS */
 gdt_end:
 
 	.balign 4
-- 
2.9.3
