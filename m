Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeBAJgU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:36:20 -0500
Received: from mout.web.de ([212.227.15.14]:49494 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeBAJgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:36:17 -0500
To: cocci@systeme.lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
Subject: [PATCH] Coccinelle: zalloc-simple: Delete function "kmem_cache_alloc"
 from SmPL rules
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net>
Date: Thu, 1 Feb 2018 10:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Bd1S1VmHT0t7TyjKtyK6wZBsgflosRLiTsrpyBFYpLg9fsKlsoE
 tvu/kKHiLBpJmnyKr7NK8lfq4/nLNJo+7bL+L9B69VSbUjkBDCxS1QygWRadnimEbSeWTm3
 RLfndncBFUFRMEIMVMA/amlFIQrAtp3twdhh9cRJ0h39I6w+qDvyzlZAmpxzOWQ4IvNiiUr
 cqmzwvsx+mM0t1WexVW4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JQo2kt58K4g=:OU4hVzY6KzBaqHhmVuWw0j
 dnkKFVJb7nDLRBkXCbaPWfJOzbK03Y8FI8Bxkfq+mNV9ABZUMqqveHfqCpHA4ShFkpKtn5jz5
 kdo8Ojg+BABOEgXegVueoWZWwo6dIJRSilg/WIS0i3X5LZaZ/ujIM+YwQA9kdfWUjhY9yk71H
 OyCbrtWRwq4Ik8tebGb2b1DEFDGpAID160dfFvKkKmV+IDr6KxtreiB8/BF33ttH5+56O+2us
 hWkFCspa7BH2ASCXMlsaFGQZGp9SynKgMxS5aFNstLHFCWgVerM9YI5OJZOtPSUD+YQhT3otM
 vS+ucy9WMOk3qSzCJOfi/kK7AogzMrfcbSvr6+oOdGLXcWIlhyaABfdJcHaZgugqGMds/Fx6i
 2s8OW9ARq3wSVr3k1cuznPuN13kmlDdIS0Sy+Xday1bj1HJxjV6XqT/XvGdushgBUKMTzy0wP
 BzGRiD6gkZcKY+gOuP5dFmfJ6aaRRE0hv7WmvDqhYFU2Ao3s2brYifFzLlMr5wO6AU57lnqNm
 pY4aS38Xetsnj6NoWOXNP8emgAM+qNNt/frj0tOOm7OXMSqlKg1B5QIqPcv5BZcLWzT4W6Fb4
 Xbq9Qui+9+9rkPJWThPohwAtfxX5TkYUzek+GFXQnbKY1oDlk3v7i+4d5BuJVbPPWj7gXIn6U
 CiTzKbJxurHGVCahTa3g7NDMlP7UdMclqI9ifSP/KGbIFoEXdWL2bMjbg1EH8PkIMHu8K5vyD
 uyiAFiIc7WFhlr6YtpGSSMo0QXnCjYVm/Qu/ECm/ciT6i1FJvnXsWwLFM1jVFbZ5r2cpurtTs
 VQmpTaGtM+f9+oqAiO1wbdGdkJ7xAOfcRdE2kK2kwa762HLUKw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 10:20:47 +0100

The deletion for a call of the function "memset" depends on
the specification that a size determination is passed by
the expression "E1".
The function "kmem_cache_alloc" was specified despite of the technical
detail that this function does not get a parameter passed which would
correspond to such a size information.

Thus remove it from the first two SmPL rules and omit the rule "r4".

Link: https://elixir.free-electrons.com/linux/v4.15/source/tools/testing/radix-tree/linux/slab.h#L14
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/testing/radix-tree/linux/slab.h?id=f26e52e08ab8e56f528ac14aa7929b3477de5616#n14
Fixes: 5e2d9da5b9ba350a4f13bd3b255be046bcf86465 ("Coccinelle: kzalloc-simple: Add all zero allocating functions")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 41 +-----------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index 92b20913055f..3bee6cdd99ea 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -34,7 +34,7 @@ statement S;
 @@
 
 * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
-  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
+  kmalloc_node(E1, ...)\|kmem_alloc(E1, ...)\|
   devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|pci_alloc_consistent(...,E1,...)\|
   kvmalloc_node(E1,...)\);
   if ((x==NULL) || ...) S
@@ -88,15 +88,6 @@ statement S;
 - x = (T)kmalloc_node(E1,E2,E3);
 + x = (T)kzalloc_node(E1,E2,E3);
 |
-- x = kmem_cache_alloc(E3,E4);
-+ x = kmem_cache_zalloc(E3,E4);
-|
-- x = (T *)kmem_cache_alloc(E3,E4);
-+ x = kmem_cache_zalloc(E3,E4);
-|
-- x = (T)kmem_cache_alloc(E3,E4);
-+ x = (T)kmem_cache_zalloc(E3,E4);
-|
 - x = kmem_alloc(E1,E2);
 + x = kmem_zalloc(E1,E2);
 |
@@ -268,36 +259,6 @@ x << r3.x;
 msg="WARNING: kzalloc_node should be used for %s, instead of kmalloc_node/memset" % (x)
 coccilib.report.print_report(p[0], msg)
 
-//-----------------------------------------------------------------
-@r4 depends on org || report@
-type T, T2;
-expression x;
-expression E1,E2,E3;
-statement S;
-position p;
-@@
-
- x = (T)kmem_cache_alloc@p(E2,E3);
- if ((x==NULL) || ...) S
- memset((T2)x,0,E1);
-
-@script:python depends on org@
-p << r4.p;
-x << r4.x;
-@@
-
-msg="%s" % (x)
-msg_safe=msg.replace("[","@(").replace("]",")")
-coccilib.org.print_todo(p[0], msg_safe)
-
-@script:python depends on report@
-p << r4.p;
-x << r4.x;
-@@
-
-msg="WARNING: kmem_cache_zalloc should be used for %s, instead of kmem_cache_alloc/memset" % (x)
-coccilib.report.print_report(p[0], msg)
-
 //-----------------------------------------------------------------
 @r5 depends on org || report@
 type T, T2;
-- 
2.16.1
