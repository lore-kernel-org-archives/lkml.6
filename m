Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5D3208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiA/k6CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5D3208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeGaWHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46429 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbeGaWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so9616669pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpkUnBLvkeQeIbBuvUmevkdmeIClxMPt19Diud5yeUM=;
        b=CiA/k6CKuRys70MSs0+uL8h9NGRCLRyTv1TdO5gXieBglvLCIOdbSZdJ3VdaeCi+dA
         mkiZ2CGEDRRHO1EvR3mb4rG3JStk/iZYMOJVSbGLrcTqrMOIPj33DAhzNy5MJGEtAP8o
         hclxXFRw88rfA8tnTKeeTsslgVqmFvNv2wKFgX9hAtJVGruRKNRHVcTviwlbAkzy8CFN
         YiKQpKcpcLx8owkKB/YJ9bDxC7JwQSzawSDngMYqCwm5wct1OXywLtYi6/IeqtkaB1sp
         mpTV153Y/mpTma8JZj5K9EG/uflGYMmPlVUAmB66DHYi+sCYxDMEEWPxD3f0etw8a/6E
         T1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpkUnBLvkeQeIbBuvUmevkdmeIClxMPt19Diud5yeUM=;
        b=gl+CmA7c0F4GUYVhBH+qcrIpVYcNvmHVLXsOU+SlxJesqHyKrexiBerG1vhvvDkgrg
         tqVPX/U1PZ+PE7J1Vfts45MEE7NnY1324AY5rhHJTnatJcqyC1fVcvH96DAahHVMAC2a
         WGE9i6OTLq0/Y81Jb/aKfrBu8ag4kxdssDVfJhxDDPBjvNtW6O9Ij3f6MJczgWGFGYtW
         +NbrZJCYUVuObv4okMOP+FI9gLjIIGIdT9lKJT7RO5uXZNNUF+wfJ08ens2qKpGWN3f9
         66D/fEgmjupxal+5Utg6DPgXmdcGww8bNh4JUaY9BCglwiE4w42CKoVDxkdYpnQLnaDf
         m8vA==
X-Gm-Message-State: AOUpUlFGn8/eAZ8Qmdwg6+ie1ViEw0IvYl7mW3Pptx5jIBkiX+puRhQo
        onEtrZupsH3YjIRLlKQvSp4=
X-Google-Smtp-Source: AAOMgpeWlcJPzHlc2CXKMcTYSpU8t7c3mJZa1MNbGX0oU30lPlW6WrgtQSalfUKU+orDxW0HI7dCoQ==
X-Received: by 2002:a62:ac12:: with SMTP id v18-v6mr23409303pfe.126.1533068712729;
        Tue, 31 Jul 2018 13:25:12 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:12 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/15] staging: gasket: ioctl: remove static function forward declarations
Date:   Tue, 31 Jul 2018 13:24:35 -0700
Message-Id: <20180731202448.229487-3-toddpoynor@gmail.com>
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
 drivers/staging/gasket/gasket_ioctl.c | 356 ++++++++++++--------------
 1 file changed, 168 insertions(+), 188 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 55bdd7bfac86..134d45a281ac 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -23,194 +23,6 @@
 #define trace_gasket_ioctl_config_coherent_allocator(x, ...)
 #endif
 
