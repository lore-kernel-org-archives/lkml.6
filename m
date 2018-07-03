Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B52086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6B52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbeGCHnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:43:15 -0400
Received: from mout.web.de ([212.227.15.3]:35911 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753606AbeGCHnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:43:13 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrbHJ-1gH2vS13OP-013LWA; Tue, 03
 Jul 2018 09:43:03 +0200
Subject: [PATCH 4/6] Coccinelle: atomic_as_refcounter: Replace disjunction by
 a constraint in two SmPL rules
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
 <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Openpgp: preference=signencrypt
Message-ID: <fcd2762c-66bb-3571-e2b7-da20eda5d8ea@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:42:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eF11gdVuxdcvXWlr8mswvf80TJcKHZrNp3d8RXmvgr4gYOGYGXD
 d8V4rd+M0pu0N+5AbqRHCcfGo7p1mdPT66oqJt4sr04ALBC/MknqEzvox3gUuTVuz66t7So
 Ng2NpnNWzablGzEKr2AaP436LWO45ApMgB/Wx+Hs4g0gQsCFS3ST8mtiNe9eaO/Ms4ipk6z
 dcsQnGOWT5XrwFwTD5CDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lgTJGz6C98Q=:ZeGGq0ap6zFiZp3usJ6htP
 A3bGiEOKWxUhZbFslG6dHGDloUN+O7xrPZpWTA3K8yU9Siq64K2wwiqPHL+GULr7zMXng3j/p
 ylcYxYNm+VRjTSgh2ALe0wAQfV/9oI0FUnDlZeTVURTDD4PaYUgDyZlhmEyVUExtBLYcAr4fU
 YLjcvo0jqDl4+lBYZ72DlXhbbGrKY0NpY+mwfetMFRykVKCWVaFeGI1jEZtyG5jB8rs+KKzxw
 DlBlQhWASw+ie3RfsJZiBdxIJaA7MJFEupe1hdW6xIS2q8QnjgiJCTedXhYYC2Bt/x52HKkar
 +WT3hkFuRIroobKgc7YcvEzks6A2yHmkW1shny4cb/Tte/RP63amQWAioGsfgwp9/sBXfKtBq
 mawZcjDi2WBXrdxeB05tEY7PJG7a6y7c2eQ/syIDrJqGQ3rcOtyPYvphIzQkJGVwtnx5Kzi85
 1Cc5YAoPuq1c7eo/xg9LMChx40R0a0rmQfPjgK9rsXjdbdzktUX+//wblyLs4dVJvH5HoWq1r
 wBsoCPBkrVf4dyn56cMe2ae1mvIIGXPSDd9FwwWfUwLhG4JQsGjU725eq0EXZdWlJh/SHIRmh
 6E2Hw7Vv3s7/XJzpShXolaRy91x9ZaZ0evGb7Yry3fXEPDNcqoi9FB+/q89tT2ddEgvk323NV
 /ZGta24c/4O/bvdaH7ObYIBMAIb5flFw41Mi3RQ4c5YbHc4Nh7fmNI8+RpCxWFj3wj9q13qV3
 RXc1ANoZpJqGcq6m+Z4FZjCWMcBOVN4EG9h1zgf7LCPzcv51Qiz98HBNU9nX1+/TYeHnb3Mpb
 Fsz1rXX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Jul 2018 18:45:15 +0200

Three function names were specified for a search of function calls
by the means of a disjunction in two rules of a script for
the semantic patch language.
Use a regular expression as a constraint for this source code search
pattern instead so that duplication of SmPL code can be avoided.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci | 21 +++++--------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 57af2db9463e..372ae99591fd 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -80,17 +80,11 @@ coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
 @r2 exists@
 expression a;
-identifier x;
+identifier F =~ "^atomic(?:64|_long)?_add_unless$", x;
 position p1;
 @@
 
-(
-atomic_add_unless(&(a)->x,-1,1)@p1
-|
-atomic_long_add_unless(&(a)->x,-1,1)@p1
-|
-atomic64_add_unless(&(a)->x,-1,1)@p1
-)
+ F(&(a)->x, -1, 1)@p1
 
 @script:python depends on report@
 p1 << r2.p1;
@@ -99,17 +93,12 @@ msg = "atomic_add_unless"
 coccilib.report.print_report(p1[0], msg)
 
 @r3 exists@
-identifier x;
+expression E;
+identifier F =~ "^atomic(?:64|_long)?_add_return$";
 position p1;
 @@
 
-(
-x = atomic_add_return@p1(-1, ...);
-|
-x = atomic_long_add_return@p1(-1, ...);
-|
-x = atomic64_add_return@p1(-1, ...);
-)
+ E = F@p1(-1, ...);
 
 @script:python depends on report@
 p1 << r3.p1;
-- 
2.18.0

