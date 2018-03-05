Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbeCEJ2s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:28:48 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:47306 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932935AbeCEJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:28:45 -0500
From: Harish Jenny K N <harish_kandiga@mentor.com>
To: <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <adrian.hunter@intel.com>, <shawn.lin@rock-chips.com>,
        <avri.altman@wdc.com>, <andriy.shevchenko@linux.intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harish_kandiga@mentor.com>, <Vladimir_Zapolskiy@mentor.com>
Subject: [PATCH v3] mmc: Export host capabilities to debugfs.
Date: Mon, 5 Mar 2018 14:58:40 +0530
Message-ID: <1520242120-2924-1-git-send-email-harish_kandiga@mentor.com>
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
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---

Changes in v3:
- Removed typecasting of &host->caps to (u32 *)

Changes in v2:
- Changed Author

 drivers/mmc/core/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c51e0c0..570c9e4 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)

 	card->debugfs_root = root;

+	if (!debugfs_create_x32("host_caps", S_IRUSR, root, &host->caps))
+		goto err;
+
 	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
 		goto err;

--
1.9.1
