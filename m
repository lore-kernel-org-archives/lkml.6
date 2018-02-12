Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754307AbeBLQuH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:50:07 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40419 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753977AbeBLQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:29 -0500
X-Google-Smtp-Source: AH8x225vj096nLkFtGK9ycUxRjJxHYQp0Zht+xzwb5TwW3UCYu4sI/R0Y8y1l7eY5zfG5DT5nd4tQw==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 1/6] iommu/intel: Add __init for dmar_register_bus_notifier()
Date: Mon, 12 Feb 2018 16:48:20 +0000
Message-Id: <20180212164825.22421-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's called only from intel_iommu_init(), which is init function.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9a7ffd13c7f0..accf58388bdb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -806,7 +806,7 @@ int __init dmar_dev_scope_init(void)
 	return dmar_dev_scope_status;
 }
 
-void dmar_register_bus_notifier(void)
+void __init dmar_register_bus_notifier(void)
 {
 	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
 }
-- 
2.13.6
