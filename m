Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeBBPoN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:44:13 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:44:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andreas Gruenbacher <agruenba@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: select CONFIG_LIBCRC32C
Date: Fri,  2 Feb 2018 16:43:56 +0100
Message-Id: <20180202154403.1605622-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:OJ5Gv+O/Qnldnk7yh0gA1GFsePiI8WXhW9hN5Pl0BVjY2aAEtvM
 vOqt3BjFNaU01CiiLyeG9i/bLkjm2Fbphi0eptOxmy3diRI/Jx+e+IdkJ1DH8gvADtSYzCD
 eBP5SSvHq2GCywayC1fFO+4SC3THSn9r7fjw9S0J5nFpHG4UExwxyOGuYX6dw1NllacaUkx
 QdI4nFfFd8U5q1lSF9QtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b1Prtoh54R0=:BQraGbcIu0nwBD/dOGTHLy
 BzUAki8ZBWl8Jfu1MvzXvad0MCIKIqNU68K66koqjN44NL8zv24BMmlMts+iV/wQAj/1iju0t
 zIXea0jB6hRLG5PZAhIP5TqSgFhsKfm8wg0OmD12V0p+cxzQysUv8NFeMxwRuU3qwLoN/cL1F
 dfclOXBXxtZUm7r6TvIxCacXGN9DuthX9yyMPTbN5odpPdDoNEeSDA3uFpOMcwCzt92jFQy85
 4TpJXbusEq4GliQ8Bva6KE1b/eGWBS0/c0h1p9XOzSyr2KFuY1eSzYDy/PFLVfD2hXffZRT19
 NYRtAmNF3QX0iBSl0Z/9Dv8y2Mg0OOOM0yySdEUGh6wh0YjbL36YOe4DndiRLYAA3Eu6IWq3T
 lds3ymFO0jRL0KEAmfOPZ9/PApKe+eIJYu8jZcMFYeEYwVc6n2O0w+Z0LqxUQXahNNbi8GgUR
 2AjmmFX4aJjVq6PdAawhPnP/OBu/TCl8zyq0o1rKN0k/h6/XCpw3DUb1x79fUmC6LEsYo0Qzr
 I3g9namNouQeRPC5U4mMZ5iASKrbP5XZ+xaDsYSOyiXC6PuFto2xUcMTU0vksbfeNLC/1NHBH
 PLW8vZO74XjaPVGN0SunPfAhOsG5r8ibyCZA0XUQfGTLEl+M2dt6OR5eycdurPN80ig8vKJvm
 C1AirBfBWcww3qV9a8d0QW0Iw7W1oIUvA1z2VyGwirUNdPxvJNK2Eu/Ez2XsTu7IEWQrimdWX
 772WX0VS2et9F4XQmLDQYETcKp+WFSlaKuhp3g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new crc32c logic in gfs2_log_header_v2 causes a link
error without libcrc32c:

ERROR: "crc32c" [fs/gfs2/gfs2.ko] undefined!

While the original patch selected CONFIG_CRYPTO_CRC32C to deal
with this issue, it turned out to be the wrong symbol.

Fixes: c1696fb85d33 ("GFS2: Introduce new gfs2_log_header_v2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/gfs2/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index c0225d4b5435..3ed2b088dcfd 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -3,8 +3,7 @@ config GFS2_FS
 	depends on (64BIT || LBDAF)
 	select FS_POSIX_ACL
 	select CRC32
-	select CRYPTO
-	select CRYPTO_CRC32C
+	select LIBCRC32C
 	select QUOTACTL
 	select FS_IOMAP
 	help
-- 
2.9.0
