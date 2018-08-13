Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96124C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DF521898
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L2/8yEJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DF521898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbeHMTdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:33:39 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:41880 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:33:36 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w7DGmsvI003842;
        Tue, 14 Aug 2018 01:48:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w7DGmsvI003842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534178934;
        bh=nJQvA4hGOm4RkV1/rR8INGOdfKkNMiIDZvwaGorBcK4=;
        h=From:To:Cc:Subject:Date:From;
        b=L2/8yEJpgz5g6gUTZzLk41ghEyEfYuM16JNa/YKn2xPIZOC/Z6A4WXt7nQsn7e1q2
         LwJxEm3vl2V74YhtsilB3wps5QBnisCXheRyZrZfHh4USLj8laqLQluAwMWtfBT+28
         H56ZGo2vOMvVeq90u/1fOZoA+cEifpPJgopi/zHMdZhKa2LgIoNR8oo/Kpq+fV7cCF
         itE5P0F2L90YlC3W7okXCa7nq0RDmiMD0mlLoUc5EbylArwBYZlzV97UeXCCOdxpS1
         fJpRGGN1OY1EQcCULd1UeeKs1EMXE+o8eS3ybCC7cTBE9Mj6nk3j1fYOTn57ol3wY6
         58xtrfdHNINAg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: remove unused sym_get_env_prop() function
Date:   Tue, 14 Aug 2018 01:48:38 +0900
Message-Id: <1534178919-8375-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is unused since commit 104daea149c4 ("kconfig: reference
environment variables directly and remove 'option env='").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/lkc.h    | 1 -
 scripts/kconfig/symbol.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 6b7bbc6..9eb7c83 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -125,7 +125,6 @@ const char *sym_get_string_default(struct symbol *sym);
 struct symbol *sym_check_deps(struct symbol *sym);
 struct property *prop_alloc(enum prop_type type, struct symbol *sym);
 struct symbol *prop_get_symbol(struct property *prop);
-struct property *sym_get_env_prop(struct symbol *sym);
 
 static inline tristate sym_get_tristate_value(struct symbol *sym)
 {
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 869a5e8..073d780 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -76,15 +76,6 @@ struct property *sym_get_choice_prop(struct symbol *sym)
 	return NULL;
 }
 
-struct property *sym_get_env_prop(struct symbol *sym)
-{
-	struct property *prop;
-
-	for_all_properties(sym, prop, P_ENV)
-		return prop;
-	return NULL;
-}
-
 static struct property *sym_get_default_prop(struct symbol *sym)
 {
 	struct property *prop;
-- 
2.7.4

