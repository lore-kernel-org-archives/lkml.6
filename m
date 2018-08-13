Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89197C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3540421755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwHvDwUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3540421755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeHNCX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:23:59 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:52642 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:23:58 -0400
Received: by mail-io0-f201.google.com with SMTP id y26-v6so15368083iob.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BfnLGHkzs1cai9pS6VjiqUYvus5m6zz/SM6B1l6ZU/E=;
        b=DwHvDwUQcnvHWItuwkaO5iCHhdpwpN4XjQPAwVjhAUJY7lmQ+fINBL2Zwdrz16QrKG
         lnpwozv7tcCC1ZkDNNOKqBbJHWW7RaAZWKcQWv7dEHX87Cm9QTjj+hOkzHI04PBSjq87
         L7b9kk3XR7lWLpZTvze+mYJapcrzYhpSI5uUCt9T6Vgr9IL0ODVHcG27P46qx1GIyhzZ
         R/0nxLCi/HmJHxXXrbf+9c/+9mgRYDU2JOuKDuih5E8W8ObxXxNZahqaor8MQQXYTwvS
         rvdYhOfIK8SExiTfHtQZtjGrllQKf4q5jGvTe+awBQ5srTUYKcIKlAQx3iN9mNZEtF13
         m8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BfnLGHkzs1cai9pS6VjiqUYvus5m6zz/SM6B1l6ZU/E=;
        b=CRcHljqkUfM8rlugZQcucJHspbb33qeQ7E4dyU1Vzzi0TFwwOj/4LM1KYOlS2UPpr9
         E56bO6XR8hb3laUdbnafJpgUvHkrev7ac+s6GJxEYXTiU95Gd6zLqZdyXLIW7t3hJHB7
         rdcfzvtGy2/xjlO44t/wbHO/3QnSod8+RfRHn7dmkKj65DHfePPatFm5c5S8sVxswEvY
         EHgcPXJywthpmKBAr1Og7vusfA2jjFfpn0dgue3mpAQCJmC0+pypBGiw6klZnBCY4P6Y
         dRv+3FfMCOFOWJ2uFDwAg9EgYcjMaUNFMw2TZG353slIKH7BDBWLVDLYCqB0gy2zJeaJ
         VR0g==
X-Gm-Message-State: AOUpUlEuuzEj6G4w9n80toz9lNN9onQPNF5e30Wpcgli7GuVQEmteUGc
        kcfuvnkYLbLmXnPxo+zIBeMN7nwr
X-Google-Smtp-Source: AA+uWPyixZbvW+LW8MhLIfL2w+pkfSrAw7wqcPGtzrXOet/7ET3iux3lF/IICborDP9Ux4Rh/z2Ir6W5
X-Received: by 2002:a24:7f50:: with SMTP id r77-v6mr7431379itc.44.1534203569278;
 Mon, 13 Aug 2018 16:39:29 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:35 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-4-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 4/9] platform: goldfish: pipe: Separate the host interface to
 a separate header
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
index 0607897c6a59..8f9580454154 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -63,6 +63,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/acpi.h>
+#include "goldfish_pipe_qemu.h"
 
 /*
  * Update this when something changes in the driver's behavior so the host
@@ -73,74 +74,6 @@ enum {
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
- * Possible status values used to signal errors - see
- * goldfish_pipe_error_convert
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
index 000000000000..51f3d9f82af6
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
+#ifndef ANDROID_PIPE_COMMON_H
+#define ANDROID_PIPE_COMMON_H
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
+#endif /* ANDROID_PIPE_COMMON_H */
-- 
2.18.0.865.gffc8e1a3cd6-goog

