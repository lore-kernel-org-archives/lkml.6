Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FDEAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDA7208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDA7208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbeFNKsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:48:45 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46749 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964804AbeFNKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:48:42 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 599D72000C;
        Thu, 14 Jun 2018 10:48:46 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc:     linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND 3/6] iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code
Date:   Thu, 14 Jun 2018 12:48:23 +0200
Message-Id: <1528973306-7962-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

Support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) IPMMUs by sharing
feature flags with r8a7795 (R-Car H3) and r8a7796 (R-Car M3-W). Also update
IOMMU_OF_DECLARE to hook up the compat strings.

Based on work for the r8a7796 by Magnus Damm

[rebased on v4.17]
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 04c8015..933a3da 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -763,6 +763,8 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
+	{ .soc_id = "r8a77970", },
+	{ .soc_id = "r8a77995", },
 	{ /* sentinel */ }
 };
 
@@ -943,6 +945,12 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.compatible = "renesas,ipmmu-r8a7796",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
+		.compatible = "renesas,ipmmu-r8a77970",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a77995",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
 		/* Terminator */
 	},
 };
@@ -1119,6 +1127,8 @@ module_exit(ipmmu_exit);
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
 IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
 IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796");
+IOMMU_OF_DECLARE(ipmmu_r8a77970_iommu_of, "renesas,ipmmu-r8a77970");
+IOMMU_OF_DECLARE(ipmmu_r8a77995_iommu_of, "renesas,ipmmu-r8a77995");
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
-- 
2.7.4

