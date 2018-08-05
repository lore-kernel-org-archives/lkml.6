Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A5C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C3A21916
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPXfub9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C3A21916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHEWOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46218 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14-v6so4692247pgv.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssbdcD1ykLGn6TARFvIWZV/VC3RVIch5AXLIl8s2xhU=;
        b=GPXfub9dydNLZa8XN4Z8EpEywpRykQ5v/gapw/WVd/cN0KRIaegqNnVLGvf+KaCqk5
         IHclLWE6n4BYIE5kp05wBYquCMVMrnIQj3zfLhs5t1icnIjbWgITPZbRDr04LSLkXGu4
         d0wmEsB5ugpg/7i7liYxUinnXNbgEUCSrAwXDwo6sCb8ZBr8ljjYQROfj+6QHNpYST3k
         utI73OnMXW7TCMZ78vrrzDt9eW40eXyqXhp0znM9gaRKw8HGskd5Fc+kthnkQc3WFVR4
         aJzCx74hJ8S4R6P5inH+gsONEElrzvtcT6uIvVEnqysTxBO4Awm7OB1S+zLnGOQ9nuVA
         TbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssbdcD1ykLGn6TARFvIWZV/VC3RVIch5AXLIl8s2xhU=;
        b=AhEbvHXYC1naFm0swr6O+N7fZ75Kpm12QGpHdRC+1aOQbi5c7gF+ryH16Gvv6mR9+3
         IwliN9XcIRbFPUvbkMj2CijiwEon2vr603ewlT6l0zA7aKmrIr8FQP1SHQN+Kts/Y1VL
         lVzlhmvbPC8g6GSUvzHKg3FOgtx5fxuq9Y7GUrpJQdYxnw4d10f4p3n6JfURTAR5DQ+4
         0Bud2I7YGrkQH0XVAkG5BBpmEz0g9nTJBKh3V/kW7pPhjD2zXvrRH9GfS7UmEoUYKI5I
         heGATx/pRjsYiCzdZ2LjphGz3JMRpgJRjHWdAqTU66qS54ibFvGChzg09DpgBkA87HYb
         VKoQ==
X-Gm-Message-State: AOUpUlER9revUU6RGtgwBIkz6J+ViSnoDRLA7wX+JVcFpfRLqKrrxWyj
        59O1piElVLZbKxUrsYWBFEk=
X-Google-Smtp-Source: AAOMgpexZZY5mZyAzo4jDn1dvCAxIBWG3Q6Gt1vpVh4OJ3/G7I1a3PHWtKe8x3YXYtqfYSYWt3jZAA==
X-Received: by 2002:a63:1546:: with SMTP id 6-v6mr11999959pgv.271.1533499695852;
        Sun, 05 Aug 2018 13:08:15 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:15 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/15] staging: gasket: core: move core PCI calls to device drivers
Date:   Sun,  5 Aug 2018 13:07:36 -0700
Message-Id: <20180805200749.116693-3-toddpoynor@gmail.com>
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

Remove gasket wrapping of PCI probe, enable, disable, and remove
functions.  Replace with calls to add and remove PCI gasket devices,
to be called by the gasket device drivers.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 82 ++++++++--------------------
 drivers/staging/gasket/gasket_core.h |  6 ++
 2 files changed, 28 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2d209e36cf372..01cafe1ff6605 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -51,9 +51,6 @@ struct gasket_internal_desc {
 	/* Kernel-internal device class. */
 	struct class *class;
 
-	/* PCI subsystem metadata associated with this driver. */
-	struct pci_driver pci;
-
 	/* Instantiated / present devices of this type. */
 	struct gasket_dev *devs[GASKET_DEV_MAX];
 };
@@ -368,10 +365,10 @@ static void gasket_unmap_pci_bar(struct gasket_dev *dev, int bar_num)
 }
 
 /*
- * Setup PCI & set up memory mapping for the specified device.
+ * Setup PCI memory mapping for the specified device.
  *
- * Enables the PCI device, reads the BAR registers and sets up pointers to the
- * device's memory mapped IO space.
+ * Reads the BAR registers and sets up pointers to the device's memory mapped
+ * IO space.
  *
  * Returns 0 on success and a negative value otherwise.
  */
