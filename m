Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365FBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7628208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7628208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeGaH4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:56:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40407 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbeGaH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:56:20 -0400
Received: from 1-161-146-33.dynamic-ip.hinet.net ([1.161.146.33] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fkNyV-0004X8-Hp; Tue, 31 Jul 2018 06:17:40 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 3/5] memstick: rtsx_usb_ms: Use ms_dev() helper
Date:   Tue, 31 Jul 2018 14:17:19 +0800
Message-Id: <20180731061721.15831-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731061721.15831-1-kai.heng.feng@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ms_dev() helper for consistency.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/memstick/host/rtsx_usb_ms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 4f64563df7de..cd12f3d1c088 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -785,7 +785,7 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 
 	mutex_lock(&host->host_mutex);
 	if (host->req) {
-		dev_dbg(&(pdev->dev),
+		dev_dbg(ms_dev(host),
 			"%s: Controller removed during transfer\n",
 			dev_name(&msh->dev));
 		host->req->error = -ENOMEDIUM;
@@ -807,10 +807,10 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	if (pm_runtime_active(ms_dev(host)))
 		pm_runtime_put(ms_dev(host));
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(ms_dev(host));
 	platform_set_drvdata(pdev, NULL);
 
-	dev_dbg(&(pdev->dev),
+	dev_dbg(ms_dev(host),
 		": Realtek USB Memstick controller has been removed\n");
 
 	return 0;
-- 
2.17.1

