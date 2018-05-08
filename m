Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeEHSUh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:20:37 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33368 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932467AbeEHSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:32 -0400
X-Google-Smtp-Source: AB8JxZoQ0YkSv5JQCVin0+o8iaonKsAlVdGcKPzxZRn2iZm/1LgdIGqRliWcY9RPvgdvk2wppCowYw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/9] iommu/tegra: gart: Remove pr_fmt and clean up includes
Date: Tue,  8 May 2018 21:16:55 +0300
Message-Id: <20180508181700.5169-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded 'includes' and sort them in alphabet order. Also remove
pr_fmt since there is no pr_xxx() and it doesn't affect dev_xxx().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 268d29fb9097..08e0de4087d1 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -17,24 +17,17 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/vmalloc.h>
-#include <linux/mm.h>
-#include <linux/list.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/iommu.h>
-#include <linux/of.h>
 
 #include <soc/tegra/mc.h>
 
-#include <asm/cacheflush.h>
-
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
-- 
2.17.0
