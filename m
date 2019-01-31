Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB71C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52632086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfAaRVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:21:36 -0500
Received: from 36-231-44-189.dynamic-ip.hinet.net ([36.231.44.189]:40666 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbfAaRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:21:36 -0500
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 12:21:35 EST
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 2FB1EC12EE;
        Fri,  1 Feb 2019 01:13:16 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: xhci: pci: Enable Intel USB role mux on GLK platforms
Date:   Fri,  1 Feb 2019 01:13:12 +0800
Message-Id: <20190131171312.16955-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like Apollo Lake, Gemini Lake support DRD in port 0, this patch
enables the DRD support for GLK based on the EDS rev 2.2 vol #1
of section 3.8 of USB Controller.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a9ec7051f286..49b438a3ccd4 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -41,6 +41,7 @@
 #define PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI		0x1aa8
 #define PCI_DEVICE_ID_INTEL_APL_XHCI			0x5aa8
 #define PCI_DEVICE_ID_INTEL_DNV_XHCI			0x19d0
+#define PCI_DEVICE_ID_INTEL_GLK_XHCI			0x31a8
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI	0x15b6
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_XHCI	0x15db
@@ -194,7 +195,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_GLK_XHCI))
 		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
-- 
2.18.1

