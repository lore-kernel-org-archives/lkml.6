Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeBKJQE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:16:04 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37162 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:16:03 -0500
X-Google-Smtp-Source: AH8x226a2YqS6Jpn8HpTpByW6odZSjun+T/hMrwO59qEBEEkekxjV303gKqU39pqdDOL8aOFyamBmw==
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix build with KASAN
Date: Sun, 11 Feb 2018 01:15:46 -0800
Message-Id: <1518340546-6690-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 917538e212a2 ("kasan: clean up KASAN_SHADOW_SCALE_SHIFT
usage") removed KASAN_SHADOW_SCALE_SHIFT definition from
include/linux/kasan.h and added it to architecture-specific headers,
except for xtensa. This broke the xtensa build with KASAN enabled.
Define KASAN_SHADOW_SCALE_SHIFT in arch/xtensa/include/asm/kasan.h

Reported by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 917538e212a2 ("kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/include/asm/kasan.h b/arch/xtensa/include/asm/kasan.h
index 54be80876e57..216b6f32c375 100644
--- a/arch/xtensa/include/asm/kasan.h
+++ b/arch/xtensa/include/asm/kasan.h
@@ -10,6 +10,8 @@
 #include <linux/sizes.h>
 #include <asm/kmem_layout.h>
 
+#define KASAN_SHADOW_SCALE_SHIFT 3
+
 /* Start of area covered by KASAN */
 #define KASAN_START_VADDR __XTENSA_UL_CONST(0x90000000)
 /* Start of the shadow map */
-- 
2.1.4
