Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeBLQsa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:48:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53175 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeBLQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:28 -0500
X-Google-Smtp-Source: AH8x225dAFjbwM2XoDD3FNK7q0ou+KTv+T8ZXAGPx2UbP5/jU7GXBXXZ+tSlM+yFHJzLATyAEQgVMw==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 0/6] iommu/intel: Handle DMAR faults in a wq
Date: Mon, 12 Feb 2018 16:48:19 +0000
Message-Id: <20180212164825.22421-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to v2:
- Ratelimit printks for dmar faults (6 patch)

First version:
https://lkml.org/lkml/2018/1/24/364

A softlockup-panic fix I've meet on kernel test suite.
While at it, fix a couple of minor issues.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org

Dmitry Safonov (6):
  iommu/intel: Add __init for dmar_register_bus_notifier()
  iommu/intel: Clean/document fault status flags
  iommu/intel: Introduce clear_primary_faults() helper
  iommu/intel: Handle DMAR faults on workqueue
  iommu/intel: Rename dmar_fault() => dmar_serve_faults()
  iommu/intel: Ratelimit each dmar fault printing

 drivers/iommu/dmar.c                | 73 +++++++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c         |  8 +++-
 drivers/iommu/intel_irq_remapping.c |  2 +-
 include/linux/dmar.h                |  3 +-
 include/linux/intel-iommu.h         | 12 +++---
 5 files changed, 78 insertions(+), 20 deletions(-)

-- 
2.13.6
