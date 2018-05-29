Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbeE2NMh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:12:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52731 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934628AbeE2NK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:59 -0400
X-Google-Smtp-Source: AB8JxZrhKQRALUb9U1brRNCQgzGEai4E0CDkJmQ67c3Vs66yVlWJbm16rfXcxGoCdrK2kwVWmE+uPQ==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 16/19] serdev: ttyport: Move serport structure to its own header
Date: Tue, 29 May 2018 15:10:11 +0200
Message-Id: <20180529131014.18641-17-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we can reuse this structure in other modules.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/serdev-ttyport.c |  9 +--------
 drivers/tty/serdev/serport.h        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)
 create mode 100644 drivers/tty/serdev/serport.h

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index fa1672993b4c..4acc5f41dc67 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -7,17 +7,10 @@
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/poll.h>
+#include "serport.h"
 
 #define SERPORT_ACTIVE		1
 
-struct serport {
-	struct tty_port *port;
-	struct tty_struct *tty;
-	struct tty_driver *tty_drv;
-	int tty_idx;
-	unsigned long flags;
-};
-
 /*
  * Callback functions from the tty port.
  */
diff --git a/drivers/tty/serdev/serport.h b/drivers/tty/serdev/serport.h
new file mode 100644
index 000000000000..15bc1ff6326e
--- /dev/null
+++ b/drivers/tty/serdev/serport.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016-2017 Linaro Ltd., Rob Herring <robh@kernel.org>
+ */
+#ifndef _SERPORT_H
+#define _SERPORT_H
+
+struct serport {
+	struct tty_port *port;
+	struct tty_struct *tty;
+	struct tty_driver *tty_drv;
+	int tty_idx;
+	unsigned long flags;
+};
+
+#endif
-- 
2.17.0
