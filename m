Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DCC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2040521836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PLUaDNRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbeLPOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:39:02 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37518 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:39:02 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBGEb8wk002539;
        Sun, 16 Dec 2018 23:37:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBGEb8wk002539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544971029;
        bh=6vhfSs+7RzquFhTIBamYt76Vi9+17EnVWOTBSFB6Vys=;
        h=From:To:Cc:Subject:Date:From;
        b=PLUaDNRIZopNiyxdS6YJyvzEtqtlaXbyclquXFnf6WgJrcegs5MSlGl+qKDmM9jBj
         94o7g7St1v0Fbgx1SQTVHnUPPiFF64032pAK0ds7bf3Ex5xSVz7fepltsagtiT08GI
         BuqmF49ULwfhyQLC08+ODUq0Bx9bARYwSgq+0alFgynAT1LbL3g1EHu+XmZaQHR4PZ
         aH4O3XC3d3pFOvYSeecurQCSXi1R0abzQhpFttoD3y0mwlWyVk/K1IPU8yB7mxNGTT
         xNtJQCh8cImIPDHAa11p2k3e0pYaFVd7sczupDpMRgbBHOYl+5rIAWssRyprvYwXGk
         FWafPcgGKsFKQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] um: remove redundant generic-y
Date:   Sun, 16 Dec 2018 23:37:06 +0900
Message-Id: <1544971026-7694-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes redundant generic-y defines in
arch/um/include/asm/Kbuild.

It is redundant to define generic-y when arch-specific implementation
exists in arch/$(ARCH)/include/asm/*.h

Remove the following generic-y:

    hardirq.h
    io.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/include/asm/Kbuild | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b10dde6..00bcbe2 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -10,9 +10,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += ftrace.h
 generic-y += futex.h
-generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += io.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
-- 
2.7.4

