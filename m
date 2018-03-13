Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeCMLxl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:53:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933217AbeCMLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:52:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: tegra: add MSI dependency
Date: Tue, 13 Mar 2018 12:52:05 +0100
Message-Id: <20180313115218.2246372-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:cSaM6c3zLVUmhnkNvqteFkaZRFZszFy0XdCG0oDakvYBb7OkGEK
 1eN/oIgfK/Y94e4vLwuFOSKEF8c+TYBQMZerIVXmCuQg5+XmEr9nHlyDQ0cRrimDHy1nIUw
 q13kfwEFa0lJ5m3HYg2yFM0cRRPop9TuZp5XkoVSXDdJ9ZV9xfv21/6r88b3YcWXYjXIP/o
 +gwmAudW0yliNPWIbuzZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h3OKVbByFmc=:8CNfB9hk/0DHwmngC5ZEHS
 I89RMYRO5iK2lTUvdrrN6HXmbBCFJhHWGv6kUaF112EKwvKwYPCSqdOL14zvvs4I5EdKQ3oCk
 y/X8aUvLfdylCALIJiCC8VSrYRpOXselAxgsjJNGZr2/wT21S56SRX16oS8UjaK2J6AHM0iWR
 zf2huJRJ6yx/mfCI8kmtRdh9sifU4gZpn8H6obhWzaDM2xbe5uYsi3m8Tx1Pl3fPMOKVpU9ac
 SvH8lo0maxb+ApTavTJzUC+OpKPNDcD9srcGaPCuNDoyi2qnfb25jgCLsMlgyjH8+omks009L
 tx8QA0naBVTX++jPY9aRZXXTMbm02vkQzA2zDKNQ9EWwj7DBLCUCy6ZKS30BUFrq+e8OkQ4nI
 5jGj3rHyrvhhrfD7rpJ4N6Pwhf+e4z/gX0+kEatuesUvRO46dyaPhvXvzltypaHUL8QEuQb7U
 dxJA00hlZrQPDn1oI3ek+KcCyDJKLgIwSw09+g3FMEUEZYCkpbmm99RtSxIBGBR2xZjtRxIHd
 +MpbG6tyzUM0QQ1eq4UcxqPs7ppqH1UYxngglqowk5gyHNraN+57po4eIQA2U5VxOfDa4Mdci
 3o4CwIfOMNBqfSB+Ylo41fZUm8Us+dGVGFOZppSb1K3cAHHrIuJd477jOl/jFwkIWOBPDh1CF
 Mw0WL4qZVGn2X2tdV3RX6SCM2UnHKp7Y50O5b5etzwcrGbSvd/3vOtMPbyax9+mRpoYArM4Hk
 1yzEUei+09rUqAvAN4yX4GubW95Sae5weY7wpg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the tegra PCIe host driver without MSI results in a link
failure:

drivers/pci/host/pci-tegra.o:(.data+0x70): undefined reference to `pci_msi_unmask_irq'
drivers/pci/host/pci-tegra.o:(.data+0x74): undefined reference to `pci_msi_mask_irq'

This adds the same dependency that everyone else uses.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1fcdc890acc7..65b4afb8d11d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -38,6 +38,7 @@ config PCI_FTPCI100
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA && MMU
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
-- 
2.9.0
