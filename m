Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6F220811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yCK6NlQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394329AbfBNDGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:05 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64388 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbfBNDGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg3020814;
        Thu, 14 Feb 2019 12:05:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg3020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113526;
        bh=z7QbcsEL2gebJ2pwu1NQAHednh5Ku/Vt6/MmBfIu8UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCK6NlQq6emtPRc5IEqJokU4opyLttoMvwtjnKyj1aW62BKX7SUzwb0Z5eHz2syxN
         zJcnKWII+vT+cGsJwxmaPRr8FQMjcmj+k3RBvAZbFqcuzECTumdAVH8WIooepZyOst
         M2nRsOUWRKjU5kjCUqfGIWAUyo0duBrmXFr4cLIakX4a3x0XmKBRCtNoS3ihhJB2va
         RegSQBaiSUQOe2KSK6+HsA99W7BI5e2l0DQ3cDyCT6/pyN1ZVZNlZ9xJjcQYkb1SAW
         wkFYrdyAd/I/N3KN+vcRyFda95z8UgIfpMXde2cvSLHxxopfSxqEb1iHFbBr7fm25m
         pdbmM1KAcgAsA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] kbuild: generate modules.order only when CONFIG_MODULES=y
Date:   Thu, 14 Feb 2019 12:05:15 +0900
Message-Id: <1550113521-23577-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not generate pointless modules.order when the module support is
disabled.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 99be01c..89debbe 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -63,7 +63,9 @@ ifneq ($(strip $(real-obj-y) $(need-builtin)),)
 builtin-target := $(obj)/built-in.a
 endif
 
+ifdef CONFIG_MODULES
 modorder-target := $(obj)/modules.order
+endif
 
 # We keep a list of all modules in $(MODVERDIR)
 
-- 
2.7.4

