Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932826AbeCLRzb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:55:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40194 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932580AbeCLRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:53:56 -0400
X-Google-Smtp-Source: AG47ELuJ+Z6mTC5zvDnHJ3rBK5uhoaE2dO2dmiY0HQHn5/bJ9+RiHF09Jnu5Ip1yA4IUel26Wrn0+Q==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH v4 05/10] arch: Introduce CONFIG_COMPAT_32BIT_TIME
Date: Mon, 12 Mar 2018 10:53:02 -0700
Message-Id: <20180312175307.11032-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180312175307.11032-1-deepa.kernel@gmail.com>
References: <20180312175307.11032-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compat functions are now used to support 32 bit time_t in
compat mode on 64 bit architectures and in native mode on
32 bit architectures.

Introduce COMPAT_32BIT_TIME to conditionally compile these
functions.

Note that turning off 32 bit time_t support requires more
changes on architecture side. For instance, architecure
syscall tables need to be updated to drop support for 32 bit
time_t syscalls.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 arch/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 16e6acfe8711..4377b0cec976 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -878,6 +878,13 @@ config 64BIT_TIME
 	  architectures, and 64-bit architectures as part of compat syscall
 	  handling.
 
+config COMPAT_32BIT_TIME
+	def_bool (!64BIT && 64BIT_TIME) || COMPAT
+	help
+	  This enables 32 bit time_t support in addition to 64 bit time_t support.
+	  This is relevant on all 32-bit architectures, and 64-bit architectures
+	  as part of compat syscall handling.
+
 config ARCH_NO_COHERENT_DMA_MMAP
 	bool
 
-- 
2.14.1
