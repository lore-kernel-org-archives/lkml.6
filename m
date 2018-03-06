Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeCFCNP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:13:15 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40459 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeCFCNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:13:14 -0500
X-Google-Smtp-Source: AG47ELvKjzwcPV8VR0TudNM5bxU+21QX6RA0dWucAi65Vw39xgJ5dY6w89GUYHWYUpmPJQYz6tgHdw==
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] regmap: debugfs: Improve warning message on debugfs_create_dir() failure
Date: Mon,  5 Mar 2018 23:13:04 -0300
Message-Id: <1520302384-21545-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently when debugfs_create_dir() fails we receive a warning message
that provides no indication as to what was the directory entry that
failed to be created.

Improve the warning message by printing the directory name that failed
in order to help debugging.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e3e7b91..68f21d6 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -581,7 +581,8 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
-		dev_warn(map->dev, "Failed to create debugfs directory\n");
+		dev_warn(map->dev,
+			 "Failed to create %s debugfs directory\n", name);
 		return;
 	}
 
-- 
2.7.4
