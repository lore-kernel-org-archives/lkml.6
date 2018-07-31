Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22838C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9020894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhN/ZYtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A9020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeGaWIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:08:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeGaWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so6638903pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuA1AJqauPX1sqyJMVR+mWbX8tRd3bYgZ6fg0nHBbrY=;
        b=fhN/ZYtpAmFvTqPoy9OiCVOlXVZk+IXL7lk4lFjt2rmAGBSZeej4ae9e4sWlge0OLi
         RjwOXrVncnQgyYF2V0dK2MSUANao0uab/b16uMDATs+p/DNwcqKXiEt4dNA1Aw8qjaa8
         Emk2uHTwaJVvy22yteGz0oGesRrXRaOY5242PNr1PhDTkrujN8P5af08z1IKHdXdZxHt
         OFwDyJVhZrXJdlDwZPM7GKh2XPGYV7giWlqp8uVu/hGXT36qsmT0hWes6Y2cn38esl9W
         C1At7ZGBcuWgzsjn+fKmO7u2u6/Wx0oVSL4NCzaDueCDWUKTlEZRCCZ7MxAbMfQE5v0y
         LxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuA1AJqauPX1sqyJMVR+mWbX8tRd3bYgZ6fg0nHBbrY=;
        b=ZetSwly9zIf9M3h4+hQGM+5hwxyaiPAGxLA16UtxewaF2mGy0A4f6Pzr53Sl/U8H79
         1k3G3vLqn/gS7kN/eKVtJgTgySXPNWPUS70YI4de1lN60zilnzcHSBBtVrPnit8576oG
         96HaBgqi0koLfIuOVjA/H3q6JELScKiIJxumGth/1956mErFfnFbd3dq0h2Sr1PC2ipN
         rqLg02oLioVM2zQZ9d9ceLY4sbIEwqEl3D5un1B6//E7ISfu18sLzSdDeYxetiyNMcd2
         G/QWinWrpJ3z+rYwtgF/ZJu0kxqoL7r5++SckuU5Dtilk7IXvMfQ9nJpA7QVEUY92pMv
         a19g==
X-Gm-Message-State: AOUpUlEW1wBBTZaqiQ0COfRP9bRjKEmcRuoOYZw150AzvZI7nu4XEvwK
        IHqUb08hWCO3VAmVU4cF+YA=
X-Google-Smtp-Source: AAOMgpeNxd+uDxJ29YFN96PztEz43YmNle4aCvtD1itfswmbFkYmUUS5yJoCrgFBlrrjNsHaPr3lNQ==
X-Received: by 2002:a62:3cd7:: with SMTP id b84-v6mr23773020pfk.183.1533068713779;
        Tue, 31 Jul 2018 13:25:13 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:13 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/15] staging: gasket: interrupt: remove static function forward declarations
Date:   Tue, 31 Jul 2018 13:24:36 -0700
Message-Id: <20180731202448.229487-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove forward declarations of static functions, move code to avoid
forward references, for kernel style.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 499 +++++++++++-----------
 1 file changed, 242 insertions(+), 257 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 27fde991edc6..3079b59b122b 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -70,32 +70,259 @@ struct gasket_interrupt_data {
 	int irq;
 };
 
-/* Function definitions. */
-static ssize_t interrupt_sysfs_show(
-	struct device *device, struct device_attribute *attr, char *buf);
-
-static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id);
-
 /* Structures to display interrupt counts in sysfs. */
 enum interrupt_sysfs_attribute_type {
 	ATTR_INTERRUPT_COUNTS,
 };
 
