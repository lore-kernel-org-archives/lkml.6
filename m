Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA773C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790CF2472E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790CF2472E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeGCHqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:46:17 -0400
Received: from mout.web.de ([212.227.15.4]:37845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeGCHqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:46:15 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5wkL-1gKOPM2ySn-00xpKH; Tue, 03
 Jul 2018 09:46:05 +0200
Subject: [PATCH 5/6] Coccinelle: atomic_as_refcounter: Use nested disjunctions
 in two SmPL rules
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
Message-ID: <6d70ae28-69c2-4d7a-2151-6df704694d0e@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dJ3Rib+AdbnHZ/0Gi5iH/7NOLh/dlXqfgEUFZlnHEbWq816bKUS
 dGQLmt6FI7TTozZtWOGvGWEhL+8PpzJQTJi8HaC/1XjBh4CtThpzzqrjwOrKVML5eEIYm1N
 uIAooe8JCFrN9tmmYoFOW7SGXHTyGrHLqiU2dT73BkvJvsTOUX3p5KSqNUv7/OvVuxPGUdv
 aRACorTuMDhVGflcG5GUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vR+gPXfvGag=:XGa/YN197sPXmlLV9oehfy
 g9rX7HnhAzXWWyzBLuBWsz/xB3WTBTVCcpV0L7qWK5XmBSko9NOtKjWFHJp3yEF5EDo9Jra9G
 0cKSYkoMgTN9wUexJGBz1Hrr9C3gRhA8pAAooyIF92iqrhwBrVErWgNkHIsAF2WTqVxjF5/rk
 u8apKv60qiFtyhU3pYJ90FOaGlvdWWD1dnxgg9JrYJO7Ve5lpGQkAITorBzNXLgjUetlhVuVR
 AtfpRtSchghKqP/Pw3XiVf3c1pvxAQ2dTqHtIK9+6ojL1GtFxdL8usmzkL5ZKXyJeKojVT0Aa
 IUO3rbAo2hx666Z3JkzQ21CZnl9CwPxDnEP933nuhv2+C8i9ZO7gRh7z//8ZSs0B9aqkW8atA
 9cCvYpIFETJRM55y87edGp8AMuf2urNOYyBwLm5nYmYXCw+8F2E08rKD/yoMrk4i08HoHsZ6G
 AllE2BA9LGitbJaIulSeWfe+cBNUbo/5uYzsGPUeuoNbRGdljuvgesiZdBeAINK+4zHVNzjBa
 VLSWglGXz+dLPnL+2hIGlEf5qqDEs29tZubfTttHRpAeTTWbNGR+5Yf2qKYTO/5ozjQJ7k73Q
 vWZxkpFzTSQvL3vs2sdRtyjYBJer+RpA2glmq0NhS0M8G56wi53mvGEgZabt5qaNAbj+IZ4yQ
 uYlPjrgLQqhHPBM7xaR4uIugwX2LGGs0jNON6TQnvMDm83USoporLOa9DCNK7Gh1isi1WBEgO
 axD28UpezhTGidyr3aZxJfJdNqd0imL+IhREiAov4wCFp3zKliLAsb2ATQ5vw4g2yG2kfby2G
 w3Ar0E7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Jul 2018 19:21:28 +0200

Six function names were specified for a search of function calls
by the means of a disjunction in two rules of a script for
the semantic patch language.
Refactor them into two groups so that the SmPL code repetition
could be reduced a bit.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 372ae99591fd..63cbe866c99f 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -18,17 +18,15 @@ identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 @@
 
 (
- atomic_dec_and_test@p1(&(a)->x)
+(atomic_dec_and_test@p1
+|atomic_long_dec_and_test@p1
+|atomic64_dec_and_test@p1
+|local_dec_and_test@p1
+)                           (&(a)->x)
 |
- atomic_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_test@p1(&(a)->x)
-|
- atomic64_dec_and_test@p1(&(a)->x)
-|
- local_dec_and_test@p1(&(a)->x)
+(atomic_dec_and_lock@p1
+|atomic_long_dec_and_lock@p1
+)                           (&(a)->x, ...)
 )
 ...
 (
@@ -53,17 +51,15 @@ identifier fname =~ "free";
 @@
 
 (
- atomic_dec_and_test@p1(&(a)->x)
-|
- atomic_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_test@p1(&(a)->x)
-|
- atomic64_dec_and_test@p1(&(a)->x)
+(atomic_dec_and_test@p1
+|atomic_long_dec_and_test@p1
+|atomic64_dec_and_test@p1
+|local_dec_and_test@p1
+)                           (&(a)->x)
 |
- local_dec_and_test@p1(&(a)->x)
+(atomic_dec_and_lock@p1
+|atomic_long_dec_and_lock@p1
+)                           (&(a)->x, ...)
 )
 ...
 y=a
-- 
2.18.0

