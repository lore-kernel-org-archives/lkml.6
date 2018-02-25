Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBYRXG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:06 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55454 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeBYRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:22:57 -0500
X-Google-Smtp-Source: AG47ELs+Zrugy3BAxEexzzbx2q7WGV6I/v1Q5E4ZY4xBnDwcOceG7/cB0cmpTTitl/Zi2IuSuzxPug==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 03/21] powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
Date: Sun, 25 Feb 2018 18:22:18 +0100
Message-Id: <20180225172236.29650-4-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
`earlycon_acpi_spcr_enable` as maybe_unused.

Fix the following warning (treated as error in W=1)

  CC      arch/powerpc/kernel/setup-common.o
In file included from ./include/linux/serial_8250.h:14:0,
                 from arch/powerpc/kernel/setup-common.c:33:
./include/linux/serial_core.h:382:19: error: ‘earlycon_acpi_spcr_enable’ defined but not used [-Werror=unused-const-variable=]
 static const bool earlycon_acpi_spcr_enable;
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..4d14ecd7dbe8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -379,6 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
 extern bool earlycon_acpi_spcr_enable __initdata;
 int setup_earlycon(char *buf);
 #else
+EARLYCON_USED_OR_UNUSED
 static const bool earlycon_acpi_spcr_enable;
 static inline int setup_earlycon(char *buf) { return 0; }
 #endif
-- 
2.11.0
