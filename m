Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5FFC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4625208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4625208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbeG0Nrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:47:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59916 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbeG0Nr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:47:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9545A200070;
        Fri, 27 Jul 2018 14:25:45 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5865D20001F;
        Fri, 27 Jul 2018 14:25:45 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id C50DB40A6B;
        Fri, 27 Jul 2018 05:25:44 -0700 (MST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6RCPbJr006998;
        Fri, 27 Jul 2018 05:25:43 -0700
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, ruxandra.radulescu@nxp.com,
        devel@driverdev.osuosl.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/2] staging: fsl-dpaa2/ethsw: document nested structs as per kernel-doc
Date:   Fri, 27 Jul 2018 15:24:47 +0300
Message-Id: <c7ae0159c9b32b80958bdf3863d5b5416e2c1b4e.1532687535.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1532687535.git.ioana.ciornei@nxp.com>
References: <cover.1532687535.git.ioana.ciornei@nxp.com>
In-Reply-To: <cover.1532687535.git.ioana.ciornei@nxp.com>
References: <cover.1532687535.git.ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nested structs per kernel-doc requirements by moving
all comments before the actual struct.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 82f80c40..db43fa3 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -79,24 +79,21 @@ enum dpsw_component_type {
  * struct dpsw_cfg - DPSW configuration
  * @num_ifs: Number of external and internal interfaces
  * @adv: Advanced parameters; default is all zeros;
- *		 use this structure to change default settings
+ *	 use this structure to change default settings
+ * @adv.options: Enable/Disable DPSW features (bitmap)
+ * @adv.max_vlans: Maximum Number of VLAN's; 0 - indicates default 16
+ * @adv.max_meters_per_if: Number of meters per interface
+ * @adv.max_fdbs: Maximum Number of FDB's; 0 - indicates default 16
+ * @adv.max_fdb_entries: Number of FDB entries for default FDB table;
+ *	0 - indicates default 1024 entries.
+ * @adv.fdb_aging_time: Default FDB aging time for default FDB table;
+ *	0 - indicates default 300 seconds
+ * @adv.max_fdb_mc_groups: Number of multicast groups in each FDB table;
+ *	0 - indicates default 32
+ * @adv.component_type: Indicates the component type of this bridge
  */
 struct dpsw_cfg {
 	u16 num_ifs;
-	/**
-	 * struct adv - Advanced parameters
-	 * @options: Enable/Disable DPSW features (bitmap)
-	 * @max_vlans: Maximum Number of VLAN's; 0 - indicates default 16
-	 * @max_meters_per_if: Number of meters per interface
-	 * @max_fdbs: Maximum Number of FDB's; 0 - indicates default 16
-	 * @max_fdb_entries: Number of FDB entries for default FDB table;
-	 *			0 - indicates default 1024 entries.
-	 * @fdb_aging_time: Default FDB aging time for default FDB table;
-	 *			0 - indicates default 300 seconds
-	 * @max_fdb_mc_groups: Number of multicast groups in each FDB table;
-	 *			0 - indicates default 32
-	 * @component_type: Indicates the component type of this bridge
-	 */
 	struct {
 		u64 options;
 		u16 max_vlans;
-- 
1.9.1

