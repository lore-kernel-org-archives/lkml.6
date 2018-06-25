Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7519C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFA925AA1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FfQ0UWWN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X19quJ9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFA925AA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeFYNki (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:40:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755608AbeFYNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C47456071C; Mon, 25 Jun 2018 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934032;
        bh=vyvfg12HSpW48SDJYOhYHNE6PiKtl/4vt7DFv5t2zBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfQ0UWWN20MU1aN7TugIUP/md4n1v0W/2ZDg97j1FwyWyNorHiNn/t0rXuHFn5pxF
         0We4eY44v5T71VZphv6mOr3gLwXZCnzulznxkLuELhWeTzLwUYvJWCiyfMKEHyWrTK
         HsQgaZHZsLZ/oQ/2FTvqKRi9vEbXZ8jmi298iZBs=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89CA860A06;
        Mon, 25 Jun 2018 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934031;
        bh=vyvfg12HSpW48SDJYOhYHNE6PiKtl/4vt7DFv5t2zBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X19quJ9YRJu0Y33rmwv8SVAXUKQKWFhHa4wjQE70FCnFRiNsU4/GxcOCVfKKEfAnF
         dV+fQbeCagaFJi67FcDGzDbtT/ED8yKRlySRRJGXr9n3xQUrr8EZZIPeHdoVXNhP1+
         nvZ9KeJAykn/me8FDKdPeZSROu/qsHvcc77mQ6fY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89CA860A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 2/7] Bluetooth: btqca: Rename ROME specific functions to Generic functions
Date:   Mon, 25 Jun 2018 19:10:08 +0530
Message-Id: <20180625134013.19684-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the QCA BTSoC ROME functions, are used for different versions
or different make of BTSoC's. Instead of duplicating the same functions
for new chip, updating names of the functions that are used for both
chip's to keep this generic and would help in future when we would have
new BT SoC and to have generic text in bt_dev_info, bt_dev_err and
bt_dev_dbg updated from ROME to QCA where ever possible. This avoids
confusion to user, when using the future Qualcomm Bluetooth SoC's.
Updated BT_DBG, BT_ERR and BT_INFO with bt_dev_dbg, bt_dev_err and
bt_dev_info where ever applicable.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v8:
    * squashed [v7 2/8] and [v7 3/8] into one.
    * updated review comments
	
Changes in v7:
    * updated the all the functions of ROME to generic.

Changes in v6:
    * initial patch
    * updated names of functions that are used for both the chips to 
      keep this generic and would help in future when we would have 
      new BT SoC.
---
 drivers/bluetooth/btqca.c   | 85 ++++++++++++++++++-------------------
 drivers/bluetooth/btqca.h   | 10 ++++-
 drivers/bluetooth/hci_qca.c |  2 +-
 3 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8219816c54a0..c5cf9cab438a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -27,7 +27,7 @@
 
 #define VERSION "0.1"
 
-static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
@@ -35,36 +35,35 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	char cmd;
 	int err = 0;
 
-	BT_DBG("%s: ROME Patch Version Request", hdev->name);
+	bt_dev_dbg(hdev, "QCA Version Request");
 
 	cmd = EDL_PATCH_VER_REQ_CMD;
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
 				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
-		       err);
+		bt_dev_err(hdev, "Reading QCA version information failed (%d)",
+			   err);
 		return err;
 	}
 
 	if (skb->len != sizeof(*edl) + sizeof(*ver)) {
-		BT_ERR("%s: Version size mismatch len %d", hdev->name,
-		       skb->len);
+		bt_dev_err(hdev, "QCA Version size mismatch len %d", skb->len);
 		err = -EILSEQ;
 		goto out;
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
-		BT_ERR("%s: TLV with no header", hdev->name);
+		bt_dev_err(hdev, "QCA TLV with no header");
 		err = -EILSEQ;
 		goto out;
 	}
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_APP_VER_RES_EVT) {
-		BT_ERR("%s: Wrong packet received %d %d", hdev->name,
-		       edl->cresp, edl->rtype);
+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
+			   edl->rtype);
 		err = -EIO;
 		goto out;
 	}
@@ -76,11 +75,11 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rome_ver));
 	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
 
-	/* ROME chipset version can be decided by patch and SoC
+	/* QCA chipset version can be decided by patch and SoC
 	 * version, combination with upper 2 bytes from SoC
 	 * and lower 2 bytes from patch will be used.
 	 */
-	*rome_version = (le32_to_cpu(ver->soc_id) << 16) |
+	*soc_version = (le32_to_cpu(ver->soc_id) << 16) |
 			(le16_to_cpu(ver->rome_ver) & 0x0000ffff);
 
 out:
@@ -88,18 +87,19 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(qca_read_soc_version);
 
-static int rome_reset(struct hci_dev *hdev)
+static int qca_send_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	int err;
 
-	BT_DBG("%s: ROME HCI_RESET", hdev->name);
+	bt_dev_dbg(hdev, "QCA HCI_RESET");
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Reset failed (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Reset failed (%d)", err);
 		return err;
 	}
 
