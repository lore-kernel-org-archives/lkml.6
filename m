Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeBVSAl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:00:41 -0500
Received: from foss.arm.com ([217.140.101.70]:46092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933441AbeBVSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:00:40 -0500
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: scpi: drop redundant arm_big_little config dependency
Date: Thu, 22 Feb 2018 18:00:23 +0000
Message-Id: <1519322423-27956-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 343a8d17fa8d (cpufreq: scpi: remove arm_big_little dependency)
removed the SCPI cpufreq dependency on arm_big_little cpufreq driver.
However the Kconfig entry still depends on ARM_BIG_LITTLE_CPUFREQ
which is clearly wrong.

This patch removes that unnecessary Kconfig dependency.

Fixes: 343a8d17fa8d (cpufreq: scpi: remove arm_big_little dependency)
Reported-by: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/Kconfig.arm | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 2e49673a9e21..9bbb5b39d18a 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -44,10 +44,10 @@ config ARM_DT_BL_CPUFREQ
 
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
+	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
 	help
-	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
-	  using SCPI protocol for CPU power management.
+	  This adds the CPUfreq driver support for ARM platforms using SCPI
+	  protocol for CPU power management.
 
 	  This driver uses SCPI Message Protocol driver to interact with the
 	  firmware providing the CPU DVFS functionality.
-- 
2.7.4
