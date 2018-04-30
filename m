Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeD3FtM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 01:49:12 -0400
Received: from david.siemens.de ([192.35.17.14]:41471 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbeD3FtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 01:49:09 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/10] PCI: Enable PCI_DOMAINS along with generic PCI host controller
Date: Mon, 30 Apr 2018 07:48:44 +0200
Message-Id: <5122e6157951cff6fc2436dcd19d51c5b6b0a353.1525067324.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This controller is often instantiated by hypervisors, and they may add
multiple of them or add them in addition to a physical host controller
like the Jailhouse hypervisor is doing. Therefore allow for multiple
domains so that we can handle them all.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..3d25b35bb5ab 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -68,6 +68,7 @@ config PCI_HOST_GENERIC
 	depends on (ARM || ARM64) && OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
+	select PCI_DOMAINS
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
-- 
2.13.6
