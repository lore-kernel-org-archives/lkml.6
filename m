Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965146AbeB1Xef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:34:35 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:47085 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965012AbeB1Xc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:32:59 -0500
X-Google-Smtp-Source: AG47ELsN6ddanCUXH+YZ13yYBvAAUEr/tEshqc7ytAA95TMbo7eVVfGV7heuI8i9jtpf24QsoDi40Q==
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] kbuild: remove remaining use of undefined YACC_PREFIX
Date: Wed, 28 Feb 2018 17:32:44 -0600
Message-Id: <20180228233249.26281-2-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228233249.26281-1-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and
YACC_PREFIX") removed YACC_PREFIX definition, but left one use of it. There
was not any build error since there is no user of "cmd_bison_h" currently.
Remove the last remaining occurrence of YACC_PREFIX.

Fixes: eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and YACC_PREFIX")
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5589bae34af6..1bc2f90cb8c0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -217,7 +217,7 @@ $(filter %.tab.c,$(targets)): $(obj)/%.tab.c: $(src)/%.y FORCE
 	$(call if_changed,bison)
 
 quiet_cmd_bison_h = YACC    $@
-      cmd_bison_h = bison -o/dev/null --defines=$@ -t -l -p $(YACC_PREFIX) $<
+      cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
 
 ifdef REGENERATE_PARSERS
 .PRECIOUS: $(src)/%.tab.h_shipped
-- 
2.14.1
