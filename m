Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BBC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8CB21722
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io6t0ZUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8CB21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeHCDn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:43:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46644 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbeHCDn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:43:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14-v6so1542987pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkmyuLo52uz5YgxkwfC/FIhFsPrYdNwy/BoSUdw7H/o=;
        b=io6t0ZUuqq6QcyXFghLzEExSCw4pc304KUsUn8cq5cblquLeSdjyJbX3w8xNWU3Q2d
         amcyy04ceLOF3frM+6WxULi8YukDgDNKZqTiaeTyy4yj/pR1U8ae7FyNKBpAaQnnZZ4m
         NE05yvlZCX5rXVCEItCmEt8MHmIwNQhTR12eXiLhWK8CWfTjohIdpnWbrkKqOS6LSiln
         ftqfIJTayprmF4AA46i77OyyaTaaHyUBgsW2E6mjXYpdNpaw4svBUfYkTckHf6lf7KW0
         UF5EXMQJe4gUh3TiH5raMr3o9vhrPqdcstsWXpvNJZLTahqQYEi17idolJlgoQS4b10j
         lKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkmyuLo52uz5YgxkwfC/FIhFsPrYdNwy/BoSUdw7H/o=;
        b=HVij7nIhd2WOKPufSp19iilZplbh1n7kuyD4o7sHz5xU9eBNKXrgEy7ic0umFa2kil
         l5KMFTv7F6WRQpYIYxWZ08BHr+XP08oRDzwz6ocNO+nfJd7JaEMPqyW6KYpRXqbrt5+B
         4qs3Bl4vxkWA5EnHLQnizWuwvEFrhcO99q569H2gbu++Vgio4qRpK/dd7+fw+JxOb4MS
         2Dkq2N4IyQXFGkKjILSutwbzs5f56IhC/LIALrqf+BvPT6VB+wiZTLVtI2GmrbHCZeY8
         /En4ri9DsOGLWxvZqMkF8OPNrxH8C8AqIr/XfJQqPK8SGThyozK4nGVBi2ZZT4E17if3
         W4RA==
X-Gm-Message-State: AOUpUlEKMD6+CdXKmlsIqe/Gazw7EW3PT0X/ZDGte72t9ujS6NgkYcIZ
        sGBIPi65o8cTXvsvG63sLkw=
X-Google-Smtp-Source: AAOMgpchRs2Xs4MdLMSBbpN5lpJ07csx3VUqWVCcHRyiyIwyVMCDy4n4PXciWlLaBD0+ucDHAXBnRA==
X-Received: by 2002:a63:3089:: with SMTP id w131-v6mr1673529pgw.79.1533261005406;
        Thu, 02 Aug 2018 18:50:05 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m81-v6sm7348315pfa.188.2018.08.02.18.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:50:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 2/4] staging: gasket: core: device register debug log cleanups
Date:   Thu,  2 Aug 2018 18:49:50 -0700
Message-Id: <20180803014952.104582-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180803014952.104582-1-toddpoynor@gmail.com>
References: <20180803014952.104582-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

At device/driver registration time, convert a not-very-informative
info message to a more informative debug message, drop some not overly
helpful debug messages.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index fa477d0c3c74c..91db71c238804 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1735,7 +1735,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	int desc_idx = -1;
 	struct gasket_internal_desc *internal;
 
-	pr_info("Initializing Gasket framework device\n");
+	pr_debug("Loading %s driver version %s\n", driver_desc->name,
+		 driver_desc->driver_version);
 	/* Check for duplicates and find a free slot. */
 	mutex_lock(&g_mutex);
 
@@ -1764,8 +1765,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		return -EBUSY;
 	}
 
-	/* Internal structure setup. */
-	pr_debug("Performing initial internal structure setup.\n");
 	internal = &g_descs[desc_idx];
 	mutex_init(&internal->mutex);
 	memset(internal->devs, 0, sizeof(struct gasket_dev *) * GASKET_DEV_MAX);
@@ -1788,7 +1787,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	 * Not using pci_register_driver() (without underscores), as it
 	 * depends on KBUILD_MODNAME, and this is a shared file.
 	 */
-	pr_debug("Registering PCI driver.\n");
 	ret = __pci_register_driver(&internal->pci, driver_desc->module,
 				    driver_desc->name);
 	if (ret) {
@@ -1796,7 +1794,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		goto fail1;
 	}
 
-	pr_debug("Registering char driver.\n");
 	ret = register_chrdev_region(MKDEV(driver_desc->major,
 					   driver_desc->minor), GASKET_DEV_MAX,
 				     driver_desc->name);
-- 
2.18.0.597.ga71716f1ad-goog

