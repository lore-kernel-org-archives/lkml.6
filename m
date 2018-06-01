Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeFANs7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:48:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49556 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeFANs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:48:58 -0400
From: Colin King <colin.king@canonical.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: PCC: make struct pcc_mbox_driver static
Date: Fri,  1 Jun 2018 14:48:56 +0100
Message-Id: <20180601134856.13322-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure pcc_mbox_driver is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/mailbox/pcc.c:576:24: warning: symbol 'pcc_mbox_driver' was
not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index fc3c237daef2..26976554372b 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -573,7 +573,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-struct platform_driver pcc_mbox_driver = {
+static struct platform_driver pcc_mbox_driver = {
 	.probe = pcc_mbox_probe,
 	.driver = {
 		.name = "PCCT",
-- 
2.17.0