@@ -380,14 +377,6 @@ static int gasket_setup_pci(struct pci_dev *pci_dev,
 {
 	int i, mapped_bars, ret;
 
-	ret = pci_enable_device(pci_dev);
-	if (ret) {
-		dev_err(gasket_dev->dev, "cannot enable PCI device\n");
-		return ret;
-	}
-
-	pci_set_master(pci_dev);
-
 	for (i = 0; i < GASKET_NUM_BARS; i++) {
 		ret = gasket_map_pci_bar(gasket_dev, i);
 		if (ret) {
@@ -402,19 +391,16 @@ static int gasket_setup_pci(struct pci_dev *pci_dev,
 	for (i = 0; i < mapped_bars; i++)
 		gasket_unmap_pci_bar(gasket_dev, i);
 
-	pci_disable_device(pci_dev);
 	return -ENOMEM;
 }
 
-/* Unmaps memory and cleans up PCI for the specified device. */
+/* Unmaps memory for the specified device. */
 static void gasket_cleanup_pci(struct gasket_dev *gasket_dev)
 {
 	int i;
 
 	for (i = 0; i < GASKET_NUM_BARS; i++)
 		gasket_unmap_pci_bar(gasket_dev, i);
-
-	pci_disable_device(gasket_dev->pci_dev);
 }
 
 /* Determine the health of the Gasket device. */
@@ -1443,15 +1429,14 @@ static int gasket_enable_dev(struct gasket_internal_desc *internal_desc,
 }
 
 /*
- * PCI subsystem probe function.
- *
- * Called when a Gasket device is found. Allocates device metadata, maps device
- * memory, and calls gasket_enable_dev to prepare the device for active use.
+ * Add PCI gasket device.
  *
- * Returns 0 if successful and a negative value otherwise.
+ * Called by Gasket device probe function.
+ * Allocates device metadata, maps device memory, and calls gasket_enable_dev
+ * to prepare the device for active use.
  */
-static int gasket_pci_probe(struct pci_dev *pci_dev,
-			    const struct pci_device_id *id)
+int gasket_pci_add_device(struct pci_dev *pci_dev,
+			  struct gasket_dev **gasket_devp)
 {
 	int ret;
 	const char *kobj_name = dev_name(&pci_dev->dev);
@@ -1460,13 +1445,14 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 	const struct gasket_driver_desc *driver_desc;
 	struct device *parent;
 
-	pr_info("Add Gasket device %s\n", kobj_name);
+	pr_debug("add PCI device %s\n", kobj_name);
 
 	mutex_lock(&g_mutex);
 	internal_desc = lookup_internal_desc(pci_dev);
 	mutex_unlock(&g_mutex);
 	if (!internal_desc) {
-		pr_err("PCI probe called for unknown driver type\n");
+		dev_err(&pci_dev->dev,
+			"PCI add device called for unknown driver type\n");
 		return -ENODEV;
 	}
 
@@ -1530,6 +1516,7 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 		goto fail5;
 	}
 
+	*gasket_devp = gasket_dev;
 	return 0;
 
 fail5:
@@ -1545,14 +1532,10 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 	gasket_free_dev(gasket_dev);
 	return ret;
 }
+EXPORT_SYMBOL(gasket_pci_add_device);
 
-/*
- * PCI subsystem remove function.
- *
- * Called to remove a Gasket device. Finds the device in the device list and
- * cleans up metadata.
- */
-static void gasket_pci_remove(struct pci_dev *pci_dev)
+/* Remove a PCI gasket device. */
+void gasket_pci_remove_device(struct pci_dev *pci_dev)
 {
 	int i;
 	struct gasket_internal_desc *internal_desc;
@@ -1583,8 +1566,8 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
 	if (!gasket_dev)
 		return;
 
-	pr_info("remove %s device %s\n", internal_desc->driver_desc->name,
-		gasket_dev->kobj_name);
+	dev_dbg(gasket_dev->dev, "remove %s PCI gasket device\n",
+		internal_desc->driver_desc->name);
 
 	gasket_disable_dev(gasket_dev);
 	gasket_cleanup_pci(gasket_dev);
@@ -1597,6 +1580,7 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
 	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
 	gasket_free_dev(gasket_dev);
 }
+EXPORT_SYMBOL(gasket_pci_remove_device);
 
 /**
  * Lookup a name by number in a num_name table.
@@ -1770,11 +1754,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal = &g_descs[desc_idx];
 	mutex_init(&internal->mutex);
 	memset(internal->devs, 0, sizeof(struct gasket_dev *) * GASKET_DEV_MAX);
-	memset(&internal->pci, 0, sizeof(internal->pci));
-	internal->pci.name = driver_desc->name;
-	internal->pci.id_table = driver_desc->pci_id_table;
-	internal->pci.probe = gasket_pci_probe;
-	internal->pci.remove = gasket_pci_remove;
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
@@ -1785,33 +1764,18 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		goto unregister_gasket_driver;
 	}
 
-	/*
-	 * Not using pci_register_driver() (without underscores), as it
-	 * depends on KBUILD_MODNAME, and this is a shared file.
-	 */
-	ret = __pci_register_driver(&internal->pci, driver_desc->module,
-				    driver_desc->name);
-	if (ret) {
-		pr_err("cannot register %s pci driver [ret=%d]\n",
-		       driver_desc->name, ret);
-		goto fail1;
-	}
-
 	ret = register_chrdev_region(MKDEV(driver_desc->major,
 					   driver_desc->minor), GASKET_DEV_MAX,
 				     driver_desc->name);
 	if (ret) {
 		pr_err("cannot register %s char driver [ret=%d]\n",
 		       driver_desc->name, ret);
-		goto fail2;
+		goto destroy_class;
 	}
 
 	return 0;
 
-fail2:
-	pci_unregister_driver(&internal->pci);
-
-fail1:
+destroy_class:
 	class_destroy(internal->class);
 
 unregister_gasket_driver:
@@ -1848,8 +1812,6 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	unregister_chrdev_region(MKDEV(driver_desc->major, driver_desc->minor),
 				 GASKET_DEV_MAX);
 
-	pci_unregister_driver(&internal_desc->pci);
-
 	class_destroy(internal_desc->class);
 
 	/* Finally, effectively "remove" the driver. */
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 67f5960943a8a..9f9bc66a0daa0 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -607,6 +607,12 @@ int gasket_register_device(const struct gasket_driver_desc *desc);
  */
 void gasket_unregister_device(const struct gasket_driver_desc *desc);
 
+/* Add a PCI gasket device. */
+int gasket_pci_add_device(struct pci_dev *pci_dev,
+			  struct gasket_dev **gasket_devp);
+/* Remove a PCI gasket device. */
+void gasket_pci_remove_device(struct pci_dev *pci_dev);
+
 /*
  * Reset the Gasket device.
  * @gasket_dev: Gasket device struct.
-- 
2.18.0.597.ga71716f1ad-goog

