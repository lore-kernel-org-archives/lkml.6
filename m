Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701FEC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD0C2192C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXSrFWqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD0C2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeHEWOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42316 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:13 -0400
Received: by mail-pl0-f67.google.com with SMTP id g6-v6so1154460plq.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWWaZ1vnH/YBjAqwNBqF9ILBsura1qGVzE4YUNOQJP0=;
        b=KXSrFWqWxubyOYmSJCTlu7bxzCJ0FNkeeIyktk9PKXMt8l4nUEyDPkw8o8YRs7ORq+
         hxbP9u/WKxrUfYY/3jxnSjjKO/cxrA9qvnEztyDfneMemxbgeD65ImAmFHLJlmFrMxE5
         PLPsDm82zPq4wfzyp4eDBuAunjjxeMyX8NHYVf2+fQMVWWlAQeWb/sV2D9O8iGP7PGSx
         lwMTMHbZnOk0SqzTidRd0XLM0d5AW3LruWZ1jQr1SlJ1/NqRxTWscUY6AEzUxDENa479
         xF0LcRSJKAdmdUCx/iHOI4ZHkaOM91LUbaMn7Rck5lZgzlDfSAxm0P3jX3P/sUaJ1YJ9
         YW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWWaZ1vnH/YBjAqwNBqF9ILBsura1qGVzE4YUNOQJP0=;
        b=HRyhA8cV2Mm91MxhYnq8EREVOKAX3UzE253pMLFKQ7J3vi3yIZIl+a765ZOOYFL710
         6mF7PFeBYG7Z/K/zZBZedK5WiDRvNMljpO9Zi7lSKGpyH9FHKyz8MFZ+gyiX0Pjf2DjX
         xlG6dymWZvU+7nJX3t02MFNsynDNk8mE9bGNCnYZBwucgadMAVAw0x+g+r4ian6DWfED
         0evdLakduSlOla7kSm6VOyRLqpppWDDM83zp4YhBQSo+bVp/ZkUsbSZ1ssRwXlwQ6fga
         ZGJp9gSooWfUDfNrlQ3K8j+n2vFBJ6hm3MXXSGpGtdyFSxcqQ88ogjgMPISOnQ7D2sLG
         8ZFg==
X-Gm-Message-State: AOUpUlFKKe2o/ZlJIOnXN9u550XQ87KeelWEVCMXkMS/peZjGg6iD89F
        8tDLTrfDh3I/3hlxVAflyLM=
X-Google-Smtp-Source: AAOMgpe3jDqF4t5uco7PRhdqCYm6YW8U4IP94pjOa7v53IhX0Xclu03/I43dglCqCd+r5hqF0wRZAQ==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6-v6mr11298245plr.313.1533499708610;
        Sun, 05 Aug 2018 13:08:28 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:28 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/15] staging: gasket: core: delete device add and remove callbacks
Date:   Sun,  5 Aug 2018 13:07:43 -0700
Message-Id: <20180805200749.116693-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Gasket device drivers are now in charge of orchestrating the device add
and removal sequences, so the callbacks from the framework to the device
drivers for these events are no longer needed.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 10 ----------
 drivers/staging/gasket/gasket_core.h | 29 ----------------------------
 2 files changed, 39 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index fad4883e6332c..0d76e18fcde5b 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1468,12 +1468,6 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	if (ret)
 		goto fail2;
 
-	ret = check_and_invoke_callback(gasket_dev, driver_desc->add_dev_cb);
-	if (ret) {
-		dev_err(gasket_dev->dev, "Error in add device cb: %d\n", ret);
-		goto fail2;
-	}
-
 	ret = gasket_sysfs_create_mapping(gasket_dev->dev_info.device,
 					  gasket_dev);
 	if (ret)
@@ -1512,7 +1506,6 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
 fail2:
 	gasket_cleanup_pci(gasket_dev);
-	check_and_invoke_callback(gasket_dev, driver_desc->remove_dev_cb);
 	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
 fail1:
 	gasket_free_dev(gasket_dev);
@@ -1559,9 +1552,6 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 
 	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
 	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
-
-	check_and_invoke_callback(gasket_dev, driver_desc->remove_dev_cb);
-
 	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
 	gasket_free_dev(gasket_dev);
 }
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 9c143ebeba452..0ef0a2640f0fe 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -302,12 +302,6 @@ struct gasket_dev {
 	/* Hardware revision value for this device. */
 	int hardware_revision;
 
-	/*
-	 * Device-specific data; allocated in gasket_driver_desc.add_dev_cb()
-	 * and freed in gasket_driver_desc.remove_dev_cb().
-	 */
-	void *cb_data;
-
 	/* Protects access to per-device data (i.e. this structure). */
 	struct mutex mutex;
 
@@ -415,29 +409,6 @@ struct gasket_driver_desc {
 	int interrupt_pack_width;
 
 	/* Driver callback functions - all may be NULL */
-	/*
-	 * add_dev_cb: Callback when a device is found.
-	 * @dev: The gasket_dev struct for this driver instance.
-	 *
-	 * This callback should initialize the device-specific cb_data.
-	 * Called when a device is found by the driver,
-	 * before any BAR ranges have been mapped. If this call fails (returns
-	 * nonzero), remove_dev_cb will be called.
-	 *
-	 */
-	int (*add_dev_cb)(struct gasket_dev *dev);
-
-	/*
-	 * remove_dev_cb: Callback for when a device is removed from the system.
-	 * @dev: The gasket_dev struct for this driver instance.
-	 *
-	 * This callback should free data allocated in add_dev_cb.
-	 * Called immediately before a device is unregistered by the driver.
-	 * All framework-managed resources will have been cleaned up by the time
-	 * this callback is invoked (PCI BARs, character devices, ...).
-	 */
-	int (*remove_dev_cb)(struct gasket_dev *dev);
-
 	/*
 	 * device_open_cb: Callback for when a device node is opened in write
 	 * mode.
-- 
2.18.0.597.ga71716f1ad-goog

