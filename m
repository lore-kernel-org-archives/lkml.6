Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F14C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A70219C1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhMTnS11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A70219C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHLUqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 16:46:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44695 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeHLUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 16:46:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so12350329wrt.11;
        Sun, 12 Aug 2018 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SlAwoNMGHVQiVm5Ag5Hs/snNGX2uJZgeU63Ofevd0q0=;
        b=HhMTnS11TYAbB+MwJmOmiuDWxlXKhvZNKeYnTNxJq0Uqyojay7zy9/QOpzfK218R++
         rpPXbHAiwUmv47RWYUoe6NELwdcGf6KssTV6E2rULETuJwWQwcOupffFjt4OVRysBNQP
         7c4BKHZAr8Et9D6T8yc5FhIcqgMUdT30pDndUR1inFQOSfeAsKUfJx4WauUB09j2xrD/
         KUH/f5ylbXpOywFfGRrNsTRcJzLC+JXcz/UjCxN9KTY+3XdgdaccsmjzdSfr/XGZHw6g
         j+5vZT/DhSdGKU95kXAfVRvH0fYP3utxgvuUt19ApFctE5M/ficB5vrwzVNWcBFf2P3J
         zZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SlAwoNMGHVQiVm5Ag5Hs/snNGX2uJZgeU63Ofevd0q0=;
        b=AyLnzDzuA9hwEOItKU7iUZA3srb8C2QCWuTi3x0+/Q7aGS4HPfdUqZ6iPT8CdXFl/O
         lU2sZPMgiIH2bpquqXcaoIXEgR10IZUXi8mxkgkXMdPXvO4pdJ2JFS1T9d7M7a7kiqs8
         TOiGxJ4A1De6jAYT3r2m4sMNWHFBLwVtYcvGgO+RYaJDWsWzd58FlNg/JS/wZUblHQsM
         7i1JYmAXauUkhc2fqAmZgKRJXombFeyhyBq2RYrT0KlEUSYiIwMQ3pk0Edb2Zw2Ac7Dc
         2B6OAXd2VtgJQWNMRZiC5D9PFztBZGpYZfLJ60pQaQKbVlGSSKsSW5ClMVhsrQxu+ZQY
         xXkA==
X-Gm-Message-State: AOUpUlFsO+RQIrinCAETjNZRg1py8V+TtWEwt2claaswotKQYqWD4WYc
        rnTs/2C41MjNgkTsIQnXzZw=
X-Google-Smtp-Source: AA+uWPzFfPOE3BCdRBNodqlGTjpTyCfiOPsGgwfR6LQqKQfxPCM2EmeFxuAir6r4rT+c6D7zDUfkgg==
X-Received: by 2002:a5d:55c8:: with SMTP id i8-v6mr8629304wrw.38.1534097231467;
        Sun, 12 Aug 2018 11:07:11 -0700 (PDT)
Received: from terrence.localdomain (cpc96818-rdng27-2-0-cust102.15-3.cable.virginm.net. [86.30.200.103])
        by smtp.gmail.com with ESMTPSA id r8-v6sm4818625wmh.37.2018.08.12.11.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 11:07:10 -0700 (PDT)
From:   Tom Todd <thomas.m.a.todd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, dan.carpenter@oracle.com,
        arvind.yadav.cs@gmail.com, thomas.m.a.todd@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: devio: fixed a trailing statement code style issue
Date:   Sun, 12 Aug 2018 19:06:56 +0100
Message-Id: <20180812180656.26079-1-thomas.m.a.todd@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a code styling issue

Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
---
 drivers/usb/core/devio.c | 57 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 476dcc5f2da3..118a29349b1d 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2139,38 +2139,39 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 		retval = -EHOSTUNREACH;
 	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
 		retval = -EINVAL;
-	else switch (ctl->ioctl_code) {
-
-	/* disconnect kernel driver from interface */
-	case USBDEVFS_DISCONNECT:
-		if (intf->dev.driver) {
-			driver = to_usb_driver(intf->dev.driver);
-			dev_dbg(&intf->dev, "disconnect by usbfs\n");
-			usb_driver_release_interface(driver, intf);
-		} else
-			retval = -ENODATA;
-		break;
+	else
+		switch (ctl->ioctl_code) {
+
+		/* disconnect kernel driver from interface */
+		case USBDEVFS_DISCONNECT:
+			if (intf->dev.driver) {
+				driver = to_usb_driver(intf->dev.driver);
+				dev_dbg(&intf->dev, "disconnect by usbfs\n");
+				usb_driver_release_interface(driver, intf);
+			} else
+				retval = -ENODATA;
+			break;
 
-	/* let kernel drivers try to (re)bind to the interface */
-	case USBDEVFS_CONNECT:
-		if (!intf->dev.driver)
-			retval = device_attach(&intf->dev);
-		else
-			retval = -EBUSY;
-		break;
+		/* let kernel drivers try to (re)bind to the interface */
+		case USBDEVFS_CONNECT:
+			if (!intf->dev.driver)
+				retval = device_attach(&intf->dev);
+			else
+				retval = -EBUSY;
+			break;
 
-	/* talk directly to the interface's driver */
-	default:
-		if (intf->dev.driver)
-			driver = to_usb_driver(intf->dev.driver);
-		if (driver == NULL || driver->unlocked_ioctl == NULL) {
-			retval = -ENOTTY;
-		} else {
-			retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
-			if (retval == -ENOIOCTLCMD)
+		/* talk directly to the interface's driver */
+		default:
+			if (intf->dev.driver)
+				driver = to_usb_driver(intf->dev.driver);
+			if (driver == NULL || driver->unlocked_ioctl == NULL) {
 				retval = -ENOTTY;
+			} else {
+				retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
+				if (retval == -ENOIOCTLCMD)
+					retval = -ENOTTY;
+			}
 		}
-	}
 
 	/* cleanup and return */
 	if (retval >= 0
-- 
2.18.0

