Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbeE1JYX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:24:23 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21477 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeE1JYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:13 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInO027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 07/31] kconfig: make default prompt of mainmenu less specific
Date: Mon, 28 May 2018 18:21:44 +0900
Message-Id: <1527499328-13213-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "mainmenu" is not specified, "Linux Kernel Configuration" is used
as a default prompt.

Given that Kconfig is used in other projects than Linux, let's use
a more generic prompt, "Main menu".

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5:
  - Newly added

Changes in v4: None
Changes in v3: None
Changes in v2: None

 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config | 2 +-
 scripts/kconfig/zconf.y                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
index 0d15e41..4732288 100644
--- a/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
@@ -1,5 +1,5 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux Kernel Configuration
+# Main menu
 #
 # CONFIG_A is not set
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 22e318c..8a82aaf 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -532,7 +532,7 @@ void conf_parse(const char *name)
 
 	if (!menu_has_prompt(&rootmenu)) {
 		current_entry = &rootmenu;
-		menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
+		menu_add_prompt(P_MENU, "Main menu", NULL);
 	}
 
 	menu_finalize(&rootmenu);
-- 
2.7.4
