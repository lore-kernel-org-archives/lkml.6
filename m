Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D729C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F682174E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qLUWnEGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F682174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbeHMTdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:33:39 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:41918 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbeHMTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:33:39 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w7DGmsvJ003842;
        Tue, 14 Aug 2018 01:48:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w7DGmsvJ003842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534178935;
        bh=5qhVpQ4BEq4n3wxqoBDGSfwfVZ8Sjm6luRF2+2zgXT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLUWnEGLcqQ2AzULwADgfOg4e8gEaclVV4tWO5UyTcimxNzmUalC0Z0CToDaPfERP
         Mdy3br/iouCcnj98YNERHhBXstMhgk6N2rkBjlSqKvh7YpLKszA56+KLKfhpF95G6J
         SgtgI5S10P0TZYw5RztREHoEUkvwoM0BP4TILo5ojatk2MJBHDfU+OLrzzfxAoFw9q
         OoWsna/CN+3XRp5rfNRDAzxoZZUBorgkaLYXZwOiZtbwZgMxPvepk5eZxdVjKUGWkY
         1fGLrsa8yT/+7E79PRs5RyQk4ORVzt/7VMSdyVT2CkLgufiEAaDiTPf/vI8V7h47iC
         cD3XGv42GGnAA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: remove P_ENV property type
Date:   Tue, 14 Aug 2018 01:48:39 +0900
Message-Id: <1534178919-8375-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534178919-8375-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534178919-8375-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is not set by anyone since commit 104daea149c4 ("kconfig:
reference environment variables directly and remove 'option env='").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/expr.h   | 1 -
 scripts/kconfig/qconf.cc | 1 -
 scripts/kconfig/symbol.c | 2 --
 3 files changed, 4 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 84a5199..7c329e1 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -185,7 +185,6 @@ enum prop_type {
 	P_SELECT,   /* select BAR */
 	P_IMPLY,    /* imply BAR */
 	P_RANGE,    /* range 7..100 (for a symbol) */
-	P_ENV,      /* value from environment variable */
 	P_SYMBOL,   /* where a symbol is defined */
 };
 
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 62261b3..ef4310f 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1149,7 +1149,6 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 		case P_DEFAULT:
 		case P_SELECT:
 		case P_RANGE:
-		case P_ENV:
 			debug += prop_get_type_name(prop->type);
 			debug += ": ";
 			expr_print(prop->expr, expr_print_help, &debug, E_NONE);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 073d780..4ec8b1f 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1289,8 +1289,6 @@ const char *prop_get_type_name(enum prop_type type)
 	switch (type) {
 	case P_PROMPT:
 		return "prompt";
-	case P_ENV:
-		return "env";
 	case P_COMMENT:
 		return "comment";
 	case P_MENU:
-- 
2.7.4

