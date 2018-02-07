Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeBGVDy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:03:54 -0500
Received: from foss.arm.com ([217.140.101.70]:55972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbeBGVDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:03:53 -0500
Date: Wed, 7 Feb 2018 15:03:51 -0600
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] coresight replicator: set default y after Kconfig rename
Message-Id: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
replicator naming") changed the Kconfig symbol name from
QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
was being set in my juno build script, which left the new symbol unset,
causing the following unexpected grief:

 # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
 ..<snip>..
 sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
 mmap size 528384B
 AUX area mmap length 4194304
 perf event ring buffer mmapped per cpu
 failed to mmap AUX area
 failed to mmap with 12 (Cannot allocate memory)

Make it default y to help not surprise unsuspecting users.

Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c164e1..b94bbd95efa6 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
 config CORESIGHT_DYNAMIC_REPLICATOR
 	bool "CoreSight Programmable Replicator driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
+	default y
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
-- 
2.16.1
