Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCKQzu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:55:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbeCKQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:55:48 -0400
From: Colin King <colin.king@canonical.com>
To: Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] lan743x: make functions lan743x_csr_read and lan743x_csr_read static
Date: Sun, 11 Mar 2018 17:55:47 +0100
Message-Id: <20180311165547.27500-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Functions lan743x_csr_read and lan743x_csr_read are local to the source
and do not need to be in global scope, so make them static.

Cleans up sparse warning:
drivers/net/ethernet/microchip/lan743x_main.c:56:5: warning: symbol
lan743x_csr_read' was not declared. Should it be static?
drivers/net/ethernet/microchip/lan743x_main.c:61:6: warning: symbol
'lan743x_csr_write' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 73ce3ee6a520..dd947e4dd3ce 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -53,12 +53,13 @@ static int lan743x_pci_init(struct lan743x_adapter *adapter,
 	return ret;
 }
 
-u32 lan743x_csr_read(struct lan743x_adapter *adapter, int offset)
+static u32 lan743x_csr_read(struct lan743x_adapter *adapter, int offset)
 {
 	return ioread32(&adapter->csr.csr_address[offset]);
 }
 
-void lan743x_csr_write(struct lan743x_adapter *adapter, int offset, u32 data)
+static void lan743x_csr_write(struct lan743x_adapter *adapter, int offset,
+			      u32 data)
 {
 	iowrite32(data, &adapter->csr.csr_address[offset]);
 }
-- 
2.15.1
