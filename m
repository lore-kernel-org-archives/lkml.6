Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeCDCaN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 21:30:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:39983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeCDCaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 21:30:11 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 2/3] net: core: dst_cache_set_ip6: Rename 'addr' parameter to 'saddr' for consistency
Date: Sun,  4 Mar 2018 03:29:52 +0100
Message-Id: <20180304022953.4508-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180304022953.4508-1-j.neuschaefer@gmx.net>
References: <20180304022953.4508-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Xqc2Rmy0/MKLa1yrvm3YnruDy3ryWQjs2eB4452yqdYNzJvFtYd
 FPRWkODxzuwlXKTSuOSJgWI9MDohfg7ydpX9C91Q7RF02NUDvDC3OZgUPeVI8CKHQCK8HlC
 eiiIx0qTNqetHt4VboEV8kbk3W6D3gyBGbUVZfcZ2x1KwhHn56H2njOfWJcFoU1JMMUmn1i
 SrS+KUbcfk7mlueTOmtlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8kCpGQjjegI=:KCp8eVg+P8V3JVSSEdPMXe
 bWu6t+9Fc+nletfiWoBE81/RcCBoHhfYjs2RqYNunv8NPQ/sHMvGyp9IjwOhqc9TbpsJJjLd6
 cLnhywbD+sscJIbt9G194btdIKgUjl+ohUxTd9L6zP5nrnofLM6c3v/zBwgDCMxlzXFmc0DXW
 W5eBVkh918ujhEWOpf6FtqTGYi1192uBTlw7FgofF894eiZ47VZewrVTtpHJKQuFEMFeawafH
 7uLckRKyTvgklnQj9mUdfU/m5gfOZ/AX2Ud2E3xaNL3oJmdcAHlX3DoXGBOabQpR0ybGKuVPz
 mP85evfgrFSTQoyhYhbfCvjzMWMAOcWs5SjyeX2tvOgmacyRfRe5skYyiySFebgTCV+4l5fEA
 ASUX3HXLPIAfFxhwwVWyGA+7agWy8SWDHcFmtgi/XQfH3oHPYDom4+2O9bMPQar83+1yw5bfK
 DDWwa69+Khb8Nbfb4tflc4f/k2gVYChPVdX4xCOSKcwFtjtCMljIsYPyyF4dmlcYg9HNrGVab
 MMFV6k6FOl0LpPwKg4AyUJ+dgxnaCUX58AvYFAKy+ZS6PHkyGlm3sW4P4BKNueOtUQ7NXuBXg
 XbG3UYoAb8RBAh7OtoNoHU2Aff3HqfU1pw3QFnwZlzv2iPJTPDx+L41OKIRQ6do3qZnqZoMB8
 iDGMmrE8Dr56PQgQjLJ0/+04rpayXFaNb+tUYWDCj3pErc3SpJFd+dKKbW0mZHHrtVNlCnZVF
 kPe3/1bPh2FC7Ob0pg3JBjYpbjFClGVhkzDIRAOCCYrUEn5g5flotuhY11wrzLlBaEC96Akqa
 YXB1WVjz2g9KXLLdzH++5Aos7gFPk1iDIhPU1wVQoNQTEo0rTk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other dst_cache_{get,set}_ip{4,6} functions, and the doc comment for
dst_cache_set_ip6 use 'saddr' for their source address parameter. Rename
the parameter to increase consistency.

This fixes the following kernel-doc warnings:

./include/net/dst_cache.h:58: warning: Function parameter or member 'addr' not described in 'dst_cache_set_ip6'
./include/net/dst_cache.h:58: warning: Excess function parameter 'saddr' description in 'dst_cache_set_ip6'

Fixes: 911362c70df5 ("net: add dst_cache support")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 include/net/dst_cache.h | 2 +-
 net/core/dst_cache.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 844906fbf8c9..67634675e919 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -54,7 +54,7 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
  *	local BH must be disabled.
  */
 void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
-		       const struct in6_addr *addr);
+		       const struct in6_addr *saddr);
 
 /**
  *	dst_cache_get_ip6 - perform cache lookup and fetch ipv6 source address
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 554d36449231..64cef977484a 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
 
 #if IS_ENABLED(CONFIG_IPV6)
 void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
-		       const struct in6_addr *addr)
+		       const struct in6_addr *saddr)
 {
 	struct dst_cache_pcpu *idst;
 
@@ -117,7 +117,7 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 	idst = this_cpu_ptr(dst_cache->cache);
 	dst_cache_per_cpu_dst_set(this_cpu_ptr(dst_cache->cache), dst,
 				  rt6_get_cookie((struct rt6_info *)dst));
-	idst->in6_saddr = *addr;
+	idst->in6_saddr = *saddr;
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
 
-- 
2.16.1
