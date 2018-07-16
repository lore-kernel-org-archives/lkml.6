Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941C520846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941C520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeGPSBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:01:19 -0400
Received: from mout.web.de ([212.227.17.12]:39781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeGPSBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:01:18 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lheqz-1gRfa540eX-00mtZ5; Mon, 16
 Jul 2018 19:32:41 +0200
Subject: [PATCH v2 5/8] Coccinelle: atomic_as_refcounter: Replace disjunction
 by a constraint in two SmPL rules
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     kernel-janitors@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
 <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
 <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Openpgp: preference=signencrypt
Message-ID: <94b3299b-becf-1026-e855-2c4826cd33ab@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:T5LN6wgtTjJwpmcWkAa0iiJUXSGeeRMXCgyx9C0RzFi9OtO4Mix
 8nMso1+96plXUkQhD+8lOAeHsQImn8CLmPxuP8GKnUE8qg6TJnHI8mDvbV/Hn/Yb5avEM/+
 0r1qHP1l0yXTvIbymxMePADcXUedFXL7qYii1mZ1Y2XvJWm13GQTs2H0Q/u8tqzqbv4iU8J
 yP7X2sSEfYXMZQvWfckKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TwRfdfesY68=:uDcc0QvzGil72U8AiWtWf5
 GriIc3xVzavabR/Ba92l2bOaLlDYhAQIYqtUFOui/qtbRZRTELSHOlEbcGfb9PTTzuZ1G2A9g
 rW24giXqcbWJTl01MZJYESodl5rGDoHVW9wrlYhu0u9Q54R5STlIVMhHx796q1J7LztkCFhn3
 gO7yme38oZO6RTjWT8NqaDOfH4Yem/fUakdNvEx2BWQYZbu+ogcrpFt6HXoLvt2+aC1r+4QtU
 IrLQxmG1uTaEoU6DVOllhXjSnq4gMC3wec8MiclSlCc95gHuGhhEXR6H2YXQD+GshloCcMXtx
 zoSz7YAiV8QTSMXOlAx0PiRqIGqWvZ6443lEfCthsBi7A/dXaquCNCg75BbVjAtItj/LqjC47
 bQetmNwpa60nL9Ncqa7ZaysHmxWF5CnIkk4fVVlIWwIcTuIZQiacn5Tssn5Kq5FUndJh2NP5Q
 Yw4KKcsGyduiyZowtVf4VuHYR7hrsbVm4WakC3X7bUcOhajXlfIE3OGLakknVs9o6EHezKDnw
 R/NRW/YfeSmvtfRjhmDo0yHNdAe46ATPEeyv5qFUKnHUcrjevNIu5buqUkUlEtZ+GdYiTymOY
 BTnUx676sFqBLnGiC9jyKlXNPPEucqWCjB6XAZtjfrtBRPIs8NuDhs9IzuJLNn0ouWK+xV6qI
 HZnH+o2JRwA6LnGfcx9ZzLx/koeJVAKiNe5FOQ49TvFouj/QYOMkVRZ9WA9/zJS8WAezadUog
 lnqEaVbUca1x3XRoEfWW1yaw7OVXekIJYr3ADo7Pnx9hjsj3RAflXNu5TC3FBpu5QbaMVBXjy
 4JNMn7v
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 18:12:10 +0200

Three function names were specified for a search of function calls
by the means of a disjunction in two rules of a script for
the semantic patch language.
Use a regular expression as a constraint for this source code search
pattern instead so that duplication of SmPL code can be avoided.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci | 23 ++++---------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 62b0132d65fc..4484bea6c9d8 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -47,17 +47,10 @@ coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
 @r2 exists@
 expression a;
-identifier x;
+identifier F =~ "^atomic(?:64|_long)?_add_unless$", x;
 position p1;
 @@
-
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
@@ -66,17 +59,11 @@ msg = "atomic_add_unless"
 coccilib.report.print_report(p1[0], msg)
 
 @r3 exists@
-identifier x;
+expression E;
+identifier F =~ "^atomic(?:64|_long)?_add_return$";
 position p1;
 @@
-
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

