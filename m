Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A97C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C047321917
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzVtPr3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C047321917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeHMBMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:12:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40103 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeHMBMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:12:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so6997486wma.5;
        Sun, 12 Aug 2018 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHi2eBHsLWAv2dII+xS6puxHWVCGYk0uHTAep/ixXF8=;
        b=IzVtPr3otL3LPsjQLVu6aDw8iJlJo9YGfan4Mr4Oj7oYP9u/SL3oLSNd+DEdgFga7r
         lQ5EYqgjDSxYK01BUazwAC5n7qFSPpSxw2v5DAzWpX2rWmKoP8P3S2tUTCDgPYGDU3Bp
         9SXU7J1lyUAg+qL3rJUwROtoPY1WSLtNCpY3uHJZ/pdPfPvWCmhh1v271UYVCduceruY
         I+kigv5ZRQmD93ATg2lu+HP5fkEzhg457OV6UQvAwLqn+pydKqO8nAG7fTqqfh8cnT+A
         pvAWPeW9HjiblA3bv8iJnrRMTg94wqm9ePXl5uSehaIoL32vyYuzaXRcDnc5Dmi5yqee
         gCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHi2eBHsLWAv2dII+xS6puxHWVCGYk0uHTAep/ixXF8=;
        b=ap5Qstm5X/Nz2udW2cGSA7u/d7WFoxgynXel4SB1MUTgoyDSS2g/BfiZFcebyxOl0B
         zqJYBjZiMaKUwNIHKDQzQ3yXhoKYrE1b3Mfi/k2a7657na1sPpGq3IwfheLBLnzPJJHm
         23e4e/tmJTH4nW5UpJo6XSPYjIwOHg+Ib4NJLqYvyejDGK0ZkSzRexTD2SCMjC6Fj0VW
         aO1lrabLTHFvoAS9i+K2fiR+yh+OZlNfRS29hu5ays946ufF1VdVug2tYjXXkvP3KnIN
         hWKIbu8rJM7JR6kdP7Un8Nd0CzEn25fZoa0fl+CFmTHYMlkdp3Azf4jHOS1StZhZx5vX
         CD7g==
X-Gm-Message-State: AOUpUlHXAIJVYdC4bD1r56yxQLwGKgjjGDcykpLp1YNinkm4SUoIC6N2
        uvjT+w0qWhgdb8Uy2IVzWTtRQ9D7h+g=
X-Google-Smtp-Source: AA+uWPy1rdZo6mXhnvyQxpsYNx4mjD/IyatyCvgN/tlWSaJHC4ZTdROWfHfINwWnT3GI2vr6MtdETg==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr6986407wme.125.1534113154888;
        Sun, 12 Aug 2018 15:32:34 -0700 (PDT)
Received: from terrence.localdomain (cpc96818-rdng27-2-0-cust102.15-3.cable.virginm.net. [86.30.200.103])
        by smtp.gmail.com with ESMTPSA id s2-v6sm16012712wrw.52.2018.08.12.15.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 15:32:33 -0700 (PDT)
From:   Tom Todd <thomas.m.a.todd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, stern@rowland.harvard.edu,
        dan.carpenter@oracle.com, arvind.yadav.cs@gmail.com,
        thomas.m.a.todd@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: core: devio: Restructured proc_ioctl for readability
Date:   Sun, 12 Aug 2018 23:26:54 +0100
Message-Id: <20180812222653.3341-1-thomas.m.a.todd@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <10f9f13a5421299a6efda1e1f84ab304ef18ddec.camel@perches.com>
References: <10f9f13a5421299a6efda1e1f84ab304ef18ddec.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On, Sun, 12 Aug 2018 11:34:59 -0700 Joe Perches wrote:
>On Sun, 2018-08-12 at 19:06 +0100, Tom Todd wrote:
>> Fixed a code styling issue
>while it's OK to fix style only issues, it's much better
>to reorganize the code for reader clarity.

Ok, thank you, I've taken your suggestions and created the a new version

Restructured method proc_ioctl for readability and fixed code style
errors.

Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
---
 drivers/usb/core/devio.c | 67 ++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 476dcc5f2da3..740e60e086e2 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2117,46 +2117,52 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 	/* alloc buffer */
 	size = _IOC_SIZE(ctl->ioctl_code);
 	if (size > 0) {
-		buf = kmalloc(size, GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
-		if ((_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE)) {
-			if (copy_from_user(buf, ctl->data, size)) {
-				kfree(buf);
+		if (_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE) {
+			buf = memdup_user(ctl->data, size);
+			if (!buf)
 				return -EFAULT;
-			}
 		} else {
-			memset(buf, 0, size);
+			buf = kmalloc(size, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
 		}
 	}
 
 	if (!connected(ps)) {
-		kfree(buf);
-		return -ENODEV;
+		retval = -ENODEV;
+		goto exit;
 	}
 
-	if (ps->dev->state != USB_STATE_CONFIGURED)
+	if (ps->dev->state != USB_STATE_CONFIGURED) {
 		retval = -EHOSTUNREACH;
-	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
+		goto exit;
+	}
+
+	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
+	if (!intf) {
 		retval = -EINVAL;
-	else switch (ctl->ioctl_code) {
+		goto exit;
+	}
 
+	switch (ctl->ioctl_code) {
 	/* disconnect kernel driver from interface */
 	case USBDEVFS_DISCONNECT:
-		if (intf->dev.driver) {
-			driver = to_usb_driver(intf->dev.driver);
-			dev_dbg(&intf->dev, "disconnect by usbfs\n");
-			usb_driver_release_interface(driver, intf);
-		} else
+		if (!intf->dev.driver) {
 			retval = -ENODATA;
+			goto exit;
+		}
+		driver = to_usb_driver(intf->dev.driver);
+		dev_dbg(&intf->dev, "disconnect by usbfs\n");
+		usb_driver_release_interface(driver, intf);
 		break;
 
 	/* let kernel drivers try to (re)bind to the interface */
 	case USBDEVFS_CONNECT:
-		if (!intf->dev.driver)
-			retval = device_attach(&intf->dev);
-		else
+		if (!intf->dev.driver) {
 			retval = -EBUSY;
+			goto exit;
+		}
+		retval = device_attach(&intf->dev);
 		break;
 
 	/* talk directly to the interface's driver */
@@ -2165,20 +2171,21 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 			driver = to_usb_driver(intf->dev.driver);
 		if (driver == NULL || driver->unlocked_ioctl == NULL) {
 			retval = -ENOTTY;
-		} else {
-			retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
-			if (retval == -ENOIOCTLCMD)
-				retval = -ENOTTY;
+			goto exit;
 		}
+		retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
+		if (retval == -ENOIOCTLCMD) {
+			retval = -ENOTTY;
+			goto exit;
+		}
+		break;
 	}
 
 	/* cleanup and return */
-	if (retval >= 0
-			&& (_IOC_DIR(ctl->ioctl_code) & _IOC_READ) != 0
-			&& size > 0
-			&& copy_to_user(ctl->data, buf, size) != 0)
+	if (retval >= 0 && (_IOC_DIR(ctl->ioctl_code) & _IOC_READ) != 0 &&
+		size > 0 && copy_to_user(ctl->data, buf, size) != 0)
 		retval = -EFAULT;
-
+exit:
 	kfree(buf);
 	return retval;
 }
-- 
2.18.0

