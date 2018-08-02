Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AF121476
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbbswwds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AF121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeHBKdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43190 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbeHBKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:13 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so693822plv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJgIjqnzBpjDCHcIaR7Lgo3X/dn0+4y3mN89lG2WtHQ=;
        b=DbbswwdsTkULcafNwaAAInXXXs3KFfrvT/IlSns12D+RZtD3yIa5dthCHQIqknATDd
         iiqWMAGXoDY/sbniagudVMCpDYVQADuuluNQDvhJ8e97kB3CRItTbyJmp54149cVa+mI
         e+ydIGclyiJ4rxpXoA7dVrYwxD9gfL1UM4l6SGJG/5i4NkF/+hGmk3IYDpBsxsPhNSLp
         zlUF/pk9xQbgKEOKg8Z1tzQCiIx/6IkWRqOEBsXvVaoq+Ncw+84yHUsTXP0acNKpa3Vf
         5OMep0Bz7MwUf3TM1hwPX1NcYNVjblwmS1BPpAnrNQjFo20X/Appmn54W7Pa1iU8RMa1
         96Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJgIjqnzBpjDCHcIaR7Lgo3X/dn0+4y3mN89lG2WtHQ=;
        b=I9qlzGq/QqRYp0bu1WQbhkjcRLlXjHcQdLC7gIUE4ixL+Oho5KGwLn4cgm7SQXs+V7
         6Yq/0mDmnf23Kao57Rt9j6UoawdivhcpYqpQF3XACeOM50qFLxwN25OGMFrJ/Ee905KG
         AWApiXaqAK3wr9HERARiYvbzGPoQpn678hlvgNLMUtLgHucf15ar40Q3y/VMKgcax2x9
         0/8DGwRLzhLcjq38yjI3TZZLDUiW3mQKsy78h/TaiqRqkA9hw3Kev8MR4yE+NI/fmgIP
         4IHOAktAUw3Lek72TqepdWJmaBmrfa4zJ3vJ3qTGSaKv0C5Q9w6cfrG8D2T9JwJG7gIe
         l/TQ==
X-Gm-Message-State: AOUpUlFaSYVBIC7cJueN28uy8XqhmPpymb3eyDlVZj2Ownn0OOw4RcUj
        Q158tLz26MqexGvXYW+4fL0=
X-Google-Smtp-Source: AAOMgpfki2+qapIrcWsb+vNLMctnfAWGhGDrriu4jlz88nm1luWAP4GGrLG42kranGiGKgJcPwPAlw==
X-Received: by 2002:a17:902:e18d:: with SMTP id cd13-v6mr1499792plb.305.1533199385688;
        Thu, 02 Aug 2018 01:43:05 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:05 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 5/8] staging: gasket: core: add subsystem and device info to error logs
