Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2051C20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2051C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeKESEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:04:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34931 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKESED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:04:03 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gJaVi-0002Or-4v; Mon, 05 Nov 2018 08:45:26 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4/5 v7] memstick: rtsx_usb_ms: Use ms_dev() helper
Date:   Mon,  5 Nov 2018 16:45:05 +0800
Message-Id: <20181105084506.6476-5-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105084506.6476-1-kai.heng.feng@canonical.com>
References: <20181105084506.6476-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e95e64974a91..24e9e6acf01a 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -786,7 +786,7 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 
 	mutex_lock(&host->host_mutex);
 	if (host->req) {
-		dev_dbg(&(pdev->dev),
+		dev_dbg(ms_dev(host),
 			"%s: Controller removed during transfer\n",
 			dev_name(&msh->dev));
 		host->req->error = -ENOMEDIUM;
@@ -808,10 +808,10 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
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
2.19.1

