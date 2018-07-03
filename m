Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4763F24B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4763F24B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932693AbeGCHss (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:48:48 -0400
Received: from mout.web.de ([212.227.15.14]:36119 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753213AbeGCHsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:48:46 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lud96-1gIQYU3sPI-00zm61; Tue, 03
 Jul 2018 09:48:35 +0200
Subject: [PATCH 6/6] Coccinelle: atomic_as_refcounter: Use format strings
 directly in SmPL rules
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
Message-ID: <3d4a4864-3b48-94a7-39c3-0f0e3018f9d5@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2dCNo3cGk7WFwrl4x5Tnfgf22i6/zxlcJNxL+ukNkmfNuGGr1nE
 DetGOz8EBycjtwRmD0M2kn5BeaERa8nF+Qq7LqO0UIVwk3kb7NwZsN28qhIfEPpZkmioH0U
 +K8sTIFCWq/Ktmxcn7rn/T3n2EG/vpn0vxumyil+ZRFYpHuvlB9vxeL/oKge2MotEX8g2Vk
 FjrBWn9Cyuz26JTistgBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+xFRUPgZiD0=:E/4eC2MVXZ0jW74dD9hfj/
 ENEFnmrZ+/gQPl5f7WWxIp3pgqT++ui3R4SpgIzwfnuUloBy44iimtoC/+56OB0D2VI+N8rbH
 2ReTc3Tp4paqaZhYJlYOg7fBmi4lBC2LLeBvAcy8yrXIUzlQstfqKSw4y+xNO750ozwz/habn
 GmiV44gOQyqVPwkscbta/MOnMr6WrBUjn7HXNTYEC0ISL7rSbI8e4itGcy2zkP0+SWAofQ45h
 LwROXCfZx2gulUukT5bQVxl9Dcc/ZoMV7OBGWeaQYXWHpoZkcewIQMn5IdWK2Q6/cmD8vVISz
 Z/lsPaX6qM79SwgNU3FtsqCx7eKrJltI/9eM7bzAaifF2C2E64rbrSlf893406PCeaB44jB3Q
 haqbGTBR9mAK4btQ+NgXrGioea1gXGvnEjkmJQ+Xsf05IVAmr//8MgGVcCDbsKdyJqH+LLeX6
 QfZH11qOde4NluO+AOlPbR1OcLM3yoT+hftBB3UATM7cieVzvdDtsmrSADVfp89wkBouJLBNX
 kCG4I4IvEjjHRj1dXy3WHp4lnNCXQYGKdBVJ5zmy5I+Tl/FMrLzKjidxrhWqMCgdqex4WIXpE
 0ZBg1um/fhCTBAO7P+/87KopKC4DX2bgRbEi6mLlkQQhFqh5N/4IksuNTqosyQBYMssULEXVv
 N2vqyU3ew+X89MWTRHqGUP9eiEZ9Et4OqLGBDbgPOeey6Dth9QWp2/Ii9JDvH4kHdI9E1GsA2
 Z2h5lPSrhNRD6eeRN6FkUYuW5ZevtD2ZTir02V7sAf++fIbN2T2+rxamoBrIhORiqn6YFhU4j
 /moB2M/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Jul 2018 19:46:45 +0200

Format strings were always assigned to the Python variable “msg”
before they were used in four rules of a script for the semantic
patch language.
Delete these extra variables so that the specified string objects
are directly used for the desired data output.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 63cbe866c99f..1e2278ff3261 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -40,8 +40,9 @@ identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 p1 << r1.p1;
 p2 << r1.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
-coccilib.report.print_report(p1[0], msg % (p2[0].line))
+coccilib.report.print_report(p1[0],
+                             "atomic_dec_and_test variation before object free at line %s."
+                             % (p2[0].line))
 
 @r4 exists@
 expression a;
@@ -71,8 +72,9 @@ fname@p2(y, ...);
 p1 << r4.p1;
 p2 << r4.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
-coccilib.report.print_report(p1[0], msg % (p2[0].line))
+coccilib.report.print_report(p1[0],
+                             "atomic_dec_and_test variation before object free at line %s."
+                             % (p2[0].line))
 
 @r2 exists@
 expression a;
@@ -85,8 +87,7 @@ position p1;
 @script:python depends on report@
 p1 << r2.p1;
 @@
-msg = "atomic_add_unless"
-coccilib.report.print_report(p1[0], msg)
+coccilib.report.print_report(p1[0], "atomic_add_unless")
 
 @r3 exists@
 expression E;
@@ -99,5 +100,4 @@ position p1;
 @script:python depends on report@
 p1 << r3.p1;
 @@
-msg = "x = atomic_add_return(-1, ...)"
-coccilib.report.print_report(p1[0], msg)
+coccilib.report.print_report(p1[0], "x = atomic_add_return(-1, ...)")
-- 
2.18.0

