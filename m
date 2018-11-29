Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A6AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E4520834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWMKqaQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E4520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeK2RBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeK2RBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:01:23 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108E820834;
        Thu, 29 Nov 2018 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471033;
        bh=KJbKyZU1jZyOJMcQ0RB4ceMjBOxqQjOUKwc5vbLYKoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWMKqaQZgxnceK8Tldtc9G9TSMOyCw86G5aIvyTxQ8kuIa2z2MN3lommQO63kpXGu
         pPI0xijo3VZMNJWbm8iCUHPvBIzhEGNBgHXWQe7/jXj2MI7wThlpn7x/o20mTDrzWl
         x1sxihMgdlRxW43gnm9FXlUPRwvkZPFLbv98vUb4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/68] can: ucan: remove set but not used variable 'udev'
Date:   Thu, 29 Nov 2018 00:55:01 -0500
Message-Id: <20181129055559.159228-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 207681fc5f3d5d398f106d1ae0080fc2373f707a ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/can/usb/ucan.c: In function 'ucan_disconnect':
drivers/net/can/usb/ucan.c:1578:21: warning:
 variable 'udev' set but not used [-Wunused-but-set-variable]
  struct usb_device *udev;

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/ucan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38b1af4..c9fd83e8d947 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1575,11 +1575,8 @@ static int ucan_probe(struct usb_interface *intf,
 /* disconnect the device */
 static void ucan_disconnect(struct usb_interface *intf)
 {
-	struct usb_device *udev;
 	struct ucan_priv *up = usb_get_intfdata(intf);
 
-	udev = interface_to_usbdev(intf);
-
 	usb_set_intfdata(intf, NULL);
 
 	if (up) {
-- 
2.17.1