+/* Set up device registers for interrupt handling. */
+static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
+{
+	int i;
+	int pack_shift;
+	ulong mask;
+	ulong value;
+	struct gasket_interrupt_data *interrupt_data =
+		gasket_dev->interrupt_data;
+
+	if (!interrupt_data) {
+		dev_dbg(gasket_dev->dev, "Interrupt data is not initialized\n");
+		return;
+	}
+
+	dev_dbg(gasket_dev->dev, "Running interrupt setup\n");
+
+	if (interrupt_data->type == PLATFORM_WIRE ||
+	    interrupt_data->type == PCI_MSI) {
+		/* Nothing needs to be done for platform or PCI devices. */
+		return;
+	}
+
+	if (interrupt_data->type != PCI_MSIX) {
+		dev_dbg(gasket_dev->dev,
+			"Cannot handle unsupported interrupt type %d\n",
+			interrupt_data->type);
+		return;
+	}
+
+	/* Setup the MSIX table. */
+
+	for (i = 0; i < interrupt_data->num_interrupts; i++) {
+		/*
+		 * If the interrupt is not packed, we can write the index into
+		 * the register directly. If not, we need to deal with a read-
+		 * modify-write and shift based on the packing index.
+		 */
+		dev_dbg(gasket_dev->dev,
+			"Setting up interrupt index %d with index 0x%llx and "
+			"packing %d\n",
+			interrupt_data->interrupts[i].index,
+			interrupt_data->interrupts[i].reg,
+			interrupt_data->interrupts[i].packing);
+		if (interrupt_data->interrupts[i].packing == UNPACKED) {
+			value = interrupt_data->interrupts[i].index;
+		} else {
+			switch (interrupt_data->interrupts[i].packing) {
+			case PACK_0:
+				pack_shift = 0;
+				break;
+			case PACK_1:
+				pack_shift = interrupt_data->pack_width;
+				break;
+			case PACK_2:
+				pack_shift = 2 * interrupt_data->pack_width;
+				break;
+			case PACK_3:
+				pack_shift = 3 * interrupt_data->pack_width;
+				break;
+			default:
+				dev_dbg(gasket_dev->dev,
+					"Found interrupt description with "
+					"unknown enum %d\n",
+					interrupt_data->interrupts[i].packing);
+				return;
+			}
+
+			mask = ~(0xFFFF << pack_shift);
+			value = gasket_dev_read_64(
+					gasket_dev,
+					interrupt_data->interrupt_bar_index,
+					interrupt_data->interrupts[i].reg) &
+				mask;
+			value |= interrupt_data->interrupts[i].index
+				 << pack_shift;
+		}
+		gasket_dev_write_64(gasket_dev, value,
+				    interrupt_data->interrupt_bar_index,
+				    interrupt_data->interrupts[i].reg);
+	}
+}
+
+static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
+{
+	struct eventfd_ctx *ctx;
+	struct gasket_interrupt_data *interrupt_data = dev_id;
+	int interrupt = -1;
+	int i;
+
+	/* If this linear lookup is a problem, we can maintain a map/hash. */
+	for (i = 0; i < interrupt_data->num_interrupts; i++) {
+		if (interrupt_data->msix_entries[i].vector == irq) {
+			interrupt = interrupt_data->msix_entries[i].entry;
+			break;
+		}
+	}
+	if (interrupt == -1) {
+		pr_err("Received unknown irq %d\n", irq);
+		return IRQ_HANDLED;
+	}
+	trace_gasket_interrupt_event(interrupt_data->name, interrupt);
+
+	ctx = interrupt_data->eventfd_ctxs[interrupt];
+	if (ctx)
+		eventfd_signal(ctx, 1);
+
+	++(interrupt_data->interrupt_counts[interrupt]);
+
+	return IRQ_HANDLED;
+}
+
+static int gasket_interrupt_msix_init(
+	struct gasket_interrupt_data *interrupt_data)
+{
+	int ret = 1;
+	int i;
+
+	for (i = 0; i < interrupt_data->num_interrupts; i++) {
+		interrupt_data->msix_entries[i].entry = i;
+		interrupt_data->msix_entries[i].vector = 0;
+		interrupt_data->eventfd_ctxs[i] = NULL;
+	}
+
+	/* Retry MSIX_RETRY_COUNT times if not enough IRQs are available. */
+	for (i = 0; i < MSIX_RETRY_COUNT && ret > 0; i++)
+		ret = pci_enable_msix_exact(interrupt_data->pci_dev,
+					    interrupt_data->msix_entries,
+					    interrupt_data->num_interrupts);
+
+	if (ret)
+		return ret > 0 ? -EBUSY : ret;
+	interrupt_data->msix_configured = 1;
+
+	for (i = 0; i < interrupt_data->num_interrupts; i++) {
+		ret = request_irq(
+			interrupt_data->msix_entries[i].vector,
+			gasket_msix_interrupt_handler, 0, interrupt_data->name,
+			interrupt_data);
+
+		if (ret) {
+			dev_err(&interrupt_data->pci_dev->dev,
+				"Cannot get IRQ for interrupt %d, vector %d; "
+				"%d\n",
+				i, interrupt_data->msix_entries[i].vector, ret);
+			return ret;
+		}
+
+		interrupt_data->num_configured++;
+	}
+
+	return 0;
+}
+
+/*
+ * On QCM DragonBoard, we exit gasket_interrupt_msix_init() and kernel interrupt
+ * setup code with MSIX vectors masked. This is wrong because nothing else in
+ * the driver will normally touch the MSIX vectors.
+ *
+ * As a temporary hack, force unmasking there.
+ *
+ * TODO: Figure out why QCM kernel doesn't unmask the MSIX vectors, after
+ * gasket_interrupt_msix_init(), and remove this code.
+ */
+static void force_msix_interrupt_unmasking(struct gasket_dev *gasket_dev)
+{
+	int i;
+#define MSIX_VECTOR_SIZE 16
+#define MSIX_MASK_BIT_OFFSET 12
+#define APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE 0x46800
+	for (i = 0; i < gasket_dev->interrupt_data->num_configured; i++) {
+		/* Check if the MSIX vector is unmasked */
+		ulong location = APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE +
+				 MSIX_MASK_BIT_OFFSET + i * MSIX_VECTOR_SIZE;
+		u32 mask =
+			gasket_dev_read_32(
+				gasket_dev,
+				gasket_dev->interrupt_data->interrupt_bar_index,
+				location);
+		if (!(mask & 1))
+			continue;
+		/* Unmask the msix vector (clear 32 bits) */
+		gasket_dev_write_32(
+			gasket_dev, 0,
+			gasket_dev->interrupt_data->interrupt_bar_index,
+			location);
+	}
+#undef MSIX_VECTOR_SIZE
+#undef MSIX_MASK_BIT_OFFSET
+#undef APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE
+}
+
+static ssize_t interrupt_sysfs_show(
+	struct device *device, struct device_attribute *attr, char *buf)
+{
+	int i, ret;
+	ssize_t written = 0, total_written = 0;
+	struct gasket_interrupt_data *interrupt_data;
+	struct gasket_dev *gasket_dev;
+	struct gasket_sysfs_attribute *gasket_attr;
+	enum interrupt_sysfs_attribute_type sysfs_type;
+
+	gasket_dev = gasket_sysfs_get_device_data(device);
+	if (!gasket_dev) {
+		dev_dbg(device, "No sysfs mapping found for device\n");
+		return 0;
+	}
+
+	gasket_attr = gasket_sysfs_get_attr(device, attr);
+	if (!gasket_attr) {
+		dev_dbg(device, "No sysfs attr data found for device\n");
+		gasket_sysfs_put_device_data(device, gasket_dev);
+		return 0;
+	}
+
+	sysfs_type = (enum interrupt_sysfs_attribute_type)
+		gasket_attr->data.attr_type;
+	interrupt_data = gasket_dev->interrupt_data;
+	switch (sysfs_type) {
+	case ATTR_INTERRUPT_COUNTS:
+		for (i = 0; i < interrupt_data->num_interrupts; ++i) {
+			written =
+				scnprintf(buf, PAGE_SIZE - total_written,
+					  "0x%02x: %ld\n", i,
+					  interrupt_data->interrupt_counts[i]);
+			total_written += written;
+			buf += written;
+		}
+		ret = total_written;
+		break;
+	default:
+		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
+			attr->attr.name);
+		ret = 0;
+		break;
+	}
+
+	gasket_sysfs_put_attr(device, gasket_attr);
+	gasket_sysfs_put_device_data(device, gasket_dev);
+	return ret;
+}
+
 static struct gasket_sysfs_attribute interrupt_sysfs_attrs[] = {
 	GASKET_SYSFS_RO(
 		interrupt_counts, interrupt_sysfs_show, ATTR_INTERRUPT_COUNTS),
 	GASKET_END_OF_ATTR_ARRAY,
 };
 
