Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82704208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGtu0S41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82704208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeH0WL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:27 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48160 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeH0WL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:26 -0400
Received: by mail-pf1-f201.google.com with SMTP id x19-v6so12351126pfh.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ogFCRVWGoIPGQHMTcU33CTu3h5C534AwkRyxUF383wI=;
        b=cGtu0S41uW7xVIOuaFZXqL+6S/QvOS9oB1pbXzWebOafhgzHITmyZTl5QcnO7eLTUY
         iDNzi9h7Zi26QwY5nIuQ50BdvW0kSU4fzOBeqxKlASI5PFk2EOLLhil11sq3Tva2hZda
         Nx7TkOzug1AW33WeKLx5oW40a7k2vidu/B9FjiaQSBvU1WlUSQWSMacss9fhVQg1+DH1
         MakK4GlPqq5mW5C16HjaXO8Ht0hR6CQvdxGzmUAgSkotA1+qRV2+5nKlL82THjm67Zab
         6ZrToegS/xnjG0ZqLM27Ft9RhSF/2osxojI4Sm36tTpCuqP8OFgn7kqiUQG8ek9ejzRi
         73MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ogFCRVWGoIPGQHMTcU33CTu3h5C534AwkRyxUF383wI=;
        b=H7OEgedZTgI8bMDUdDcy6XqkoWd+BU3kg0YuIroo8f0zNBaueaT7q1Vlw5kt1gKnBs
         36afGrGL7BoBTvaI1ZsDYd2oAqleF2uVZl+aT8qYsVXoz3CsIhVsJJZ3VhpZvB5+jZOL
         7zRU8DdcGiN4pUKcswDnr9qfubZzZaHSJQIwe5zjKhYCOBYzzOtnppiSVicF/PI8uOUt
         mx/jvTp4tYq9u+uLTSFvfiQFN+nABDouFldbnWkbBzh0hKknB30RmNCpMwabQ85bQlMk
         8MRCZggvW39xP9sfarQyqy/+hTou+ruvdkbF+SrYDlnUbbth5SYWwc5hJsJonnH5XcHh
         GHeQ==
X-Gm-Message-State: APzg51Az4k4n3ubd0MWkUYgE5WVeTnJSiXJ+XftXjZIj4h4pOD7Fm5OT
        KG5Y4oaZjKjw1baiEQRq5mkQijuw
X-Google-Smtp-Source: ANB0Vda9ALCRckAAJ6G5Eh79gm26gMutWgB1kJyXhv6nH3pwluoWaQKGN1zmrOq2TRis/8igRpSmjBEG
X-Received: by 2002:a63:c0f:: with SMTP id b15-v6mr3415332pgl.80.1535394224148;
 Mon, 27 Aug 2018 11:23:44 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:22:59 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-4-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 04/20] platform: goldfish: pipe: Separate the host interface
 to a separate header
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

