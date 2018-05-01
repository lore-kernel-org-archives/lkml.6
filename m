Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeEAJLO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:11:14 -0400
Received: from foss.arm.com ([217.140.101.70]:44024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEAJLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:11 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 01/27] coresight: ETM: Add support for ARM Cortex-A73
Date: Tue,  1 May 2018 10:10:31 +0100
Message-Id: <1525165857-11096-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARM Cortex A-73 ETM PIDs to the known ETM ips. While at it
also add description of the CPU to which the ETM belongs, to make
it easier to identify the ETM devices.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cf364a5..e84d80b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1034,7 +1034,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: %s initialized\n",
+			drvdata->cpu, (char *)id->data);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1053,20 +1054,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 }
 
 static const struct amba_id etm4_ids[] = {
-	{       /* ETM 4.0 - Cortex-A53  */
+	{
 		.id	= 0x000bb95d,
 		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
+		.data	= "Cortex-A53 ETM v4.0",
 	},
-	{       /* ETM 4.0 - Cortex-A57 */
+	{
 		.id	= 0x000bb95e,
 		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
+		.data	= "Cortex-A57 ETM v4.0",
 	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id = 0x000bb95a,
-		.mask = 0x000fffff,
-		.data = "ETM 4.0",
+	{
+		.id	= 0x000bb95a,
+		.mask	= 0x000fffff,
+		.data	= "Cortex-A72 ETM v4.0",
+	},
+	{
+		.id	= 0x000bb959,
+		.mask	= 0x000fffff,
+		.data	= "Cortex-A73 ETM v4.0",
 	},
 	{ 0, 0},
 };
-- 
2.7.4