-static void gasket_interrupt_setup(struct gasket_dev *gasket_dev);
-
-/* MSIX init and cleanup. */
-static int gasket_interrupt_msix_init(
-	struct gasket_interrupt_data *interrupt_data);
-static void gasket_interrupt_msix_cleanup(
-	struct gasket_interrupt_data *interrupt_data);
-static void force_msix_interrupt_unmasking(struct gasket_dev *gasket_dev);
-
 int gasket_interrupt_init(
 	struct gasket_dev *gasket_dev, const char *name, int type,
 	const struct gasket_interrupt_desc *interrupts,
@@ -181,48 +408,6 @@ int gasket_interrupt_init(
 	return 0;
 }
 
-static int gasket_interrupt_msix_init(
-	struct gasket_interrupt_data *interrupt_data)
-{
-	int ret = 1;
-	int i;
-
-	for (i = 0; i < interrupt_data->num_interrupts; i++) {
-		interrupt_data->msix_entries[i].entry = i;
-		interrupt_data->msix_entries[i].vector = 0;
-		interrupt_data->eventfd_ctxs[i] = NULL;
-	}
-
-	/* Retry MSIX_RETRY_COUNT times if not enough IRQs are available. */
-	for (i = 0; i < MSIX_RETRY_COUNT && ret > 0; i++)
-		ret = pci_enable_msix_exact(interrupt_data->pci_dev,
-					    interrupt_data->msix_entries,
-					    interrupt_data->num_interrupts);
-
-	if (ret)
-		return ret > 0 ? -EBUSY : ret;
-	interrupt_data->msix_configured = 1;
-
-	for (i = 0; i < interrupt_data->num_interrupts; i++) {
-		ret = request_irq(
-			interrupt_data->msix_entries[i].vector,
-			gasket_msix_interrupt_handler, 0, interrupt_data->name,
-			interrupt_data);
-
-		if (ret) {
-			dev_err(&interrupt_data->pci_dev->dev,
-				"Cannot get IRQ for interrupt %d, vector %d; "
-				"%d\n",
-				i, interrupt_data->msix_entries[i].vector, ret);
-			return ret;
-		}
-
-		interrupt_data->num_configured++;
-	}
-
-	return 0;
-}
-
 static void gasket_interrupt_msix_cleanup(
 	struct gasket_interrupt_data *interrupt_data)
 {
@@ -238,44 +423,6 @@ static void gasket_interrupt_msix_cleanup(
 	interrupt_data->msix_configured = 0;
 }
 
-/*
- * On QCM DragonBoard, we exit gasket_interrupt_msix_init() and kernel interrupt
- * setup code with MSIX vectors masked. This is wrong because nothing else in
- * the driver will normally touch the MSIX vectors.
- *
- * As a temporary hack, force unmasking there.
- *
- * TODO: Figure out why QCM kernel doesn't unmask the MSIX vectors, after
- * gasket_interrupt_msix_init(), and remove this code.
- */
-static void force_msix_interrupt_unmasking(struct gasket_dev *gasket_dev)
-{
-	int i;
-#define MSIX_VECTOR_SIZE 16
-#define MSIX_MASK_BIT_OFFSET 12
-#define APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE 0x46800
-	for (i = 0; i < gasket_dev->interrupt_data->num_configured; i++) {
-		/* Check if the MSIX vector is unmasked */
-		ulong location = APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE +
-				 MSIX_MASK_BIT_OFFSET + i * MSIX_VECTOR_SIZE;
-		u32 mask =
-			gasket_dev_read_32(
-				gasket_dev,
-				gasket_dev->interrupt_data->interrupt_bar_index,
-				location);
-		if (!(mask & 1))
-			continue;
-		/* Unmask the msix vector (clear 32 bits) */
-		gasket_dev_write_32(
-			gasket_dev, 0,
-			gasket_dev->interrupt_data->interrupt_bar_index,
-			location);
-	}
-#undef MSIX_VECTOR_SIZE
-#undef MSIX_MASK_BIT_OFFSET
-#undef APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE
-}
-
 int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 {
 	int ret;
@@ -327,89 +474,6 @@ int gasket_interrupt_reset_counts(struct gasket_dev *gasket_dev)
 	return 0;
 }
 
-/* Set up device registers for interrupt handling. */
-static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
-{
-	int i;
-	int pack_shift;
-	ulong mask;
-	ulong value;
-	struct gasket_interrupt_data *interrupt_data =
-		gasket_dev->interrupt_data;
-
-	if (!interrupt_data) {
-		dev_dbg(gasket_dev->dev, "Interrupt data is not initialized\n");
-		return;
-	}
-
-	dev_dbg(gasket_dev->dev, "Running interrupt setup\n");
-
-	if (interrupt_data->type == PLATFORM_WIRE ||
-	    interrupt_data->type == PCI_MSI) {
-		/* Nothing needs to be done for platform or PCI devices. */
-		return;
-	}
-
-	if (interrupt_data->type != PCI_MSIX) {
-		dev_dbg(gasket_dev->dev,
-			"Cannot handle unsupported interrupt type %d\n",
-			interrupt_data->type);
-		return;
-	}
-
-	/* Setup the MSIX table. */
-
-	for (i = 0; i < interrupt_data->num_interrupts; i++) {
-		/*
-		 * If the interrupt is not packed, we can write the index into
-		 * the register directly. If not, we need to deal with a read-
-		 * modify-write and shift based on the packing index.
-		 */
-		dev_dbg(gasket_dev->dev,
-			"Setting up interrupt index %d with index 0x%llx and "
-			"packing %d\n",
-			interrupt_data->interrupts[i].index,
-			interrupt_data->interrupts[i].reg,
-			interrupt_data->interrupts[i].packing);
-		if (interrupt_data->interrupts[i].packing == UNPACKED) {
-			value = interrupt_data->interrupts[i].index;
-		} else {
-			switch (interrupt_data->interrupts[i].packing) {
-			case PACK_0:
-				pack_shift = 0;
-				break;
-			case PACK_1:
-				pack_shift = interrupt_data->pack_width;
-				break;
-			case PACK_2:
-				pack_shift = 2 * interrupt_data->pack_width;
-				break;
-			case PACK_3:
-				pack_shift = 3 * interrupt_data->pack_width;
-				break;
-			default:
-				dev_dbg(gasket_dev->dev,
-					"Found interrupt description with "
-					"unknown enum %d\n",
-					interrupt_data->interrupts[i].packing);
-				return;
-			}
-
-			mask = ~(0xFFFF << pack_shift);
-			value = gasket_dev_read_64(
-					gasket_dev,
-					interrupt_data->interrupt_bar_index,
-					interrupt_data->interrupts[i].reg) &
-				mask;
-			value |= interrupt_data->interrupts[i].index
-				 << pack_shift;
-		}
-		gasket_dev_write_64(gasket_dev, value,
-				    interrupt_data->interrupt_bar_index,
-				    interrupt_data->interrupts[i].reg);
-	}
-}
-
 /* See gasket_interrupt.h for description. */
 void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 {
@@ -489,82 +553,3 @@ int gasket_interrupt_clear_eventfd(
 	interrupt_data->eventfd_ctxs[interrupt] = NULL;
 	return 0;
 }
-
-static ssize_t interrupt_sysfs_show(
-	struct device *device, struct device_attribute *attr, char *buf)
-{
-	int i, ret;
-	ssize_t written = 0, total_written = 0;
-	struct gasket_interrupt_data *interrupt_data;
-	struct gasket_dev *gasket_dev;
-	struct gasket_sysfs_attribute *gasket_attr;
-	enum interrupt_sysfs_attribute_type sysfs_type;
-
-	gasket_dev = gasket_sysfs_get_device_data(device);
-	if (!gasket_dev) {
-		dev_dbg(device, "No sysfs mapping found for device\n");
-		return 0;
-	}
-
-	gasket_attr = gasket_sysfs_get_attr(device, attr);
-	if (!gasket_attr) {
-		dev_dbg(device, "No sysfs attr data found for device\n");
-		gasket_sysfs_put_device_data(device, gasket_dev);
-		return 0;
-	}
-
-	sysfs_type = (enum interrupt_sysfs_attribute_type)
-		gasket_attr->data.attr_type;
-	interrupt_data = gasket_dev->interrupt_data;
-	switch (sysfs_type) {
-	case ATTR_INTERRUPT_COUNTS:
-		for (i = 0; i < interrupt_data->num_interrupts; ++i) {
-			written =
-				scnprintf(buf, PAGE_SIZE - total_written,
-					  "0x%02x: %ld\n", i,
-					  interrupt_data->interrupt_counts[i]);
-			total_written += written;
-			buf += written;
-		}
-		ret = total_written;
-		break;
-	default:
-		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
-			attr->attr.name);
-		ret = 0;
-		break;
-	}
-
-	gasket_sysfs_put_attr(device, gasket_attr);
-	gasket_sysfs_put_device_data(device, gasket_dev);
-	return ret;
-}
-
-static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
-{
-	struct eventfd_ctx *ctx;
-	struct gasket_interrupt_data *interrupt_data = dev_id;
-	int interrupt = -1;
-	int i;
-
-	/* If this linear lookup is a problem, we can maintain a map/hash. */
-	for (i = 0; i < interrupt_data->num_interrupts; i++) {
-		if (interrupt_data->msix_entries[i].vector == irq) {
-			interrupt = interrupt_data->msix_entries[i].entry;
-			break;
-		}
-	}
-	if (interrupt == -1) {
-		pr_err("Received unknown irq %d\n", irq);
-		return IRQ_HANDLED;
-	}
-	trace_gasket_interrupt_event(interrupt_data->name, interrupt);
-
-	ctx = interrupt_data->eventfd_ctxs[interrupt];
-	if (ctx)
-		eventfd_signal(ctx, 1);
-
-	++(interrupt_data->interrupt_counts[interrupt]);
-
-	return IRQ_HANDLED;
-}
-- 
2.18.0.345.g5c9ce644c3-goog