@@ -108,7 +108,7 @@ static int rome_reset(struct hci_dev *hdev)
 	return 0;
 }
 
-static void rome_tlv_check_data(struct rome_config *config,
+static void qca_tlv_check_data(struct rome_config *config,
 				const struct firmware *fw)
 {
 	const u8 *data;
@@ -207,7 +207,7 @@ static void rome_tlv_check_data(struct rome_config *config,
 	}
 }
 
-static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
+static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 				 const u8 *data, enum rome_tlv_dnld_mode mode)
 {
 	struct sk_buff *skb;
@@ -228,19 +228,19 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to send TLV segment (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to send TLV segment (%d)", err);
 		return err;
 	}
 
 	if (skb->len != sizeof(*edl) + sizeof(*tlv_resp)) {
-		BT_ERR("%s: TLV response size mismatch", hdev->name);
+		bt_dev_err(hdev, "QCA TLV response size mismatch");
 		err = -EILSEQ;
 		goto out;
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
-		BT_ERR("%s: TLV with no header", hdev->name);
+		bt_dev_err(hdev, "TLV with no header");
 		err = -EILSEQ;
 		goto out;
 	}
@@ -249,8 +249,8 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_TVL_DNLD_RES_EVT || tlv_resp->result != 0x00) {
-		BT_ERR("%s: TLV with error stat 0x%x rtype 0x%x (0x%x)",
-		       hdev->name, edl->cresp, edl->rtype, tlv_resp->result);
+		bt_dev_err(hdev, "QCA TLV with error stat 0x%x rtype 0x%x (0x%x)",
+			   edl->cresp, edl->rtype, tlv_resp->result);
 		err = -EIO;
 	}
 
@@ -260,23 +260,23 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	return err;
 }
 
-static int rome_download_firmware(struct hci_dev *hdev,
+static int qca_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
 	const struct firmware *fw;
 	const u8 *segment;
 	int ret, remain, i = 0;
 
-	bt_dev_info(hdev, "ROME Downloading %s", config->fwname);
+	bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
 
 	ret = request_firmware(&fw, config->fwname, &hdev->dev);
 	if (ret) {
-		BT_ERR("%s: Failed to request file: %s (%d)", hdev->name,
-		       config->fwname, ret);
+		bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+			   config->fwname, ret);
 		return ret;
 	}
 
-	rome_tlv_check_data(config, fw);
+	qca_tlv_check_data(config, fw);
 
 	segment = fw->data;
 	remain = fw->size;
@@ -290,7 +290,7 @@ static int rome_download_firmware(struct hci_dev *hdev,
 		if (!remain || segsize < MAX_SIZE_PER_TLV_SEGMENT)
 			config->dnld_mode = ROME_SKIP_EVT_NONE;
 
-		ret = rome_tlv_send_segment(hdev, segsize, segment,
+		ret = qca_tlv_send_segment(hdev, segsize, segment,
 					    config->dnld_mode);
 		if (ret)
 			break;
@@ -317,8 +317,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Change address command failed (%d)",
-		       hdev->name, err);
+		bt_dev_err(hdev, "QCA Change address command failed (%d)", err);
 		return err;
 	}
 
@@ -328,32 +327,32 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 {
 	u32 rome_ver = 0;
 	struct rome_config config;
 	int err;
 
-	BT_DBG("%s: ROME setup on UART", hdev->name);
+	bt_dev_dbg(hdev, "QCA setup on UART");
 
 	config.user_baud_rate = baudrate;
 
-	/* Get ROME version information */
-	err = rome_patch_ver_req(hdev, &rome_ver);
+	/* Get QCA version information */
+	err = qca_read_soc_version(hdev, &rome_ver);
 	if (err < 0 || rome_ver == 0) {
-		BT_ERR("%s: Failed to get version 0x%x", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to get version %d", err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "ROME controller version 0x%08x", rome_ver);
+	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
 		 rome_ver);
-	err = rome_download_firmware(hdev, &config);
+	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
-		BT_ERR("%s: Failed to download patch (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
 		return err;
 	}
 
@@ -361,24 +360,24 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	config.type = TLV_TYPE_NVM;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
 		 rome_ver);
-	err = rome_download_firmware(hdev, &config);
+	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
-		BT_ERR("%s: Failed to download NVM (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
 		return err;
 	}
 
 	/* Perform HCI reset */
-	err = rome_reset(hdev);
+	err = qca_send_reset(hdev);
 	if (err < 0) {
-		BT_ERR("%s: Failed to run HCI_RESET (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "ROME setup on UART is completed");
+	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qca_uart_setup_rome);
+EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 13d77fd873b6..5c9851b11838 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -127,7 +127,8 @@ struct tlv_type_hdr {
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
+int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 
 #else
 
@@ -136,7 +137,12 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 	return -EOPNOTSUPP;
 }
 
-static inline int qca_uart_setup_rome(struct hci_dev *hdev, int speed)
+static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 51790dd02afb..d7b60669b656 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -966,7 +966,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup_rome(hdev, qca_baudrate);
+	ret = qca_uart_setup(hdev, qca_baudrate);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

