Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934491AbeEIJuy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:50:54 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:53969 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934106AbeEIJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:50:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w499oiPP018127
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] modpost: constify *modname function argument where possible
Date: Wed,  9 May 2018 18:50:40 +0900
Message-Id: <1525859440-29583-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither find_module() nor read_symbols() does change *modname.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9e70a6a..1663fb1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -121,7 +121,7 @@ void *do_nofail(void *ptr, const char *expr)
 /* A list of all modules we processed */
 static struct module *modules;
 
-static struct module *find_module(char *modname)
+static struct module *find_module(const char *modname)
 {
 	struct module *mod;
 
@@ -1929,7 +1929,7 @@ static char *remove_dot(char *s)
 	return s;
 }
 
-static void read_symbols(char *modname)
+static void read_symbols(const char *modname)
 {
 	const char *symname;
 	char *version;
-- 
2.7.4
