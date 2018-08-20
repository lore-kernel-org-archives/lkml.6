Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D40EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D2420C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiclI4tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D2420C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHTMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:33:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34154 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeHTMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:33:56 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so6823635plo.1;
        Mon, 20 Aug 2018 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tghwBLWOV/3T54AesfMEpwuCXEdCsQ4AGc/KQoGqp0c=;
        b=EiclI4tXnRwVOkFQr3jMKa4vXfrSvCjB3yzLF2zftXzF7gnXhNupizk0aVE/MerhTK
         ezEPJYs7aw9O6Z0aThokSkf4K5nyY8BOk8XwbF3+q1fAJv1114v1ojQyPER8rb3/jVu4
         QMYAQZDe4IH8eG+58d2wF07wq8v71mZm6rT4TJH4kg4AfdZ10Cz5r6V3GRhYuxgDwbKH
         fERAqxHkpoeJl3OsVm4cFmAkeW+VMuk2+3HTr4g8rzK7dPsLCmubKk+/htynba+A2gQ8
         hNGygCdOPMXiHPN46/ads65FiavrojwHRKzl2wdXlt4s5b7XnpfRsY9XkGVv/v8X+yF5
         owcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tghwBLWOV/3T54AesfMEpwuCXEdCsQ4AGc/KQoGqp0c=;
        b=XL4r7pdppaxirAQ1/p76mezEPlf8ETL13kQidEl4+V3HuJLRjdlOMPCMuEX4mGsvge
         Gw+qDIhe+4eCbmWwcshYKmPkDosa/SEtHeeAtDae0mnJ6OeeLaTkpDY19Lsw/CU4U+FV
         4xBWZqugHPMsWeBC8aoxzXzT/nhINUV1eR7H9CXGcfVDnfjzbiAxWMxSm/+jlg6ftXgx
         S0BV9krAFeetyvweEe7mp/PlnInlkeyl7Yn1iX4dW1H3bmv4sB5YUu+ysm9C5vVCYZzI
         JE2fe2gD9A49XcUl6gDlXyXQprshqyamvcbAxWu2SciMpZvkaE2ljaIbsRSMac6wMKqq
         HXPw==
X-Gm-Message-State: AOUpUlFlbg9eWvTK4RhdIcuErwZRN1XOzkI7EGOoie8NfTEHSPeIB51Y
        M/IEetgRL+g7HaNKw3zuQJmClk0=
X-Google-Smtp-Source: AA+uWPyGN8Aku2pW8kUgzbanBOBapj+a7KBI2mXGngHq3+gVqqFfXfOtvx25C+3Er6bMvw3r1uqFxQ==
X-Received: by 2002:a17:902:528a:: with SMTP id a10-v6mr44659742pli.199.1534756745190;
        Mon, 20 Aug 2018 02:19:05 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-v6sm16166340pfd.117.2018.08.20.02.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 02:19:04 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drivers/base: clean up unused devices_kset_move_*() functions
Date:   Mon, 20 Aug 2018 17:18:37 +0800
Message-Id: <1534756717-25553-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, shutdown seq is unified with PM, and there is no need to maintain the
"parent <- child" or "supplier <- consumer" order in devices_kset any more,
hence removing the corresponding routines

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/base.h |  1 -
 drivers/base/core.c | 56 -----------------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7..fcb213b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -133,7 +133,6 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
-extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
 extern void module_add_driver(struct module *mod, struct device_driver *drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7c83384..99fdc57 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
 
-	/*
-	 * Devices that have not been registered yet will be put to the ends
-	 * of the lists during the registration, so skip them here.
-	 */
-	if (device_is_registered(dev))
-		devices_kset_move_last(dev);
-
 	if (device_pm_initialized(dev))
 		device_pm_move_last(dev);
 
@@ -1316,52 +1309,6 @@ static DEVICE_ATTR_RO(dev);
 struct kset *devices_kset;
 
 /**
- * devices_kset_move_before - Move device in the devices_kset's list.
- * @deva: Device to move.
- * @devb: Device @deva should come before.
- */
-static void devices_kset_move_before(struct device *deva, struct device *devb)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s before %s\n",
-		 dev_name(deva), dev_name(devb));
-	spin_lock(&devices_kset->list_lock);
-	list_move_tail(&deva->kobj.entry, &devb->kobj.entry);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
- * devices_kset_move_after - Move device in the devices_kset's list.
- * @deva: Device to move
- * @devb: Device @deva should come after.
- */
-static void devices_kset_move_after(struct device *deva, struct device *devb)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s after %s\n",
-		 dev_name(deva), dev_name(devb));
-	spin_lock(&devices_kset->list_lock);
-	list_move(&deva->kobj.entry, &devb->kobj.entry);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
- * devices_kset_move_last - move the device to the end of devices_kset's list.
- * @dev: device to move
- */
-void devices_kset_move_last(struct device *dev)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s to end of list\n", dev_name(dev));
-	spin_lock(&devices_kset->list_lock);
-	list_move_tail(&dev->kobj.entry, &devices_kset->list);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
  * device_create_file - create sysfs attribute file for device.
  * @dev: device.
  * @attr: device attribute descriptor.
@@ -2834,15 +2781,12 @@ int device_move(struct device *dev, struct device *new_parent,
 		break;
 	case DPM_ORDER_DEV_AFTER_PARENT:
 		device_pm_move_after(dev, new_parent);
-		devices_kset_move_after(dev, new_parent);
 		break;
 	case DPM_ORDER_PARENT_BEFORE_DEV:
 		device_pm_move_before(new_parent, dev);
-		devices_kset_move_before(new_parent, dev);
 		break;
 	case DPM_ORDER_DEV_LAST:
 		device_pm_move_last(dev);
-		devices_kset_move_last(dev);
 		break;
 	}
 
-- 
2.7.4

