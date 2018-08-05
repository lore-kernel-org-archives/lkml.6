Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D471C46473
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F10221918
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9SkQOcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F10221918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHEWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37175 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so5215653pgq.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8VmjF7ZyG88Ui6fM1wfRMTbGa2pqST45iFbf1PFvpY=;
        b=M9SkQOcR35xeAwlMUJRbJKrZ6Boc5N8F/eQWNL9xZ7mj1HgkgYgXZp7NrUFHf6SQOM
         J7luJjDTJrKpo7Y3p/ZGG8Rc7biyd/QMq/oy6ESvP4HG3w++M+fnEenD8HzYR/6cOp7D
         pXhjruu4dNLlR5dbPsubvz56zf0CrqcmX4xWjDZ/t6Ovobc1szK9YV9RdzbFR++M6Y2b
         Dqd6foJt6ad7wvTZdF2S+TgJ2dJDIPFNGsbkA/F96sf/Eynk+DfwXu2cZ9ZriWjDeK5l
         y6gHox08G1IQOS0+39EGFbHE6pIMK0kBvK8yXF2z7KD+8kdaTRSe1TX/y0x5gRk0/yt/
         JUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8VmjF7ZyG88Ui6fM1wfRMTbGa2pqST45iFbf1PFvpY=;
        b=SO6qbPQEr8/pQrMaB0AEG9K0P1mUB//ngCash4EBXRsUDBibkqpYu63llRR2GYWOc4
         3dujvoAOlI94CMX7JaiSboPye8C6SZ4XQv/lq/fDefEyFlLJhoomtxNChWyw5cNLIP2J
         yLZyKi2M/L33mjaiyUt2+XMByIGIz88AnHVWeTG/ii16Mlff5VN+O0Z9q4Q8r6jh9Qpv
         V9WvB7Ewp7r9o1so0u2L+4pSUhmH8hZgmdg7ZzFQbIC+Jz+GRV7MUWFl1Y8snVL90R80
         jKPv8gzIHm4RnWmB/qjqgZleDug/89GF8te1sYtN9VUWBwa/+oYufGHqBQya2wIqWS+X
         t+IA==
X-Gm-Message-State: AOUpUlGgKgDM6I46L+9WIQtbwjuFT5lKjBMiaUYQQ0o7khx2BhbmNSj+
        A6qUKkI5g8XZV8EnwVN03Ek=
X-Google-Smtp-Source: AAOMgpeXmG+MJoTZx/KXt863CvIJxmAbNuNUjmOOeW8JdOH/vaMcTxYcEu8S2C3OiQujrPQGUYC5VA==
X-Received: by 2002:a65:550d:: with SMTP id f13-v6mr12210629pgr.340.1533499697691;
        Sun, 05 Aug 2018 13:08:17 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:17 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/15] staging: gasket: apex: move PCI core calls to apex driver
Date:   Sun,  5 Aug 2018 13:07:37 -0700
Message-Id: <20180805200749.116693-4-toddpoynor@gmail.com>
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

Apex driver moves PCI core calls like probe, enable, and remove from
gasket to apex.  Call new functions in gasket to register apex as a PCI
device to the gasket framework.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 49 +++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 42cef68eb4c19..b47661442009d 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/pci.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
@@ -621,6 +622,36 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
 
+static int apex_pci_probe(struct pci_dev *pci_dev,
+			  const struct pci_device_id *id)
+{
+	int ret;
+	struct gasket_dev *gasket_dev;
+
+	ret = pci_enable_device(pci_dev);
+	if (ret) {
+		dev_err(&pci_dev->dev, "error enabling PCI device\n");
+		return ret;
+	}
+
+	pci_set_master(pci_dev);
+
+	ret = gasket_pci_add_device(pci_dev, &gasket_dev);
+	if (ret) {
+		dev_err(&pci_dev->dev, "error adding gasket device\n");
+		pci_disable_device(pci_dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void apex_pci_remove(struct pci_dev *pci_dev)
+{
+	gasket_pci_remove_device(pci_dev);
+	pci_disable_device(pci_dev);
+}
+
 static struct gasket_driver_desc apex_desc = {
 	.name = "apex",
 	.driver_version = APEX_DRIVER_VERSION,
@@ -672,13 +703,29 @@ static struct gasket_driver_desc apex_desc = {
 	.device_reset_cb = apex_reset,
 };
 
+static struct pci_driver apex_pci_driver = {
+	.name = "apex",
+	.probe = apex_pci_probe,
+	.remove = apex_pci_remove,
+	.id_table = apex_pci_ids,
+};
+
 static int __init apex_init(void)
 {
-	return gasket_register_device(&apex_desc);
+	int ret;
+
+	ret = gasket_register_device(&apex_desc);
+	if (ret)
+		return ret;
+	ret = pci_register_driver(&apex_pci_driver);
+	if (ret)
+		gasket_unregister_device(&apex_desc);
+	return ret;
 }
 
 static void apex_exit(void)
 {
+	pci_unregister_driver(&apex_pci_driver);
 	gasket_unregister_device(&apex_desc);
 }
 MODULE_DESCRIPTION("Google Apex driver");
-- 
2.18.0.597.ga71716f1ad-goog

