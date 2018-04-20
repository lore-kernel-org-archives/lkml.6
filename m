Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeDTNeg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:34:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44028 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755166AbeDTNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:09 -0400
X-Google-Smtp-Source: AIpwx4/9XPX+4x5Uj4JU30DLs/rk4HHFLFJSWGSVtqL1fr8zxrjU0tStac8elg84iFfRgsFUa9CC4g==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 4/9] nds32: Fix drivers/gpu/drm/udl/udl_fb.c building error by defining PAGE_SHARED
Date: Fri, 20 Apr 2018 21:31:10 +0800
Message-Id: <9d2383486ec59d7e37cdcb6359ff62b3c368e4bb.1524229039.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It broke the 'allmodconfig' build.
drivers/gpu/drm/udl/udl_fb.c: In function 'udl_fb_mmap':
drivers/gpu/drm/udl/udl_fb.c:183:52: error: 'PAGE_SHARED' undeclared (first use in this function)
   if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                                                    ^~~~~~~~~~~
drivers/gpu/drm/udl/udl_fb.c:183:52: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [drivers/gpu/drm/udl/udl_fb.o] Error 1

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 6783937edbeb..d3e19a55cf53 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -152,6 +152,7 @@
 #define PAGE_CACHE_L1	__pgprot(_HAVE_PAGE_L | _PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE)
 #define PAGE_MEMORY	__pgprot(_HAVE_PAGE_L | _PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
 #define PAGE_KERNEL	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
+#define PAGE_SHARED	__pgprot(_PAGE_V | _PAGE_M_URW_KRW | _PAGE_D | _PAGE_CACHE_SHRD)
 #define PAGE_DEVICE    __pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_G | _PAGE_C_DEV)
 #endif /* __ASSEMBLY__ */
 
-- 
1.9.5