Date:   Thu,  2 Aug 2018 01:42:42 -0700
Message-Id: <20180802084245.239689-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802084245.239689-1-toddpoynor@gmail.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Identify gasket as the subsystem printing various error messages.
Add the driver name to appropriate messages to indicate which driver
has a problem.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 36c077fffc41c..19331feb9b09f 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -160,7 +160,7 @@ static int gasket_find_dev_slot(struct gasket_internal_desc *internal_desc,
 	for (i = 0; i < GASKET_DEV_MAX; i++) {
 		if (internal_desc->devs[i] &&
 		    strcmp(internal_desc->devs[i]->kobj_name, kobj_name) == 0) {
-			pr_err("Duplicate device %s\n", kobj_name);
+			pr_err("gasket: Duplicate device %s\n", kobj_name);
 			mutex_unlock(&internal_desc->mutex);
 			return -EBUSY;
 		}
@@ -173,7 +173,8 @@ static int gasket_find_dev_slot(struct gasket_internal_desc *internal_desc,
 	}
 
 	if (i == GASKET_DEV_MAX) {
-		pr_err("Too many registered devices; max %d\n", GASKET_DEV_MAX);
+		pr_err("gasket: Too many registered devices, max %d\n",
+		       GASKET_DEV_MAX);
 		mutex_unlock(&internal_desc->mutex);
 		return -EBUSY;
 	}
@@ -208,7 +209,7 @@ static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
 
 	gasket_dev = *pdev = kzalloc(sizeof(*gasket_dev), GFP_KERNEL);
 	if (!gasket_dev) {
-		pr_err("no memory for device\n");
+		pr_err("gasket: no memory for device %s\n",  kobj_name);
 		return -ENOMEM;
 	}
 	internal_desc->devs[dev_idx] = gasket_dev;
@@ -1464,7 +1465,7 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 	internal_desc = lookup_internal_desc(pci_dev);
 	mutex_unlock(&g_mutex);
 	if (!internal_desc) {
-		pr_err("PCI probe called for unknown driver type\n");
+		pr_err("gasket: PCI probe called for unknown driver type\n");
 		return -ENODEV;
 	}
 
@@ -1476,7 +1477,7 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 		return ret;
 	gasket_dev->pci_dev = pci_dev_get(pci_dev);
 	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
-		pr_err("Cannot create %s device %s [ret = %ld]\n",
+		pr_err("gasket: Cannot create %s device %s [ret = %ld]\n",
 		       driver_desc->name, gasket_dev->dev_info.name,
 		       PTR_ERR(gasket_dev->dev_info.device));
 		ret = -ENODEV;
@@ -1523,7 +1524,7 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 
 	ret = gasket_enable_dev(internal_desc, gasket_dev);
 	if (ret) {
-		pr_err("cannot setup %s device\n", driver_desc->name);
+		pr_err("gasket: cannot setup %s device\n", driver_desc->name);
 		gasket_disable_dev(gasket_dev);
 		goto fail5;
 	}
@@ -1743,7 +1744,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 
 	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
 		if (g_descs[i].driver_desc == driver_desc) {
-			pr_err("%s driver already loaded/registered\n",
+			pr_err("gasket: %s driver already loaded/registered\n",
 			       driver_desc->name);
 			mutex_unlock(&g_mutex);
 			return -EBUSY;
@@ -1761,7 +1762,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	mutex_unlock(&g_mutex);
 
 	if (desc_idx == -1) {
-		pr_err("Too many Gasket drivers loaded: %d\n",
+		pr_err("gasket: too many drivers loaded, max %d\n",
 		       GASKET_FRAMEWORK_DESC_MAX);
 		return -EBUSY;
 	}
@@ -1778,7 +1779,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		class_create(driver_desc->module, driver_desc->name);
 
 	if (IS_ERR(internal->class)) {
-		pr_err("Cannot register %s class [ret=%ld]\n",
+		pr_err("gasket: Cannot register %s class [ret=%ld]\n",
 		       driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
 		goto unregister_gasket_driver;
@@ -1791,7 +1792,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	ret = __pci_register_driver(&internal->pci, driver_desc->module,
 				    driver_desc->name);
 	if (ret) {
-		pr_err("cannot register pci driver [ret=%d]\n", ret);
+		pr_err("gasket: cannot register %s pci driver [ret=%d]\n",
+		       driver_desc->name, ret);
 		goto fail1;
 	}
 
@@ -1799,7 +1801,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 					   driver_desc->minor), GASKET_DEV_MAX,
 				     driver_desc->name);
 	if (ret) {
-		pr_err("cannot register char driver [ret=%d]\n", ret);
+		pr_err("gasket: cannot register %s char driver [ret=%d]\n",
+		       driver_desc->name, ret);
 		goto fail2;
 	}
 
@@ -1840,7 +1843,7 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	mutex_unlock(&g_mutex);
 
 	if (!internal_desc) {
-		pr_err("request to unregister unknown desc: %s, %d:%d\n",
+		pr_err("gasket: request to unregister unknown desc: %s, %d:%d\n",
 		       driver_desc->name, driver_desc->major,
 		       driver_desc->minor);
 		return;
-- 
2.18.0.597.ga71716f1ad-goog

