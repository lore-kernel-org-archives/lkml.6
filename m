Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C672070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfBVSvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:51:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39330 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2213980D;
        Fri, 22 Feb 2019 10:51:03 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF83E3F5C1;
        Fri, 22 Feb 2019 10:50:59 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC PATCH 08/20] m68k: io: Remove useless definition of mmiowb()
Date:   Fri, 22 Feb 2019 18:50:14 +0000
Message-Id: <20190222185026.10973-9-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m68k includes asm-generic/io.h, which provides a dummy definition of
mmiowb() if one isn't already provided by the architecture.

Remove the useless definition.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/m68k/include/asm/io_mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 782b78f8a048..6c03ca5bc436 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -377,8 +377,6 @@ static inline void isa_delay(void)
 #define writesw(port, buf, nr)    raw_outsw((port), (u16 *)(buf), (nr))
 #define writesl(port, buf, nr)    raw_outsl((port), (u32 *)(buf), (nr))
 
-#define mmiowb()
-
 #ifndef CONFIG_SUN3
 #define IO_SPACE_LIMIT 0xffff
 #else
-- 
2.11.0

