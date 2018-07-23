Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2760420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2760420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeGWEFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:05:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42660 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeGWEFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:05:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB6E51A0063;
        Mon, 23 Jul 2018 05:06:36 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A16E1A000B;
        Mon, 23 Jul 2018 05:06:36 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id CFE4040C72;
        Sun, 22 Jul 2018 20:06:35 -0700 (MST)
Received: from mega.am.freescale.net ([10.192.208.232])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6N36WSe017523;
        Sun, 22 Jul 2018 20:06:32 -0700
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradeadorg,
        ran.wang_1@nxp.com, pengbo.mu@nxp.com
Subject: [PATCH v6 1/4] usb: dwc3: add global soc bus configuration reg0
Date:   Mon, 23 Jul 2018 11:06:21 +0800
Message-Id: <1532315184-22985-1-git-send-email-pengbo.mu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the macro definition for global soc bus configuration
register 0

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v6:
 - delete some register unrelated
Changes in v5:
 - no change
Changes in v4:
 - no change
Changes in v3:
 - no change
Changes in v2:
 - split the patch
 - add more macro definition for soc bus configuration register
---
 drivers/usb/dwc3/core.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0e..213b939 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -163,6 +163,17 @@
 
 /* Bit fields */
 
+/* Global SoC Bus Configuration INCRx Register 0 */
+#define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
+#define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
+#define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
+#define DWC3_GSBUSCFG0_INCR32BRSTENA	(1 << 4) /* INCR32 burst */
+#define DWC3_GSBUSCFG0_INCR16BRSTENA	(1 << 3) /* INCR16 burst */
+#define DWC3_GSBUSCFG0_INCR8BRSTENA	(1 << 2) /* INCR8 burst */
+#define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
+#define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
+#define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
+
 /* Global Debug Queue/FIFO Space Available Register */
 #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
-- 
2.7.4

