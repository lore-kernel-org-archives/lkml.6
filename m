Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeB1ARl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:17:41 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24336 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeB1AQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:48 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1S0Fahm000353
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] kconfig: remove unneeded input_mode test in conf()
Date: Wed, 28 Feb 2018 09:15:22 +0900
Message-Id: <1519776926-30459-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

conf() is never called for listnewconfig / olddefconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2: None

 scripts/kconfig/conf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 4227d3b..1faa55f 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -358,9 +358,7 @@ static void conf(struct menu *menu)
 
 		switch (prop->type) {
 		case P_MENU:
-			if ((input_mode == silentoldconfig ||
-			     input_mode == listnewconfig ||
-			     input_mode == olddefconfig) &&
+			if (input_mode == silentoldconfig &&
 			    rootEntry != menu) {
 				check_conf(menu);
 				return;
-- 
2.7.4
