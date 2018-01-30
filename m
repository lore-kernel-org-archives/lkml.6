Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeA3VFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:05:15 -0500
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:59022 "EHLO
        2.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753371AbeA3VFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:05:10 -0500
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v6 03/11] PCI: generic: fix missing call of pci_free_resource_list()
Date: Tue, 30 Jan 2018 21:56:51 +0100
Message-Id: <19fc2c448cf8f19c47225450a375af657bd2c61a.1517343502.git.cyrille.pitchen@free-electrons.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
X-Ovh-Tracer-Id: 15879692289597134849
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 25
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrtddtgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucgotffhvedqqdfjughrqdfuuhhsphgvtghtqdhlohifucdlhedmnegotffhvedqqdfjughrqdfuuhhsphgvtghtucdlvddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call pci_free_resource_list() from pci_host_common_probe() when probing
fails, as done inside gen_pci_init() when this later function fails.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/host/pci-host-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index efd904d93562..10e3f5b39499 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -110,6 +110,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0) {
 		dev_err(dev, "Scanning root bridge failed");
+		pci_free_resource_list(&resources);
 		return ret;
 	}
 
-- 
2.11.0
