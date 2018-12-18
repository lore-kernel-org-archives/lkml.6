Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2398C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6642721852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hnSFo2Rf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SdUHWXCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeLRLgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:36:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeLRLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:36:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A509260A43; Tue, 18 Dec 2018 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545132961;
        bh=USb75eDXNfcvqvp05qisI4Mmqi/YjfsStN03YbSaYFM=;
        h=From:To:Cc:Subject:Date:From;
        b=hnSFo2RfAGlRHMV7fZFIW6c/wmg9DJ7dbXSaaSTANnUDe3i0sL4lBUc2bU8CUVRbx
         xzJeIxUveZabUyHJZjBvmawEwx2yzeG8KjEUdyX5+ZiAzErj7gLbMselNm3nYXQqyJ
         WR+vVfImYJA4ioSdeHoJTdd28X1NGu1rkxa3Gwz4=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9888608CE;
        Tue, 18 Dec 2018 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545132959;
        bh=USb75eDXNfcvqvp05qisI4Mmqi/YjfsStN03YbSaYFM=;
        h=From:To:Cc:Subject:Date:From;
        b=SdUHWXCOiZFdgibqkmvSDhYO9oWnecXLo1D2YzGSkPjnjm2k9fXwCxnduLKI30MNI
         RXgtw//rP//fynYQHX3Ie2+fVWnfCgeu+y7pLhJmt18aYdodIHJ6rjd9Ik142B5CcZ
         wgf5FVPCJbdlVJa9+jM/j2KHcCmDAtQwghG7rmRA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9888608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: [v3] drm/msm/dpu: Clean up dpu hw interrupts
Date:   Tue, 18 Dec 2018 17:05:48 +0530
Message-Id: <1545132948-20833-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused functions and macros from files handling
dpu hardware interrupts.

changes in v2:
  Removed clear_interrupt_status (Jordan Crouse)
changes in v3:
  Changed commit text

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 44 -----------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h | 44 -----------------------
 2 files changed, 88 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index c0b7f00..8a28a03 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -170,10 +170,6 @@
 /**
  * AD4 interrupt status bit definitions
  */
-#define DPU_INTR_BRIGHTPR_UPDATED BIT(4)
-#define DPU_INTR_DARKENH_UPDATED BIT(3)
-#define DPU_INTR_STREN_OUTROI_UPDATED BIT(2)
-#define DPU_INTR_STREN_INROI_UPDATED BIT(1)
 #define DPU_INTR_BACKLIGHT_UPDATED BIT(0)
 /**
  * struct dpu_intr_reg - array of DPU register sets
@@ -782,18 +778,6 @@ static int dpu_hw_intr_irqidx_lookup(enum dpu_intr_type intr_type,
 	return -EINVAL;
 }
 
-static void dpu_hw_intr_set_mask(struct dpu_hw_intr *intr, uint32_t reg_off,
-		uint32_t mask)
-{
-	if (!intr)
-		return;
-
-	DPU_REG_WRITE(&intr->hw, reg_off, mask);
-
-	/* ensure register writes go through */
-	wmb();
-}
-
 static void dpu_hw_intr_dispatch_irq(struct dpu_hw_intr *intr,
 		void (*cbfunc)(void *, int),
 		void *arg)
@@ -1004,18 +988,6 @@ static int dpu_hw_intr_disable_irqs(struct dpu_hw_intr *intr)
 	return 0;
 }
 
