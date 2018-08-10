Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D6C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F66D223DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjP3PiKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F66D223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeHJFtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43381 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeHJFtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id a14-v6so3698068pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyp/WsGFpqmURQEyJsdUvTUgfgMYpnGPm7PPRrAblaM=;
        b=SjP3PiKbC7K+599as6dihD5ItRgFB75V5FKwT1KNeml61vagH+QtDeaSa5qWEDQ7Ae
         2xO1Faos7F9398KH+1bFA8FC+aHEeJyvEjxYvL94O9rmEivaB303qU1bfyxZu0iUL8NW
         NuuBkg5MA0BBH9OCQGiBpR1XhQzF1TGaexRIfs4wlJCFPqlbiV35N+Zf6xJV861sbWIC
         35r34m7lq6MQGSZg51y99N7d1vWqydFOGzwG0LLYY0rZLTRcxH+3+g8fBQ50ozlNrW1M
         fNBQsWhlIJMxH+S5sQWO+dcI7kt5mtoHgQD65d8q0kyIxHb+aaEpXzQRqk/w273CDeVt
         CDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyp/WsGFpqmURQEyJsdUvTUgfgMYpnGPm7PPRrAblaM=;
        b=Ckejf9DFi9dB/LhwOyy+8//2vBamt1/tOCsFbBc73ywi/tR9hjc2xliEYRr05EQQlf
         OJ68jcJk1eBRYoBxcPknZR+PVHobmTMRlyW6IZqXA9efzOmD1hUkJ+NQhs0LTWngAArE
         gyovnMO1Ve/b3LAzFvKfiv/MQyGtaxvLCEamQozVAkBcZe22thLMkrWiks+E5fyFXH5K
         Stt6NRiNU3+hhCb8pz9I4WZeTup5CW325pm5zTcWL6TtTR0eWeF0L39NPDvnigXzf+ic
         oROIztT7mARP6LJodK497+7T2r36tgGoTqiM/nzFE/QiA6IZKKXRetDjQCerXxLGS+rn
         L2Eg==
X-Gm-Message-State: AOUpUlHgsrs7WvIr6+q9+OD5ZPqa6e2vQKF+kiFSmnYY68NRbtS6BLCO
        euP1MQH3xzEgtmuGo4pe+fo=
X-Google-Smtp-Source: AA+uWPzLKQTWKCQcQ+rSkWH4OcuXwp9SItMK358f3y9uoYUmuI0fDwtnvV/u4eOnlMHzgaHKSH/G8g==
X-Received: by 2002:a62:9f1d:: with SMTP id g29-v6mr4944349pfe.207.1533871298255;
        Thu, 09 Aug 2018 20:21:38 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:37 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 15/16] staging: gasket: interrupt: simplify interrupt init parameters
Date:   Thu,  9 Aug 2018 20:21:10 -0700
Message-Id: <20180810032111.197743-16-toddpoynor@gmail.com>
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

Pass the gasket driver descriptor to the interrupt init function, rather
than exploding out separate parameters from various fields of that
structure.  This allows us to make more localized changes to the types
of interrupts supported (MSIX vs. wire, etc.) without affecting the
calling sequence, and seems nicer for simplification purposes.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c      |  8 +------
 drivers/staging/gasket/gasket_interrupt.c | 27 +++++++++++------------
 drivers/staging/gasket/gasket_interrupt.h | 24 +-------------------
 3 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 99f3f11d75ce2..f230bec76ae4e 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1357,13 +1357,7 @@ int gasket_enable_device(struct gasket_dev *gasket_dev)
 	const struct gasket_driver_desc *driver_desc =
 		gasket_dev->internal_desc->driver_desc;
 
