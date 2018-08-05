Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2619C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F6D21920
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7JMmtHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F6D21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeHEWOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35989 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id h12-v6so5219683pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIfWKzo+9VbS1sLYxT/Twzq48RXXCzrmzJzdB6N3Am8=;
        b=n7JMmtHav/PMEnJVm3BECinufWZN3WEueBAkjPCaLv61sSmSX301rDQbVmlj1wpMDN
         O8K3hnWeWxfTEdiYTQ8B6tjO113kMiqrQTX7gYuszpP5ov9Jr3tTkYZL/vDP8xEg77SV
         bXkZ3MECejKmDkTBGl4SXqSjNmYyhypa+oskHXUWQCrienl2uFOMMn38bQOUY9PxQbdr
         +guPJIrBileJNidfkJzfIRrR+ps/cUHa5q7DhXwMNHyiyPW+MzX7Nh1muvFqcijPU2MG
         d8Arbf2hwwSui0yNaNU9kbavQ53N4U/eVRayU9uCz3AifobLWRjCDcMuLlN9enBctD/G
         or9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIfWKzo+9VbS1sLYxT/Twzq48RXXCzrmzJzdB6N3Am8=;
        b=FX/6UZ1GsnzXxRV6yftHPMz9ywNB6ZMhb9paIqXlIxDTcm4dFWegkH8O7Etj+s1QI3
         44wvXOcnGtqId20iNRnaE00RHnxDZSI8A5Wt1yj3pcZeuRREk4DQT1CuGgMKUAJ9Bako
         yzrg/CWDQDxhmbVpaBq+vdvGzWvhptADlZ0AysMnTH2oJ3Q2tsS06NGeULCaLhxBwV2R
         iCUk5BLtbHHeg9BwR6Lx3O8NKHIpMZx/Zmtm+p+k6uJzpD0eKToPKXGdJ28wwt1MEPl1
         fSbzLBj/4Y3j/gmF7b+V4p7h3JVBC96/wVDgjAZAig8yarrmc6Us6FxVjW6lJ5yLBViz
         FsZQ==
X-Gm-Message-State: AOUpUlFNTkgl0YLTv3ckhJbE1lOS9gTPGeyQp5uw5q6XPNu2A+wg9M+8
        9e3JpNfDntvrYM+XdjSYWXg=
X-Google-Smtp-Source: AAOMgpdcJBKvjgelvIHGOjgGvQ4PNkCWhzDU1YxLKcXdGzdk3QcE+BM96OglkUIx0IcPwBaidU+xNw==
X-Received: by 2002:a62:ce81:: with SMTP id y123-v6mr14194396pfg.95.1533499705288;
        Sun, 05 Aug 2018 13:08:25 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:24 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/15] staging: gasket: core: let device driver enable/disable gasket device
Date:   Sun,  5 Aug 2018 13:07:41 -0700
Message-Id: <20180805200749.116693-8-toddpoynor@gmail.com>
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

Move gasket device enable/disable functions from internal calls to
external calls from the gasket device drivers.  The device driver will
call these functions at appropriate times in its processing, placing
the device driver in control of this sequence and reducing the need for
callbacks from framework back to the device drivers during the
enable/disable sequences.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 22 ++++++++--------------
 drivers/staging/gasket/gasket_core.h |  6 ++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b070efaf0d41c..fad4883e6332c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -628,7 +628,7 @@ static int gasket_add_cdev(struct gasket_cdev_info *dev_info,
 }
 
 /* Disable device operations. */
-static void gasket_disable_dev(struct gasket_dev *gasket_dev)
+void gasket_disable_device(struct gasket_dev *gasket_dev)
 {
 	const struct gasket_driver_desc *driver_desc =
 		gasket_dev->internal_desc->driver_desc;
@@ -649,6 +649,7 @@ static void gasket_disable_dev(struct gasket_dev *gasket_dev)
 		}
 	}
 }
+EXPORT_SYMBOL(gasket_disable_device);
 
 /*
  * Registered descriptor lookup.
@@ -1350,13 +1351,12 @@ static const struct file_operations gasket_file_ops = {
 };
 
 /* Perform final init and marks the device as active. */
-static int gasket_enable_dev(struct gasket_internal_desc *internal_desc,
-			     struct gasket_dev *gasket_dev)
+int gasket_enable_device(struct gasket_dev *gasket_dev)
 {
 	int tbl_idx;
 	int ret;
 	const struct gasket_driver_desc *driver_desc =
-		internal_desc->driver_desc;
+		gasket_dev->internal_desc->driver_desc;
 
 	ret = gasket_interrupt_init(gasket_dev, driver_desc->name,
 				    driver_desc->interrupt_type,
@@ -1418,13 +1418,15 @@ static int gasket_enable_dev(struct gasket_internal_desc *internal_desc,
 
 	return 0;
 }
+EXPORT_SYMBOL(gasket_enable_device);
 
 /*
  * Add PCI gasket device.
  *
  * Called by Gasket device probe function.
- * Allocates device metadata, maps device memory, and calls gasket_enable_dev
- * to prepare the device for active use.
+ * Allocates device metadata and maps device memory.  The device driver must
+ * call gasket_enable_device after driver init is complete to place the device
+ * in active use.
  */
 int gasket_pci_add_device(struct pci_dev *pci_dev,
 			  struct gasket_dev **gasket_devp)
@@ -1500,13 +1502,6 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 		goto fail5;
 	}
 
-	ret = gasket_enable_dev(internal_desc, gasket_dev);
-	if (ret) {
-		pr_err("cannot setup %s device\n", driver_desc->name);
-		gasket_disable_dev(gasket_dev);
-		goto fail5;
-	}
-
 	*gasket_devp = gasket_dev;
 	return 0;
 
@@ -1560,7 +1555,6 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 	dev_dbg(gasket_dev->dev, "remove %s PCI gasket device\n",
 		internal_desc->driver_desc->name);
 
-	gasket_disable_dev(gasket_dev);
 	gasket_cleanup_pci(gasket_dev);
 
 	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 5d40bc7f52e91..9c143ebeba452 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -590,6 +590,12 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 /* Remove a PCI gasket device. */
 void gasket_pci_remove_device(struct pci_dev *pci_dev);
 
+/* Enable a Gasket device. */
+int gasket_enable_device(struct gasket_dev *gasket_dev);
+
+/* Disable a Gasket device. */
+void gasket_disable_device(struct gasket_dev *gasket_dev);
+
 /*
  * Reset the Gasket device.
  * @gasket_dev: Gasket device struct.
-- 
2.18.0.597.ga71716f1ad-goog

