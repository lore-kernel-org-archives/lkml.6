Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935177AbeCENi5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:38:57 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:40471 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934037AbeCENiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:54 -0500
From: Harish Jenny K N <harish_kandiga@mentor.com>
To: <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>,
        <avri.altman@wdc.com>, <andriy.shevchenko@linux.intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harish_kandiga@mentor.com>, <Vladimir_Zapolskiy@mentor.com>
Subject: [PATCH] mmc: Export host capabilities to debugfs.
Date: Mon, 5 Mar 2018 19:08:44 +0530
Message-ID: <1520257124-27647-1-git-send-email-harish_kandiga@mentor.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abbas Raza <Abbas_Raza@mentor.com>

This patch exports the host capabilities to debugfs

Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
[Harish: Added caps2, moved creation to mmc_add_host_debugfs]
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---

Changes in v4:
- Moved the creation of nodes to mmc_add_host_debugfs
- Exported caps2
- Renamed host_caps to caps

Changes in v3:
- Removed typecasting of &host->caps to (u32 *)

Changes in v2:
- Changed Author

 drivers/mmc/core/debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c51e0c0..d2275c5 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -243,6 +243,12 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
 		goto err_node;

+	if (!debugfs_create_x32("caps", S_IRUSR, root, &host->caps))
+		goto err_node;
+
+	if (!debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2))
+		goto err_node;
+
 	if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
 			&mmc_clock_fops))
 		goto err_node;
--
1.9.1
