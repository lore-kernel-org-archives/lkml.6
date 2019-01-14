Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF9E2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANPPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:15:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48444 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfANPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:15:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gj3xM-0001Vh-Tb; Mon, 14 Jan 2019 15:15:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        everest-linux-l2@cavium.com, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bnx2x: fix various indentation issues
Date:   Mon, 14 Jan 2019 15:15:16 +0000
Message-Id: <20190114151516.17744-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are lines that have indentation issues, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_init.h  |   2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 176 +++++++++---------
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |   2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_sp.c    |  12 +-
 4 files changed, 94 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h
index 46ee2c01f4c5..066765fbef06 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h
@@ -449,7 +449,7 @@ static inline void bnx2x_init_fw_wrr(const struct cmng_init_input *input_data,
 				ccd[cos] =
 				    (u32)input_data->cos_min_rate[cos] * 100 *
 				    (T_FAIR_COEF / (8 * 100 * cosWeightSum));
-				 if (ccd[cos] < pdata->fair_vars.fair_threshold
+				if (ccd[cos] < pdata->fair_vars.fair_threshold
 						+ MIN_ABOVE_THRESH) {
 					ccd[cos] =
 					    pdata->fair_vars.fair_threshold +
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 98d4c5a3ff21..7852654c7593 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -837,49 +837,45 @@ static int bnx2x_ets_e3b0_set_cos_bw(struct bnx2x *bp,
 
 	switch (cos_entry) {
 	case 0:
-	    nig_reg_adress_crd_weight =
-		 (port) ? NIG_REG_P1_TX_ARB_CREDIT_WEIGHT_0 :
-		     NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_0;
-	     pbf_reg_adress_crd_weight = (port) ?
-		 PBF_REG_COS0_WEIGHT_P1 : PBF_REG_COS0_WEIGHT_P0;
-	     break;
+		nig_reg_adress_crd_weight =
+			(port) ? NIG_REG_P1_TX_ARB_CREDIT_WEIGHT_0 :
+			NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_0;
+		pbf_reg_adress_crd_weight = (port) ?
+		    PBF_REG_COS0_WEIGHT_P1 : PBF_REG_COS0_WEIGHT_P0;
+		break;
 	case 1:
-	     nig_reg_adress_crd_weight = (port) ?
-		 NIG_REG_P1_TX_ARB_CREDIT_WEIGHT_1 :
-		 NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_1;
-	     pbf_reg_adress_crd_weight = (port) ?
-		 PBF_REG_COS1_WEIGHT_P1 : PBF_REG_COS1_WEIGHT_P0;
-	     break;
+		nig_reg_adress_crd_weight = (port) ?
+			NIG_REG_P1_TX_ARB_CREDIT_WEIGHT_1 :
+			NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_1;
+		pbf_reg_adress_crd_weight = (port) ?
+			PBF_REG_COS1_WEIGHT_P1 : PBF_REG_COS1_WEIGHT_P0;
+		break;
 	case 2:
-	     nig_reg_adress_crd_weight = (port) ?
-		 NIG_REG_P1_TX_ARB_CREDIT_WEIGHT_2 :
-		 NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_2;
+		nig_reg_adress_crd_weight = (port) ?
+			NIG_REG_P1_TX_ARB_CREDIT_WEIGHT_2 :
+			NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_2;
 
-		 pbf_reg_adress_crd_weight = (port) ?
-		     PBF_REG_COS2_WEIGHT_P1 : PBF_REG_COS2_WEIGHT_P0;
-	     break;
+		pbf_reg_adress_crd_weight = (port) ?
+			PBF_REG_COS2_WEIGHT_P1 : PBF_REG_COS2_WEIGHT_P0;
+		break;
 	case 3:
-	    if (port)
+		if (port)
 			return -EINVAL;
-	     nig_reg_adress_crd_weight =
-		 NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_3;
-	     pbf_reg_adress_crd_weight =
-		 PBF_REG_COS3_WEIGHT_P0;
-	     break;
+		nig_reg_adress_crd_weight = NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_3;
+		pbf_reg_adress_crd_weight = PBF_REG_COS3_WEIGHT_P0;
+		break;
 	case 4:
-	    if (port)
-		return -EINVAL;
-	     nig_reg_adress_crd_weight =
-		 NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_4;
-	     pbf_reg_adress_crd_weight = PBF_REG_COS4_WEIGHT_P0;
-	     break;
+		if (port)
+			return -EINVAL;
+		nig_reg_adress_crd_weight = NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_4;
+		pbf_reg_adress_crd_weight = PBF_REG_COS4_WEIGHT_P0;
+		break;
 	case 5:
-	    if (port)
-		return -EINVAL;
-	     nig_reg_adress_crd_weight =
-		 NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_5;
-	     pbf_reg_adress_crd_weight = PBF_REG_COS5_WEIGHT_P0;
-	     break;
+		if (port)
+			return -EINVAL;
+		nig_reg_adress_crd_weight = NIG_REG_P0_TX_ARB_CREDIT_WEIGHT_5;
+		pbf_reg_adress_crd_weight = PBF_REG_COS5_WEIGHT_P0;
+		break;
 	}
 
 	REG_WR(bp, nig_reg_adress_crd_weight, cos_bw_nig);
@@ -966,7 +962,7 @@ static int bnx2x_ets_e3b0_sp_pri_to_cos_set(const struct link_params *params,
 	if (pri >= max_num_of_cos) {
 		DP(NETIF_MSG_LINK, "bnx2x_ets_e3b0_sp_pri_to_cos_set invalid "
 		   "parameter Illegal strict priority\n");
-	    return -EINVAL;
+		return -EINVAL;
 	}
 
 	if (sp_pri_to_cos[pri] != DCBX_INVALID_COS) {
@@ -1845,28 +1841,28 @@ static int bnx2x_emac_enable(struct link_params *params,
 	bnx2x_bits_en(bp, emac_base + EMAC_REG_EMAC_TX_MODE,
 		      EMAC_TX_MODE_RESET);
 
-		/* pause enable/disable */
-		bnx2x_bits_dis(bp, emac_base + EMAC_REG_EMAC_RX_MODE,
-			       EMAC_RX_MODE_FLOW_EN);
+	/* pause enable/disable */
+	bnx2x_bits_dis(bp, emac_base + EMAC_REG_EMAC_RX_MODE,
+		       EMAC_RX_MODE_FLOW_EN);
 
-		bnx2x_bits_dis(bp,  emac_base + EMAC_REG_EMAC_TX_MODE,
-			       (EMAC_TX_MODE_EXT_PAUSE_EN |
-				EMAC_TX_MODE_FLOW_EN));
-		if (!(params->feature_config_flags &
-		      FEATURE_CONFIG_PFC_ENABLED)) {
-			if (vars->flow_ctrl & BNX2X_FLOW_CTRL_RX)
-				bnx2x_bits_en(bp, emac_base +
-					      EMAC_REG_EMAC_RX_MODE,
-					      EMAC_RX_MODE_FLOW_EN);
-
-			if (vars->flow_ctrl & BNX2X_FLOW_CTRL_TX)
-				bnx2x_bits_en(bp, emac_base +
-					      EMAC_REG_EMAC_TX_MODE,
-					      (EMAC_TX_MODE_EXT_PAUSE_EN |
-					       EMAC_TX_MODE_FLOW_EN));
-		} else
-			bnx2x_bits_en(bp, emac_base + EMAC_REG_EMAC_TX_MODE,
-				      EMAC_TX_MODE_FLOW_EN);
+	bnx2x_bits_dis(bp,  emac_base + EMAC_REG_EMAC_TX_MODE,
+		       (EMAC_TX_MODE_EXT_PAUSE_EN |
+			EMAC_TX_MODE_FLOW_EN));
+	if (!(params->feature_config_flags &
+	      FEATURE_CONFIG_PFC_ENABLED)) {
+		if (vars->flow_ctrl & BNX2X_FLOW_CTRL_RX)
+			bnx2x_bits_en(bp, emac_base +
+				      EMAC_REG_EMAC_RX_MODE,
+				      EMAC_RX_MODE_FLOW_EN);
+
+		if (vars->flow_ctrl & BNX2X_FLOW_CTRL_TX)
+			bnx2x_bits_en(bp, emac_base +
+				      EMAC_REG_EMAC_TX_MODE,
+				      (EMAC_TX_MODE_EXT_PAUSE_EN |
+				       EMAC_TX_MODE_FLOW_EN));
+	} else
+		bnx2x_bits_en(bp, emac_base + EMAC_REG_EMAC_TX_MODE,
+			      EMAC_TX_MODE_FLOW_EN);
 
 	/* KEEP_VLAN_TAG, promiscuous */
 	val = REG_RD(bp, emac_base + EMAC_REG_EMAC_RX_MODE);
@@ -6478,9 +6474,9 @@ int bnx2x_test_link(struct link_params *params, struct link_vars *vars,
 			  MDIO_REG_BANK_GP_STATUS,
 			  MDIO_GP_STATUS_TOP_AN_STATUS1,
 			  &gp_status);
-	/* Link is up only if both local phy and external phy are up */
-	if (!(gp_status & MDIO_GP_STATUS_TOP_AN_STATUS1_LINK_STATUS))
-		return -ESRCH;
+		/* Link is up only if both local phy and external phy are up */
+		if (!(gp_status & MDIO_GP_STATUS_TOP_AN_STATUS1_LINK_STATUS))
+			return -ESRCH;
 	}
 	/* In XGXS loopback mode, do not check external PHY */
 	if (params->loopback_mode == LOOPBACK_XGXS)
@@ -7293,8 +7289,8 @@ static int bnx2x_8073_xaui_wa(struct bnx2x *bp, struct bnx2x_phy *phy)
 					DP(NETIF_MSG_LINK,
 					  "XAUI workaround has completed\n");
 					return 0;
-				 }
-				 usleep_range(3000, 6000);
+				}
+				usleep_range(3000, 6000);
 			}
 			break;
 		}
@@ -12675,39 +12671,39 @@ static void bnx2x_init_bmac_loopback(struct link_params *params,
 				     struct link_vars *vars)
 {
 	struct bnx2x *bp = params->bp;
-		vars->link_up = 1;
-		vars->line_speed = SPEED_10000;
-		vars->duplex = DUPLEX_FULL;
-		vars->flow_ctrl = BNX2X_FLOW_CTRL_NONE;
-		vars->mac_type = MAC_TYPE_BMAC;
+	vars->link_up = 1;
+	vars->line_speed = SPEED_10000;
+	vars->duplex = DUPLEX_FULL;
+	vars->flow_ctrl = BNX2X_FLOW_CTRL_NONE;
+	vars->mac_type = MAC_TYPE_BMAC;
 
-		vars->phy_flags = PHY_XGXS_FLAG;
+	vars->phy_flags = PHY_XGXS_FLAG;
 
-		bnx2x_xgxs_deassert(params);
+	bnx2x_xgxs_deassert(params);
 
-		/* Set bmac loopback */
-		bnx2x_bmac_enable(params, vars, 1, 1);
+	/* Set bmac loopback */
+	bnx2x_bmac_enable(params, vars, 1, 1);
 
-		REG_WR(bp, NIG_REG_EGRESS_DRAIN0_MODE + params->port*4, 0);
+	REG_WR(bp, NIG_REG_EGRESS_DRAIN0_MODE + params->port * 4, 0);
 }
 
 static void bnx2x_init_emac_loopback(struct link_params *params,
 				     struct link_vars *vars)
 {
 	struct bnx2x *bp = params->bp;
-		vars->link_up = 1;
-		vars->line_speed = SPEED_1000;
-		vars->duplex = DUPLEX_FULL;
-		vars->flow_ctrl = BNX2X_FLOW_CTRL_NONE;
-		vars->mac_type = MAC_TYPE_EMAC;
+	vars->link_up = 1;
+	vars->line_speed = SPEED_1000;
+	vars->duplex = DUPLEX_FULL;
+	vars->flow_ctrl = BNX2X_FLOW_CTRL_NONE;
+	vars->mac_type = MAC_TYPE_EMAC;
 
-		vars->phy_flags = PHY_XGXS_FLAG;
+	vars->phy_flags = PHY_XGXS_FLAG;
 
-		bnx2x_xgxs_deassert(params);
-		/* Set bmac loopback */
-		bnx2x_emac_enable(params, vars, 1);
-		bnx2x_emac_program(params, vars);
-		REG_WR(bp, NIG_REG_EGRESS_DRAIN0_MODE + params->port*4, 0);
+	bnx2x_xgxs_deassert(params);
+	/* Set bmac loopback */
+	bnx2x_emac_enable(params, vars, 1);
+	bnx2x_emac_program(params, vars);
+	REG_WR(bp, NIG_REG_EGRESS_DRAIN0_MODE + params->port * 4, 0);
 }
 
 static void bnx2x_init_xmac_loopback(struct link_params *params,
@@ -13073,12 +13069,12 @@ int bnx2x_link_reset(struct link_params *params, struct link_vars *vars,
 		REG_WR(bp, NIG_REG_EGRESS_EMAC0_OUT_EN + port*4, 0);
 	}
 
-		if (!CHIP_IS_E3(bp)) {
-			bnx2x_set_bmac_rx(bp, params->chip_id, port, 0);
-		} else {
-			bnx2x_set_xmac_rxtx(params, 0);
-			bnx2x_set_umac_rxtx(params, 0);
-		}
+	if (!CHIP_IS_E3(bp)) {
+		bnx2x_set_bmac_rx(bp, params->chip_id, port, 0);
+	} else {
+		bnx2x_set_xmac_rxtx(params, 0);
+		bnx2x_set_umac_rxtx(params, 0);
+	}
 	/* Disable emac */
 	if (!CHIP_IS_E3(bp))
 		REG_WR(bp, NIG_REG_NIG_EMAC0_EN + port*4, 0);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 3b5b47e98c73..0cec82450e19 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -11298,7 +11298,7 @@ static void bnx2x_link_settings_supported(struct bnx2x *bp, u32 switch_cfg)
 			   dev_info.port_hw_config[port].external_phy_config),
 			   SHMEM_RD(bp,
 			   dev_info.port_hw_config[port].external_phy_config2));
-			return;
+		return;
 	}
 
 	if (CHIP_IS_E3(bp))
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index a9eaaf3e73a4..7b22a6d8514c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -2977,8 +2977,8 @@ static inline void bnx2x_mcast_hdl_pending_del_e2(struct bnx2x *bp,
 
 		cmd_pos->data.macs_num--;
 
-		  DP(BNX2X_MSG_SP, "Deleting MAC. %d left,cnt is %d\n",
-				   cmd_pos->data.macs_num, cnt);
+		DP(BNX2X_MSG_SP, "Deleting MAC. %d left,cnt is %d\n",
+		   cmd_pos->data.macs_num, cnt);
 
 		/* Break if we reached the maximum
 		 * number of rules.
@@ -3597,8 +3597,8 @@ static int bnx2x_mcast_validate_e1(struct bnx2x *bp,
 	/* RESTORE command will restore the entire multicast configuration */
 	case BNX2X_MCAST_CMD_RESTORE:
 		p->mcast_list_len = reg_sz;
-		  DP(BNX2X_MSG_SP, "Command %d, p->mcast_list_len=%d\n",
-				   cmd, p->mcast_list_len);
+		DP(BNX2X_MSG_SP, "Command %d, p->mcast_list_len=%d\n",
+		   cmd, p->mcast_list_len);
 		break;
 
 	case BNX2X_MCAST_CMD_ADD:
@@ -3735,8 +3735,8 @@ static inline int bnx2x_mcast_handle_restore_cmd_e1(
 
 		i++;
 
-		  DP(BNX2X_MSG_SP, "About to configure %pM mcast MAC\n",
-		     cfg_data.mac);
+		DP(BNX2X_MSG_SP, "About to configure %pM mcast MAC\n",
+		   cfg_data.mac);
 	}
 
 	*rdata_idx = i;
-- 
2.19.1

