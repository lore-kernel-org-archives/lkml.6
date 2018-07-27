Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBCC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2E5208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2E5208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bgodavar-linux.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbeG0P5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:57:14 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:48767 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730561AbeG0P5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:57:14 -0400
X-IronPort-AV: E=Sophos;i="5.51,409,1526322600"; 
   d="scan'208";a="115116"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Jul 2018 19:43:25 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8966"; a="828473"
Received: from bgodavar-linux.qualcomm.com ([10.206.64.85])
  by ironmsg04-blr.qualcomm.com with ESMTP; 27 Jul 2018 19:43:25 +0530
Received: by bgodavar-linux.qualcomm.com (Postfix, from userid 2304065)
        id 9EEA13C27; Fri, 27 Jul 2018 19:43:23 +0530 (IST)
From:   Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 5/7] Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
Date:   Fri, 27 Jul 2018 19:43:18 +0530
Message-Id: <20180727141320.25218-6-bgodavar@bgodavar-linux.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Enable Qualcomm chips to operate at 3.2Mbps.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5f8a74d65bec..a6e7d38ef931 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -877,6 +877,8 @@ static uint8_t qca_get_baudrate_value(int speed)
 		return QCA_BAUDRATE_2000000;
 	case 3000000:
 		return QCA_BAUDRATE_3000000;
+	case 3200000:
+		return QCA_BAUDRATE_3200000;
 	case 3500000:
 		return QCA_BAUDRATE_3500000;
 	default:
@@ -891,7 +893,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	struct sk_buff *skb;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
-	if (baudrate > QCA_BAUDRATE_3000000)
+	if (baudrate > QCA_BAUDRATE_3200000)
 		return -EINVAL;
 
 	cmd[4] = baudrate;
-- 
2.17.1

