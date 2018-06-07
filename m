Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6LNHEnBDGVsXCAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 31FC6608BA; Thu,  7 Jun 2018 14:40:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9B177607DC;
	Thu,  7 Jun 2018 14:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B177607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934575AbeFGOkv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40567 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934559AbeFGOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:49 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbr-0005Zq-Iu; Thu, 07 Jun 2018 15:09:51 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002q4-RH; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Alexandra Yates" <alexandra.yates@linux.intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.349774425@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 110/410] ahci: Order SATA device IDs for codename
 Lewisburg
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandra Yates <alexandra.yates@linux.intel.com>

commit 4d92f0099a06ef0e36c7673f7c090f1a448b2d1b upstream.

This change was to preserve the ascending order of device IDs.
There was an exception with the first two Lewisburg device IDs to
keep all device IDs of the same kind grouped by code name.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/ahci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -332,16 +332,6 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
@@ -374,6 +364,16 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci }, /* Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci }, /* Lewisburg RAID*/
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
