Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48289214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DT0fGchN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48289214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeKLNxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:53:32 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:46685 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeKLNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:53:32 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wAC41xir030487;
        Mon, 12 Nov 2018 13:01:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wAC41xir030487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541995320;
        bh=xF+7SkazDq4cdU6JomuI/6Nri05HwPm8HbqEPm3cCaw=;
        h=From:To:Cc:Subject:Date:From;
        b=DT0fGchNdfExhRr3o0bE5qNDHNfP5ZrIxfaPXnCw+4E/Lb263ApKkW5dJ0EYcthGl
         MLEyQvpenmplzOQ5P1a+EGBu7pkO394DWugyLGonrQspKtRnFOd3uoL0f4Va6XQnw1
         PgEosk9aAZ/nCI+sNN0ma1gYZodGY6093mVDj529Eq9UnaIbAzJy4Mml9Ez4zd+3GH
         ILRsYl3UPO5b7C+JEnLpFjBfAj8qRDrK3NUSF4i7YSOl6FGmzT80DzIDz8N9E+TXkG
         +/YazXF/lLISTFmCRXQMMy9FkruKZk7T0A/DCUEDOClsl4C356ostYl29FeIk9dP+S
         XBEKJoNGWEiOw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove 'prepare' and 'scripts' dummies for external module build
Date:   Mon, 12 Nov 2018 13:01:25 +0900
Message-Id: <1541995285-11144-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make is lenient enough to ignore missing rules as long as they are marked
as PHONY. Remove dummy targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 766a64e..7508243 100644
--- a/Makefile
+++ b/Makefile
@@ -1610,10 +1610,7 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
-# Dummies...
 PHONY += prepare scripts
-prepare: ;
-scripts: ;
 endif # KBUILD_EXTMOD
 
 clean: $(clean-dirs)
-- 
2.7.4

