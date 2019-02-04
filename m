Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F20C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F22082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfBDTDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:03:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56515 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfBDTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:03:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gqjWR-0001VL-7j; Mon, 04 Feb 2019 19:03:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: remove redundant zero check on count
Date:   Mon,  4 Feb 2019 19:03:10 +0000
Message-Id: <20190204190310.24179-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable count is never zero inside the loop so the check if count is
zero is redundant and can be removed. Fix this.

Detected by CoverityScan, CID#1466880 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/h4_recv.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
index 307d82166f48..87ccaceadba7 100644
--- a/drivers/bluetooth/h4_recv.h
+++ b/drivers/bluetooth/h4_recv.h
@@ -67,9 +67,6 @@ static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
 	while (count) {
 		int i, len;
 
-		if (!count)
-			break;
-
 		if (!skb) {
 			for (i = 0; i < pkts_count; i++) {
 				if (buffer[0] != (&pkts[i])->type)
-- 
2.20.1

