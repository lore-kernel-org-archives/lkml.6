Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66450ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C57B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCaXsBQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGQVjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46913 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so1081404pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=spfKPJapcjAqYHmM8PHMImRoo/pf564doGGH7tS/BT0=;
        b=kCaXsBQpMKg/CVp/0nrVHZoAtu/jC9jdwL/bHGUAOKCEkflq83QOqtjTZ2vFHD57xu
         ADCQ6JTBi6Lq6KZ3/xyAr6sgI7xaA1/QWPv9WbnIbxGtoMnnmXRZtJiKEFij8UfiZt8a
         5ZWDE2/hpHCEB6L/SIszSLGPEdyTydOADejSEeWzGdoZWZXutENfPheNPZ4Qui1BdIIc
         ges7R/uB/XN3ghQZ0FedmnujINSLOVerLFu3DKpzj8p8fRoM1vez6YSZ4gapHsaDvDI0
         /xdBjvRtBmnscP2SoY4jiOHyYCw2DPE7cmI9R9Mx5SN18h2S7QlFMRtnYzy2hg2thTFG
         a7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=spfKPJapcjAqYHmM8PHMImRoo/pf564doGGH7tS/BT0=;
        b=oCo33EyX3X6eL+9oobiOs0lgHw2yeKb1NBJkr8oaN4qvC5/EALU8pXvBoUUS/c7E84
         i/Jtu0nbTuadvO+u1ZBQdxg+y6CCqgf+5Cg1p2KqRv8uFuaJ2TpP/1nsin2EMpj82VYX
         DIU3NBLmcMXaUpf7JQ2oyQvzY/4KrpJ+P8r9bUo2GbOIEo0GxrXD6p06IuEfzGJo292q
         bVhagVxR4f8Y/bbKPjNjkXm/7bQ41px1z+s74AKKiN4RN41wnf6Ydw0tvQSkceK2xyiJ
         2ZQKjzQ+9yY5JzYhtc4PsxyHWQhaPg+HtZ4tJtAnLjoCI6hxGoRK4Aa52PjjBD5guWfo
         z5Kg==
X-Gm-Message-State: AOUpUlFtyB2dTEkqjmO/1YTKlNKXEl1Kx8edbp40SVml7kly7pRMFtw/
        GkWNeFrvWiLdvOs0zAFy06bMTY9X
X-Google-Smtp-Source: AAOMgpeKKCv/vOf5RKWdyikiZhw4e2Co1EKZsQWXuH+UwMHAL8UB17l32MWlaoXP79ZBSwEkS3pxAQ==
X-Received: by 2002:a63:314f:: with SMTP id x76-v6mr3012238pgx.373.1531861503071;
        Tue, 17 Jul 2018 14:05:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 15/32] staging: gasket: drop gasket_cdev_get_info, use container_of
Date:   Tue, 17 Jul 2018 13:56:55 -0700
Message-Id: <20180717205712.29495-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove gasket_cdev_get_info(), use container_of() directly instead,
drop unnecessary NULL checks.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index bc3662eafb63d..0d5ba7359af73 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -233,18 +233,6 @@ static inline int gasket_check_and_invoke_callback_nolock(
 	return ret;
 }
 
-/*
- * Retrieve device-specific data via cdev pointer.
- * @cdev_ptr: Character device pointer associated with the device.
- *
- * This function returns the pointer to the device-specific data allocated in
- * add_dev_cb for the device associated with cdev_ptr.
- */
-static struct gasket_cdev_info *gasket_cdev_get_info(struct cdev *cdev_ptr)
-{
-	return container_of(cdev_ptr, struct gasket_cdev_info, cdev);
-}
-
 /*
  * Returns nonzero if the gasket_cdev_info is owned by the current thread group
  * ID.
@@ -1095,12 +1083,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	const struct gasket_driver_desc *driver_desc;
 	struct gasket_ownership *ownership;
 	char task_name[TASK_COMM_LEN];
-	struct gasket_cdev_info *dev_info = gasket_cdev_get_info(inode->i_cdev);
+	struct gasket_cdev_info *dev_info =
+	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
 
-	if (!dev_info) {
-		gasket_nodev_error("Unable to retrieve device data");
-		return -EINVAL;
-	}
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	ownership = &dev_info->ownership;
@@ -1182,11 +1167,8 @@ static int gasket_release(struct inode *inode, struct file *file)
 	const struct gasket_driver_desc *driver_desc;
 	char task_name[TASK_COMM_LEN];
 	struct gasket_cdev_info *dev_info =
-		(struct gasket_cdev_info *)gasket_cdev_get_info(inode->i_cdev);
-	if (!dev_info) {
-		gasket_nodev_error("Unable to retrieve device data");
-		return -EINVAL;
-	}
+		container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	ownership = &dev_info->ownership;
-- 
2.18.0.203.gfac676dfb9-goog

