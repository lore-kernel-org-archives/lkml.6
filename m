Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C456BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4FA214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfBRKak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:30:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:30:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1IAT7Xv2531156
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 02:29:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1IAT6nZ2531151;
        Mon, 18 Feb 2019 02:29:06 -0800
Date:   Mon, 18 Feb 2019 02:29:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4e6b26d23dc1faee318796d5c7f91b5692b1e6be@git.kernel.org>
Cc:     marc.zyngier@arm.com, axboe@kernel.dk, kashyap.desai@broadcom.com,
        hpa@zytor.com, keith.busch@intel.com, hch@lst.de,
        tglx@linutronix.de, sumit.saxena@broadcom.com, sagi@grimberg.me,
        ming.lei@redhat.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org,
        shivasharan.srikanteshwara@broadcom.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org,
          shivasharan.srikanteshwara@broadcom.com, mingo@kernel.org,
          hch@lst.de, tglx@linutronix.de, sumit.saxena@broadcom.com,
          ming.lei@redhat.com, sagi@grimberg.me, helgaas@kernel.org,
          hpa@zytor.com, keith.busch@intel.com, marc.zyngier@arm.com,
          axboe@kernel.dk, kashyap.desai@broadcom.com
In-Reply-To: <20190216172228.778630549@linutronix.de>
References: <20190216172228.778630549@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] PCI/MSI: Remove obsolete sanity checks for multiple
 interrupt sets
Git-Commit-ID: 4e6b26d23dc1faee318796d5c7f91b5692b1e6be
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4e6b26d23dc1faee318796d5c7f91b5692b1e6be
Gitweb:     https://git.kernel.org/tip/4e6b26d23dc1faee318796d5c7f91b5692b1e6be
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sat, 16 Feb 2019 18:13:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 18 Feb 2019 11:21:29 +0100

PCI/MSI: Remove obsolete sanity checks for multiple interrupt sets

Multiple interrupt sets for affinity spreading are now handled in the core
code and the number of sets and their size is recalculated via a driver
supplied callback.

That avoids the requirement to invoke pci_alloc_irq_vectors_affinity() with
the arguments minvecs and maxvecs set to the same value and the callsite
handling the ENOSPC situation.

Remove the now obsolete sanity checks and the related comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Link: https://lkml.kernel.org/r/20190216172228.778630549@linutronix.de


---
 drivers/pci/msi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7149d6315726..73986825d221 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
