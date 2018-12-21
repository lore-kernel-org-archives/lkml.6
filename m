Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B44AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C85217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l36MwPc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeLUGXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:23:11 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:57506 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbeLUGXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:23:10 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBL6N657002210;
        Fri, 21 Dec 2018 15:23:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBL6N657002210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545373387;
        bh=vzOZQsXooXSdMNp86ZEeqNq4Pm6rIXeQHGV2En72PeM=;
        h=From:To:Cc:Subject:Date:From;
        b=l36MwPc/2fC88Xc5XShlr49DCmtgoSJZdmwNW4cAlnHy1zssmG8QknarCLNmso0tW
         Xw6haY9XT+DRDhs/lL1k7HNphwAdXP2Hiw4iYxmPjiud+/4LLf4iBFNL0ClXv/yaRD
         5HpRWOaxldJFbgNdW2fBzwgxcDGzCD1ePJ7GNyWhKQa8ucjueQqEYDQtVCmrTLWNyZ
         RGGlwwJWWT1k1JOoubL4N0TNKJTcsqFjF/oxhjXMPV2LQ14ajLRloHtRqjAdofiw3p
         kQ/g8naGEY3Z/HSEHdxKncNDlyhOkq+0qcYxzPyRG+wW/670w1RCKnAJRUh1RtgQmn
         g3nuyYwFvJBgQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: remove unused "file" field of yylval union
Date:   Fri, 21 Dec 2018 15:23:02 +0900
Message-Id: <1545373382-29088-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has never been used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 8a4d029..60ee8e7 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -36,7 +36,6 @@ static struct menu *current_menu, *current_entry;
 %union
 {
 	char *string;
-	struct file *file;
 	struct symbol *symbol;
 	struct expr *expr;
 	struct menu *menu;
-- 
2.7.4

