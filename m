Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCVUVB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:21:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54686 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeCVUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:57 -0400
X-Google-Smtp-Source: AG47ELsj3CHJafAp7xD2py9NOvI3yql2J1v81knKQbLBx2TkEN65L1DQtiW3b0y8p2FjUL0nfO+DwQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 10/19] powerpc/chrp/time: Make some functions static, add missing header include
Date: Thu, 22 Mar 2018 21:19:56 +0100
Message-Id: <20180322202007.23088-11-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing include <platforms/chrp/chrp.h>.

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/time.c:41:13: error: no previous prototype for ‘chrp_time_init’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:66:5: error: no previous prototype for ‘chrp_cmos_clock_read’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:74:6: error: no previous prototype for ‘chrp_cmos_clock_write’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:86:5: error: no previous prototype for ‘chrp_set_rtc_time’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/time.c:130:6: error: no previous prototype for ‘chrp_get_rtc_time’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/chrp/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/time.c b/arch/powerpc/platforms/chrp/time.c
index 03d115aaa191..acde7bbe0716 100644
--- a/arch/powerpc/platforms/chrp/time.c
+++ b/arch/powerpc/platforms/chrp/time.c
@@ -28,6 +28,8 @@
 #include <asm/sections.h>
 #include <asm/time.h>
 
+#include <platforms/chrp/chrp.h>
+
 extern spinlock_t rtc_lock;
 
 #define NVRAM_AS0  0x74
@@ -63,7 +65,7 @@ long __init chrp_time_init(void)
 	return 0;
 }
 
-int chrp_cmos_clock_read(int addr)
+static int chrp_cmos_clock_read(int addr)
 {
 	if (nvram_as1 != 0)
 		outb(addr>>8, nvram_as1);
@@ -71,7 +73,7 @@ int chrp_cmos_clock_read(int addr)
 	return (inb(nvram_data));
 }
 
-void chrp_cmos_clock_write(unsigned long val, int addr)
+static void chrp_cmos_clock_write(unsigned long val, int addr)
 {
 	if (nvram_as1 != 0)
 		outb(addr>>8, nvram_as1);
-- 
2.11.0
