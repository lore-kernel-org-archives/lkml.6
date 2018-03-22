Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbeCVPAN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:00:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36311 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeCVPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:00:11 -0400
X-Google-Smtp-Source: AG47ELs5MtyUqUt7L6I0ZwU9Ti4+KZNbNgJfkSTqppiYLPhhypES4mAYOTOFcfsZrptYEbDOTqJbKg==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Michal Marek <mmarek@suse.cz>,
        Masahiro Yamada <yamada.m@jp.panasonic.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] modpost: delete stale comment
Date: Thu, 22 Mar 2018 15:59:53 +0100
Message-Id: <20180322150005.15061-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit (7840fea200cd "kbuild: Fix computing srcversion for modules")
fixed the comment above parse_source_files to refer to the new source_
line, but left this one behind that could still give the impression that
drivers/net/dummy.c appears in the deps_ variable.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/mod/sumversion.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 944418da9fe3..0f6dcb4011a8 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -330,14 +330,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 		goto out;
 	}
 
-	/* There will be a line like so:
-		deps_drivers/net/dummy.o := \
-		  drivers/net/dummy.c \
-		    $(wildcard include/config/net/fastroute.h) \
-		  include/linux/module.h \
-
-	   Sum all files in the same dir or subdirs.
-	*/
+	/* Sum all files in the same dir or subdirs. */
 	while ((line = get_next_line(&pos, file, flen)) != NULL) {
 		char* p = line;
 
-- 
2.15.1
