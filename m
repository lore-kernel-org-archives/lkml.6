Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeCGKCW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:02:22 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45106 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeCGKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:02:18 -0500
X-Google-Smtp-Source: AG47ELuVKQyFTFW6jo4k03ngDzPr2HiDGDDpfoa3m0TL4bLvlgVjcOge063I3GpinBodyr48xqDhdg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: m@bues.ch
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH] ssb:: use put_device() if device_register fail
Date: Wed,  7 Mar 2018 15:31:30 +0530
Message-Id: <bdd20c00cba68044d82e387072b39f0176448e97.1520416785.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ssb/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 65420a9..c4449e0 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -521,6 +521,7 @@ static int ssb_devices_register(struct ssb_bus *bus)
 			ssb_err("Could not register %s\n", dev_name(dev));
 			/* Set dev to NULL to not unregister
 			 * dev on error unwinding. */
+			put_device(dev);
 			sdev->dev = NULL;
 			kfree(devwrap);
 			goto error;
-- 
1.9.1
