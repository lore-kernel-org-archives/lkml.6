Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2338CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE06E223BD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/skj0VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE06E223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHJFtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42263 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id g6-v6so3420554plq.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WW/H0kwUtT4AkFcweU8P3XfIcUG9uEG2Op6lpLwNdZ8=;
        b=A/skj0VAEjPwQkWAsrV1GT1hS4+wiTKePLJnxC42pirw2qIHxF6h2NlbcQOwicrJJS
         VetfvMRyFtDy2n8SD7RYthh8SGU3Kd13/z0BQFAqzBaDULWx9Yi3SyM0VBfifocHS5p0
         VlelPufFs9N8zf0gPX7EEVCVmNEGnhX9sqjjK2vAU22JYd6y/F61hV1qmeSNUKt0uQrW
         3xwS4ICMWFo6VwM0tU2wDMTQvD/4Niv+A2/Ehp625/TcUtRatpAYbe5p9iPVQXUF/bYg
         r3wKObn6CQcIWrMYH16JviMpS/tmfPiPe1BxLg3GMnW91tzl5c9YxOLY37KtQsFh0ieG
         m0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WW/H0kwUtT4AkFcweU8P3XfIcUG9uEG2Op6lpLwNdZ8=;
        b=ALfDx8cJU7kyloDWeg0ky270V/xOpJ69P49adDQuOZzegn+nS1xfPmfSzs5Etk6hNj
         fPS7NWCxf1KALyHjVKn2CJ8RTrOXTTIP3o+2cJHPUH2R3Ia4HPR9m5lppiTBTKlacqGL
         D8vGHLFscNel/6p49ziriA0Y/zV6IhZkHMCBvAeeHwVqXMIDL2r4+S2UIUYLqYR6e3uT
         hZiCafOTV0JR6nS03vc3JeVZzKJBml4OYxrHLfXl4nceru54sSjir9noOOu4gK3ocM4o
         W9q6l+kup5C6CcencNvxgHSEY4qR2IgbMiBzNUUldr02WcNUS8/+XDbsjAc3ScfeZkDe
         ExfA==
X-Gm-Message-State: AOUpUlGPhU8l0uNE9PIOsWSl+HcHlNUKTjjB5UI7/0HM/1zWVEPVoVp/
        SWrwTorSdgCgxSBCtQ/PxFA=
X-Google-Smtp-Source: AA+uWPzjLOb09UHXNqbFPnBowibJ1pALia9VMAkcu/rJcj3AOYk3gw4P2JN0mJ3UKKhNLKHjqg62dg==
X-Received: by 2002:a17:902:9695:: with SMTP id n21-v6mr4445521plp.6.1533871286796;
        Thu, 09 Aug 2018 20:21:26 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:26 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/16] staging: gasket: core: remove kobj_name param from gasket_alloc_dev
Date:   Thu,  9 Aug 2018 20:20:59 -0700
Message-Id: <20180810032111.197743-5-toddpoynor@gmail.com>
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

gasket_alloc_dev can retrieve the device name from the parent parameter,
a separate parameter isn't needed for this.  Rename the variable to
better reflect its meaning, as the name of the parent device for which a
gasket device is being allocated.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 3fb805204d700..5f54b3615f67c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -189,26 +189,26 @@ static int gasket_find_dev_slot(struct gasket_internal_desc *internal_desc,
  * Returns 0 if successful, a negative error code otherwise.
  */
 static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
-			    struct device *parent, struct gasket_dev **pdev,
-			    const char *kobj_name)
+			    struct device *parent, struct gasket_dev **pdev)
 {
 	int dev_idx;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 	struct gasket_dev *gasket_dev;
 	struct gasket_cdev_info *dev_info;
+	const char *parent_name = dev_name(parent);
 
-	pr_debug("Allocating a Gasket device %s.\n", kobj_name);
+	pr_debug("Allocating a Gasket device, parent %s.\n", parent_name);
 
 	*pdev = NULL;
 
-	dev_idx = gasket_find_dev_slot(internal_desc, kobj_name);
+	dev_idx = gasket_find_dev_slot(internal_desc, parent_name);
 	if (dev_idx < 0)
 		return dev_idx;
 
 	gasket_dev = *pdev = kzalloc(sizeof(*gasket_dev), GFP_KERNEL);
 	if (!gasket_dev) {
-		pr_err("no memory for device %s\n", kobj_name);
+		pr_err("no memory for device, parent %s\n", parent_name);
 		return -ENOMEM;
 	}
 	internal_desc->devs[dev_idx] = gasket_dev;
@@ -217,7 +217,7 @@ static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
 
 	gasket_dev->internal_desc = internal_desc;
 	gasket_dev->dev_idx = dev_idx;
-	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
+	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", parent_name);
 	gasket_dev->dev = get_device(parent);
 	/* gasket_bar_data is uninitialized. */
 	gasket_dev->num_page_tables = driver_desc->num_page_tables;
@@ -1431,13 +1431,12 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 			  struct gasket_dev **gasket_devp)
 {
 	int ret;
-	const char *kobj_name = dev_name(&pci_dev->dev);
 	struct gasket_internal_desc *internal_desc;
 	struct gasket_dev *gasket_dev;
 	const struct gasket_driver_desc *driver_desc;
 	struct device *parent;
 
-	pr_debug("add PCI device %s\n", kobj_name);
+	dev_dbg(&pci_dev->dev, "add PCI gasket device\n");
 
 	mutex_lock(&g_mutex);
 	internal_desc = lookup_internal_desc(pci_dev);
@@ -1451,7 +1450,7 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 	driver_desc = internal_desc->driver_desc;
 
 	parent = &pci_dev->dev;
-	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev, kobj_name);
+	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev);
 	if (ret)
 		return ret;
 	gasket_dev->pci_dev = pci_dev;
-- 
2.18.0.597.ga71716f1ad-goog

