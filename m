Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28177C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4954223D8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZrQx1aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4954223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHJFtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39443 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeHJFta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so3829394pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oT/TFDguXYEAAijqO25uIhuE2wJzONOr29rVv+r/etk=;
        b=dZrQx1aWMfINDCXiIRxgy4Kj4bu0NbmODVfYx550XdjgrqPYndxAYAduCqOT8uhkcI
         mGa/A69gXFHh4tYzSNFN+ry4zn9hCK8r/Tc0hP6T1QPoxSHtIaB5hkaeL0WyPPkhN/Ez
         Z1ogCJKu8d93hO63PF5GS7GaWN14Tf3u9Fq1ACVLmqWSDYd5ESxyS9YZSP/HXePj6wz0
         FgR6xPdUe/9zp3nkUc8oGtBRAXrsehMjgpNY79sBnQ0/XKavpGs+v3biQ3HCEJPEqN5W
         5dEZid0ZPSrKMENmr6ShSLCz3h6g8WB+AMjeds2qoOcpqWGkKBIjeT83mdn65RJaLKhR
         3wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oT/TFDguXYEAAijqO25uIhuE2wJzONOr29rVv+r/etk=;
        b=p7Z7I2GPH+jDNLXBKXYwExR/Cu8Rkb7+fLuzbw7oRC3q3eJ4/SrIESG72n21O0Z+1W
         3cVWakOjrM22Hd+RERbXRzqsanzgsL4lmtooYGCZMi86GiIHfdVJC2Z2IQwJ04Nd8Qrv
         lhKJlXGr+UTqkqFDrYfqoIQBlNGyn+xgTFf+v9iY6n0G9HSnB7KLCYgLcS8rzwxBu/Uw
         aBS+ubFIXFsp3pwnoQpRa5vU8ugQOBLkr3LVtp0zShzTRPOnHUe2x+dME6+VdZyeR1jN
         6/dFknkd6gerECtmLvmKo7Z0zQlnVush9A8sTMd5xuEO0FShhE6s8t0pW3wMvp543uc8
         /9qg==
X-Gm-Message-State: AOUpUlEnBFbsb8kmVUXlc/VAzXp1Jc7snAZbKmAMMzGdgxeMqGbVHYpw
        shH5gqXnslBRki5xlBy7Qk8=
X-Google-Smtp-Source: AA+uWPxEv260FfyWrZ9jJaS5M8YsPSk27ey3dDQD5wCleku4rb6WL6/5hBB+lENf2MXqwATx9VEajQ==
X-Received: by 2002:a63:d54e:: with SMTP id v14-v6mr4659462pgi.264.1533871297198;
        Thu, 09 Aug 2018 20:21:37 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:36 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/16] staging: gasket: interrupt: refactor PCI MSIX-specific handler code
Date:   Thu,  9 Aug 2018 20:21:09 -0700
Message-Id: <20180810032111.197743-15-toddpoynor@gmail.com>
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

Split interrupt handler into PCI MSIX-specific and generic functions,
for adding non-MSIX handlers in the future.  Move MSIX init code
together,, out of generic init path.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 48 ++++++++++++-----------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 1cfbc120f2284..f94e4ea9a7ded 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -157,9 +157,22 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 	}
 }
 
-static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
+static void
+gasket_handle_interrupt(struct gasket_interrupt_data *interrupt_data,
+			int interrupt_index)
 {
 	struct eventfd_ctx *ctx;
+
+	trace_gasket_interrupt_event(interrupt_data->name, interrupt_index);
+	ctx = interrupt_data->eventfd_ctxs[interrupt_index];
+	if (ctx)
+		eventfd_signal(ctx, 1);
+
+	++(interrupt_data->interrupt_counts[interrupt_index]);
+}
+
+static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
+{
 	struct gasket_interrupt_data *interrupt_data = dev_id;
 	int interrupt = -1;
 	int i;
@@ -175,14 +188,7 @@ static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
 		pr_err("Received unknown irq %d\n", irq);
 		return IRQ_HANDLED;
 	}
-	trace_gasket_interrupt_event(interrupt_data->name, interrupt);
-
-	ctx = interrupt_data->eventfd_ctxs[interrupt];
-	if (ctx)
-		eventfd_signal(ctx, 1);
-
-	++(interrupt_data->interrupt_counts[interrupt]);
-
+	gasket_handle_interrupt(interrupt_data, interrupt);
 	return IRQ_HANDLED;
 }
 
@@ -192,6 +198,12 @@ gasket_interrupt_msix_init(struct gasket_interrupt_data *interrupt_data)
 	int ret = 1;
 	int i;
 
+	interrupt_data->msix_entries =
+		kcalloc(interrupt_data->num_interrupts,
+			sizeof(struct msix_entry), GFP_KERNEL);
+	if (!interrupt_data->msix_entries)
+		return -ENOMEM;
+
 	for (i = 0; i < interrupt_data->num_interrupts; i++) {
 		interrupt_data->msix_entries[i].entry = i;
 		interrupt_data->msix_entries[i].vector = 0;
@@ -343,20 +355,10 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
 	interrupt_data->num_configured = 0;
 	interrupt_data->wire_interrupt_offsets = wire_int_offsets;
 
-	/* Allocate all dynamic structures. */
-	interrupt_data->msix_entries = kcalloc(num_interrupts,
-					       sizeof(struct msix_entry),
-					       GFP_KERNEL);
-	if (!interrupt_data->msix_entries) {
-		kfree(interrupt_data);
-		return -ENOMEM;
-	}
-
 	interrupt_data->eventfd_ctxs = kcalloc(num_interrupts,
 					       sizeof(struct eventfd_ctx *),
 					       GFP_KERNEL);
 	if (!interrupt_data->eventfd_ctxs) {
-		kfree(interrupt_data->msix_entries);
 		kfree(interrupt_data);
 		return -ENOMEM;
 	}
@@ -366,7 +368,6 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
 						   GFP_KERNEL);
 	if (!interrupt_data->interrupt_counts) {
 		kfree(interrupt_data->eventfd_ctxs);
-		kfree(interrupt_data->msix_entries);
 		kfree(interrupt_data);
 		return -ENOMEM;
 	}
@@ -417,6 +418,7 @@ gasket_interrupt_msix_cleanup(struct gasket_interrupt_data *interrupt_data)
 	if (interrupt_data->msix_configured)
 		pci_disable_msix(interrupt_data->pci_dev);
 	interrupt_data->msix_configured = 0;
+	kfree(interrupt_data->msix_entries);
 }
 
 int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
@@ -448,10 +450,11 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 	}
 
 	if (ret) {
-		/* Failing to setup MSIx will cause the device
+		/* Failing to setup interrupts will cause the device
 		 * to report GASKET_STATUS_LAMED, but is not fatal.
 		 */
-		dev_warn(gasket_dev->dev, "Couldn't init msix: %d\n", ret);
+		dev_warn(gasket_dev->dev, "Couldn't reinit interrupts: %d\n",
+			 ret);
 		return 0;
 	}
 
@@ -497,7 +500,6 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 
 	kfree(interrupt_data->interrupt_counts);
 	kfree(interrupt_data->eventfd_ctxs);
-	kfree(interrupt_data->msix_entries);
 	kfree(interrupt_data);
 	gasket_dev->interrupt_data = NULL;
 }
-- 
2.18.0.597.ga71716f1ad-goog

