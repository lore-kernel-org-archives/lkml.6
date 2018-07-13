Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B33208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B33208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeGMKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:12:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59715 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGMKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:12:42 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fduqb-0007fa-0Y; Fri, 13 Jul 2018 09:58:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: uss720: remove redundant pointer usbdev
Date:   Fri, 13 Jul 2018 10:58:44 +0100
Message-Id: <20180713095844.25115-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer usbdev is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'usbdev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/misc/uss720.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index de9a502491c2..82f220631bd7 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -748,13 +748,11 @@ static void uss720_disconnect(struct usb_interface *intf)
 {
 	struct parport *pp = usb_get_intfdata(intf);
 	struct parport_uss720_private *priv;
-	struct usb_device *usbdev;
 
 	dev_dbg(&intf->dev, "disconnect\n");
 	usb_set_intfdata(intf, NULL);
 	if (pp) {
 		priv = pp->private_data;
-		usbdev = priv->usbdev;
 		priv->usbdev = NULL;
 		priv->pp = NULL;
 		dev_dbg(&intf->dev, "parport_remove_port\n");
-- 
2.17.1