These are several enums that must kept in sync with the host side.
This change explicitly separates them into a dedicated header file.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c     |  69 +----------
 .../platform/goldfish/goldfish_pipe_qemu.h    | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+), 68 deletions(-)
 create mode 100644 drivers/platform/goldfish/goldfish_pipe_qemu.h

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 4e7e100dc7a0..caf514aafb21 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -64,6 +64,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/acpi.h>
+#include "goldfish_pipe_qemu.h"
 
 /*
  * Update this when something changes in the driver's behavior so the host
@@ -74,74 +75,6 @@ enum {
 	PIPE_CURRENT_DEVICE_VERSION = 2
 };
 
-/*
- * IMPORTANT: The following constants must match the ones used and defined
- * in external/qemu/hw/goldfish_pipe.c in the Android source tree.
- */
-
-/* List of bitflags returned in status of CMD_POLL command */
-enum PipePollFlags {
-	PIPE_POLL_IN	= 1 << 0,
-	PIPE_POLL_OUT	= 1 << 1,
-	PIPE_POLL_HUP	= 1 << 2
-};
-
-/*
- * Possible status values used to signal errors
- * see: goldfish_pipe_error_convert
- */
-enum PipeErrors {
-	PIPE_ERROR_INVAL  = -1,
-	PIPE_ERROR_AGAIN  = -2,
-	PIPE_ERROR_NOMEM  = -3,
-	PIPE_ERROR_IO     = -4
-};
-
-/* Bit-flags used to signal events from the emulator */
-enum PipeWakeFlags {
-	PIPE_WAKE_CLOSED = 1 << 0,  /* emulator closed pipe */
-	PIPE_WAKE_READ   = 1 << 1,  /* pipe can now be read from */
-	PIPE_WAKE_WRITE  = 1 << 2  /* pipe can now be written to */
-};
-
-/* Bit flags for the 'flags' field */
-enum PipeFlagsBits {
-	BIT_CLOSED_ON_HOST = 0,  /* pipe closed by host */
-	BIT_WAKE_ON_WRITE  = 1,  /* want to be woken on writes */
-	BIT_WAKE_ON_READ   = 2,  /* want to be woken on reads */
-};
-
-enum PipeRegs {
-	PIPE_REG_CMD = 0,
-
-	PIPE_REG_SIGNAL_BUFFER_HIGH = 4,
-	PIPE_REG_SIGNAL_BUFFER = 8,
-	PIPE_REG_SIGNAL_BUFFER_COUNT = 12,
-
-	PIPE_REG_OPEN_BUFFER_HIGH = 20,
-	PIPE_REG_OPEN_BUFFER = 24,
-
-	PIPE_REG_VERSION = 36,
-
-	PIPE_REG_GET_SIGNALLED = 48,
-};
-
-enum PipeCmdCode {
-	PIPE_CMD_OPEN = 1,	/* to be used by the pipe device itself */
-	PIPE_CMD_CLOSE,
-	PIPE_CMD_POLL,
-	PIPE_CMD_WRITE,
-	PIPE_CMD_WAKE_ON_WRITE,
-	PIPE_CMD_READ,
-	PIPE_CMD_WAKE_ON_READ,
-
-	/*
-	 * TODO(zyy): implement a deferred read/write execution to allow
-	 * parallel processing of pipe operations on the host.
-	 */
-	PIPE_CMD_WAKE_ON_DONE_IO,
-};
-
 enum {
 	MAX_BUFFERS_PER_COMMAND = 336,
 	MAX_SIGNALLED_PIPES = 64,
diff --git a/drivers/platform/goldfish/goldfish_pipe_qemu.h b/drivers/platform/goldfish/goldfish_pipe_qemu.h
new file mode 100644
index 000000000000..c272e11c5433
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe_qemu.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * IMPORTANT: The following constants must match the ones used and defined in
+ * external/qemu/include/hw/misc/goldfish_pipe.h
+ */
+
+#ifndef GOLDFISH_PIPE_QEMU_H
+#define GOLDFISH_PIPE_QEMU_H
+
+/* List of bitflags returned in status of CMD_POLL command */
+enum PipePollFlags {
+	PIPE_POLL_IN	= 1 << 0,
+	PIPE_POLL_OUT	= 1 << 1,
+	PIPE_POLL_HUP	= 1 << 2
+};
+
+/* Possible status values used to signal errors */
+enum PipeErrors {
+	PIPE_ERROR_INVAL	= -1,
+	PIPE_ERROR_AGAIN	= -2,
+	PIPE_ERROR_NOMEM	= -3,
+	PIPE_ERROR_IO		= -4
+};
+
+/* Bit-flags used to signal events from the emulator */
+enum PipeWakeFlags {
+	/* emulator closed pipe */
+	PIPE_WAKE_CLOSED		= 1 << 0,
+
+	/* pipe can now be read from */
+	PIPE_WAKE_READ			= 1 << 1,
+
+	/* pipe can now be written to */
+	PIPE_WAKE_WRITE			= 1 << 2,
+
+	/* unlock this pipe's DMA buffer */
+	PIPE_WAKE_UNLOCK_DMA		= 1 << 3,
+
+	/* unlock DMA buffer of the pipe shared to this pipe */
+	PIPE_WAKE_UNLOCK_DMA_SHARED	= 1 << 4,
+};
+
+/* Possible pipe closing reasons */
+enum PipeCloseReason {
+	/* guest sent a close command */
+	PIPE_CLOSE_GRACEFUL		= 0,
+
+	/* guest rebooted, we're closing the pipes */
+	PIPE_CLOSE_REBOOT		= 1,
+
+	/* close old pipes on snapshot load */
+	PIPE_CLOSE_LOAD_SNAPSHOT	= 2,
+
+	/* some unrecoverable error on the pipe */
+	PIPE_CLOSE_ERROR		= 3,
+};
+
+/* Bit flags for the 'flags' field */
+enum PipeFlagsBits {
+	BIT_CLOSED_ON_HOST = 0,  /* pipe closed by host */
+	BIT_WAKE_ON_WRITE  = 1,  /* want to be woken on writes */
+	BIT_WAKE_ON_READ   = 2,  /* want to be woken on reads */
+};
+
+enum PipeRegs {
+	PIPE_REG_CMD = 0,
+
+	PIPE_REG_SIGNAL_BUFFER_HIGH = 4,
+	PIPE_REG_SIGNAL_BUFFER = 8,
+	PIPE_REG_SIGNAL_BUFFER_COUNT = 12,
+
+	PIPE_REG_OPEN_BUFFER_HIGH = 20,
+	PIPE_REG_OPEN_BUFFER = 24,
+
+	PIPE_REG_VERSION = 36,
+
+	PIPE_REG_GET_SIGNALLED = 48,
+};
+
+enum PipeCmdCode {
+	/* to be used by the pipe device itself */
+	PIPE_CMD_OPEN		= 1,
+
+	PIPE_CMD_CLOSE,
+	PIPE_CMD_POLL,
+	PIPE_CMD_WRITE,
+	PIPE_CMD_WAKE_ON_WRITE,
+	PIPE_CMD_READ,
+	PIPE_CMD_WAKE_ON_READ,
+
+	/*
+	 * TODO(zyy): implement a deferred read/write execution to allow
+	 * parallel processing of pipe operations on the host.
+	 */
+	PIPE_CMD_WAKE_ON_DONE_IO,
+};
+
+#endif /* GOLDFISH_PIPE_QEMU_H */
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

