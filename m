Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B28C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3680120869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TBXjIneK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3680120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeIDFIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:08:04 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:31383 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeIDFIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:08:04 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w840idCx006387;
        Tue, 4 Sep 2018 09:44:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w840idCx006387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536021880;
        bh=aDfplpw6vjsR/6FWFUZnvdWwNAConh/vmkPi5yIhz0c=;
        h=From:To:Cc:Subject:Date:From;
        b=TBXjIneK7jXaIxPuTplNgtpXXe/hie6ZL+Q4FPBBPdbQ+kHZ9TYQcEbHROTaY67Ze
         HbA6ndWCwyIICJwMzLHBNiylNfdNMcP5yr2f3wwJFs342ZSfDDPZZhhS3ZlH4wkmFz
         likVMs52ALIGjVEN4DrrbYdXXMrtlZy9tJxO9GA3G721VtoFWtHTAV2wURGF3oOiIU
         UDoL9NXS44sOrKCg5JM7t6o1AFPxX8wi/+uUelOsevAXuyDc2XljbV9tEbuJE/W5Fy
         rHl6MxFkwBMlEv0+J6YA7xINI2hjyR2O4oAv7S5LvSFJyaAIQsUN8OsjU7d4d9tkRG
         SPcFr2MRR/j1g==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Aaron Wu <Aaron.Wu@analog.com>,
        Bryan Wu <cooloney@gmail.com>,
        Robin Getz <robin.getz@analog.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: remove left-over Blackfin code
Date:   Tue,  4 Sep 2018 09:42:24 +0900
Message-Id: <1536021744-2552-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols were added by commit 028f042613c3 ("kallsyms: support
kernel symbols in Blackfin on-chip memory") for Blackfin.

The Blackfin support was removed by commit 4ba66a976072 ("arch: remove
blackfin port").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index a9186a9..50af068 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -48,8 +48,6 @@ static unsigned long long relative_base;
 static struct addr_range text_ranges[] = {
 	{ "_stext",     "_etext"     },
 	{ "_sinittext", "_einittext" },
-	{ "_stext_l1",  "_etext_l1"  },	/* Blackfin on-chip L1 inst SRAM */
-	{ "_stext_l2",  "_etext_l2"  },	/* Blackfin on-chip L2 SRAM */
 };
 #define text_range_text     (&text_ranges[0])
 #define text_range_inittext (&text_ranges[1])
-- 
2.7.4

