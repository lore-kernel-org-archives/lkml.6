Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CCFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F31621564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lr6hJVSc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UIrlxMod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F31621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeHBVAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:00:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeHBVAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:00:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B8D560B62; Thu,  2 Aug 2018 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533236887;
        bh=1Jdp7Zlr0OEA1yU9+iwqVJNjFakj/qigqjjsA79r2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lr6hJVScEpPHljcIOMi9GL3vCH1TooI8OcPCWXnRPTTh9X56FlFcnPFCFaA2rXlGq
         3zagfwTXGdP7lDv5syApz2jAEaZC9zu6wQi28iyKiy0bTJ0VOq1QQNj2B46raNzVeG
         MpA2zuK2Nqw2tDLVwLbwpQTFpUb2hTrweZFkpDCw=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62A4160B72;
        Thu,  2 Aug 2018 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533236886;
        bh=1Jdp7Zlr0OEA1yU9+iwqVJNjFakj/qigqjjsA79r2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIrlxModRDaiE0jqGFxN78hc1vnZCvF6RH0ZV4QKg03DOEg2nX30X3Bb9BTBbimUu
         jagrvWYgbBZttCDb7Wg+KkqCY+mf28O0CfdIZMkMMOUpqN/73+TUsXoVm+JfZzqXIs
         /t+yfuM1xDcOFCU50SK4kZjYgy6V+ezUe0nBZHIE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62A4160B72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v13 5/7] Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
Date:   Fri,  3 Aug 2018 00:37:30 +0530
Message-Id: <20180802190732.4811-6-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802190732.4811-1-bgodavar@codeaurora.org>
References: <20180802190732.4811-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

