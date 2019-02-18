Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7AA218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JdzuboHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfBRGJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:09:21 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:56512 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfBRGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:09:21 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1I68mT5029459;
        Mon, 18 Feb 2019 15:08:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1I68mT5029459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550470128;
        bh=RRs7iTOqt6oCNZE8ATx0fL2NncDfzADyNLizR6ngoOM=;
        h=From:To:Cc:Subject:Date:From;
        b=JdzuboHyr8fARcNsPeIMRTGmnpltNU0H6EYxzI4WS/WlvGWo4K26x3ChgbYTS2P7r
         PxHPHwZ5hohxQhsnddB8geaw8T8Bygw1/6ewW2JkSUjKZyi+ivuVBLvJD5IaDiw8uE
         5bEBGW8hH0njuTcy1np6iJboPOt7uRc6KTqqcBpo2w60WHsKOs/b0dXTT9PPKv+Ugt
         X9BQh+Snkg0oSInQgxZxz8jhQ/bs8sxqUswBjkghH2IzbEEpG9EFQ04+8mx+EEWvs1
         UJBBWvKns6ZgrP+g/s2/LdKnTfOm+QWTSpr5FbPYuHvqusyQg/rBcYr0nWJCIk62gs
         ENnGhW/A+cOiA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] regulator: core: remove unused rdev_get_supply()
Date:   Mon, 18 Feb 2019 15:08:38 +0900
Message-Id: <1550470118-26648-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a remnant of commit 70a7fb80e85a ("regulator: core: Fix nested
locking of supplies").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/regulator/core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b9d7b45..bc25a17 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -145,14 +145,6 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
 	return false;
 }
 
-static inline struct regulator_dev *rdev_get_supply(struct regulator_dev *rdev)
-{
-	if (rdev && rdev->supply)
-		return rdev->supply->rdev;
-
-	return NULL;
-}
-
 /**
  * regulator_lock_nested - lock a single regulator
  * @rdev:		regulator source
-- 
2.7.4

