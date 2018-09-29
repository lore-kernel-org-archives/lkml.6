Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7833C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DD92084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DD92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeI2N5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:57:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59264 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeI2N5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:57:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A7C0320007E;
        Sat, 29 Sep 2018 09:30:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 949AF200145;
        Sat, 29 Sep 2018 09:30:19 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DEEBC4031D;
        Sat, 29 Sep 2018 15:30:13 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 3/5] net: dpaa2: rename rtc as ptp in dpaa2-ptp driver
Date:   Sat, 29 Sep 2018 15:26:43 +0800
Message-Id: <20180929072645.20027-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180929072645.20027-1-yangbo.lu@nxp.com>
References: <20180929072645.20027-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dpaa2-ptp driver, it's odd to use rtc in names of
some functions and structures except for these dprtc
APIs. This patch is to use ptp instead of rtc in names.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added this patch.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c |   30 +++++++++++-----------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 2e90d5a..c73eef2 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -12,7 +12,7 @@
 #include "dpaa2-ptp.h"
 
 struct ptp_dpaa2_priv {
-	struct fsl_mc_device *rtc_mc_dev;
+	struct fsl_mc_device *ptp_mc_dev;
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
 	u32 freq_comp;
@@ -23,7 +23,7 @@ static int ptp_dpaa2_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 {
 	struct ptp_dpaa2_priv *ptp_dpaa2 =
 		container_of(ptp, struct ptp_dpaa2_priv, caps);
-	struct fsl_mc_device *mc_dev = ptp_dpaa2->rtc_mc_dev;
+	struct fsl_mc_device *mc_dev = ptp_dpaa2->ptp_mc_dev;
 	struct device *dev = &mc_dev->dev;
 	u64 adj;
 	u32 diff, tmr_add;
@@ -53,7 +53,7 @@ static int ptp_dpaa2_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct ptp_dpaa2_priv *ptp_dpaa2 =
 		container_of(ptp, struct ptp_dpaa2_priv, caps);
-	struct fsl_mc_device *mc_dev = ptp_dpaa2->rtc_mc_dev;
+	struct fsl_mc_device *mc_dev = ptp_dpaa2->ptp_mc_dev;
 	struct device *dev = &mc_dev->dev;
 	s64 now;
 	int err = 0;
@@ -78,7 +78,7 @@ static int ptp_dpaa2_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct ptp_dpaa2_priv *ptp_dpaa2 =
 		container_of(ptp, struct ptp_dpaa2_priv, caps);
-	struct fsl_mc_device *mc_dev = ptp_dpaa2->rtc_mc_dev;
+	struct fsl_mc_device *mc_dev = ptp_dpaa2->ptp_mc_dev;
 	struct device *dev = &mc_dev->dev;
 	u64 ns;
 	u32 remainder;
@@ -100,7 +100,7 @@ static int ptp_dpaa2_settime(struct ptp_clock_info *ptp,
 {
 	struct ptp_dpaa2_priv *ptp_dpaa2 =
 		container_of(ptp, struct ptp_dpaa2_priv, caps);
-	struct fsl_mc_device *mc_dev = ptp_dpaa2->rtc_mc_dev;
+	struct fsl_mc_device *mc_dev = ptp_dpaa2->ptp_mc_dev;
 	struct device *dev = &mc_dev->dev;
 	u64 ns;
 	int err = 0;
@@ -129,7 +129,7 @@ static int ptp_dpaa2_settime(struct ptp_clock_info *ptp,
 	.settime64	= ptp_dpaa2_settime,
 };
 
-static int rtc_probe(struct fsl_mc_device *mc_dev)
+static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 {
 	struct device *dev = &mc_dev->dev;
 	struct ptp_dpaa2_priv *ptp_dpaa2;
@@ -153,7 +153,7 @@ static int rtc_probe(struct fsl_mc_device *mc_dev)
 		goto err_free_mcp;
 	}
 
-	ptp_dpaa2->rtc_mc_dev = mc_dev;
+	ptp_dpaa2->ptp_mc_dev = mc_dev;
 
 	err = dprtc_get_freq_compensation(mc_dev->mc_io, 0,
 					  mc_dev->mc_handle, &tmr_add);
@@ -187,7 +187,7 @@ static int rtc_probe(struct fsl_mc_device *mc_dev)
 	return err;
 }
 
-static int rtc_remove(struct fsl_mc_device *mc_dev)
+static int dpaa2_ptp_remove(struct fsl_mc_device *mc_dev)
 {
 	struct ptp_dpaa2_priv *ptp_dpaa2;
 	struct device *dev = &mc_dev->dev;
@@ -204,26 +204,26 @@ static int rtc_remove(struct fsl_mc_device *mc_dev)
 	return 0;
 }
 
-static const struct fsl_mc_device_id rtc_match_id_table[] = {
+static const struct fsl_mc_device_id dpaa2_ptp_match_id_table[] = {
 	{
 		.vendor = FSL_MC_VENDOR_FREESCALE,
 		.obj_type = "dprtc",
 	},
 	{}
 };
-MODULE_DEVICE_TABLE(fslmc, rtc_match_id_table);
+MODULE_DEVICE_TABLE(fslmc, dpaa2_ptp_match_id_table);
 
-static struct fsl_mc_driver rtc_drv = {
+static struct fsl_mc_driver dpaa2_ptp_drv = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.owner = THIS_MODULE,
 	},
-	.probe = rtc_probe,
-	.remove = rtc_remove,
-	.match_id_table = rtc_match_id_table,
+	.probe = dpaa2_ptp_probe,
+	.remove = dpaa2_ptp_remove,
+	.match_id_table = dpaa2_ptp_match_id_table,
 };
 
-module_fsl_mc_driver(rtc_drv);
+module_fsl_mc_driver(dpaa2_ptp_drv);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DPAA2 PTP Clock Driver");
-- 
1.7.1

