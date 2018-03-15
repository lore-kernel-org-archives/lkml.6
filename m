Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeCOG0F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:26:05 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:63149 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeCOG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:26:04 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2F6PVED008255
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: do not include both curses.h and ncurses.h for nconfig
Date: Thu, 15 Mar 2018 15:25:27 +0900
Message-Id: <1521095127-23067-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nconf.h includes <curses.h> and "ncurses.h", but it does not need to
include both.  Generally, it should fall back to curses.h only when
ncurses.h is not found.  But, looks like it has never happened;
these includes have been here for many years since commit 692d97c380c6
("kconfig: new configuration interface (nconfig)"), and nobody has
complained about hard-coding of ncurses.h .  Let's simply drop the
curses.h inclusion.

I replaced "ncurses.h" with <ncurses.h> since it does not exist in
the local directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/nconf.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/nconf.h b/scripts/kconfig/nconf.h
index 0d52617..9f6f21d 100644
--- a/scripts/kconfig/nconf.h
+++ b/scripts/kconfig/nconf.h
@@ -15,7 +15,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <locale.h>
-#include <curses.h>
+#include <ncurses.h>
 #include <menu.h>
 #include <panel.h>
 #include <form.h>
@@ -24,8 +24,6 @@
 #include <time.h>
 #include <sys/time.h>
 
-#include "ncurses.h"
-
 #define max(a, b) ({\
 		typeof(a) _a = a;\
 		typeof(b) _b = b;\
-- 
2.7.4
