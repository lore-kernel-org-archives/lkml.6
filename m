Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A986AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD7A20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD7A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408702AbeKWTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:25:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41346 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393753AbeKWTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:25:41 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gQ72d-0000l1-A2; Fri, 23 Nov 2018 08:42:23 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] USB: usb-storage: Add new IDs to ums-realtek
Date:   Fri, 23 Nov 2018 08:42:19 +0000
Message-Id: <20181123084219.30987-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two new Realtek card readers require ums-realtek to work
correctly.

Add the new IDs to support them.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/storage/unusual_realtek.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/storage/unusual_realtek.h b/drivers/usb/storage/unusual_realtek.h
index d17cd95b55bb..6b2140f966ef 100644
--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -27,4 +27,14 @@ UNUSUAL_DEV(0x0bda, 0x0159, 0x0000, 0x9999,
 		"USB Card Reader",
 		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
 
+UNUSUAL_DEV(0x0bda, 0x0177, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
+UNUSUAL_DEV(0x0bda, 0x0184, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
 #endif  /* defined(CONFIG_USB_STORAGE_REALTEK) || ... */
-- 
2.17.1

