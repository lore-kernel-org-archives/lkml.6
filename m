Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68F1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607A320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oamS9B0/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gWJXqeRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607A320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeGTOVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:21:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbeGTOVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:21:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16B096063A; Fri, 20 Jul 2018 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532093599;
        bh=1Jdp7Zlr0OEA1yU9+iwqVJNjFakj/qigqjjsA79r2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oamS9B0/stHCr1p6NZNcKAnxKIB8wvhQJvN3OgA1lHzZ0w1UxmN5c3ywqNvOl1jOV
         t5dvTDd0gmGCsj68LWku/BAyl2PnxoW1Nf2/vbSuXpKHff8LwBcyuNHdFHztv2PSqr
         E5ClhXIuFNHTyfL9ZD2Fqge3fewF5dDFKSLa2id0=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD41607C6;
        Fri, 20 Jul 2018 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532093598;
        bh=1Jdp7Zlr0OEA1yU9+iwqVJNjFakj/qigqjjsA79r2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWJXqeRZxJLO4Vkg+FXq+LEdvUz8sDXLromssBcyvQbdLZ/lS/M9M8fE5qPeu8JPi
         sJuYwP9OUPXRSa3CkAvQvtOP/mw1/Az+ckTX/anYaaGaxm0mTjxZGFWml/hHKtYklP
         26HVDdLDF/VYL7oDiWycPdjExVRqhtLuYRrsKGBw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD41607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v10 5/7] Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
Date:   Fri, 20 Jul 2018 19:02:41 +0530
Message-Id: <20180720133243.6851-6-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720133243.6851-1-bgodavar@codeaurora.org>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
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

