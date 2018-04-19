Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeDSOQP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:16:15 -0400
Received: from sauhun.de ([88.99.104.3]:45270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753491AbeDSOHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:05 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 37/61] perf: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:07 +0200
Message-Id: <20180419140641.27926-38-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/perf/arm_spe_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 28bb642af18b..54ec278d2fc4 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -131,8 +131,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 	struct dev_ext_attribute *ea =
 		container_of(attr, struct dev_ext_attribute, attr);
 	int cap = (long)ea->var;
@@ -247,8 +246,7 @@ static ssize_t arm_spe_pmu_get_attr_cpumask(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
 	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
 }
-- 
2.11.0