-static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd);
-static int gasket_set_event_fd(struct gasket_dev *dev,
-			       struct gasket_interrupt_eventfd __user *argp);
-static int gasket_read_page_table_size(
-	struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp);
-static int gasket_read_simple_page_table_size(
-	struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp);
-static int gasket_partition_page_table(
-	struct gasket_dev *gasket_dev,
-	struct gasket_page_table_ioctl __user *argp);
-static int gasket_map_buffers(struct gasket_dev *gasket_dev,
-			      struct gasket_page_table_ioctl __user *argp);
-static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
-				struct gasket_page_table_ioctl __user *argp);
-static int gasket_config_coherent_allocator(
-	struct gasket_dev *gasket_dev,
-	struct gasket_coherent_alloc_config_ioctl __user *argp);
-
-/*
- * standard ioctl dispatch function.
- * @filp: File structure pointer describing this node usage session.
- * @cmd: ioctl number to handle.
- * @argp: ioctl-specific data pointer.
- *
- * Standard ioctl dispatcher; forwards operations to individual handlers.
- */
-long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
-{
-	struct gasket_dev *gasket_dev;
-	unsigned long arg = (unsigned long)argp;
-	gasket_ioctl_permissions_cb_t ioctl_permissions_cb;
-	int retval;
-
-	gasket_dev = (struct gasket_dev *)filp->private_data;
-	trace_gasket_ioctl_entry(gasket_dev->dev_info.name, cmd);
-
-	ioctl_permissions_cb = gasket_get_ioctl_permissions_cb(gasket_dev);
-	if (ioctl_permissions_cb) {
-		retval = ioctl_permissions_cb(filp, cmd, argp);
-		if (retval < 0) {
-			trace_gasket_ioctl_exit(retval);
-			return retval;
-		} else if (retval == 0) {
-			trace_gasket_ioctl_exit(-EPERM);
-			return -EPERM;
-		}
-	} else if (!gasket_ioctl_check_permissions(filp, cmd)) {
-		trace_gasket_ioctl_exit(-EPERM);
-		dev_dbg(gasket_dev->dev, "ioctl cmd=%x noperm\n", cmd);
-		return -EPERM;
-	}
-
-	/* Tracing happens in this switch statement for all ioctls with
-	 * an integer argrument, but ioctls with a struct argument
-	 * that needs copying and decoding, that tracing is done within
-	 * the handler call.
-	 */
-	switch (cmd) {
-	case GASKET_IOCTL_RESET:
-		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_reset(gasket_dev, arg);
-		break;
-	case GASKET_IOCTL_SET_EVENTFD:
-		retval = gasket_set_event_fd(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_CLEAR_EVENTFD:
-		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_interrupt_clear_eventfd(
-			gasket_dev->interrupt_data, (int)arg);
-		break;
-	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
-		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_partition_page_table(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
-		trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
-		if (copy_to_user(argp, &gasket_dev->num_page_tables,
-				 sizeof(uint64_t)))
-			retval = -EFAULT;
-		else
-			retval = 0;
-		break;
-	case GASKET_IOCTL_PAGE_TABLE_SIZE:
-		retval = gasket_read_page_table_size(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
-		retval = gasket_read_simple_page_table_size(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_MAP_BUFFER:
-		retval = gasket_map_buffers(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
-		retval = gasket_config_coherent_allocator(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_UNMAP_BUFFER:
-		retval = gasket_unmap_buffers(gasket_dev, argp);
-		break;
-	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
-		/* Clear interrupt counts doesn't take an arg, so use 0. */
-		trace_gasket_ioctl_integer_data(0);
-		retval = gasket_interrupt_reset_counts(gasket_dev);
-		break;
-	default:
-		/* If we don't understand the ioctl, the best we can do is trace
-		 * the arg.
-		 */
-		trace_gasket_ioctl_integer_data(arg);
-		dev_dbg(gasket_dev->dev,
-			"Unknown ioctl cmd=0x%x not caught by "
-			"gasket_is_supported_ioctl\n",
-			cmd);
-		retval = -EINVAL;
-		break;
-	}
-
-	trace_gasket_ioctl_exit(retval);
-	return retval;
-}
-
-/*
- * Determines if an ioctl is part of the standard Gasket framework.
- * @cmd: The ioctl number to handle.
- *
- * Returns 1 if the ioctl is supported and 0 otherwise.
- */
-long gasket_is_supported_ioctl(uint cmd)
-{
-	switch (cmd) {
-	case GASKET_IOCTL_RESET:
-	case GASKET_IOCTL_SET_EVENTFD:
-	case GASKET_IOCTL_CLEAR_EVENTFD:
-	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
-	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
-	case GASKET_IOCTL_PAGE_TABLE_SIZE:
-	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
-	case GASKET_IOCTL_MAP_BUFFER:
-	case GASKET_IOCTL_UNMAP_BUFFER:
-	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
-	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
-/* Check permissions for Gasket ioctls. */
-static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
-{
-	bool alive;
-	bool read, write;
-	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
-
-	alive = (gasket_dev->status == GASKET_STATUS_ALIVE);
-	if (!alive)
-		dev_dbg(gasket_dev->dev, "%s alive %d status %d\n",
-			__func__, alive, gasket_dev->status);
-
-	read = !!(filp->f_mode & FMODE_READ);
-	write = !!(filp->f_mode & FMODE_WRITE);
-
-	switch (cmd) {
-	case GASKET_IOCTL_RESET:
-	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
-		return write;
-
-	case GASKET_IOCTL_PAGE_TABLE_SIZE:
-	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
-	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
-		return read;
-
-	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
-	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
-		return alive && write;
-
-	case GASKET_IOCTL_MAP_BUFFER:
-	case GASKET_IOCTL_UNMAP_BUFFER:
-		return alive && write;
-
-	case GASKET_IOCTL_CLEAR_EVENTFD:
-	case GASKET_IOCTL_SET_EVENTFD:
-		return alive && write;
-	}
-
-	return false; /* unknown permissions */
-}
-
 /* Associate an eventfd with an interrupt. */
 static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
 			       struct gasket_interrupt_eventfd __user *argp)
@@ -410,3 +222,171 @@ static int gasket_config_coherent_allocator(
 
 	return 0;
 }
+
+/* Check permissions for Gasket ioctls. */
+static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
+{
+	bool alive;
+	bool read, write;
+	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
+
+	alive = (gasket_dev->status == GASKET_STATUS_ALIVE);
+	if (!alive)
+		dev_dbg(gasket_dev->dev, "%s alive %d status %d\n",
+			__func__, alive, gasket_dev->status);
+
+	read = !!(filp->f_mode & FMODE_READ);
+	write = !!(filp->f_mode & FMODE_WRITE);
+
+	switch (cmd) {
+	case GASKET_IOCTL_RESET:
+	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
+		return write;
+
+	case GASKET_IOCTL_PAGE_TABLE_SIZE:
+	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
+	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
+		return read;
+
+	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
+	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
+		return alive && write;
+
+	case GASKET_IOCTL_MAP_BUFFER:
+	case GASKET_IOCTL_UNMAP_BUFFER:
+		return alive && write;
+
+	case GASKET_IOCTL_CLEAR_EVENTFD:
+	case GASKET_IOCTL_SET_EVENTFD:
+		return alive && write;
+	}
+
+	return false; /* unknown permissions */
+}
+
+/*
+ * standard ioctl dispatch function.
+ * @filp: File structure pointer describing this node usage session.
+ * @cmd: ioctl number to handle.
+ * @argp: ioctl-specific data pointer.
+ *
+ * Standard ioctl dispatcher; forwards operations to individual handlers.
+ */
+long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
+{
+	struct gasket_dev *gasket_dev;
+	unsigned long arg = (unsigned long)argp;
+	gasket_ioctl_permissions_cb_t ioctl_permissions_cb;
+	int retval;
+
+	gasket_dev = (struct gasket_dev *)filp->private_data;
+	trace_gasket_ioctl_entry(gasket_dev->dev_info.name, cmd);
+
+	ioctl_permissions_cb = gasket_get_ioctl_permissions_cb(gasket_dev);
+	if (ioctl_permissions_cb) {
+		retval = ioctl_permissions_cb(filp, cmd, argp);
+		if (retval < 0) {
+			trace_gasket_ioctl_exit(retval);
+			return retval;
+		} else if (retval == 0) {
+			trace_gasket_ioctl_exit(-EPERM);
+			return -EPERM;
+		}
+	} else if (!gasket_ioctl_check_permissions(filp, cmd)) {
+		trace_gasket_ioctl_exit(-EPERM);
+		dev_dbg(gasket_dev->dev, "ioctl cmd=%x noperm\n", cmd);
+		return -EPERM;
+	}
+
+	/* Tracing happens in this switch statement for all ioctls with
+	 * an integer argrument, but ioctls with a struct argument
+	 * that needs copying and decoding, that tracing is done within
+	 * the handler call.
+	 */
+	switch (cmd) {
+	case GASKET_IOCTL_RESET:
+		trace_gasket_ioctl_integer_data(arg);
+		retval = gasket_reset(gasket_dev, arg);
+		break;
+	case GASKET_IOCTL_SET_EVENTFD:
+		retval = gasket_set_event_fd(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_CLEAR_EVENTFD:
+		trace_gasket_ioctl_integer_data(arg);
+		retval = gasket_interrupt_clear_eventfd(
+			gasket_dev->interrupt_data, (int)arg);
+		break;
+	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
+		trace_gasket_ioctl_integer_data(arg);
+		retval = gasket_partition_page_table(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
+		trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
+		if (copy_to_user(argp, &gasket_dev->num_page_tables,
+				 sizeof(uint64_t)))
+			retval = -EFAULT;
+		else
+			retval = 0;
+		break;
+	case GASKET_IOCTL_PAGE_TABLE_SIZE:
+		retval = gasket_read_page_table_size(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
+		retval = gasket_read_simple_page_table_size(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_MAP_BUFFER:
+		retval = gasket_map_buffers(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
+		retval = gasket_config_coherent_allocator(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_UNMAP_BUFFER:
+		retval = gasket_unmap_buffers(gasket_dev, argp);
+		break;
+	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
+		/* Clear interrupt counts doesn't take an arg, so use 0. */
+		trace_gasket_ioctl_integer_data(0);
+		retval = gasket_interrupt_reset_counts(gasket_dev);
+		break;
+	default:
+		/* If we don't understand the ioctl, the best we can do is trace
+		 * the arg.
+		 */
+		trace_gasket_ioctl_integer_data(arg);
+		dev_dbg(gasket_dev->dev,
+			"Unknown ioctl cmd=0x%x not caught by "
+			"gasket_is_supported_ioctl\n",
+			cmd);
+		retval = -EINVAL;
+		break;
+	}
+
+	trace_gasket_ioctl_exit(retval);
+	return retval;
+}
+
+/*
+ * Determines if an ioctl is part of the standard Gasket framework.
+ * @cmd: The ioctl number to handle.
+ *
+ * Returns 1 if the ioctl is supported and 0 otherwise.
+ */
+long gasket_is_supported_ioctl(uint cmd)
+{
+	switch (cmd) {
+	case GASKET_IOCTL_RESET:
+	case GASKET_IOCTL_SET_EVENTFD:
+	case GASKET_IOCTL_CLEAR_EVENTFD:
+	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
+	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
+	case GASKET_IOCTL_PAGE_TABLE_SIZE:
+	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
+	case GASKET_IOCTL_MAP_BUFFER:
+	case GASKET_IOCTL_UNMAP_BUFFER:
+	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
+	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
+		return 1;
+	default:
+		return 0;
+	}
+}
-- 
2.18.0.345.g5c9ce644c3-goog

