Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C7CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEF2206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EFky02Cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEF2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390551AbeKVJsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:48:40 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:51971 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387918AbeKVJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:48:39 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wALNBvXO019266;
        Thu, 22 Nov 2018 08:11:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wALNBvXO019266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542841919;
        bh=pL6iditA2OWMhJElimNUDbGuTxlF6AP+5xjs5DzNhhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFky02CclNUzLI1iJcNk2PQXjT/m7uNOwPXidba+7FAOpHTQWcTBiypJo01R5Keas
         cGNDwJsLHHOU4Fod1A+4LhaXrGTPTjKg4oDaHvUA/CewNmu+r+dTZ3ETe+r4lNbzw4
         ZAGGyeHoF0L9c0VTw9WDUmHTT1ePKS8t/o/2qAMUYyOGqmZ5ynZ8BYMDA6Rcwwokt1
         l6Oe2Y9I62pIup36BKEIYYg2nZRmxt320mrVMPDSsMgN9boB/lw+ckL94n80fk53R9
         8iZW53FiWBk6J6Jb2BaCDm/I/lwRUzjxad7SYqfEk9JU4uCZzBdsAS9RagaZYeS0lI
         H04R7hP2C/Kfg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: remove 'scripts' dummy target for external module build
Date:   Thu, 22 Nov 2018 08:11:55 +0900
Message-Id: <1542841915-19686-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542841915-19686-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542841915-19686-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make simply skips a missing rule as long as it is marked as PHONY.
Remove the dummy target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index 36f3f0e..269a9bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1604,11 +1604,9 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
-# Dummies...
 PHONY += prepare scripts
 prepare:
 	$(cmd_crmodverdir)
-scripts: ;
 endif # KBUILD_EXTMOD
 
 clean: $(clean-dirs)
-- 
2.7.4

