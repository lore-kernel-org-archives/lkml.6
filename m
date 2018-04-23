Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932432AbeDWTvE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:51:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37141 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeDWTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:51:02 -0400
X-Google-Smtp-Source: AIpwx4+CeqmefN4jvREtZYN1F576WLMJ7K5aiwh0q4Z/1YrgBKHWI+/I/Ndcb4vQLgpjyxI9LRag6Q==
From: Mathieu Malaterre <malat@debian.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild/debian: Use KBUILD_BUILD_* when set
Date: Mon, 23 Apr 2018 21:50:54 +0200
Message-Id: <20180423195055.26069-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be nice to the user and check env vars KBUILD_BUILD_USER &
KBUILD_BUILD_HOST when those are set.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 scripts/package/mkdebian | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 6adb3a16ba3b..05d58d3ae8a0 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -76,6 +76,8 @@ if [ -n "$DEBEMAIL" ]; then
        email=$DEBEMAIL
 elif [ -n "$EMAIL" ]; then
        email=$EMAIL
+elif [ -n "$KBUILD_BUILD_USER" ] && [ -n "$KBUILD_BUILD_HOST" ]; then
+       email=$KBUILD_BUILD_USER@$KBUILD_BUILD_HOST
 else
        email=$(id -nu)@$(hostname -f 2>/dev/null || hostname)
 fi
-- 
2.11.0
