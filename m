Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeDXLIr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:08:47 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:36073 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeDXLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:08:41 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3OB8LRb013907
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Mauro Rossi <issor.oruam@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] genksyms: fix typo in parse.tab.{c,h} generation rules
Date: Tue, 24 Apr 2018 20:08:18 +0900
Message-Id: <1524568099-25206-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Rossi <issor.oruam@gmail.com>

'quet' is replaced by 'quiet' in scripts/genksyms/Makefile

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/genksyms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
index ef0287e..03b7ce9 100644
--- a/scripts/genksyms/Makefile
+++ b/scripts/genksyms/Makefile
@@ -14,14 +14,14 @@ genksyms-objs	:= genksyms.o parse.tab.o lex.lex.o
 # so that 'bison: not found' will be displayed if it is missing.
 ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
 
-quiet_cmd_bison_no_warn = $(quet_cmd_bison)
+quiet_cmd_bison_no_warn = $(quiet_cmd_bison)
       cmd_bison_no_warn = $(YACC) --version >/dev/null; \
 			  $(cmd_bison) 2>/dev/null
 
 $(obj)/parse.tab.c: $(src)/parse.y FORCE
 	$(call if_changed,bison_no_warn)
 
-quiet_cmd_bison_h_no_warn = $(quet_cmd_bison_h)
+quiet_cmd_bison_h_no_warn = $(quiet_cmd_bison_h)
       cmd_bison_h_no_warn = $(YACC) --version >/dev/null; \
 			    $(cmd_bison_h) 2>/dev/null
 
-- 
2.7.4
