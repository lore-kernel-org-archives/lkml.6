Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0782075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0782075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937905AbeFSMzR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:55:17 -0400
Received: from foss.arm.com ([217.140.101.70]:49350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937858AbeFSMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09418165C;
        Tue, 19 Jun 2018 05:52:41 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF18D3F59C;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CC47F1AE36A0; Tue, 19 Jun 2018 13:53:15 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v2 5/9] sh: Don't pull in all of linux/bitops.h in asm/cmpxchg-xchg.h
Date:   Tue, 19 Jun 2018 13:53:10 +0100
Message-Id: <1529412794-17720-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sh implementation of asm/cmpxchg-xchg.h pulls in linux/bitops.h
so that it can refer to BITS_PER_BYTE. It also transitively relies on
this pulling in linux/compiler.h for READ_ONCE().

Replace the #include with linux/bits.h and linux/compiler.h

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/cmpxchg-xchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
index 1e881f5db659..593a9704782b 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/arch/sh/include/asm/cmpxchg-xchg.h
@@ -8,7 +8,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2.  See the
  * file "COPYING" in the main directory of this archive for more details.
  */
-#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/compiler.h>
 #include <asm/byteorder.h>
 
 /*
-- 
2.1.4

