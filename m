Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB0208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLrQ2b41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB0208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbeGaWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46067 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbeGaWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so7658312pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KcjScMqTtYrmsruupuxgsoeygIAnY7CykKRvPLpQAI=;
        b=iLrQ2b41KAEIKV5l1XRc+sFFnTtgY4mKWhMy5W50Btyrka/zzhI+rsvOBRPlNiQr9D
         qs1theMLn2RVDNkczcdU/x6U1b5DQYPWCUCsqAGcBvTM8TcA5zS9CDRw1V370BbkS4Lk
         swSfiTQCZ+gK9/XoqFTugQu3Gi69OqNrlF3NmGhZ9WWVhYf0DnkjMAtF+nQOZUxjVrhu
         0ttHN/dbhmhA1HAvVQfsrJf7jd8E9YpBOvCTFHq7J+bOp8PtzpilknkX0OUlRXrMX3NU
         wNIJykJZm1uuGzK812o6XPrPJDjg9S66ZJGjxOhqT/blgxXDX9A9rIgEQdVXT/m1XXxs
         BXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KcjScMqTtYrmsruupuxgsoeygIAnY7CykKRvPLpQAI=;
        b=o4vitAo79kXci4avavA7gqEgzOrnEaQCgsSZm9+zCxYfTgigbCJFs4UCKluSaRFcni
         yfq8pkOWjQ5IXnSXN3JrB1fymNUa+pzDkigP2/qjhoHfgKzvjcb5in3iCS3nc4uG4E/i
         RQXbnDvYeKvNQ9lKa7L3zrZ6OVqPIdB6llvK3MfGXkx3cmfMJkiYi7UtAiaPvhqAgjar
         tYEf/rVdx7mW/HslGPud7S69Wz+y5P86tXkJzo5mCuyKtxQRusYBsDCIi2YcTfmwtgff
         pZFXQW5HkF/zHsvjvpvgGDxLiq9/cbwZS8SnFIF6EGtXJQQSkGDcCYJSUVGG6UGllHZT
         kGuw==
X-Gm-Message-State: AOUpUlEUTOo+fM/KcJPl8jusZZmzi1VIDXF+XqTmKVq137KXlfRm4a3M
        roDOPjuRHmFWI64dd1q9WJQ=
X-Google-Smtp-Source: AAOMgpeLTpDoB4LSk5TqZzLArsTkUaMjsmcWSS1pvSOumXoMtkihhLK2mhg/w0G6Rso9+YSQsXKZSg==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1-v6mr21755217plp.239.1533068721551;
        Tue, 31 Jul 2018 13:25:21 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:20 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/15] staging: gasket: interrupt: fix function param line continuation style
Date:   Tue, 31 Jul 2018 13:24:43 -0700
Message-Id: <20180731202448.229487-11-toddpoynor@gmail.com>
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

Fix multi-line alignment formatting to look like:
      int ret = long_function_name(device, VARIABLE1, VARIABLE2,
                                   VARIABLE3, VARIABLE4);

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 73 +++++++++++------------
 drivers/staging/gasket/gasket_interrupt.h | 19 +++---
 2 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 3079b59b122b..09c3d0747af6 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -144,11 +144,10 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 			}
 
 			mask = ~(0xFFFF << pack_shift);
-			value = gasket_dev_read_64(
-					gasket_dev,
-					interrupt_data->interrupt_bar_index,
-					interrupt_data->interrupts[i].reg) &
-				mask;
+			value = gasket_dev_read_64(gasket_dev,
+						   interrupt_data->interrupt_bar_index,
+						   interrupt_data->interrupts[i].reg);
+			value &= mask;
 			value |= interrupt_data->interrupts[i].index
 				 << pack_shift;
 		}
