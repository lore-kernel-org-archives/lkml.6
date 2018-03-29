Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1046311-1522335689-2-16037940503291163566
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
    1522335689; b=XKRBWkNCbamqAml8HbqklhN/7kfxAU5DHKXD4+hY/8wJHpSzRM
    FGfxujMr8gouCK+1raZhCFuDTdMk7rGVvj4dpZTWsauL5wMjAyuO4B9Ky8rSLDjC
    6Po4qvxpaYu8CHH9wIrYCZSX/6DU48IMmiMKKt1ZUKg+C4J0OoAodbCFoQxVwGnM
    G6x7xy3tUvEE1LRsyUUvNqdtgSkBeNghXPCr+pnPGH/IRGkdYOaTd76yNfckWv5m
    JyGrEmFV1pyeg9PxscmE6eMvAapSTzwAkrbFG1ZAamuWTQ5A5obpHDraLohnmDhr
    1Q61+No2NnkdaWGXnNUJ3bVNcCIRiVdgBhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522335689; bh=9vyH1qwSnVq1mt5ecLpKLF26ICQlT9
    LhWmipkyuVBYo=; b=qysGnH2Uuhk7B6mb0w6BJVmxf/fvOEMkJimd00uFnSX+Fj
    iQYb+YiCkfhFRU2WGoYFAFBl623IMHLP80oPAs5a2/o43jcG9+b0+fprCbkKTL4H
    1wbeZnHCT8yTJdPdqLBHSFPGFXSOdGwc2d1oO6MbcJXxEfdLnBm7k3U5cCogSoBp
    2dpxXUpVBUU4sA1CLaM5UtKAnsYgY0zWeK6hx740GIUqaIhOeX+E/Zk52DIGjwSD
    kaPigIt3tTikCIRvLHearmSLCZ57P2f2sHKvI4FGKgZD70oKJmz0AKapmfFs1o+V
    WS0Kc+ZmguE1DlQru+wTYdsHIFK4ssdH3d+P6dNQ==
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
X-CM-Envelope: MS4wfMsqWs+vTPK/1rmoHviB4n0kP6kr1B42qPd+FLozFa5SPuS5G3I7ZJAhrEz7y4bIq/qBjaC3cx30MnF5ZpjrTlJV+lqIjDamerForYkztmgGlgnvN5Ic
    mEPGzpPNG698TnzVzmqU4vljZ8uAJd7Y5p/WcA+cP5QuOzNDsDVyHI3/Kvz4Rv1KfwjCN5fb8Tjcb+oi5nA4C9BUMxUiCQ0kX3bWPB4eVqoxCTVchMmtKi0E
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=W-9zxaGCp6Ovam2rKdEA:9
    a=C0b4SmEpsbxy5-O7:21 a=eVaFukOnOZrfkMSP:21 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeC2PB1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 11:01:27 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:42677 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeC2PB1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 11:01:27 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Thu, 29 Mar 2018 10:28:24 +0100
Message-ID: <1522315704-31641-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522335682-853316-8127-463000-10
X-BESS-VER: 2018.3-r1803192001
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191514
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

The label .Lpartial_fixup\@ is jumped to on page fault. Currently it
masks the remaining count of bytes (a2) with STORMASK, meaning that the
least significant 2 (32bit) or 3 (64bit) bits of the remaining count are
always clear.
Secondly, .Lpartial_fixup\@ expects t1 to contain the end address of the
copy. This is set up by the initial block:
	PTR_ADDU	t1, a0			/* end address */
However, the .Lmemset_partial\@ block then reuses register t1 to
calculate a jump through a block of word copies. This leaves it no
longer containing the end address of the copy operation if a page fault
occurs, and the remaining bytes calculation is incorrect.

Fix these issues by removing the and of a2 with STORMASK, and replace t1
with register t2 in the .Lmemset_partial\@ block.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/lib/memset.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 90bcdf1224ee..3257dca58cad 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -161,19 +161,19 @@
 
 .Lmemset_partial\@:
 	R10KCBARRIER(0(ra))
-	PTR_LA		t1, 2f			/* where to start */
+	PTR_LA		t2, 2f			/* where to start */
 #ifdef CONFIG_CPU_MICROMIPS
 	LONG_SRL	t7, t0, 1
 #endif
 #if LONGSIZE == 4
-	PTR_SUBU	t1, FILLPTRG
+	PTR_SUBU	t2, FILLPTRG
 #else
 	.set		noat
 	LONG_SRL	AT, FILLPTRG, 1
-	PTR_SUBU	t1, AT
+	PTR_SUBU	t2, AT
 	.set		at
 #endif
-	jr		t1
+	jr		t2
 	PTR_ADDU	a0, t0			/* dest ptr */
 
 	.set		push
@@ -250,7 +250,6 @@
 
 .Lpartial_fixup\@:
 	PTR_L		t0, TI_TASK($28)
-	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
 	LONG_ADDU	a2, t1
 	jr		ra
-- 
2.7.4