-	ret = gasket_interrupt_init(gasket_dev, driver_desc->name,
-				    driver_desc->interrupt_type,
-				    driver_desc->interrupts,
-				    driver_desc->num_interrupts,
-				    driver_desc->interrupt_pack_width,
-				    driver_desc->interrupt_bar_index,
-				    driver_desc->wire_interrupt_offsets);
+	ret = gasket_interrupt_init(gasket_dev);
 	if (ret) {
 		dev_err(gasket_dev->dev,
 			"Critical failure to allocate interrupts: %d\n", ret);
diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index f94e4ea9a7ded..eb5dfbe08e214 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -331,31 +331,30 @@ static struct gasket_sysfs_attribute interrupt_sysfs_attrs[] = {
 	GASKET_END_OF_ATTR_ARRAY,
 };
 
-int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
-			  int type,
-			  const struct gasket_interrupt_desc *interrupts,
-			  int num_interrupts, int pack_width, int bar_index,
-			  const struct gasket_wire_interrupt_offsets *wire_int_offsets)
+int gasket_interrupt_init(struct gasket_dev *gasket_dev)
 {
 	int ret;
 	struct gasket_interrupt_data *interrupt_data;
+	const struct gasket_driver_desc *driver_desc =
+		gasket_get_driver_desc(gasket_dev);
 
 	interrupt_data = kzalloc(sizeof(struct gasket_interrupt_data),
 				 GFP_KERNEL);
 	if (!interrupt_data)
 		return -ENOMEM;
 	gasket_dev->interrupt_data = interrupt_data;
-	interrupt_data->name = name;
-	interrupt_data->type = type;
+	interrupt_data->name = driver_desc->name;
+	interrupt_data->type = driver_desc->interrupt_type;
 	interrupt_data->pci_dev = gasket_dev->pci_dev;
-	interrupt_data->num_interrupts = num_interrupts;
-	interrupt_data->interrupts = interrupts;
-	interrupt_data->interrupt_bar_index = bar_index;
-	interrupt_data->pack_width = pack_width;
+	interrupt_data->num_interrupts = driver_desc->num_interrupts;
+	interrupt_data->interrupts = driver_desc->interrupts;
+	interrupt_data->interrupt_bar_index = driver_desc->interrupt_bar_index;
+	interrupt_data->pack_width = driver_desc->interrupt_pack_width;
 	interrupt_data->num_configured = 0;
-	interrupt_data->wire_interrupt_offsets = wire_int_offsets;
+	interrupt_data->wire_interrupt_offsets =
+	    driver_desc->wire_interrupt_offsets;
 
-	interrupt_data->eventfd_ctxs = kcalloc(num_interrupts,
+	interrupt_data->eventfd_ctxs = kcalloc(driver_desc->num_interrupts,
 					       sizeof(struct eventfd_ctx *),
 					       GFP_KERNEL);
 	if (!interrupt_data->eventfd_ctxs) {
@@ -363,7 +362,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
 		return -ENOMEM;
 	}
 
-	interrupt_data->interrupt_counts = kcalloc(num_interrupts,
+	interrupt_data->interrupt_counts = kcalloc(driver_desc->num_interrupts,
 						   sizeof(ulong),
 						   GFP_KERNEL);
 	if (!interrupt_data->interrupt_counts) {
diff --git a/drivers/staging/gasket/gasket_interrupt.h b/drivers/staging/gasket/gasket_interrupt.h
index 835af439e96a9..85526a1374a1a 100644
--- a/drivers/staging/gasket/gasket_interrupt.h
+++ b/drivers/staging/gasket/gasket_interrupt.h
@@ -24,30 +24,8 @@ struct gasket_interrupt_data;
 /*
  * Initialize the interrupt module.
  * @gasket_dev: The Gasket device structure for the device to be initted.
- * @type: Type of the interrupt. (See gasket_interrupt_type).
- * @name: The name to associate with these interrupts.
- * @interrupts: An array of all interrupt descriptions for this device.
- * @num_interrupts: The length of the @interrupts array.
- * @pack_width: The width, in bits, of a single field in a packed interrupt reg.
- * @bar_index: The bar containing all interrupt registers.
- *
- * Allocates and initializes data to track interrupt state for a device.
- * After this call, no interrupts will be configured/delivered; call
- * gasket_interrupt_set_vector[_packed] to associate each interrupt with an
- * __iomem location, then gasket_interrupt_set_eventfd to associate an eventfd
- * with an interrupt.
- *
- * If num_interrupts interrupts are not available, this call will return a
- * negative error code. In that case, gasket_interrupt_cleanup should still be
- * called. Returns 0 on success (which can include a device where interrupts
- * are not possible to set up, but is otherwise OK; that device will report
- * status LAMED.)
  */
-int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
-			  int type,
-			  const struct gasket_interrupt_desc *interrupts,
-			  int num_interrupts, int pack_width, int bar_index,
-			  const struct gasket_wire_interrupt_offsets *wire_int_offsets);
+int gasket_interrupt_init(struct gasket_dev *gasket_dev);
 
 /*
  * Clean up a device's interrupt structure.
-- 
2.18.0.597.ga71716f1ad-goog

