Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270ADC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0727208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnXTaq2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0727208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbeGaWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38816 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so6650266pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WB3gdOqRtAqqLWlzQvoVxUmiuMYdtno+oWJ+6oSLQgE=;
        b=XnXTaq2C/NavWs2GckAaDgSNpssPFhMgdw32A101pu7nJdMqJY+pEPEUNs10VbAA72
         7OBJNcN0l1ycvNBrHt023Xfai4fe/gW1dR8qCdlPOWIbuovcc84GFPNDfFhs/CndglLd
         RfRbwZpvTu2fOh/TCaL9P/hQlbokRxJz0KarEH6GZiaDIgsQl9gPUyeJn7PiFxs6fgKM
         RycTmykB6J6D9eYdGtM+XTSGY3HCIZrtgwMnkWVqd4ojQmh0THrpdWvsw/tzmP3wJFLw
         f+NQH4wn1XMpU1Rbw3SA59tVMddKNRFiNRYJrA0X+59FyyFCJgY5waZ0iGZMuMiBuQH4
         IvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WB3gdOqRtAqqLWlzQvoVxUmiuMYdtno+oWJ+6oSLQgE=;
        b=jlnbBVKWc/qral0lQXxJHsm3yUD+LnKdr6KOX40nbYDtyc31g5nQhprBzox7mYYDZr
         Y/D3rWXbIq78duxj78gI9Uhzn7n3gnS4w/lcSvCWUaQ7PT+GD0stBeCrNrNHdEyQeMTN
         yV6Jl8rfrUtahBuTYda4DiY8KVg+9ag1Q4x3rSl4hKW8fppZUFF5biok5tG8NvJPoZ92
         bN7N1kFRsK0lhVQW1lQS5kML8He5qz5xVy4GB6AWjtJRk0jWg8FG7PgFSfCG7TgwD+GT
         oRGo7Y7FU2yMuXTlbITwRZbWxuEIWZXnOOf2LXTCuR0q+yYDGc/N32NLFTxDmIW44pmB
         OS8Q==
X-Gm-Message-State: AOUpUlFJVvKq6k/pqUrnzOkqTTDNRH9RyOh8fSi7vv8GdbW8UD/ECcqr
        IRt5MexvUZka2uWhvQH/bhO6IRTiiAo=
X-Google-Smtp-Source: AAOMgpe0E2RBd9ou0I/p9HdV0kEUun5J9jmx6GWt39eRNI0fnIH5mng4MsVyYn3uLlqO4ht0xOc7eQ==
X-Received: by 2002:a63:1063:: with SMTP id 35-v6mr21904914pgq.249.1533068720385;
        Tue, 31 Jul 2018 13:25:20 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:19 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/15] staging: gasket: sysfs: fix function param line continuation style
Date:   Tue, 31 Jul 2018 13:24:42 -0700
Message-Id: <20180731202448.229487-10-toddpoynor@gmail.com>
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
 drivers/staging/gasket/gasket_sysfs.c | 26 +++++++++++-----------
 drivers/staging/gasket/gasket_sysfs.h | 32 +++++++++++++--------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index ef4eca02afa6..a4bfca43cd03 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -145,8 +145,8 @@ void gasket_sysfs_init(void)
 	}
 }
 
