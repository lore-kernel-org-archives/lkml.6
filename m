Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D710C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392BA2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXWEc1R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfASAOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:14:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53927 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfASAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:14:36 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so9254145ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8B2UCvQd7gRR64mddN1rS5cY92pXhXBggqbXefoupA=;
        b=nXWEc1R0suVeF7Fg8y8p7soZQvolJFuL72dE9GoyyqEkfF0fYhM6vrTtPD/Fz2b2iB
         TYl7tZ4qgXeM0fH4jKH+vbxnG+sUTXwXfgcT38Z8flm0ukbpLQeebeuLYIUguicF3+rd
         E0mioJJ8OsB1/BluwA+bSoj+eLgHPKKEOV5Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8B2UCvQd7gRR64mddN1rS5cY92pXhXBggqbXefoupA=;
        b=Xl/kCZpKlhSHfYrEKp8kVhg+H+/0FUgi7SIvqlMXbtIyv1UgcHkJMw1WJFvHcVU3U5
         4WgYHNwYN7KGl40bUoHd9HUPhDrVRYndFAxqqXxmChUBEFCs3bY43KMkMzbWMa/eyMbC
         SpZ4BsbhtebnmLBK9xF2s3DabdzgFKgQpvlQWP4GS+zJsQZVNo36cCXHdWr0HhyU8iRb
         i/850s3OCLpcPgWKlNhwiWIp2crsDbaAJHxMKPrChmeUjEjF8tjKNIw4WKSM/2ItMxDU
         +nooQwFvStLOuyQYbsZG8FX/AuZompUFryVuCYjp3SUAVsls3FFy7bLn5n7wVHGt6t1A
         tG2g==
X-Gm-Message-State: AJcUukfqKwLmym9AyE7w2tJ8RTLxRkY7Xbv76zxHSgGZsLghMUXzXJnw
        iXq7+2iko2EB6kBNGFmJZkXF6SuQtQQ=
X-Google-Smtp-Source: ALg8bN7KXyNlSlcEIM5TM7k+ZDAEdOSh5Qmi+PZZvE1cooRDTCeNRhEaFNkvbuhFjxcCQc7YOGeRfQ==
X-Received: by 2002:a05:660c:684:: with SMTP id n4mr10501343itk.64.1547856873874;
        Fri, 18 Jan 2019 16:14:33 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id e22sm2382062iod.47.2019.01.18.16.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:14:33 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, djkurtz@google.com,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 3/9] platform/chrome: Add support for raw commands in debugfs
Date:   Fri, 18 Jan 2019 17:14:16 -0700
Message-Id: <20190119001422.48186-4-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190119001422.48186-1-ncrews@chromium.org>
References: <20190119001422.48186-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

Add a debugfs attribute that allows sending raw commands to the EC.
This is useful for development and debug but should not be enabled
in a production environment.

Turn the keyboard global mic mute led on
> echo 00 f2 01 76 06 00 00 01 01 > /sys/kernel/debug/wilco_ec/raw
Turn the keyboard global mic mute led off
> echo 00 f2 01 76 06 00 00 01 00 > /sys/kernel/debug/wilco_ec/raw
Get the EC firmware build date
First send the request command
> echo 00 f0 38 00 03 00 > raw
Then read the result. "12/21/18" is in the middle of the response
> cat raw
00 31 32 2f 32 31 2f 31 38 00 00 0f 01 00 01 00  .12/21/18.......

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v3:
- Move the attribute to the debugfs system
- Move the implementation to debugfs.c
- Improve the raw hex parsing
- Encapsulate global variables in one object
- Add safety check when passing less than 3 bytes
- Move documentation to debugfs-wilco-ec

Changes in v2:
- Add sysfs documentation
- rm duplicate EC_MAILBOX_DATA_SIZE defs
- Make docstrings follow kernel style
- Fix tags in commit msg
- Move Kconfig to subdirectory
- Reading raw now includes ASCII translation

 Documentation/ABI/testing/debugfs-wilco-ec |  23 +++
 drivers/platform/chrome/wilco_ec/Kconfig   |   9 +
 drivers/platform/chrome/wilco_ec/Makefile  |   2 +-
 drivers/platform/chrome/wilco_ec/core.c    |  17 ++
 drivers/platform/chrome/wilco_ec/debugfs.c | 218 +++++++++++++++++++++
 include/linux/platform_data/wilco-ec.h     |   3 +
 6 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-wilco-ec b/Documentation/ABI/testing/debugfs-wilco-ec
