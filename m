Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034947AbeE1PtU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:49:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034934AbeE1PtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:49:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kiszka <jan.kiszka@siemens.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: versatile: include pci.h
Date: Mon, 28 May 2018 17:48:39 +0200
Message-Id: <20180528154850.2647019-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:2NFFx52rilNFoShuK3Xv7WX/vDmXoLi0tmd3BsUAQ9IfL8opXIo
 87hlYGNCSQ8Mi/UyR7bIadfeInokg9p2YvWDcb1GpKQHsVApiq1kj6R/UJHNppckS7Jctqd
 a0Ae1f3aDQNTFTQeUdilxQbI9t/zZN/Y+tmx3KeOdL21Dj7Mh1vhs7LgIoZTcOrNoAJzIs7
 AnobjB9ncCx4rySPor5uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ASY1+DLFZeY=:6vCDnhnHtKlqsiiHDwzcK8
 3UUt341VUTnYi7z73x50JczsIdIE51lNxMkIVtWrGV9Ocd5uHlMPKlwtTcwaOpq1ShXyrdkgb
 mv14/wKANFOeBtULLYqg8l9LqsqM5Hs7UVKp8Ac4lHC5thlpPhXM3KX5DvS6icQctC1VRu7Yr
 gTFGju0BNLerLlwsZRCAipfZz8c/qXM6gw6/ErtVQdYWH6+D3aNzn9eGl/DhauHWrHX+9yehm
 +8uEnIfDRiEG9CA6KGNRczXDvhwY6kJMP1YbhjiwDru7IGLFlwvakKhi5HWfcqHLeGclO3n5a
 z+mMIXkFMR4EPPmvn7oE+ildgOu7ZYFU43GnpydQVxHKOKgFVGO4OKmE1LT9FrxJPN7sVCOF0
 SbiXKxIr4VtDAdo0R7MnuqoP6Qb7dXGSJIEO/lCHKDEzt7iAqAE+tMfDaJ99z96tBSKRMNvqo
 ZRuhPL+w4KJN2sAkkFPVfKxc9aVW3UC0UGRGY96T4hY0D7ahLyTV7AwexI1CYRpy9ZAq8KH1c
 tuDVvSDZL0Ifkeujvew8AhZ9vJ+d9AZiSf5Ej++1d0Kr184+37Z1Ogp4o3T+nssvMAVpdZByN
 oXpd5ydqzacJf1hYPZbZ71uAk1lAMNbx20OOk8/niJztwgwlv1NilmdOUpkgwhresr4vVURYh
 iIUXFo3is31hM+z5RiAGxfSobOx62QA6PugXGqXLVkEa0fiN0XtqLJRY+gUhM/T3omL0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches for PCI host drivers clashed recently, leading to a broken
build for versatile-pci:

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_parse_request_of_pci_ranges':
drivers/pci/host/pci-versatile.c:70:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]

This adds the missing header inclusion that became necessary now.

Fixes: 9e2aee80c78d ("PCI: Move private DT related functions into private header")
Fixes: 64720fd1f630 ("PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-versatile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index ff2cd12b3978..994f32061b32 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
+
 static void __iomem *versatile_pci_base;
 static void __iomem *versatile_cfg_base[2];
 
-- 
2.9.0
