Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeCNEGV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:06:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35991 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeCNEGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:06:19 -0400
X-Google-Smtp-Source: AG47ELtlFDQ4mlhzBWSOLxQbrGBdxuv1EpySHCKLnGC26ExXOR6TVLpGaJxBPvezuyvDqhIBLrXW6Q==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH v5 04/10] arch: introduce CONFIG_64BIT_TIME
Date: Tue, 13 Mar 2018 21:03:27 -0700
Message-Id: <20180314040333.3291-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a total of 53 system calls (aside from ioctl) that pass a time_t
or derived data structure as an argument, and in order to extend time_t
to 64-bit, we have to replace them with new system calls and keep providing
backwards compatibility.

To avoid adding completely new and untested code for this purpose, we
introduce a new CONFIG_64BIT_TIME symbol. Every architecture that supports
new 64 bit time_t syscalls enables this config.

After this is done for all architectures, the CONFIG_64BIT_TIME symbol
will be deleted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 arch/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665c8d53..16e6acfe8711 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -870,6 +870,14 @@ config OLD_SIGACTION
 config COMPAT_OLD_SIGACTION
 	bool
 
+config 64BIT_TIME
+	def_bool ARCH_HAS_64BIT_TIME
+	help
+	  This should be selected by all architectures that need to support
+	  new system calls with a 64-bit time_t. This is relevant on all 32-bit
+	  architectures, and 64-bit architectures as part of compat syscall
+	  handling.
+
 config ARCH_NO_COHERENT_DMA_MMAP
 	bool
 
-- 
2.14.1
