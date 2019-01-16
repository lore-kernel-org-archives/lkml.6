Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F487C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6810D20578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gfBUbdaS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y4mXWpHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392782AbfAPMbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:31:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392579AbfAPMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:31:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9721D60208; Wed, 16 Jan 2019 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547641890;
        bh=UTejcDY/XE3AHidaahIJmn23UpUx87hv2SPQ3EFob4c=;
        h=From:To:Cc:Subject:Date:From;
        b=gfBUbdaSHd+yWk7RvPwfPvwmI+Wt+nddfwuU9PEgokXWRvcJQj5UWIhPGxPgrCivQ
         FDYSjjMaqW4Btqd+1TEtGkom18vIJYNR0zRa3GSqOcQQDqZ8VaNqqb6Z4J43zqoLOt
         jEVKdvMOm5XspoUM0IlGjxiJA+7PpsKKY5rpXlWY=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B453C60208;
        Wed, 16 Jan 2019 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547641889;
        bh=UTejcDY/XE3AHidaahIJmn23UpUx87hv2SPQ3EFob4c=;
        h=From:To:Cc:Subject:Date:From;
        b=Y4mXWpHPL8XSnDiPyCXroOGR6FiQNMjKZ2U/aTB7jNKjL23fVPybj94SGgabQh4Z9
         lprkpra79QZUK+Vc12jHp2Gq1U3MfgRqyQQRYIAqQ0ySqQoBp24RmCQXOPhLJqC1H9
         8QUgf1snbS3EdRNS5PCAISVeDFeO7GP4/m2Y43aU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B453C60208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [RESEND v2] Bluetooth: hci_qca: Add helper to set device address
Date:   Wed, 16 Jan 2019 18:01:15 +0530
Message-Id: <20190116123115.24973-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add qca_set_bdaddr() to set the device
address for latest Qualcomm Bluetooth chipset wcn3990 and above.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c   | 19 +++++++++++++++++++
 drivers/bluetooth/btqca.h   |  8 +++++++-
 drivers/bluetooth/hci_qca.c |  5 ++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index ec9e03a6b778..612268574fc7 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -391,6 +391,25 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 }
 EXPORT_SYMBOL_GPL(qca_uart_setup);
 
+int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
+				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca_set_bdaddr);
+
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 0c01f375fe83..c72c56ea7480 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -20,6 +20,7 @@
 
 #define EDL_PATCH_CMD_OPCODE		(0xFC00)
 #define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
+#define EDL_WRITE_BD_ADDR_OPCODE	(0xFC14)
 #define EDL_PATCH_CMD_LEN		(1)
 #define EDL_PATCH_VER_REQ_CMD		(0x19)
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
@@ -140,7 +141,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, u32 soc_ver);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
-
+int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #else
 
 static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
@@ -159,4 +160,9 @@ static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 	return -EOPNOTSUPP;
 }
 
+static inline int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..53ac5ade532b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1241,7 +1241,10 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup bdaddr */
-	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		hu->hdev->set_bdaddr = qca_set_bdaddr;
+	else
+		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

