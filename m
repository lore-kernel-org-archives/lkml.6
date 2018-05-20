Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeETITG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:19:06 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:22125 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeETISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:18:45 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w4K8H4h1004008
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] kbuild: do not display CHK for filechk
Date: Sun, 20 May 2018 17:16:49 +0900
Message-Id: <1526804213-8238-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filechk displays two short logs; CHK for creating a temporary file,
and UPD for really updating the target.

IMHO, the build system can be quiet when the target file has not
been updated.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Kbuild.include | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 50cee53..c7fedc5 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -57,7 +57,6 @@ kecho := $($(quiet)kecho)
 #   to specify a valid file as first prerequisite (often the kbuild file)
 define filechk
 	$(Q)set -e;				\
-	$(kecho) '  CHK     $@';		\
 	mkdir -p $(dir $@);			\
 	$(filechk_$(1)) < $< > $@.tmp;		\
 	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
-- 
2.7.4
