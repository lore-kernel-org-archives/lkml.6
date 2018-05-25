Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936365AbeEYOh0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:37:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936228AbeEYOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:35:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 4/7] x86: remove a stray reference to pci-nommu.c
Date: Fri, 25 May 2018 16:35:09 +0200
Message-Id: <20180525143512.1466-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525143512.1466-1-hch@lst.de>
References: <20180525143512.1466-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just the minimal workaround.  The file file is mostly either stale
and/or duplicative of Documentation/admin-guide/kernel-parameters.txt,
but that is much more work than I'm willing to do right now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/x86/x86_64/boot-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index b297c48389b9..153b3a57fba2 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -187,9 +187,9 @@ PCI
 
 IOMMU (input/output memory management unit)
 
- Currently four x86-64 PCI-DMA mapping implementations exist:
+ Multiple x86-64 PCI-DMA mapping implementations exist, for example:
 
-   1. <arch/x86_64/kernel/pci-nommu.c>: use no hardware/software IOMMU at all
+   1. <lib/dma-direct.c>: use no hardware/software IOMMU at all
       (e.g. because you have < 3 GB memory).
       Kernel boot message: "PCI-DMA: Disabling IOMMU"
 
-- 
2.17.0
