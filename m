Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCD6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90DE2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="u4Ourkff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLXOLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:11:17 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53888 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbeLXOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:11:17 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBOEBDce012605;
        Mon, 24 Dec 2018 23:11:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBOEBDce012605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545660674;
        bh=9G5HQLopEx21g2flGESRukeSiBFeedfI2DHKd3BZ8pE=;
        h=From:To:Cc:Subject:Date:From;
        b=u4OurkffjrGsfDQKruCQYuhG/lOWK8tN/4M04ejqS1NlQsr3MpwsYaqAgd0cTaaKq
         qfkNp4vomW/gL8hDu9RvLSjZEIrFVZigxN7hQFREbthjmW1Jp4EPxWwYRBerI7ZlVJ
         2s3uMKqwoHFXQ3wDUjl0z8R15ILjq+LlKeQTB3TlR/0pWKn+L+Yje71h3mLQ3ZDx8X
         CWiBQZEH7q1tXVucQ2pK8Cr1TGFxngulVwkTrNs+SDYKHF7iGec46eWdn3uRlkDSNV
         +4xJ4V48UyG6ZkzJBAq6KXoEgBW1AqAt0GfVCyNwuz+8+fKS5aWJzOzzsOmsco9+yw
         DOWcqr6KD2gow==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unused cmd_gentimeconst
Date:   Mon, 24 Dec 2018 23:11:09 +0900
Message-Id: <1545660669-15123-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filechk_gentimeconst is always used instead of cmd_gentimeconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Kbuild b/Kbuild
index 640557d..4455dfd 100644
--- a/Kbuild
+++ b/Kbuild
@@ -25,10 +25,6 @@ timeconst-file := include/generated/timeconst.h
 
 targets += $(timeconst-file)
 
-quiet_cmd_gentimeconst = GEN     $@
-define cmd_gentimeconst
-	(echo $(CONFIG_HZ) | bc -q $< ) > $@
-endef
 define filechk_gentimeconst
 	(echo $(CONFIG_HZ) | bc -q $< )
 endef
-- 
2.7.4

