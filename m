Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747CB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GLBhqZ+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBYTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:11:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42550 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbfBYTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:11:19 -0500
Received: from zn.tnic (p200300EC2BC68000EC11815BDBFEF01F.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:8000:ec11:815b:dbfe:f01f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C6601EC0253;
        Mon, 25 Feb 2019 20:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551121878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=p226ROE7AW3gVIZ7N6apTJomZqhvFH+jHFvGXU2tTW4=;
        b=GLBhqZ+FVdFj2oLuBW2HW2E0yNr+A/ezoLSoZym3NRJWH9znB/NFfUwHzN8WDGbpVZGbZY
        gVbcN8lbl/fyzp37OuWUDYvRRhsm4NfbThv/Tl3zvfM/2CwanJLXYWuohfWWU07PUnAgXe
        vZFgkrofU2E0ZWLAJd6WEB+JL23WFI8=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: [PATCH] x86/uaccess: Remove unused __addr_ok() macro
Date:   Mon, 25 Feb 2019 20:11:09 +0100
Message-Id: <20190225191109.7671-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This was caught while staring at the whole {set,get}_fs() machinery.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: the arch/x86 maintainers <x86@kernel.org>
Cc: "Tobin C. Harding" <tobin@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 780f2b42c8ef..e2ffedd51fd8 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -35,10 +35,7 @@ static inline void set_fs(mm_segment_t fs)
 }
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
-
 #define user_addr_max() (current->thread.addr_limit.seg)
-#define __addr_ok(addr) 	\
-	((unsigned long __force)(addr) < user_addr_max())
 
 /*
  * Test whether a block of memory is a valid user space address.
-- 
2.21.0

