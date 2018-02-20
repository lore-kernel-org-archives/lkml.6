Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeBTQZm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:25:42 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeBTQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: clps711x: mark clps711x_compat as const
Date: Tue, 20 Feb 2018 17:24:50 +0100
Message-Id: <20180220162519.1498223-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:fXYVUPI+6dLY7rICVDMHqPLs5NL8aankfKB+dOP8X51nrDYhwcB
 jm2+d9j086x7lSr0CKwarQ9ZsMHFmBUpP7bWqcrgB+Tlg1oWPsvsu08pxkixJZ+a0eXdTUQ
 Vs7+mnl6Zy/gE4y9kDvxj6B34itskviPvUx1WcQhsojGl7HCuDwllBm4VloYktUXIEWC7+1
 uClV4vJ555zUk5ex0eCXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:39cjZnKOEXQ=:/OO8b0BU3N9c2DykWw3DCa
 J3Kl6TfK0heG/Xdd2NPSMuncxip5QFIUnjuRHCjqo6rZWuaX8LxnissyAvT6oiW4Aw4wgt7ov
 Dphvh2PaB2hP4nduZyLXkU+e++3fGS/23EAHwhN3gnCExyKQGwxRvf+BG25lb6gc9lnRGd5sK
 RS4h0bsPS0DPUdsB/HwFArqjZN4vmbE+QYQ729u56lMhrbWw/AJABxCokTGZ+lI0xxqRF+tod
 vH5+CUKryUs//MX2oJ17ZKcuOUp1moajDnAW6nXlzByl2UCNnUWrNCkUVIxHLvPcmYOEiRu7W
 GrjT2Dm+594hAZqF3YXalDqZ+NRmIROSC9jzOQKlyuJ7lsqPx/MBaGEyGPwSayLun3gW1NcNp
 /3FptrVwp3sMC8cqhhi+bqsIIqmPMISdTzseHeBUv6YrIJsBjrap93/oUCN5VK74SP5Z8JSBw
 9v6aMqqpPGwDkRIDWYZ2rQgEfHRuI1XYSsymJY4oW4QkYp1r4nrjSik6HUI32wri3ZWOBGyvP
 IuIt3l+vSoZl9LhPnZy2rAYOZx1yENpI4FSrGA1iD36YbXzt2QVXNjrXMXPijsEnMMluQd3J7
 cYYjwF8ARvybpO2eOAp5uNO0x1DQueNphjGL5fQLAhA1Pk7jNYCkjMLSvw5mpm2n3RwaQ5lxK
 QG9jqKIzClS1beTzMn4Gzp6FlRP/gofzwmHhRSa9GHTKEClLVMzS3qLVtS/x6pCC6V4m1E+fX
 rWlv75h2LlI8HlzkN6Yf+em+WTxIXuDeNUYfoA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array of string pointers is put in __initconst, and the strings themselves
are marke 'const' but the the pointers are not, which caused a warning when
built with LTO:

arch/arm/mach-clps711x/board-dt.c:72:20: error: 'clps711x_compat' causes a section type conflict with 'feroceon_ids'
 static const char *clps711x_compat[] __initconst = {

This marks the array itself const as well, which was certainly the
intention originally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-clps711x/board-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/board-dt.c b/arch/arm/mach-clps711x/board-dt.c
index ee1f83b1a332..4c89a8e9a2e3 100644
--- a/arch/arm/mach-clps711x/board-dt.c
+++ b/arch/arm/mach-clps711x/board-dt.c
@@ -69,7 +69,7 @@ static void clps711x_restart(enum reboot_mode mode, const char *cmd)
 	soft_restart(0);
 }
 
-static const char *clps711x_compat[] __initconst = {
+static const char *const clps711x_compat[] __initconst = {
 	"cirrus,ep7209",
 	NULL
 };
-- 
2.9.0
