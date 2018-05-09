Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeEIHY7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:24:59 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50795 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbeEIHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:24:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36K028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] checkpatch: remove VMLINUX_SYMBOL() check
Date: Wed,  9 May 2018 16:23:52 +0900
Message-Id: <1525850632-10921-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that VMLINUX_SYMBOL() is no-op and being removed, let's stop
checking VMLINUX_SYMBOL().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/checkpatch.pl | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e16d671..ce582a8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5121,16 +5121,6 @@ sub process {
 			}
 		}
 
-# make sure symbols are always wrapped with VMLINUX_SYMBOL() ...
-# all assignments may have only one of the following with an assignment:
-#	.
-#	ALIGN(...)
-#	VMLINUX_SYMBOL(...)
-		if ($realfile eq 'vmlinux.lds.h' && $line =~ /(?:(?:^|\s)$Ident\s*=|=\s*$Ident(?:\s|$))/) {
-			WARN("MISSING_VMLINUX_SYMBOL",
-			     "vmlinux.lds.h needs VMLINUX_SYMBOL() around C-visible symbols\n" . $herecurr);
-		}
-
 # check for redundant bracing round if etc
 		if ($line =~ /(^.*)\bif\b/ && $1 !~ /else\s*$/) {
 			my ($level, $endln, @chunks) =
-- 
2.7.4