new file mode 100644
index 000000000000..90bc3fe08dff
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-wilco-ec
@@ -0,0 +1,23 @@
+What:		/sys/kernel/debug/wilco_ec/raw
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Write and read raw mailbox commands to the EC.
+
+		For writing:
+		Bytes 0-1 indicate the message type:
+			00 F0 = Execute Legacy Command
+			00 F2 = Read/Write NVRAM Property
+		Byte 2 provides the command code
+		Bytes 3+ consist of the data passed in the request
+
+		Example:
+		// Request EC info type 3 (EC firmware build date)
+		$ echo 00 f0 38 00 03 00 > raw
+		// View the result. The decoded ASCII result "12/21/18" is
+		// included after the raw hex.
+		$ cat raw
+		00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
+
+		At least three bytes are required, for the msg type and command,
+		with additional bytes optional for additional data.
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index f8e6c9e8c5cd..0bd84c98b79b 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -21,4 +21,13 @@ config WILCO_EC
 	  To compile this driver as a module, choose M here: the
 	  module will be called wilco_ec.
 
+config WILCO_EC_SYSFS_RAW
+	bool "Enable raw access to EC via sysfs"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support for sending raw commands to
+	  the Wilco EC via sysfs.  These commands do not do any byte
+	  manipulation and allow for testing arbitrary commands.  This
+	  interface is intended for debug only and is disabled by default.
+
 endif # WILCO_EC_PLATFORM
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 03b32301dc61..86d0457d85ea 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-wilco_ec-objs				:= core.o mailbox.o
+wilco_ec-objs				:= core.o mailbox.o debugfs.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 13fe21dd235a..749fd6a36057 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -34,6 +34,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct wilco_ec_device *ec;
+	int ret;
 
 	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
 	if (!ec)
