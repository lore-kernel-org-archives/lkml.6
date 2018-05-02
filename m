Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeEBO24 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeEBO2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:28:44 -0400
From: Dinh Nguyen <dinguyen@kernel.org>
To: linux-clk@vger.kernel.org
Cc: dinguyen@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: socfpga: stratix10: suppress unbinding platform's clock driver
Date: Wed,  2 May 2018 09:28:33 -0500
Message-Id: <1525271313-24427-2-git-send-email-dinguyen@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
References: <1525271313-24427-1-git-send-email-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Stratix10 clock driver is essential to system operation, so their
removal should never happen.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-s10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index c788997..3c953ca 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -329,6 +329,7 @@ static struct platform_driver stratix10_clkmgr_driver = {
 	.probe		= s10_clkmgr_probe,
 	.driver		= {
 		.name	= "stratix10-clkmgr",
+		.suppress_bind_attrs = true,
 		.of_match_table = stratix10_clkmgr_match_table,
 	},
 };
-- 
2.7.4
