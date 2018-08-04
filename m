Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2488FC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6576217BF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6576217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeHDLD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:03:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:03:27 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8081BB3;
        Sat,  4 Aug 2018 09:03:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.17 24/31] iwlwifi: add more card IDs for 9000 series
Date:   Sat,  4 Aug 2018 11:00:59 +0200
Message-Id: <20180804082634.036372595@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 0a5257bc6d89c2ae69b9bf955679cb4f89261874 upstream.

Add new device IDs for the 9000 series.

Cc: stable@vger.kernel.org # 4.14
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   |   69 ++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |    5 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |   22 +++++++
 3 files changed, 96 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -180,6 +180,17 @@ const struct iwl_cfg iwl9260_2ac_cfg = {
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
 };
 
+const struct iwl_cfg iwl9260_killer_2ac_cfg = {
+	.name = "Killer (R) Wireless-AC 1550 Wireless Network Adapter (9260NGW)",
+	.fw_name_pre = IWL9260A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9260B_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+};
+
 const struct iwl_cfg iwl9270_2ac_cfg = {
 	.name = "Intel(R) Dual Band Wireless AC 9270",
 	.fw_name_pre = IWL9260A_FW_PRE,
@@ -269,6 +280,34 @@ const struct iwl_cfg iwl9560_2ac_cfg_soc
 	.soc_latency = 5000,
 };
 
+const struct iwl_cfg iwl9560_killer_2ac_cfg_soc = {
+	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
+const struct iwl_cfg iwl9560_killer_s_2ac_cfg_soc = {
+	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+};
+
 const struct iwl_cfg iwl9460_2ac_cfg_shared_clk = {
 	.name = "Intel(R) Dual Band Wireless AC 9460",
 	.fw_name_pre = IWL9000A_FW_PRE,
@@ -319,6 +358,36 @@ const struct iwl_cfg iwl9560_2ac_cfg_sha
 	.fw_name_pre = IWL9000A_FW_PRE,
 	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
 	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
+};
+
+const struct iwl_cfg iwl9560_killer_2ac_cfg_shared_clk = {
+	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
+};
+
+const struct iwl_cfg iwl9560_killer_s_2ac_cfg_shared_clk = {
+	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
 	IWL_DEVICE_9000,
 	.ht_params = &iwl9000_ht_params,
 	.nvm_ver = IWL9000_NVM_VERSION,
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -471,6 +471,7 @@ extern const struct iwl_cfg iwl8275_2ac_
 extern const struct iwl_cfg iwl4165_2ac_cfg;
 extern const struct iwl_cfg iwl9160_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
+extern const struct iwl_cfg iwl9260_killer_2ac_cfg;
 extern const struct iwl_cfg iwl9270_2ac_cfg;
 extern const struct iwl_cfg iwl9460_2ac_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg;
@@ -478,10 +479,14 @@ extern const struct iwl_cfg iwl9460_2ac_
 extern const struct iwl_cfg iwl9461_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9462_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9560_killer_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9460_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9461_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9462_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_2ac_cfg_shared_clk;
+extern const struct iwl_cfg iwl9560_killer_2ac_cfg_shared_clk;
+extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl22000_2ac_cfg_hr;
 extern const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb;
 extern const struct iwl_cfg iwl22000_2ac_cfg_jf;
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -545,6 +545,9 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x2526, 0x1210, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x1410, iwl9270_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x1420, iwl9460_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x1550, iwl9260_killer_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2526, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x1610, iwl9270_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x2034, iwl9560_2ac_cfg_soc)},
@@ -554,6 +557,7 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9460_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2526, 0x8014, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0xA014, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0014, iwl9160_2ac_cfg)},
@@ -578,6 +582,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x2720, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2720, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x2720, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_cfg)},
@@ -604,6 +610,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x30DC, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x4030, iwl9560_2ac_cfg_soc)},
@@ -630,6 +638,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x31DC, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x31DC, 0x1030, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, 0x1551, iwl9560_killer_s_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x1552, iwl9560_killer_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x2030, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x2034, iwl9560_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x4030, iwl9560_2ac_cfg_shared_clk)},
@@ -656,6 +666,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x34F0, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x34F0, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x34F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x34F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x4030, iwl9560_2ac_cfg_soc)},
@@ -682,6 +694,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x3DF0, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x3DF0, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x3DF0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x3DF0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x3DF0, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x3DF0, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x3DF0, 0x4030, iwl9560_2ac_cfg_soc)},
@@ -708,6 +722,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x43F0, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x43F0, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x43F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x43F0, 0x4030, iwl9560_2ac_cfg_soc)},
@@ -743,6 +759,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x9DF0, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x9DF0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x2010, iwl9460_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x9DF0, 0x2034, iwl9560_2ac_cfg_soc)},
@@ -771,6 +789,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0xA0F0, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x4030, iwl9560_2ac_cfg_soc)},
@@ -797,6 +817,8 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0xA370, 0x1010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0xA370, 0x1030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0xA370, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0xA370, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x2030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x2034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0xA370, 0x4030, iwl9560_2ac_cfg_soc)},


