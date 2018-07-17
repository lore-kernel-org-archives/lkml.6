Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1F20C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTD67los"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA1F20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGQCkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46175 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbeGQCkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so16091160pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tsTxvelgfSZt9NoU/bVE4xvBM75NVHnvM1mRkKNrPNE=;
        b=tTD67losWJpdQUFFeaGrrQ0y+NMzB33u6r6Z/R9sbl4g4DyYg1EVtu2qbFKvm/kRE8
         eB4Nu8c3eXPmaBh0BrzD6iznfV8sP+ArEF1TflwUPsCeUIv7bYvcXNpNnccpOARHd7N9
         r3sE21pI+83x+0OwSfnN0+ncE9sKcWPsveg9sv00tZtRmIHekyH4qIu0tkB2XyqSbiQG
         VyDbOZR4XPwRLulDc5QKv6Vk5thZuQijcIpYHpnmNH3TAQGgQI6U3dEeJmfUJ+UMBR0D
         bGaJ4XI8ZYMnWbaGBVNmEMc8KvEmXA+VXhU6ywh2nS5cK8NIiaGCzDWnMFEWYlFIpkGh
         oVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tsTxvelgfSZt9NoU/bVE4xvBM75NVHnvM1mRkKNrPNE=;
        b=ta7hHXL9uedfREcAZ9ViZaTgMwlBWbUVB0UXoa0FfXz/Adye7QDb7Sbrb8lIeCJ7/D
         Yv4p9eOaaFDvAhxQwI05Rp6WuaSAXeGwk94dAqPovf/GHwstLI4np471PqnA0Q+FUIQD
         dMsAbsQGNrjx/2p8S9X5mRfzlYgwgGR+f2XOZiaPEje67wDNaQ0eyIUXAUpE9WXK1NO1
         QYOWvz0W/fWfb38yo6lxVh2zGjKBEjsqQLIq20sQIYhssBGLoqxv4SvG1TCg+edMjJzv
         FLl1Hlb/v5/X/UnbncGq/GamFj9QxJPifBujvdxryziltsNOhRFhA6bYOzSjsgcwGkne
         f/QQ==
X-Gm-Message-State: AOUpUlHSCVarNT/gQOvenuxGiLnPtuTCAW0H6Rnl5HOoqIdukiOejdRs
        W/HvQCluRhqVgq3oz8lrTyY=
X-Google-Smtp-Source: AAOMgpel+pBVmuHdrU8z7NLwRULTLUVW0SPg1X2W/vwlPt3lX9HgwG1vA7l90xsfIwme0ZwcomTd2g==
X-Received: by 2002:a17:902:1682:: with SMTP id h2-v6mr18750183plh.327.1531793406246;
        Mon, 16 Jul 2018 19:10:06 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:05 -0700 (PDT)
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
Date:   Mon, 16 Jul 2018 19:09:09 -0700
Message-Id: <20180717020926.176408-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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
index 4808bac93f983..ae20b7ff9569b 100644
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

