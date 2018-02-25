Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBYGGM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 01:06:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeBYGGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 01:06:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1500460556
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rfried@codeaurora.org
From: Ramon Fried <rfried@codeaurora.org>
To: davem@davemloft.net, kvalo@codeaurora.org, marcel@holtmann.org,
        andy.gross@linaro.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramon Fried <rfried@codeaurora.org>
Subject: [PATCH v2] qrtr: add MODULE_ALIAS macro to smd
Date: Sun, 25 Feb 2018 08:05:59 +0200
Message-Id: <20180225060559.17527-1-rfried@codeaurora.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added MODULE_ALIAS("rpmsg:IPCRTR") to ensure qrtr-smd and qrtr will load
when IPCRTR channel is detected.

Signed-off-by: Ramon Fried <rfried@codeaurora.org>

V2: Corrected subject line, this is not a part of a patchset.
---
 net/qrtr/smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
index 50615d5efac1..9cf089b9754e 100644
--- a/net/qrtr/smd.c
+++ b/net/qrtr/smd.c
@@ -114,5 +114,6 @@ static struct rpmsg_driver qcom_smd_qrtr_driver = {
 
 module_rpmsg_driver(qcom_smd_qrtr_driver);
 
+MODULE_ALIAS("rpmsg:IPCRTR");
 MODULE_DESCRIPTION("Qualcomm IPC-Router SMD interface driver");
 MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
