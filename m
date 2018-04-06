Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeDFO2k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:28:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeDFO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:28:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hexagon: fix ffz/fls/ffs return type
Date: Fri,  6 Apr 2018 16:28:21 +0200
Message-Id: <20180406142832.2243021-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sPYsZINIgbBBJhorGwFFBdtSAn9M6hmr/qN+/8IJ6as1F2rud+t
 8MkX1M9zdH5LKJB1kyL6feysNEjhxJKcjsA/pn2HB67MfsmVyIV0QuVoeKDinyZH4zA0mbe
 +s3fa+7XtDzpGH7w8A4ZqtpdyXvXAzT59g+FNoMY2DT1Gx1mfIl48cXzS00tbnAsnKKyi6p
 voY7972ns/9+UDOA9+EVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xsRU8VXITB8=:cjM9VJrMR1MFrVjKN7hgtb
 Yogw/7M7ukvcWyQu/9m3+HbK02FpYi22hzBKV5Jn6f2pzS22ZCebLEfwpPvHyHE4Lv9r90zDt
 QKy4hJ0dnMXgmzQQM10ez9UZxeWvIpi4jZxaAkzaxfOPxfMH29o0ed1UIwBZOuDnk57pdDKbk
 FOliz4q5QsDHS/yPMoElTMGEZENiyYaXX1KZuVNToyyRMpS2mpyZmrBGUVRjfbhePs4P1S29U
 0uz4UepCkb+HDcDeNAyCfwIwwQXHALBtIRYSnlom2MPUvg5HbWWBt0TqrWcOLAaaa+I0ZuBfF
 /NGVg8M5HohnRcUiseO8fJKPWU0UHWhO6nxxHk5d+NufKixXxe0+5dE4cbH2LoNU0hFo4Wt2X
 GdDf7hg7IgYuxjANp+lHOu9zRyBmmoSBXq6fFITr8Q7XDi+32OO2QoZqpHIjYfWXHnyEdH/kV
 IEJhtYavZFRlGzd5yWcMjYLxARdk+nLmiiMnp+Uo75FYmlZdezutqYsDvTuvUSqKGRl+43/G6
 1oa2Str/o4zLnirHGKAas/N8+SStGrOXu7wD0l7LMF/V3O5VqLXnHiHoZ4nZNiLYNYJ2c2YDG
 OHF7YopC3xEdCTTPwa6uNIqWbkqCP2fG2gPLmEmbWHWG0430OV97q6iJYHkEO2AVbLi/C41IE
 rXZ/0smG/cf9keBwVYk4oqTwGLnolwMvBLsjkYXeuRp+Zrxf9+3b8j/8q22EIYIE/hSU8eqxt
 dgIYkZ5TiRPVEUO5q1/V9egIWzpA1jE27edHkA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the same return type as the major architectures to
avoid warnings like

drivers/ata/libahci_platform.c: In function 'ahci_platform_init_host':
drivers/ata/libahci_platform.c:561:12: warning: comparison of distinct pointer types lacks a cast [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 5e4a59b3ec1b..8790a50b1f5e 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -194,7 +194,7 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline long ffz(int x)
+static inline int ffz(int x)
 {
 	int r;
 
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
 
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
 
-- 
2.9.0
