Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D166AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA5224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6njVS2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCA5224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeKMBtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:49:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44814 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:49:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so4536331plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ojMfWus/PP+5St/TIl0w4YsqTgJivAZTw1D88bD9oFw=;
        b=T6njVS2xqZmkGnJk6CINn05TKnLXMHmcozF0jH2jJIQ8bwmj42BnYgeOWayKAOuc2P
         uFbFlmzGtEhLgi1TiP+3i0k36+b2ckqeMH7BMXQfGf6kOKSnBu7symVMjgTmH2AgvdHa
         fxvxiKSugmdBA9Hu1luo4018xSqqSkhqM3CxaHMw2Ez2HaiuMgFD1uPAH0RiwS2t0IRT
         V8k9SdYjGIP1aedatf6igxvE12qB19NK6H/uHHPSXuNk0z8jUPaQVa5aAxhQgXOgsc5j
         ETVrkN9t/MFeTTNtZStF1aQrA5YGI0edE9jbD47RPSjxa47MDMS0PuVKkn2Kq5m/WzR+
         oi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ojMfWus/PP+5St/TIl0w4YsqTgJivAZTw1D88bD9oFw=;
        b=EqpbCJZnySEtMYXlaqyZZP5Ndq1S0HEijCqOkO/wkPxIfjLQ8/ZIIITVLrYK272ojy
         S8Rjnmgq6sbeQ2Na4IcFiPlUOL33SjmI4usZ+vE07SPddbAUDLq3fyBEZUqZAEyU8Y5B
         Xe3RVgjuEmj9ZGBPSXuWZi1T1+jxhq0Pc2j6aCNArhL0NXVXC7EGuBpO//ApPSwXieN+
         45cb/GI3Ra8i7kSum4rHNojSeclGFb1Fbp+EhnKSnr5oy9SgoT7Kmg9ALrPooD+5q/gv
         cCYyO+djZ82ma9mIswD2cR6wAnV0o36HsqbAebeAwufslCDhXita9kAgzBA5JyeNfeQp
         xXCg==
X-Gm-Message-State: AGRZ1gLQC5bVWsTVniQ3th4K2C+9KT2ckVcfvKUFkzQVscsH7SQsUUpt
        qFj6VIx82X6swTtWsnOoros6qPMnwsQ=
X-Google-Smtp-Source: AJdET5cIm9Kz1dl0+uQqwXgDAHkBv+/206T7WrrOY8ljpYZBlFxtB1olSFE1gjHZ66CU/7b1mOFQXQ==
X-Received: by 2002:a17:902:b104:: with SMTP id q4-v6mr1456193plr.5.1542038163148;
        Mon, 12 Nov 2018 07:56:03 -0800 (PST)
Received: from localhost.localdomain ([207.246.110.149])
        by smtp.gmail.com with ESMTPSA id d80sm9599737pfm.146.2018.11.12.07.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:56:02 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] openrisc: make function cache_loop() inline
Date:   Mon, 12 Nov 2018 23:55:44 +0800
Message-Id: <20181112155544.7230-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The third operand of mtspr instruction must be a constraint. To guarantee
this condition, function cache_loop() which uses macro mtspr() must be
inlined. So let's force it as 'inline'. This is to fix compiling error with
new option CONFIG_NO_AUTO_INLINE.

In file included from arch/openrisc/mm/cache.c:17:0:
arch/openrisc/mm/cache.c: In function 'cache_loop':
arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
                              ^
arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
      mtspr(reg, line);
      ^~~~~
arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index b747bf1fc1b6..4a4b2b6e006b 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -20,7 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static void cache_loop(struct page *page, const unsigned int reg)
+static inline void cache_loop(struct page *page, const unsigned int reg)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
-- 
2.17.1