@@ -61,11 +62,27 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	cros_ec_lpc_mec_init(ec->io_packet->start,
 			     ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
 
+	/* add debugfs attributes */
+	ret = wilco_ec_debugfs_init(ec);
+	if (ret) {
+		dev_err(dev, "Failed to create debugfs attributes\n");
+		goto destroy_mec;
+	}
+
 	return 0;
+
+destroy_mec:
+	cros_ec_lpc_mec_destroy();
+	return ret;
 }
 
 static int wilco_ec_remove(struct platform_device *pdev)
 {
+	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
+
+	/* remove debugfs attributes */
+	wilco_ec_debugfs_remove(ec);
+
 	/* Teardown cros_ec interface */
 	cros_ec_lpc_mec_destroy();
 
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
new file mode 100644
index 000000000000..46b0bf3fdf39
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * debugfs attributes for Wilco EC
+ *
+ * Copyright 2019 Google LLC
+ *
+ * There is only one attribute used for debugging, called raw.
+ * You can write a hexadecimal sentence to raw, and that series of bytes
+ * will be sent to the EC. Then, you can read the bytes of response
+ * by reading from raw.
+ */
+
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/platform_data/wilco-ec.h>
+
+#ifdef CONFIG_WILCO_EC_SYSFS_RAW
+
+#define FORMATTED_BUFFER_SIZE (EC_MAILBOX_DATA_SIZE_EXTENDED * 4)
+
+struct wilco_ec_debugfs {
+	struct wilco_ec_device *ec;
+	struct dentry *dir;
+	size_t response_size;
+	u8 raw_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+	u8 formatted_data[FORMATTED_BUFFER_SIZE];
+};
+
+static struct wilco_ec_debugfs *debug_info;
+
+/**
+ * parse_hex_sentence() - Convert a ascii hex representation into byte array
+ * @in: Input buffer of ascii
+ * @isize: Length of input buffer
+ * @out: Output buffer
+ * @osize: Length of output buffer, e.g. max number of bytes to parse
+ *
+ * If an individual "word" within the hex sentence is longer than MAX_WORD_SIZE,
+ * then the sentence is illegal.
+ *
+ * Return: Number of bytes parsed, or negative error code on failure
+ */
+static int parse_hex_sentence(const char *in, int isize, u8 *out, int osize)
+{
+	int n_parsed = 0;
+	int word_start = 0;
+	int word_end;
+	int word_len;
+	/* Temp buffer for holding a "word" of chars that represents one byte */
+	const static int MAX_WORD_SIZE = 16;
+	char tmp[MAX_WORD_SIZE+1];
+	u8 byte;
+
+	while (word_start < isize && n_parsed < osize) {
+		/* Find the start of the next word */
+		while (word_start < isize && isspace(in[word_start]))
+			word_start++;
+		 /* reached the end of the input before next word? */
+		if (word_start >= isize)
+			break;
+
+		/* Find the end of this word */
+		word_end = word_start;
+		while (word_end < isize && !isspace(in[word_end]))
+			word_end++;
+
+		/* Copy to a tmp NULL terminated string */
+		word_len = word_end - word_start;
+		if (word_len > MAX_WORD_SIZE)
+			return -EINVAL;
+		memcpy(tmp, in + word_start, word_len);
+		tmp[word_len] = '\0';
+
+		/*
+		 * Convert from hex string, place in output. If fails to parse,
+		 * just return -EINVAL because specific error code is only
+		 * relevant for this one word, returning it would be confusing.
+		 */
+		if (kstrtou8(tmp, 16, &byte))
+			return -EINVAL;
+		out[n_parsed++] = byte;
+
+		word_start = word_end;
+	}
+	return n_parsed;
+}
+
+#define CMDS_AND_DATA_SIZE ((EC_MAILBOX_DATA_SIZE) + 3)
+
+static ssize_t raw_write(struct file *file, const char __user *user_buf,
+			 size_t count, loff_t *ppos)
+{
+	char *buf = debug_info->formatted_data;
+	struct wilco_ec_message msg;
+	u8 request_data[CMDS_AND_DATA_SIZE];
+	ssize_t kcount;
+	int ret;
+
+	if (count > FORMATTED_BUFFER_SIZE)
+		return -EINVAL;
+
+	kcount = simple_write_to_buffer(buf, FORMATTED_BUFFER_SIZE, ppos,
+					user_buf, count);
+	if (kcount < 0)
+		return kcount;
+
+	ret = parse_hex_sentence(buf, kcount, request_data, CMDS_AND_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+	/* Need at least three bytes for type and command */
+	if (ret < 3)
+		return -EINVAL;
+
+	/* Clear response data buffer */
+	memset(debug_info->raw_data, '\0', EC_MAILBOX_DATA_SIZE_EXTENDED);
+
+	msg.type = request_data[0] << 8 | request_data[1];
+	msg.flags = WILCO_EC_FLAG_RAW;
+	msg.command = request_data[2];
+	msg.request_data = ret > 3 ? request_data + 3 : NULL;
+	msg.request_size = ret - 3;
+	msg.response_data = debug_info->raw_data;
+	msg.response_size = EC_MAILBOX_DATA_SIZE;
+
+	/* Telemetry commands use extended response data */
+	if (msg.type == WILCO_EC_MSG_TELEMETRY) {
+		msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
+		msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+	}
+
+	ret = wilco_ec_mailbox(debug_info->ec, &msg);
+	if (ret < 0)
+		return ret;
+	debug_info->response_size = ret;
+
+	return count;
+}
+
+/**
+ * wilco_ec_raw_show() - Show result from previous call to raw_store()
+ * @dev: Device representing the EC
+ * @attr: The attribute in question
+ * @buf: Output buffer to be filled
+ *
+ * Example usage:
+ *	// Call raw_store(), read EC info type 3 (EC firmware build date)
+ *	# echo 00 f0 38 00 03 00 > raw
+ *	// Call this function, view the result. The decoded ASCII result
+ *	// "12/21/18" is included after the raw hex.
+ *	# cat raw
+ *	00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8.../.
+ *
+ * Return: Number of bytes written to output, negative error code on failure
+ */
+static ssize_t raw_read(struct file *file, char __user *user_buf, size_t count,
+			loff_t *ppos)
+{
+	int fmt_len = 0;
+
+	if (debug_info->response_size) {
+		fmt_len = hex_dump_to_buffer(debug_info->raw_data,
+					     debug_info->response_size,
+					     16, 1, debug_info->formatted_data,
+					     FORMATTED_BUFFER_SIZE, true);
+		/* Only return response the first time it is read */
+		debug_info->response_size = 0;
+	}
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       debug_info->formatted_data, fmt_len);
+}
+
+static const struct file_operations fops_raw = {
+	.owner = THIS_MODULE,
+	.read = raw_read,
+	.write = raw_write,
+	.llseek = no_llseek,
+};
+
+int wilco_ec_debugfs_init(struct wilco_ec_device *ec)
+{
+	debug_info = devm_kzalloc(ec->dev, sizeof(*debug_info), GFP_KERNEL);
+	if (!debug_info)
+		return -ENOMEM;
+	debug_info->ec = ec;
+
+	debug_info->dir = debugfs_create_dir("wilco_ec", NULL);
+	if (!debug_info->dir)
+		return -ENOMEM;
+
+	if (!debugfs_create_file("raw", 0644, debug_info->dir,
+				 NULL, &fops_raw)) {
+		debugfs_remove_recursive(debug_info->dir);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void wilco_ec_debugfs_remove(struct wilco_ec_device *ec)
+{
+	if (debug_info) {
+		debugfs_remove_recursive(debug_info->dir);
+		devm_kfree(ec->dev, debug_info); /* needed? */
+	}
+}
+
+#else /* CONFIG_WILCO_EC_SYSFS_RAW */
+
+int wilco_ec_debugfs_init(struct wilco_ec_device *ec)
+{
+	return 0;
+}
+
+void wilco_ec_debugfs_remove(struct wilco_ec_device *ec) {}
+
+#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 5477b8802f81..3298eabe73bc 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -135,4 +135,7 @@ struct wilco_ec_response {
  */
 int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
 
+int wilco_ec_debugfs_init(struct wilco_ec_device *ec);
+void wilco_ec_debugfs_remove(struct wilco_ec_device *ec);
+
 #endif /* WILCO_EC_H */
-- 
2.20.1.321.g9e740568ce-goog

