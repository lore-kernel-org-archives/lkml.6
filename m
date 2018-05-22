Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeEVQSP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:18:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeEVQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:18:14 -0400
From: Colin King <colin.king@canonical.com>
To: Jon Mason <jdmason@kudzu.us>, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] net: vxge: fix spelling mistake in macro VXGE_HW_ERR_PRIVILAGED_OPEARATION
Date: Tue, 22 May 2018 17:18:09 +0100
Message-Id: <20180522161809.30299-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Rename VXGE_HW_ERR_PRIVILAGED_OPEARATION to VXGE_HW_ERR_PRIVILEGED_OPERATION
to fix spelling mistake.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: PRIVILAGED -> PRIVILEGED, thanks to Edward Cree for spotting that mistake

---
 drivers/net/ethernet/neterion/vxge/vxge-config.c  | 12 ++++++------
 drivers/net/ethernet/neterion/vxge/vxge-config.h  |  2 +-
 drivers/net/ethernet/neterion/vxge/vxge-ethtool.c |  2 +-
 drivers/net/ethernet/neterion/vxge/vxge-main.c    |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 6223930a8155..8656fcc9f2a0 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -693,7 +693,7 @@ __vxge_hw_device_is_privilaged(u32 host_type, u32 func_id)
 		VXGE_HW_DEVICE_ACCESS_RIGHT_MRPCIM)
 		return VXGE_HW_OK;
 	else
-		return VXGE_HW_ERR_PRIVILAGED_OPEARATION;
+		return VXGE_HW_ERR_PRIVILEGED_OPERATION;
 }
 
 /*
@@ -1920,7 +1920,7 @@ enum vxge_hw_status vxge_hw_device_getpause_data(struct __vxge_hw_device *hldev,
 	}
 
 	if (!(hldev->access_rights & VXGE_HW_DEVICE_ACCESS_RIGHT_MRPCIM)) {
-		status = VXGE_HW_ERR_PRIVILAGED_OPEARATION;
+		status = VXGE_HW_ERR_PRIVILEGED_OPERATION;
 		goto exit;
 	}
 
@@ -3153,7 +3153,7 @@ vxge_hw_mgmt_reg_read(struct __vxge_hw_device *hldev,
 	case vxge_hw_mgmt_reg_type_mrpcim:
 		if (!(hldev->access_rights &
 			VXGE_HW_DEVICE_ACCESS_RIGHT_MRPCIM)) {
-			status = VXGE_HW_ERR_PRIVILAGED_OPEARATION;
+			status = VXGE_HW_ERR_PRIVILEGED_OPERATION;
 			break;
 		}
 		if (offset > sizeof(struct vxge_hw_mrpcim_reg) - 8) {
@@ -3165,7 +3165,7 @@ vxge_hw_mgmt_reg_read(struct __vxge_hw_device *hldev,
 	case vxge_hw_mgmt_reg_type_srpcim:
 		if (!(hldev->access_rights &
 			VXGE_HW_DEVICE_ACCESS_RIGHT_SRPCIM)) {
-			status = VXGE_HW_ERR_PRIVILAGED_OPEARATION;
+			status = VXGE_HW_ERR_PRIVILEGED_OPERATION;
 			break;
 		}
 		if (index > VXGE_HW_TITAN_SRPCIM_REG_SPACES - 1) {
@@ -3279,7 +3279,7 @@ vxge_hw_mgmt_reg_write(struct __vxge_hw_device *hldev,
 	case vxge_hw_mgmt_reg_type_mrpcim:
 		if (!(hldev->access_rights &
 			VXGE_HW_DEVICE_ACCESS_RIGHT_MRPCIM)) {
-			status = VXGE_HW_ERR_PRIVILAGED_OPEARATION;
+			status = VXGE_HW_ERR_PRIVILEGED_OPERATION;
 			break;
 		}
 		if (offset > sizeof(struct vxge_hw_mrpcim_reg) - 8) {
@@ -3291,7 +3291,7 @@ vxge_hw_mgmt_reg_write(struct __vxge_hw_device *hldev,
 	case vxge_hw_mgmt_reg_type_srpcim:
 		if (!(hldev->access_rights &
 			VXGE_HW_DEVICE_ACCESS_RIGHT_SRPCIM)) {
-			status = VXGE_HW_ERR_PRIVILAGED_OPEARATION;
+			status = VXGE_HW_ERR_PRIVILEGED_OPERATION;
 			break;
 		}
 		if (index > VXGE_HW_TITAN_SRPCIM_REG_SPACES - 1) {
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.h b/drivers/net/ethernet/neterion/vxge/vxge-config.h
index cfa970417f81..5ebdbfedc269 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.h
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.h
@@ -127,7 +127,7 @@ enum vxge_hw_status {
 	VXGE_HW_ERR_INVALID_TCODE 		  = VXGE_HW_BASE_ERR + 14,
 	VXGE_HW_ERR_INVALID_BLOCK_SIZE		  = VXGE_HW_BASE_ERR + 15,
 	VXGE_HW_ERR_INVALID_STATE		  = VXGE_HW_BASE_ERR + 16,
-	VXGE_HW_ERR_PRIVILAGED_OPEARATION	  = VXGE_HW_BASE_ERR + 17,
+	VXGE_HW_ERR_PRIVILEGED_OPERATION	  = VXGE_HW_BASE_ERR + 17,
 	VXGE_HW_ERR_INVALID_PORT 		  = VXGE_HW_BASE_ERR + 18,
 	VXGE_HW_ERR_FIFO		 	  = VXGE_HW_BASE_ERR + 19,
 	VXGE_HW_ERR_VPATH			  = VXGE_HW_BASE_ERR + 20,
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c b/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c
index 0452848d1316..2f1bde500420 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-ethtool.c
@@ -276,7 +276,7 @@ static void vxge_get_ethtool_stats(struct net_device *dev,
 	*ptr++ = 0;
 	status = vxge_hw_device_xmac_stats_get(hldev, xmac_stats);
 	if (status != VXGE_HW_OK) {
-		if (status != VXGE_HW_ERR_PRIVILAGED_OPEARATION) {
+		if (status != VXGE_HW_ERR_PRIVILEGED_OPERATION) {
 			vxge_debug_init(VXGE_ERR,
 				"%s : %d Failure in getting xmac stats",
 				__func__, __LINE__);
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
index b2299f2b2155..64fa94f8b471 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
@@ -3484,11 +3484,11 @@ static int vxge_device_register(struct __vxge_hw_device *hldev,
 				0,
 				&stat);
 
-	if (status == VXGE_HW_ERR_PRIVILAGED_OPEARATION)
+	if (status == VXGE_HW_ERR_PRIVILEGED_OPERATION)
 		vxge_debug_init(
 			vxge_hw_device_trace_level_get(hldev),
 			"%s: device stats clear returns"
-			"VXGE_HW_ERR_PRIVILAGED_OPEARATION", ndev->name);
+			"VXGE_HW_ERR_PRIVILEGED_OPERATION", ndev->name);
 
 	vxge_debug_entryexit(vxge_hw_device_trace_level_get(hldev),
 		"%s: %s:%d  Exiting...",
-- 
2.17.0
