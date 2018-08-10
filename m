Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB9C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40445223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8F0Efcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40445223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeHJFt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41683 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeHJFt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so3706222pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zt0lm5ekJ1wGmSK9QTAKo5hWh+iePyb259udOMm8/cs=;
        b=m8F0EfcnUwZm1kKvB0HNlIvBQjGa3fCmw4WqMyHfoiPc/IhIc+iGSLn8mk6LVeMWC7
         hH34fARMNHtVi0wA709JiRQB+1o3DK54T4i/dJ5SI18k1yz5zrA9Cs3fFnyxNNC3DWzC
         5qhvQZVYG77XvsDBbMdXzNNfXUew368rPcWbMpfMmXqoUFtYvSYI6l5s6e9Y5D7cfHFx
         Eies15gM0VbfTgsxX8r8IxK/6EuSpVL6IBjNWWHEVX12StixiPlSz0nMvGJedp3XLE5w
         GIuDcseYegSLIM5mNgpyMNaKpuH0SVGkTcm1l2sQU1K38berhJmrB6n+Mg4E9fBq1pLa
         71sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zt0lm5ekJ1wGmSK9QTAKo5hWh+iePyb259udOMm8/cs=;
        b=nlkgDrY+nRWMH8nnKRRCdpXXAdyRuvDIVh9ZSOVnXCqPhTStdql2n6rXs8TYWqy03e
         8FVuSxQaUC10eUuRoN/5yCtwkrJbUY2vAKYFvOyYfJYOLqnsusLLYgPz5zqBwxxMSyon
         eOr+d5UYQ5O1OF94YDYjcBmKsIImAr75gGh7eBAY4DCZ2US7rb2l1MmRllkCvqEpWv6S
         wdeL7E6CNS0016aenm467QTrx+JG076WVxhCWBfolO4HoJXPktZRWQlxA5mE+nFFsJJx
         RVtZ1I/RFGSn1Ie39YWEewkP8Lr1Lvme6lRoZCVya3vBCzh5TBXvTM27vpwVk6l9DlEM
         lX8g==
X-Gm-Message-State: AOUpUlHaSoMyIy95jHrF1J8U3AoI0FwK4Zmu5KIe2LwDC+7m2aEu9o6G
        LzNZibGg1INFN8SMQjY3WF8=
X-Google-Smtp-Source: AA+uWPyozgi58CDsGHpT/nOL+ULaW2+qjlAHDMZorcw5xom27Qa6NX931+IwdLpXHq7bTCvGCha5Mg==
X-Received: by 2002:a63:1b49:: with SMTP id b9-v6mr4519160pgm.72.1533871295132;
        Thu, 09 Aug 2018 20:21:35 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:34 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/16] staging: gasket: core: factor out generic device remove code from PCI
Date:   Thu,  9 Aug 2018 20:21:07 -0700
Message-Id: <20180810032111.197743-13-toddpoynor@gmail.com>
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

Separate code for generic parts of gasket device removal sequence from
the PCI device removal code, in prep for non-PCI devices later.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ce8ae226f82d9..5e048f6e16e12 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1461,6 +1461,14 @@ static int __gasket_add_device(struct device *parent_dev,
 	return ret;
 }
 
+static void __gasket_remove_device(struct gasket_internal_desc *internal_desc,
+				   struct gasket_dev *gasket_dev)
+{
+	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
+	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
+	gasket_free_dev(gasket_dev);
+}
+
 /*
  * Add PCI gasket device.
  *
@@ -1515,9 +1523,7 @@ int gasket_pci_add_device(struct pci_dev *pci_dev,
 
 cleanup_pci:
 	gasket_cleanup_pci(gasket_dev);
-	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
-	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
-	gasket_free_dev(gasket_dev);
+	__gasket_remove_device(internal_desc, gasket_dev);
 	return ret;
 }
 EXPORT_SYMBOL(gasket_pci_add_device);
@@ -1528,7 +1534,6 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 	int i;
 	struct gasket_internal_desc *internal_desc;
 	struct gasket_dev *gasket_dev = NULL;
-	const struct gasket_driver_desc *driver_desc;
 	/* Find the device desc. */
 	mutex_lock(&g_mutex);
 	internal_desc = lookup_internal_desc(pci_dev);
@@ -1538,8 +1543,6 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 	}
 	mutex_unlock(&g_mutex);
 
-	driver_desc = internal_desc->driver_desc;
-
 	/* Now find the specific device */
 	mutex_lock(&internal_desc->mutex);
 	for (i = 0; i < GASKET_DEV_MAX; i++) {
@@ -1558,10 +1561,7 @@ void gasket_pci_remove_device(struct pci_dev *pci_dev)
 		internal_desc->driver_desc->name);
 
 	gasket_cleanup_pci(gasket_dev);
-
-	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
-	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
-	gasket_free_dev(gasket_dev);
+	__gasket_remove_device(internal_desc, gasket_dev);
 }
 EXPORT_SYMBOL(gasket_pci_remove_device);
 
-- 
2.18.0.597.ga71716f1ad-goog

