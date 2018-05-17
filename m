Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeEQDsl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 23:48:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50262 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751379AbeEQDsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 23:48:39 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <doshir@vmware.com>, <pv-drivers@vmware.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] vmxnet3: Replace msleep(1) with usleep_range()
Date: Thu, 17 May 2018 11:46:41 +0800
Message-ID: <20180517034641.30004-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented in Documentation/timers/timers-howto.txt,
replace msleep(1) with usleep_range().

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c     | 6 +++---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 9ebe2a6..2234a33 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2945,7 +2945,7 @@ vmxnet3_close(struct net_device *netdev)
 	 * completion.
 	 */
 	while (test_and_set_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state))
-		msleep(1);
+		usleep_range(1000, 2000);
 
 	vmxnet3_quiesce_dev(adapter);
 
@@ -2995,7 +2995,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	 * completion.
 	 */
 	while (test_and_set_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state))
-		msleep(1);
+		usleep_range(1000, 2000);
 
 	if (netif_running(netdev)) {
 		vmxnet3_quiesce_dev(adapter);
@@ -3567,7 +3567,7 @@ static void vmxnet3_shutdown_device(struct pci_dev *pdev)
 	 * completion.
 	 */
 	while (test_and_set_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state))
-		msleep(1);
+		usleep_range(1000, 2000);
 
 	if (test_and_set_bit(VMXNET3_STATE_BIT_QUIESCED,
 			     &adapter->state)) {
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 2ff2731..559db05 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -600,7 +600,7 @@ vmxnet3_set_ringparam(struct net_device *netdev,
 	 * completion.
 	 */
 	while (test_and_set_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state))
-		msleep(1);
+		usleep_range(1000, 2000);
 
 	if (netif_running(netdev)) {
 		vmxnet3_quiesce_dev(adapter);
-- 
2.7.0
