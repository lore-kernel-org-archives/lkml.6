Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCVVFb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:05:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35162 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCVVF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:05:29 -0400
X-Google-Smtp-Source: AG47ELuRPWf2ULphzIRQ1o337O+lM1B9wzeyv8NEsyXJ1IrSsdnQBSrVhh+SM57ocLfzzCoR6IxEcg==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC resend 1/2] modpost: delete stale comment
Date: Thu, 22 Mar 2018 22:05:23 +0100
Message-Id: <20180322210525.25361-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180322150005.15061-2-linux@rasmusvillemoes.dk>
References: <20180322150005.15061-2-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit (7840fea200cd "kbuild: Fix computing srcversion for modules")
fixed the comment above parse_source_files to refer to the new source_
line, but left this one behind that could still give the impression that
drivers/net/dummy.c appears in the deps_ variable.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Resending because I didn't reach any current kbuild maintainers nor
the kbuild mailing list.

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