-int gasket_sysfs_create_mapping(
-	struct device *device, struct gasket_dev *gasket_dev)
+int gasket_sysfs_create_mapping(struct device *device,
+				struct gasket_dev *gasket_dev)
 {
 	struct gasket_sysfs_mapping *mapping;
 	int map_idx = -1;
@@ -210,8 +210,8 @@ int gasket_sysfs_create_mapping(
 	return 0;
 }
 
-int gasket_sysfs_create_entries(
-	struct device *device, const struct gasket_sysfs_attribute *attrs)
+int gasket_sysfs_create_entries(struct device *device,
+				const struct gasket_sysfs_attribute *attrs)
 {
 	int i;
 	int ret;
@@ -293,8 +293,8 @@ void gasket_sysfs_put_device_data(struct device *device, struct gasket_dev *dev)
 }
 EXPORT_SYMBOL(gasket_sysfs_put_device_data);
 
-struct gasket_sysfs_attribute *gasket_sysfs_get_attr(
-	struct device *device, struct device_attribute *attr)
+struct gasket_sysfs_attribute *
+gasket_sysfs_get_attr(struct device *device, struct device_attribute *attr)
 {
 	int i;
 	int num_attrs;
@@ -317,8 +317,8 @@ struct gasket_sysfs_attribute *gasket_sysfs_get_attr(
 }
 EXPORT_SYMBOL(gasket_sysfs_get_attr);
 
-void gasket_sysfs_put_attr(
-	struct device *device, struct gasket_sysfs_attribute *attr)
+void gasket_sysfs_put_attr(struct device *device,
+			   struct gasket_sysfs_attribute *attr)
 {
 	int i;
 	int num_attrs;
@@ -342,9 +342,9 @@ void gasket_sysfs_put_attr(
 }
 EXPORT_SYMBOL(gasket_sysfs_put_attr);
 
-ssize_t gasket_sysfs_register_store(
-	struct device *device, struct device_attribute *attr, const char *buf,
-	size_t count)
+ssize_t gasket_sysfs_register_store(struct device *device,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	ulong parsed_value = 0;
 	struct gasket_sysfs_mapping *mapping;
@@ -386,8 +386,8 @@ ssize_t gasket_sysfs_register_store(
 			    gasket_attr->data.bar_address.offset);
 
 	if (gasket_attr->write_callback)
-		gasket_attr->write_callback(
-			gasket_dev, gasket_attr, parsed_value);
+		gasket_attr->write_callback(gasket_dev, gasket_attr,
+					    parsed_value);
 
 	gasket_sysfs_put_attr(device, gasket_attr);
 	put_mapping(mapping);
diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
index e9f4fad80461..f32eaf89e056 100644
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -68,9 +68,9 @@ struct gasket_sysfs_attribute {
 	 * The callback should perform any logging necessary, as errors cannot
 	 * be returned from the callback.
 	 */
-	void (*write_callback)(
-		struct gasket_dev *dev, struct gasket_sysfs_attribute *attr,
-		ulong value);
+	void (*write_callback)(struct gasket_dev *dev,
+			       struct gasket_sysfs_attribute *attr,
+			       ulong value);
 };
 
 #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
@@ -98,8 +98,8 @@ void gasket_sysfs_init(void);
  * If this function is not called before gasket_sysfs_create_entries, a warning
  * will be logged.
  */
-int gasket_sysfs_create_mapping(
-	struct device *device, struct gasket_dev *gasket_dev);
+int gasket_sysfs_create_mapping(struct device *device,
+				struct gasket_dev *gasket_dev);
 
 /*
  * Creates bulk entries in sysfs.
@@ -111,8 +111,8 @@ int gasket_sysfs_create_mapping(
  * gasket_sysfs_create_mapping had a legacy device, the entries will be created
  * for it, as well.
  */
-int gasket_sysfs_create_entries(
-	struct device *device, const struct gasket_sysfs_attribute *attrs);
+int gasket_sysfs_create_entries(struct device *device,
+				const struct gasket_sysfs_attribute *attrs);
 
 /*
  * Removes a device mapping from the global table.
@@ -141,8 +141,8 @@ struct gasket_dev *gasket_sysfs_get_device_data(struct device *device);
  * @device: Kernel device structure.
  * @dev: Gasket device descriptor (returned by gasket_sysfs_get_device_data).
  */
-void gasket_sysfs_put_device_data(
-	struct device *device, struct gasket_dev *gasket_dev);
+void gasket_sysfs_put_device_data(struct device *device,
+				  struct gasket_dev *gasket_dev);
 
 /*
  * Gasket-specific attribute lookup.
@@ -155,8 +155,8 @@ void gasket_sysfs_put_device_data(
  * gasket_sysfs_get_device_data. While this reference is held, the underlying
  * device sysfs information/structure will remain valid/will not be deleted.
  */
-struct gasket_sysfs_attribute *gasket_sysfs_get_attr(
-	struct device *device, struct device_attribute *attr);
+struct gasket_sysfs_attribute *
+gasket_sysfs_get_attr(struct device *device, struct device_attribute *attr);
 
 /*
  * Releases a references to internal data.
@@ -164,16 +164,16 @@ struct gasket_sysfs_attribute *gasket_sysfs_get_attr(
  * @attr: Gasket sysfs attribute descriptor (returned by
  *        gasket_sysfs_get_attr).
  */
-void gasket_sysfs_put_attr(
-	struct device *device, struct gasket_sysfs_attribute *attr);
+void gasket_sysfs_put_attr(struct device *device,
+			   struct gasket_sysfs_attribute *attr);
 
 /*
  * Write to a register sysfs node.
  * @buf: NULL-terminated data being written.
  * @count: number of bytes in the "buf" argument.
  */
-ssize_t gasket_sysfs_register_store(
-	struct device *device, struct device_attribute *attr, const char *buf,
-	size_t count);
+ssize_t gasket_sysfs_register_store(struct device *device,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count);
 
 #endif /* __GASKET_SYSFS_H__ */
-- 
2.18.0.345.g5c9ce644c3-goog

