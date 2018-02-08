Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBHDIM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:08:12 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35734 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHDIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:08:11 -0500
X-Google-Smtp-Source: AH8x224DcWmpahak7+8ued7vCjUEIE9FnnLB5sq2yQbBRzpVM1ru8gcPoZK8qmiAA4KAQD5sodvhJQ==
Date: Wed, 7 Feb 2018 22:08:08 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs: better MTD dependency expression
Message-ID: <nycvar.YSQ.7.76.1802072149330.7021@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9f5fb1800d8 ("cramfs: fix MTD dependency") did what it says.
Since commit 9059a3493efe ("kconfig: fix relational operators for bool
and tristate symbols") it is possible to do it slightly better though.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---

Linus,

Viro once told me that my cramfs pull requests could go either to him or 
to you. I have only this one patch at the moment, and since it depends 
on a commit that recently appeared in your tree I'm therefore sending it 
directly to you.

diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
index 58e2fe40b2..5933f99530 100644
--- a/fs/cramfs/Kconfig
+++ b/fs/cramfs/Kconfig
@@ -33,8 +33,7 @@ config CRAMFS_BLOCKDEV
 
 config CRAMFS_MTD
 	bool "Support CramFs image directly mapped in physical memory"
-	depends on CRAMFS && MTD
-	depends on CRAMFS=m || MTD=y
+	depends on CRAMFS && CRAMFS <= MTD
 	default y if !CRAMFS_BLOCKDEV
 	help
 	  This option allows the CramFs driver to load data directly from
