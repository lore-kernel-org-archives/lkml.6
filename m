Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeCVUWL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:22:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43899 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeCVUVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:08 -0400
X-Google-Smtp-Source: AG47ELsqNLgt8zVhcOR4vAi9XfGK+MYe/lLLe5JwGjfkcfx7Xd9hOZVeCux3LyKdux/MxwHWs6Qxug==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 16/19] powerpc/powermac: Add missing include of header pmac.h
Date: Thu, 22 Mar 2018 21:20:02 +0100
Message-Id: <20180322202007.23088-17-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header `pmac.h` was not included, leading to the following warnings,
treated as error with W=1:

  arch/powerpc/platforms/powermac/time.c:69:13: error: no previous prototype for ‘pmac_time_init’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:207:15: error: no previous prototype for ‘pmac_get_boot_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:222:6: error: no previous prototype for ‘pmac_get_rtc_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:240:5: error: no previous prototype for ‘pmac_set_rtc_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:259:12: error: no previous prototype for ‘via_calibrate_decr’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/time.c:311:13: error: no previous prototype for ‘pmac_calibrate_decr’ [-Werror=missing-prototypes]

The function `via_calibrate_decr` was made static to silence a warning.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 274af6fa388e..5cc6fa40fcc4 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -34,6 +34,8 @@
 #include <asm/nvram.h>
 #include <asm/smu.h>
 
+#include "pmac.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -256,7 +258,7 @@ int pmac_set_rtc_time(struct rtc_time *tm)
  * Calibrate the decrementer register using VIA timer 1.
  * This is used both on powermacs and CHRP machines.
  */
-int __init via_calibrate_decr(void)
+static int __init via_calibrate_decr(void)
 {
 	struct device_node *vias;
 	volatile unsigned char __iomem *via;
-- 
2.11.0
