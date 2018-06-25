Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45EAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AC325A9A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WAmcgw6k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WAmcgw6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AC325A9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934103AbeFYNko (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:40:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755611AbeFYNkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBDFA6071C; Mon, 25 Jun 2018 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934041;
        bh=czj0L+O6T0vDI+SRUaXXeXae/ybtNOFfFJ3tJyOBFHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAmcgw6kj+QS61oAOOmexwG4FeEepdJ0PCaj3ycWDuw5pYUWc5PTknRfMe8G6s9Tm
         wBrVEHOMqkbct5aGh3WceZbOXNK+SoPFS8mBEZJpFRvciEQi/Zca5DNWLj8G7eJQdL
         TxbLklvgzzsOwjkt5pPeSYvCGI45NZ81YivhWZoY=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78F3B607EB;
        Mon, 25 Jun 2018 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934041;
        bh=czj0L+O6T0vDI+SRUaXXeXae/ybtNOFfFJ3tJyOBFHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAmcgw6kj+QS61oAOOmexwG4FeEepdJ0PCaj3ycWDuw5pYUWc5PTknRfMe8G6s9Tm
         wBrVEHOMqkbct5aGh3WceZbOXNK+SoPFS8mBEZJpFRvciEQi/Zca5DNWLj8G7eJQdL
         TxbLklvgzzsOwjkt5pPeSYvCGI45NZ81YivhWZoY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78F3B607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 5/7] Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
Date:   Mon, 25 Jun 2018 19:10:11 +0530
Message-Id: <20180625134013.19684-6-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 38b7dbe6c897..28187a89b850 100644
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

