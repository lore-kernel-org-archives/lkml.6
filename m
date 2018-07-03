Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E86C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1551C208FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8r1qZAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1551C208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbeGCGvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:51:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38510 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbeGCGvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:51:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so505881pgf.5;
        Mon, 02 Jul 2018 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TXQBgUrpFuHfd5+LvClU01eky3CM9TxFnoMItwpkzv0=;
        b=E8r1qZALHqIGg1WF8yStaNZz81lteokOux2GU2D3LlhOz1ksJbJNYA4UPZ6m/JG4N/
         qG2FJTHUxoCrkzFxwO0AjO9VRGTjvUynfpmx3F2IE18TrrZIPLXJNL18/kM2r9sbQTPI
         hz7s3+qkcd9Cj3D3trayVvY4FpwxcP0J8bhJprCwbc4w2+bu0DUPzdR0fm/DCvWo0qwl
         1vKl+MzdkSls7DVRwz9yi1uZ6fCkNO34WVcNVtfF3hlqV1WqdT832QJ1FTShEq/iMjpp
         5GNa5ve12EstO5uO40CulO+yr4OB6cxvb4GLWeJD2Dx1PO7UG6ecvVclrY3g9XmAb1PR
         VwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TXQBgUrpFuHfd5+LvClU01eky3CM9TxFnoMItwpkzv0=;
        b=ZeqysJ51Bl+tY0DE8Q+8YUKVYsDJLGD6XsVx58Qpxnzecy2CkbR2DrexOAWPZ+PCVj
         nvpU6eUCqaeAJV2CQqlL6OCgp0d9vrPz1a1C6DxtA6Fu4YlstbTOvjaMnZoKm7JFqEeE
         /omy/ra05dPj2PC3tIb68tvbubuAqU2UHo+YxXDJRBBvVZ9pkbJq/DopoDajK1vPbqL1
         7KXbLfEmmY57PCSyENYfWDpwdLav5As3PWnjKApTwCNZU7znX/A7zRijyC030I3/IsPw
         rsOwMW3uhlDoFfqKY72L3WDF+zw0UGMmFvoYYlFHeOUrIVM9TH6FVvasH9QCoaguyFPp
         ur+g==
X-Gm-Message-State: APt69E1tEqo27OS4YyEFZXzFKJcvjo/ItN+wj6rNSFUmGWBgjpD0NHGF
        GdKciM145ewRcIsChzCQk9Js
X-Google-Smtp-Source: ADUXVKIsyrhMEDGcj3FLR5qX06Is3G/1e7BmbsyqvF94o3T4VEPJGjCgrNPry/qjR7D83IJJgQ41NQ==
X-Received: by 2002:a65:5683:: with SMTP id v3-v6mr23783860pgs.176.1530600708137;
        Mon, 02 Jul 2018 23:51:48 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e189-v6sm981122pfe.52.2018.07.02.23.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 23:51:47 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 4/4] Revert "driver core: correct device's shutdown order"
Date:   Tue,  3 Jul 2018 14:50:42 +0800
Message-Id: <1530600642-25090-5-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 52cdbdd49853dfa856082edb0f4c4c0249d9df07.
Since the device_shutdown() does not rely on the order in devices_kset any
more, reverting that commit safely.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/base.h |  1 -
 drivers/base/core.c | 49 -------------------------------------------------
 drivers/base/dd.c   |  8 --------
 3 files changed, 58 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a75c302..5bc9064 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -135,7 +135,6 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
-extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
 extern void module_add_driver(struct module *mod, struct device_driver *drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index db3deb8..570aeee 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1259,52 +1259,6 @@ static DEVICE_ATTR_RO(dev);
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
@@ -2776,15 +2730,12 @@ int device_move(struct device *dev, struct device *new_parent,
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
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..6ebcd65 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -434,14 +434,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	/*
-	 * Ensure devices are listed in devices_kset in correct order
-	 * It's important to move Dev to the end of devices_kset before
-	 * calling .probe, because it could be recursive and parent Dev
-	 * should always go first
-	 */
-	devices_kset_move_last(dev);
-
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
-- 
2.7.4

