Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeB0XT5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:19:57 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.100]:22974 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751779AbeB0XT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:19:56 -0500
Date: Tue, 27 Feb 2018 17:19:52 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PCI/ASPM: Change type of threshold_ns variable to u32
Message-ID: <20180227231952.GA9001@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.175.32
X-Source-L: No
X-Exim-ID: 1eqoXK-001Bxn-M1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.175.32]:55808
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the expression threshold_us * 1000 will never exceed the
32-bit limits [1]. So changing the type of threshold_ns from u64 to u32
seems sensible [2].

[1] https://marc.info/?l=linux-kernel&m=151855021100725&w=2
[2] https://marc.info/?l=linux-kernel&m=151976318924615&w=2

Addresses-Coverity-ID: 1462501
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 57feef2..8633fc4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -322,7 +322,7 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 
 static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 {
-	u64 threshold_ns = threshold_us * 1000;
+	u32 threshold_ns = threshold_us * 1000;
 
 	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
 	if (threshold_ns < 32) {
-- 
2.7.4
