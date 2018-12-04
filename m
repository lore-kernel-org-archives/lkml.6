Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B232081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="joVYPGyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B232081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLDOK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:10:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44254 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeLDOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:10:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so8348736pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTPdu0Dl5dI9f0RvwZ4b3FQV4mVlXTL1ZWm0hIO3Dcg=;
        b=joVYPGyfS51dy2YuZIbN92mHTKVXiz11syOtUFtSzZNvPzULvzC/elLQ2QeqDxFeNa
         ces1AMrzpGS3kukOEVdgUjdCO05TiDmOQT53uKDD8EVDx9LJ0BaFi7oS2wFge0dp5qXt
         ZyZxRslRHXio/przej1AHS1Y/GxS5QNpzXkfJ7vaFbc9jbdS+0Nm8yA+fJn7jmod9yvn
         7c3T9KLAIingr1zzA5osaqvaCgtf7YV8Gqv8OxbHOd8av23iYyEp0+NQYWc+2qNYFf6G
         AdCqccFC3JtH1BAMbx/Nz/cpWR6qBZK71DtjgEb3JhtrGJ95x56mTZt5ib+KP9FqbTEr
         fJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BTPdu0Dl5dI9f0RvwZ4b3FQV4mVlXTL1ZWm0hIO3Dcg=;
        b=XZ3ZaOUsTNgulMN0RR9FycYDhEheoJddT7r4OG417HkN5/En6YCToQ0SrTeHePW59Z
         7yfW2Ot25mEqpuNFHhZsPdU5CgoO/aS5rUk1JH/0On/esNuWPmEmoVpPPvkxxYicJmQ+
         vzEfDz6C/aeWFCNNe52c7bDFgpahSJKAHfukknVfZgxEbTYfRa7I/XGHuLnEvs727q5v
         0A/vjFupZYn07KIsd5cYpz+Q8h5bHOr2V5lTpDfAMktr/XQB9L9PRp6LaiPc360kMiN5
         oKYcJpt5gK6hhzGZWURDI+88JJtT7jSJkB3iKBjARNGm4WF/+HpBIYxjBEvbwxXZd3dI
         uFyA==
X-Gm-Message-State: AA+aEWaCXaz3oqktMjLAjuMoON6t1l5s3024zPiLy78nzzpQYBumWlXy
        VjVaYkSimv1ODkO7MriQteDR9w==
X-Google-Smtp-Source: AFSGD/VmR50lnvpHU80Xag/uZ2hvS+h9ZbY6ijbVgs6o5BV0WQTIdzab5I/fpvMnhrFib84FA8tvkw==
X-Received: by 2002:a17:902:1102:: with SMTP id d2mr15988999pla.138.1543932654889;
        Tue, 04 Dec 2018 06:10:54 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.53.58])
        by smtp.googlemail.com with ESMTPSA id k129sm31298884pgk.29.2018.12.04.06.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:10:54 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
Date:   Tue,  4 Dec 2018 19:25:05 +0530
Message-Id: <20181204135507.3706-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
References: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V, the M-mode runtime firmware provide SBI calls for
debug prints. This patch adds earlycon support using RISC-V
SBI console calls. To enable it, just pass "earlycon=sbi" in
kernel parameters.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/tty/serial/Kconfig              | 12 +++++++++++
 drivers/tty/serial/Makefile             |  1 +
 drivers/tty/serial/earlycon-riscv-sbi.c | 28 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 32886c304641..287bb41ac814 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -85,6 +85,18 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
 	  with "earlycon=smh" on the kernel command line. The console is
 	  enabled when early_param is processed.
 
+config SERIAL_EARLYCON_RISCV_SBI
+	bool "Early console using RISC-V SBI"
+	depends on RISCV
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Support for early debug console using RISC-V SBI. This enables
+	  the console before standard serial driver is probed. This is enabled
+	  with "earlycon=sbi" on the kernel command line. The console is
+	  enabled when early_param is processed.
+
 config SERIAL_SB1250_DUART
 	tristate "BCM1xxx on-chip DUART serial support"
 	depends on SIBYTE_SB1xxx_SOC=y
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index daac675612df..3ce26ce08616 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
+obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) += earlycon-riscv-sbi.o
 
 # These Sparc drivers have to appear before others such as 8250
 # which share ttySx minor node space.  Otherwise console device
diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
new file mode 100644
index 000000000000..e1a551aae336
--- /dev/null
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V SBI based earlycon
+ *
+ * Copyright (C) 2018 Anup Patel <anup@brainfault.org>
+ */
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <asm/sbi.h>
+
+static void sbi_console_write(struct console *con,
+			      const char *s, unsigned int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i)
+		sbi_console_putchar(s[i]);
+}
+
+static int __init early_sbi_setup(struct earlycon_device *device,
+				  const char *opt)
+{
+	device->con->write = sbi_console_write;
+	return 0;
+}
+EARLYCON_DECLARE(sbi, early_sbi_setup);
-- 
2.17.1

