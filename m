Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE18C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF012087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfAGW7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:59:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51951 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:59:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ggdrk-0001uu-Re; Mon, 07 Jan 2019 22:59:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i40e: clean up several indentation issues
Date:   Mon,  7 Jan 2019 22:59:28 +0000
Message-Id: <20190107225928.12855-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several statements that have incorrect levels of indentation,
fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 6 +++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a6bc7847346b..fe84f054f0c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2440,10 +2440,10 @@ static int i40e_set_phys_id(struct net_device *netdev,
 	default:
 		break;
 	}
-		if (ret)
-			return -ENOENT;
-		else
-			return 0;
+	if (ret)
+		return -ENOENT;
+	else
+		return 0;
 }
 
 /* NOTE: i40e hardware uses a conversion factor of 2 for Interrupt
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4d40878e395a..76dac65bf0ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3610,7 +3610,7 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 		      (I40E_QUEUE_TYPE_TX
 		       << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
 
-	       wr32(hw, I40E_QINT_TQCTL(nextqp), val);
+		wr32(hw, I40E_QINT_TQCTL(nextqp), val);
 	}
 
 	val = I40E_QINT_TQCTL_CAUSE_ENA_MASK		      |
@@ -8131,8 +8131,8 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 		i40e_service_event_schedule(pf);
 	} else {
 		i40e_pf_unquiesce_all_vsi(pf);
-	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
-	set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
+		set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
+		set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
 	}
 
 exit:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2ac23ebfbf31..46054634e68c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3384,8 +3384,8 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		dev_info(&pf->pdev->dev,
 			 "VF %d: Invalid input/s, can't apply cloud filter\n",
 			 vf->vf_id);
-			aq_ret = I40E_ERR_PARAM;
-			goto err;
+		aq_ret = I40E_ERR_PARAM;
+		goto err;
 	}
 
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
-- 
2.19.1

