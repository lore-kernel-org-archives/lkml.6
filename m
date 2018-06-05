Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeFEG1E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:27:04 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37769 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeFEG1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:27:00 -0400
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 1/3] Documentation: dt: keystone: ti-sci: Add optional host-id parameter
Date: Tue, 5 Jun 2018 01:26:38 -0500
Message-ID: <20180605062640.3356-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605062640.3356-1-nm@ti.com>
References: <20180605062640.3356-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instrument's System Control Interface (TISCI) permits the
ability for Operating Systems to running in virtual machines to be
able to independently communicate with the firmware without the need
going through an hypervisor.

The "host-id" in effect is the hardware representation of the
host (example: VMs locked to a core) as identified to the System
Controller.

This is introduced as an optional parameter to maintain consistency
with legacy device tree blobs.

We call this with a vendor prefix to prevent any possible confusion
with SCSI ID (m68k) kernel option.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index 31f5f9a104cc..b56a02c10ae6 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -45,11 +45,15 @@ Optional Properties:
 	debug_messages - Map the Debug message region
 - reg:  register space corresponding to the debug_messages
 - ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
+- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
+	for identification of host processing entities such as virtual
+	machines
 
 Example (K2G):
 -------------
 	pmmc: pmmc {
 		compatible = "ti,k2g-sci";
+		ti,host-id = <2>;
 		mbox-names = "rx", "tx";
 		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
 			<&msgmgr &msgmgr_proxy_pmmc_tx>;
-- 
2.15.1