@@ -187,8 +186,8 @@ static irqreturn_t gasket_msix_interrupt_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int gasket_interrupt_msix_init(
-	struct gasket_interrupt_data *interrupt_data)
+static int
+gasket_interrupt_msix_init(struct gasket_interrupt_data *interrupt_data)
 {
 	int ret = 1;
 	int i;
@@ -210,10 +209,9 @@ static int gasket_interrupt_msix_init(
 	interrupt_data->msix_configured = 1;
 
 	for (i = 0; i < interrupt_data->num_interrupts; i++) {
-		ret = request_irq(
-			interrupt_data->msix_entries[i].vector,
-			gasket_msix_interrupt_handler, 0, interrupt_data->name,
-			interrupt_data);
+		ret = request_irq(interrupt_data->msix_entries[i].vector,
+				  gasket_msix_interrupt_handler, 0,
+				  interrupt_data->name, interrupt_data);
 
 		if (ret) {
 			dev_err(&interrupt_data->pci_dev->dev,
@@ -250,25 +248,23 @@ static void force_msix_interrupt_unmasking(struct gasket_dev *gasket_dev)
 		ulong location = APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE +
 				 MSIX_MASK_BIT_OFFSET + i * MSIX_VECTOR_SIZE;
 		u32 mask =
-			gasket_dev_read_32(
-				gasket_dev,
-				gasket_dev->interrupt_data->interrupt_bar_index,
-				location);
+			gasket_dev_read_32(gasket_dev,
+					   gasket_dev->interrupt_data->interrupt_bar_index,
+					   location);
 		if (!(mask & 1))
 			continue;
 		/* Unmask the msix vector (clear 32 bits) */
-		gasket_dev_write_32(
-			gasket_dev, 0,
-			gasket_dev->interrupt_data->interrupt_bar_index,
-			location);
+		gasket_dev_write_32(gasket_dev, 0,
+				    gasket_dev->interrupt_data->interrupt_bar_index,
+				    location);
 	}
 #undef MSIX_VECTOR_SIZE
 #undef MSIX_MASK_BIT_OFFSET
 #undef APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE
 }
 
-static ssize_t interrupt_sysfs_show(
-	struct device *device, struct device_attribute *attr, char *buf)
+static ssize_t interrupt_sysfs_show(struct device *device,
+				    struct device_attribute *attr, char *buf)
 {
 	int i, ret;
 	ssize_t written = 0, total_written = 0;
@@ -318,22 +314,22 @@ static ssize_t interrupt_sysfs_show(
 }
 
 static struct gasket_sysfs_attribute interrupt_sysfs_attrs[] = {
-	GASKET_SYSFS_RO(
-		interrupt_counts, interrupt_sysfs_show, ATTR_INTERRUPT_COUNTS),
+	GASKET_SYSFS_RO(interrupt_counts, interrupt_sysfs_show,
+			ATTR_INTERRUPT_COUNTS),
 	GASKET_END_OF_ATTR_ARRAY,
 };
 
-int gasket_interrupt_init(
-	struct gasket_dev *gasket_dev, const char *name, int type,
-	const struct gasket_interrupt_desc *interrupts,
-	int num_interrupts, int pack_width, int bar_index,
-	const struct gasket_wire_interrupt_offsets *wire_int_offsets)
+int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
+			  int type,
+			  const struct gasket_interrupt_desc *interrupts,
+			  int num_interrupts, int pack_width, int bar_index,
+			  const struct gasket_wire_interrupt_offsets *wire_int_offsets)
 {
 	int ret;
 	struct gasket_interrupt_data *interrupt_data;
 
-	interrupt_data = kzalloc(
-		sizeof(struct gasket_interrupt_data), GFP_KERNEL);
+	interrupt_data = kzalloc(sizeof(struct gasket_interrupt_data),
+				 GFP_KERNEL);
 	if (!interrupt_data)
 		return -ENOMEM;
 	gasket_dev->interrupt_data = interrupt_data;
@@ -402,14 +398,14 @@ int gasket_interrupt_init(
 	}
 
 	gasket_interrupt_setup(gasket_dev);
-	gasket_sysfs_create_entries(
-		gasket_dev->dev_info.device, interrupt_sysfs_attrs);
+	gasket_sysfs_create_entries(gasket_dev->dev_info.device,
+				    interrupt_sysfs_attrs);
 
 	return 0;
 }
 
-static void gasket_interrupt_msix_cleanup(
-	struct gasket_interrupt_data *interrupt_data)
+static void
+gasket_interrupt_msix_cleanup(struct gasket_interrupt_data *interrupt_data)
 {
 	int i;
 
@@ -528,9 +524,8 @@ int gasket_interrupt_system_status(struct gasket_dev *gasket_dev)
 	return GASKET_STATUS_ALIVE;
 }
 
-int gasket_interrupt_set_eventfd(
-	struct gasket_interrupt_data *interrupt_data, int interrupt,
-	int event_fd)
+int gasket_interrupt_set_eventfd(struct gasket_interrupt_data *interrupt_data,
+				 int interrupt, int event_fd)
 {
 	struct eventfd_ctx *ctx = eventfd_ctx_fdget(event_fd);
 
@@ -544,8 +539,8 @@ int gasket_interrupt_set_eventfd(
 	return 0;
 }
 
-int gasket_interrupt_clear_eventfd(
-	struct gasket_interrupt_data *interrupt_data, int interrupt)
+int gasket_interrupt_clear_eventfd(struct gasket_interrupt_data *interrupt_data,
+				   int interrupt)
 {
 	if (interrupt < 0 || interrupt >= interrupt_data->num_interrupts)
 		return -EINVAL;
diff --git a/drivers/staging/gasket/gasket_interrupt.h b/drivers/staging/gasket/gasket_interrupt.h
index 805fee64569f..835af439e96a 100644
--- a/drivers/staging/gasket/gasket_interrupt.h
+++ b/drivers/staging/gasket/gasket_interrupt.h
@@ -43,11 +43,11 @@ struct gasket_interrupt_data;
  * are not possible to set up, but is otherwise OK; that device will report
  * status LAMED.)
  */
-int gasket_interrupt_init(
-	struct gasket_dev *gasket_dev, const char *name, int type,
-	const struct gasket_interrupt_desc *interrupts,
-	int num_interrupts, int pack_width, int bar_index,
-	const struct gasket_wire_interrupt_offsets *wire_int_offsets);
+int gasket_interrupt_init(struct gasket_dev *gasket_dev, const char *name,
+			  int type,
+			  const struct gasket_interrupt_desc *interrupts,
+			  int num_interrupts, int pack_width, int bar_index,
+			  const struct gasket_wire_interrupt_offsets *wire_int_offsets);
 
 /*
  * Clean up a device's interrupt structure.
@@ -87,9 +87,8 @@ int gasket_interrupt_reset_counts(struct gasket_dev *gasket_dev);
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int gasket_interrupt_set_eventfd(
-	struct gasket_interrupt_data *interrupt_data, int interrupt,
-	int event_fd);
+int gasket_interrupt_set_eventfd(struct gasket_interrupt_data *interrupt_data,
+				 int interrupt, int event_fd);
 
 /*
  * Removes an interrupt-eventfd association.
@@ -98,8 +97,8 @@ int gasket_interrupt_set_eventfd(
  *
  * Removes any eventfd associated with the specified interrupt, if any.
  */
-int gasket_interrupt_clear_eventfd(
-	struct gasket_interrupt_data *interrupt_data, int interrupt);
+int gasket_interrupt_clear_eventfd(struct gasket_interrupt_data *interrupt_data,
+				   int interrupt);
 
 /*
  * The below functions exist for backwards compatibility.
-- 
2.18.0.345.g5c9ce644c3-goog

