Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC098ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95BD20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95BD20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbeGWL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:28:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38534 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387906AbeGWL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:28:41 -0400
Received: from 1-161-144-158.dynamic-ip.hinet.net ([1.161.144.158] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fhY4V-0002UB-50; Mon, 23 Jul 2018 10:28:07 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 3/5] memstick: rtsx_usb_ms: Use ms_dev() helper
Date:   Mon, 23 Jul 2018 18:27:42 +0800
Message-Id: <20180723102744.15140-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723102744.15140-1-kai.heng.feng@canonical.com>
References: <20180723102744.15140-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ms_dev() helper for consistency.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/memstick/host/rtsx_usb_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 4f64563df7de..d56f0863653f 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -807,7 +807,7 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	if (pm_runtime_active(ms_dev(host)))
 		pm_runtime_put(ms_dev(host));
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(ms_dev(host));
 	platform_set_drvdata(pdev, NULL);
 
 	dev_dbg(&(pdev->dev),
-- 
2.17.1

