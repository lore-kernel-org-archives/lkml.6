Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518709171-2-16496574805126047408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709171; b=C0ulYoOOFshLKU/Lvs1VLYwxpXwczPdWChq9x+S0uxf5arA
    MVA0Zhaw9gR62obwptwsHb8rrLeTxo7Jqbtx156jqM0bldkiWJ2JLErjE6UEwKyf
    kGrY/KPcolSufLYewTdaK2BUOGBPEqSM2t8TVBRGoLqBKPSUCPCVAPk/wBUrO6cd
    9bhvwEvDUylNggO/PfyqllKIvyo0Fr/pWuSK22RWK+HdheVoLUDEsVEouw5nXcSE
    NFS7lwppC5ekj6XhFRHfeJC2rcx6UOA7SXxUDZcZsc3SgXY9IxNtAFtOPbC01eBK
    FFey8aXqFix8uYbblBBxxvdixveHihhtB1ik0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709171; bh=YQyMFrUOtlsFMwijZi9ciCFMCa
    nxv5GNsqifGiwcRbo=; b=ZcJ7Qm07m/TlnYION6SKByogvfRmTkdC5sjaQgxLlh
    dVey2D/K5uYaPKV3PEl1sJxwh0xZhGEKX2nNNVVRNHYgeO4eUat54WOZ/K0rDNyy
    rOfb9E9X5tXUe67xLBZnVCN397QRpD6BJo8PTdDFhFaP58beDRd4x9nFxaW9PQDY
    58RdEBFmCg1wP1a/gL6tKeNN7cZejTDNewcnB2pxHPBCxIcU/Zf1Ljl4nWiGbpCa
    VmINlE4I2tUEOgl0S5FSXI3xszCdwXvNKg+YwN9XK1RHBEAwOcIYlK2GizN8OLhX
    Jktg7k//GGm2iL0h+NQZ+9OFWhwJHJd5dYW/aV131wZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423519AbeBOPj0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:39:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423502AbeBOPjV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:39:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 019/202] [Variant 3/Meltdown] arm64: mm: Rename post_ttbr0_update_workaround
Date: Thu, 15 Feb 2018 16:15:19 +0100
Message-Id: <20180215151713.882305520@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 158d495899ce upstream.

The post_ttbr0_update_workaround hook applies to any change to TTBRx_EL1.
Since we're using TTBR1 for the ASID, rename the hook to make it clearer
as to what it's doing.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |    5 ++---
 arch/arm64/kernel/entry.S          |    2 +-
 arch/arm64/mm/proc.S               |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -477,10 +477,9 @@ alternative_endif
 	.endm
 
 /*
-/*
- * Errata workaround post TTBR0_EL1 update.
+ * Errata workaround post TTBRx_EL1 update.
  */
-	.macro	post_ttbr0_update_workaround
+	.macro	post_ttbr_update_workaround
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 alternative_if ARM64_WORKAROUND_CAVIUM_27456
 	ic	iallu
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -257,7 +257,7 @@ alternative_else_nop_endif
 	 * Cavium erratum 27456 (broadcast TLBI instructions may cause I-cache
 	 * corruption).
 	 */
-	post_ttbr0_update_workaround
+	post_ttbr_update_workaround
 	.endif
 1:
 	.if	\el != 0
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -145,7 +145,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr0_update_workaround
+	post_ttbr_update_workaround
 	ret
 ENDPROC(cpu_do_switch_mm)
 
