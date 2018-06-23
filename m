Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8426EC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C60B24ABF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALcrZEoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C60B24ABF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934814AbeFWCV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38223 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id a1-v6so140813pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=weunrdRlQMpf4fsyQKPE9LXV6t51796M/t4XNrNBMi8=;
        b=ALcrZEoXZgRbnSuE9eLW5pOQ/X3YEOUUMrmc5lclheR24mSmw24GbAwnLNi6+Nq8me
         n8CGVUZYjLU+huBlLIGjGsATxWgqpozlr5CSLciu2wJr/6p+4Ufjwlp7ppZKjZlcjfKq
         LdBthCqmIiW1L60Xjxj1sfg3ZobrDO9rKH00g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=weunrdRlQMpf4fsyQKPE9LXV6t51796M/t4XNrNBMi8=;
        b=Pt6u9d7sqsTxuedsOhtgOI2OEWtQlBQeKun8Mr5glR18w0X/317BMq+MJSEJMjVkAS
         NYLH1jx94RDkJ4q2cDoEkd3G4A6EmI/Jbp7YUBEIamUYEUyD8GMG67zitYrGDe5U0QyY
         aw3h0RjazNwCPbsIcox9/hYDij1L70hs7SMit7oUJVbm3ZfXDDa1XaG9AbjNq5P+f+3o
         LDgAlBbmiQJvZxfZG0pE8d4uTJ9bs2XB4X2/g+58nTQEsPiDM66eV2O9SR+uE21DqfFq
         FjMyJU9tB+z3okLwxfPxSIkXVrLkQDDoJHW7tQ3F3bSPOLk5vLR5x95MTHyi9Iz/De9q
         GewA==
X-Gm-Message-State: APt69E2+acE44psfV6Q0hbGq+UffW786Wk7/VoKLoij6btAqqcRunGDw
        PFHeLS7OVQbIN8/pN74zfoBn/A==
X-Google-Smtp-Source: ADUXVKIR9JtFUb6b8azXhN6KtovKBhEQATQbYubtsOE5EJPDw8wLuzl1KHwN4KXTcGt4avc+DP+g5g==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr2857010pgc.344.1529720483242;
        Fri, 22 Jun 2018 19:21:23 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f30-v6sm22678679pgn.76.2018.06.22.19.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:22 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 07/14] arm64: enable KEXEC_FILE config
Date:   Sat, 23 Jun 2018 11:20:51 +0900
Message-Id: <20180623022058.10935-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify arm64/Kconfig to enable kexec_file_load support.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                     | 10 ++++++++++
 arch/arm64/kernel/Makefile             |  3 ++-
 arch/arm64/kernel/machine_kexec_file.c | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..f68318f61c85 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -835,6 +835,16 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	select BUILD_BIN2C
+	help
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 0025f8691046..06281e1ad7ed 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -48,8 +48,9 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
+arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..c38a8048ed00
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for arm64
+ *
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/kexec.h>
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL
+};
-- 
2.17.0

