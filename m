Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01143214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfBRKaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:30:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:30:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1IASQml2531099
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 02:28:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1IASQBT2531096;
        Mon, 18 Feb 2019 02:28:26 -0800
Date:   Mon, 18 Feb 2019 02:28:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a6a309edba13866b31dc4d8aebad3864a6d56ade@git.kernel.org>
Cc:     tglx@linutronix.de, keith.busch@intel.com, mingo@kernel.org,
        helgaas@kernel.org, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hch@lst.de, sagi@grimberg.me, marc.zyngier@arm.com,
        axboe@kernel.dk, hpa@zytor.com, ming.lei@redhat.com
Reply-To: hch@lst.de, sagi@grimberg.me, marc.zyngier@arm.com,
          axboe@kernel.dk, ming.lei@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, keith.busch@intel.com,
          shivasharan.srikanteshwara@broadcom.com,
          sumit.saxena@broadcom.com, helgaas@kernel.org, mingo@kernel.org,
          kashyap.desai@broadcom.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190216172228.689834224@linutronix.de>
References: <20190216172228.689834224@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Remove the leftovers of the
 original set support
Git-Commit-ID: a6a309edba13866b31dc4d8aebad3864a6d56ade
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

Commit-ID:  a6a309edba13866b31dc4d8aebad3864a6d56ade
Gitweb:     https://git.kernel.org/tip/a6a309edba13866b31dc4d8aebad3864a6d56ade
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sat, 16 Feb 2019 18:13:11 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 18 Feb 2019 11:21:29 +0100

genirq/affinity: Remove the leftovers of the original set support

Now that the NVME driver is converted over to the calc_set() callback, the
workarounds of the original set support can be removed.

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
Link: https://lkml.kernel.org/r/20190216172228.689834224@linutronix.de

---
 kernel/irq/affinity.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d737dc60ab52..f18cd5aa33e8 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -264,20 +264,13 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 	/*
 	 * Simple invocations do not provide a calc_sets() callback. Install
-	 * the generic one. The check for affd->nr_sets is a temporary
-	 * workaround and will be removed after the NVME driver is converted
-	 * over.
+	 * the generic one.
 	 */
-	if (!affd->nr_sets && !affd->calc_sets)
+	if (!affd->calc_sets)
 		affd->calc_sets = default_calc_sets;
 
-	/*
-	 * If the device driver provided a calc_sets() callback let it
-	 * recalculate the number of sets and their size. The check will go
-	 * away once the NVME driver is converted over.
-	 */
-	if (affd->calc_sets)
-		affd->calc_sets(affd, affvecs);
+	/* Recalculate the sets */
+	affd->calc_sets(affd, affvecs);
 
 	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
@@ -344,11 +337,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 
 	if (affd->calc_sets) {
 		set_vecs = maxvec - resv;
-	} else if (affd->nr_sets) {
-		unsigned int i;
-
-		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->set_size[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);
