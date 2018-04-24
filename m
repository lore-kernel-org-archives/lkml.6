Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDXLHc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:07:32 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:43312 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeDXLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:07:28 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w3OB7FjK029501
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: replace hardcoded bison in cmd_bison_h with $(YACC)
Date: Tue, 24 Apr 2018 20:07:13 +0900
Message-Id: <1524568033-25026-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 73a4f6dbe70a ("kbuild: add LEX and YACC variables") missed to
update cmd_bison_h somehow.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 07d0740..5af34a2b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -196,7 +196,7 @@ $(obj)/%.tab.c: $(src)/%.y FORCE
 	$(call if_changed,bison)
 
 quiet_cmd_bison_h = YACC    $@
-      cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
+      cmd_bison_h = $(YACC) -o/dev/null --defines=$@ -t -l $<
 
 $(obj)/%.tab.h: $(src)/%.y FORCE
 	$(call if_changed,bison_h)
-- 
2.7.4
