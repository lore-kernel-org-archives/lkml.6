Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeCWNGN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:06:13 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:52673 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeCWNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:06:00 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2ND4mgX011418
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 01/10] .gitignore: move *.lex.c *.tab.[ch] patterns to the top-level .gitignore
Date: Fri, 23 Mar 2018 22:04:30 +0900
Message-Id: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patterns are common to host programs that require lexer and parser.
Move them to the top .gitignore.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .gitignore                  | 2 ++
 scripts/dtc/.gitignore      | 3 ---
 scripts/genksyms/.gitignore | 3 ---
 scripts/kconfig/.gitignore  | 3 ---
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/.gitignore b/.gitignore
index 85bcc26..1e82be1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -22,6 +22,7 @@
 *.gz
 *.i
 *.ko
+*.lex.c
 *.ll
 *.lst
 *.lz4
@@ -37,6 +38,7 @@
 *.so.dbg
 *.su
 *.symtypes
+*.tab.[ch]
 *.tar
 *.xz
 Module.symvers
diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
index cdabdc9..2e6e60d 100644
--- a/scripts/dtc/.gitignore
+++ b/scripts/dtc/.gitignore
@@ -1,4 +1 @@
 dtc
-dtc-lexer.lex.c
-dtc-parser.tab.c
-dtc-parser.tab.h
diff --git a/scripts/genksyms/.gitignore b/scripts/genksyms/.gitignore
index e7836b4..b119c7d 100644
--- a/scripts/genksyms/.gitignore
+++ b/scripts/genksyms/.gitignore
@@ -1,4 +1 @@
-*.lex.c
-*.tab.c
-*.tab.h
 genksyms
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index a76856e..2da579e 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -1,9 +1,6 @@
 #
 # Generated files
 #
-*.lex.c
-*.tab.c
-*.tab.h
 *.moc
 gconf.glade.h
 *.pot
-- 
2.7.4
