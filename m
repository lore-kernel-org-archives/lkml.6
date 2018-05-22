Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeEVPz1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:55:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38652 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751196AbeEVPz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:55:26 -0400
From: John Garry <john.garry@huawei.com>
To: <will.deacon@arm.com>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] drivers/perf: Remove ARM_SPE_PMU explicit PERF_EVENTS dependency
Date: Tue, 22 May 2018 23:54:04 +0800
Message-ID: <1527004444-239462-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bddb9b68d3fb ("drivers/perf: commonise PERF_EVENTS
dependency"), all perf drivers depend on PERF_EVENTS config under a
common menu.

Config ARM_SPE_PMU still declares explicitly a dependency on
PERF_EVENTS, which is unneeded, so remove it.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 28bb5a0..90ce4da 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -94,7 +94,7 @@ config XGENE_PMU
 
 config ARM_SPE_PMU
 	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
-	depends on PERF_EVENTS && ARM64
+	depends on ARM64
 	help
 	  Enable perf support for the ARMv8.2 Statistical Profiling
 	  Extension, which provides periodic sampling of operations in
-- 
1.9.1
