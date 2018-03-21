Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeCUSCF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:02:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53451 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeCUSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:02:01 -0400
From: Colin King <colin.king@canonical.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] firmware: arm_scmi: remove redundant null check on array
Date: Wed, 21 Mar 2018 18:01:58 +0000
Message-Id: <20180321180158.2507-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The null check on clk->name is redundant since name is a char array
and can never be null, so the check is always true.  Remove it.

Detected by CoverityScan, CID#1466117 ("Array compared against 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e8ffad33a0ff..0aabffc88599 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -283,7 +283,7 @@ scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 	struct clock_info *ci = handle->clk_priv;
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
-	if (!clk->name || !clk->name[0])
+	if (!clk->name[0])
 		return NULL;
 
 	return clk;
-- 
2.15.1
