Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E735C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0941223E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3esPltX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0941223E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeHJFt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37335 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeHJFt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so3832240pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZB4Uz61EhjUo+qimKERp3DQ1UreOcxOPyIdQ+erSog=;
        b=l3esPltX7ncHlokPkZ8yymTAZonwau4MTYqZ8x+AE5bljBMz6X5W72SzVO5dD63FJw
         Hf8tZOOD4HRR7fzBiBLBXq9mPKmFredM5da7rHv1hnEYXgNwwE6J1V9UUvWWgyECxZ7M
         o+3m4Rz28gJbpft+rV4QVurBI/8qvwfzPOKbbc7192mBUlfYbttj0dFkeLaJxtuvdZpV
         nsUt/F0ZVwzKU5FxUVDaNN2NJ1MDM2skHYxXpWDkCIHfTbZnVC4uDcdRfbasz7MdATu5
         Q9TGTH+/BXVhGxrvj7uglY76S1jwfhsGKQ5bMwLUit+py3MulnedKWbRz8b2SRI8rWIU
         J2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZB4Uz61EhjUo+qimKERp3DQ1UreOcxOPyIdQ+erSog=;
        b=aWeJMJpJ4pkee2reR09qfFYDC96l1r4j0f1JixZ4UZG6tSInr53lK+5fz7Adn1I05e
         B/emDXNyXN0djXq4UOZ7PZAK+OsOpH2MWK41hpXPlvYluzJbxsG+mmZeK1677WnN0WfD
         lqNlE4d4ZqNIoNhmEGEUhD69Tke/lkvrtsVcuhqc0Rn0LmQ/Nb6zzCsGV5/ofYrfdH+0
         SXCKX1pNo7hKVGvxPD95+7aZ5mJz17ZYYRKd0+4OchCu4xeyxseoxsrfyY8OBfC7uhjR
         OFWx2xfSzzdV8248ghwCmUHsSMDYIRsVKNbIQx5xpxlpF4HIwrUpwJvvh9jyD4spwjHL
         hGFg==
X-Gm-Message-State: AOUpUlHuVtRIUMBWhh6jUPHgo77glax9OeqE80goL42MtdMoIq2j/NDu
        sgOoP0gXULocKlCUQDfILJE=
X-Google-Smtp-Source: AA+uWPzk625FeH5mRXwCmyh7Pbie+mHNAtFZYZPIh60eIdGLXRiYwxZA6oSQCF5+kwO1EcHuL+41ZA==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr4649052pga.453.1533871294017;
        Thu, 09 Aug 2018 20:21:34 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:33 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/16] staging: gasket: core: factor out generic device add code from PCI code
Date:   Thu,  9 Aug 2018 20:21:06 -0700
Message-Id: <20180810032111.197743-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Split out generic gasket device add code from the code for adding a PCI
gasket device, in prep for other gasket device types in the future.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 76 ++++++++++++++++++----------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index aee819f379e9a..ce8ae226f82d9 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1419,6 +1419,48 @@ int gasket_enable_device(struct gasket_dev *gasket_dev)
 }
 EXPORT_SYMBOL(gasket_enable_device);
 
+static int __gasket_add_device(struct device *parent_dev,
+			       struct gasket_internal_desc *internal_desc,
+			       struct gasket_dev **gasket_devp)
+{
+	int ret;
+	struct gasket_dev *gasket_dev;
+	const struct gasket_driver_desc *driver_desc =
+	    internal_desc->driver_desc;
+
+	ret = gasket_alloc_dev(internal_desc, parent_dev, &gasket_dev);
+	if (ret)
+		return ret;
+	if (IS_ERR(gasket_dev->dev_info.device)) {
+		dev_err(parent_dev, "Cannot create %s device %s [ret = %ld]\n",
+			driver_desc->name, gasket_dev->dev_info.name,
+			PTR_ERR(gasket_dev->dev_info.device));
+		ret = -ENODEV;
+		goto free_gasket_dev;
+	}
+
+	ret = gasket_sysfs_create_mapping(gasket_dev->dev_info.device,
+					  gasket_dev);
+	if (ret)
+		goto remove_device;
+
+	ret = gasket_sysfs_create_entries(gasket_dev->dev_info.device,
+					  gasket_sysfs_generic_attrs);
+	if (ret)
+		goto remove_sysfs_mapping;
+
+	*gasket_devp = gasket_dev;
+	return 0;
+
+remove_sysfs_mapping:
+	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
+remove_device:
+	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
+free_gasket_dev:
+	gasket_free_dev(gasket_dev);
+	return ret;
+}
+
 /*
  * Add PCI gasket device.
  *
@@ -1433,7 +1475,6 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	int ret;
 	struct gasket_internal_desc *internal_desc;
 	struct gasket_dev *gasket_dev;
-	const struct gasket_driver_desc *driver_desc;
 	struct device *parent;
 
 	dev_dbg(&pci_dev->dev, "add PCI gasket device\n");
@@ -1447,29 +1488,15 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 		return -ENODEV;
 	}
 
-	driver_desc = internal_desc->driver_desc;
-
 	parent = &pci_dev->dev;
-	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev);
+	ret = __gasket_add_device(parent, internal_desc, &gasket_dev);
 	if (ret)
 		return ret;
-	gasket_dev->pci_dev = pci_dev;
-	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
-		pr_err("Cannot create %s device %s [ret = %ld]\n",
-		       driver_desc->name, gasket_dev->dev_info.name,
-		       PTR_ERR(gasket_dev->dev_info.device));
-		ret = -ENODEV;
-		goto fail1;
-	}
 
+	gasket_dev->pci_dev = pci_dev;
 	ret = gasket_setup_pci(pci_dev, gasket_dev);
 	if (ret)
-		goto fail2;
-
-	ret = gasket_sysfs_create_mapping(gasket_dev->dev_info.device,
-					  gasket_dev);
-	if (ret)
-		goto fail3;
+		goto cleanup_pci;
 
 	/*
 	 * Once we've created the mapping structures successfully, attempt to
@@ -1480,23 +1507,16 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	if (ret) {
 		dev_err(gasket_dev->dev,
 			"Cannot create sysfs pci link: %d\n", ret);
-		goto fail3;
+		goto cleanup_pci;
 	}
-	ret = gasket_sysfs_create_entries(gasket_dev->dev_info.device,
-					  gasket_sysfs_generic_attrs);
-	if (ret)
-		goto fail4;
 
 	*gasket_devp = gasket_dev;
 	return 0;
 
-fail4:
-fail3:
-	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
-fail2:
+cleanup_pci:
 	gasket_cleanup_pci(gasket_dev);
+	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
 	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
-fail1:
 	gasket_free_dev(gasket_dev);
 	return ret;
 }
-- 
2.18.0.597.ga71716f1ad-goog

