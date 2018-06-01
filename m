Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFANbU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:31:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49201 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFANbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:31:19 -0400
From: Colin King <colin.king@canonical.com>
To: Alessandro Rubini <rubini@gnudd.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/fmc: make struct fmc_dbgfs_sdb_dump static
Date: Fri,  1 Jun 2018 14:31:17 +0100
Message-Id: <20180601133117.6511-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure fmc_dbgfs_sdb_dump is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/fmc/fmc-debug.c:143:30: warning: symbol 'fmc_dbgfs_sdb_dump'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fmc/fmc-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
index 32930722770c..c96b928f0112 100644
--- a/drivers/fmc/fmc-debug.c
+++ b/drivers/fmc/fmc-debug.c
@@ -140,7 +140,7 @@ static int fmc_sdb_dump_open(struct inode *inode, struct file *file)
 }
 
 
-const struct file_operations fmc_dbgfs_sdb_dump = {
+static const struct file_operations fmc_dbgfs_sdb_dump = {
 	.owner = THIS_MODULE,
 	.open  = fmc_sdb_dump_open,
 	.read = seq_read,
-- 
2.17.0