-static int dpu_hw_intr_get_valid_interrupts(struct dpu_hw_intr *intr,
-		uint32_t *mask)
-{
-	if (!intr || !mask)
-		return -EINVAL;
-
-	*mask = IRQ_SOURCE_MDP | IRQ_SOURCE_DSI0 | IRQ_SOURCE_DSI1
-		| IRQ_SOURCE_HDMI | IRQ_SOURCE_EDP;
-
-	return 0;
-}
-
 static void dpu_hw_intr_get_interrupt_statuses(struct dpu_hw_intr *intr)
 {
 	int i;
@@ -1065,19 +1037,6 @@ static void dpu_hw_intr_clear_intr_status_nolock(struct dpu_hw_intr *intr,
 	wmb();
 }
 
-static void dpu_hw_intr_clear_interrupt_status(struct dpu_hw_intr *intr,
-		int irq_idx)
-{
-	unsigned long irq_flags;
-
-	if (!intr)
-		return;
-
-	spin_lock_irqsave(&intr->irq_lock, irq_flags);
-	dpu_hw_intr_clear_intr_status_nolock(intr, irq_idx);
-	spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
-}
-
 static u32 dpu_hw_intr_get_interrupt_status(struct dpu_hw_intr *intr,
 		int irq_idx, bool clear)
 {
@@ -1113,16 +1072,13 @@ static u32 dpu_hw_intr_get_interrupt_status(struct dpu_hw_intr *intr,
 
 static void __setup_intr_ops(struct dpu_hw_intr_ops *ops)
 {
-	ops->set_mask = dpu_hw_intr_set_mask;
 	ops->irq_idx_lookup = dpu_hw_intr_irqidx_lookup;
 	ops->enable_irq = dpu_hw_intr_enable_irq;
 	ops->disable_irq = dpu_hw_intr_disable_irq;
 	ops->dispatch_irqs = dpu_hw_intr_dispatch_irq;
 	ops->clear_all_irqs = dpu_hw_intr_clear_irqs;
 	ops->disable_all_irqs = dpu_hw_intr_disable_irqs;
-	ops->get_valid_interrupts = dpu_hw_intr_get_valid_interrupts;
 	ops->get_interrupt_statuses = dpu_hw_intr_get_interrupt_statuses;
-	ops->clear_interrupt_status = dpu_hw_intr_clear_interrupt_status;
 	ops->clear_intr_status_nolock = dpu_hw_intr_clear_intr_status_nolock;
 	ops->get_interrupt_status = dpu_hw_intr_get_interrupt_status;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 61e4cba..4d7a1c7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -20,13 +20,6 @@
 #include "dpu_hw_util.h"
 #include "dpu_hw_mdss.h"
 
-#define IRQ_SOURCE_MDP		BIT(0)
-#define IRQ_SOURCE_DSI0		BIT(4)
-#define IRQ_SOURCE_DSI1		BIT(5)
-#define IRQ_SOURCE_HDMI		BIT(8)
-#define IRQ_SOURCE_EDP		BIT(12)
-#define IRQ_SOURCE_MHL		BIT(16)
-
 /**
  * dpu_intr_type - HW Interrupt Type
  * @DPU_IRQ_TYPE_WB_ROT_COMP:		WB rotator done
@@ -96,18 +89,6 @@ enum dpu_intr_type {
  */
 struct dpu_hw_intr_ops {
 	/**
-	 * set_mask - Programs the given interrupt register with the
-	 *            given interrupt mask. Register value will get overwritten.
-	 * @intr:	HW interrupt handle
-	 * @reg_off:	MDSS HW register offset
-	 * @irqmask:	IRQ mask value
-	 */
-	void (*set_mask)(
-			struct dpu_hw_intr *intr,
-			uint32_t reg,
-			uint32_t irqmask);
-
-	/**
 	 * irq_idx_lookup - Lookup IRQ index on the HW interrupt type
 	 *                 Used for all irq related ops
 	 * @intr_type:		Interrupt type defined in dpu_intr_type
@@ -177,16 +158,6 @@ struct dpu_hw_intr_ops {
 			struct dpu_hw_intr *intr);
 
 	/**
-	 * clear_interrupt_status - Clears HW interrupt status based on given
-	 *                          lookup IRQ index.
-	 * @intr:	HW interrupt handle
-	 * @irq_idx:	Lookup irq index return from irq_idx_lookup
-	 */
-	void (*clear_interrupt_status)(
-			struct dpu_hw_intr *intr,
-			int irq_idx);
-
-	/**
 	 * clear_intr_status_nolock() - clears the HW interrupts without lock
 	 * @intr:	HW interrupt handle
 	 * @irq_idx:	Lookup irq index return from irq_idx_lookup
@@ -206,21 +177,6 @@ struct dpu_hw_intr_ops {
 			struct dpu_hw_intr *intr,
 			int irq_idx,
 			bool clear);
-
-	/**
-	 * get_valid_interrupts - Gets a mask of all valid interrupt sources
-	 *                        within DPU. These are actually status bits
-	 *                        within interrupt registers that specify the
-	 *                        source of the interrupt in IRQs. For example,
-	 *                        valid interrupt sources can be MDP, DSI,
-	 *                        HDMI etc.
-	 * @intr:	HW interrupt handle
-	 * @mask:	Returning the interrupt source MASK
-	 * @return:	0 for success, otherwise failure
-	 */
-	int (*get_valid_interrupts)(
-			struct dpu_hw_intr *intr,
-			uint32_t *mask);
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

