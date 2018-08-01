Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847BB208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847BB208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbeHAOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:16:18 -0400
Received: from mout.web.de ([217.72.192.78]:49745 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbeHAOQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:16:18 -0400
Received: from [192.168.1.2] ([77.181.227.154]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lal6K-1gDHC40KDo-00kPg8; Wed, 01
 Aug 2018 14:30:24 +0200
Subject: [PATCH] Coccinelle: atomic_as_refcounter: Merge two SmPL rules
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
 <3d4a4864-3b48-94a7-39c3-0f0e3018f9d5@users.sourceforge.net>
Openpgp: preference=signencrypt
Message-ID: <9d9a0d3c-e4fd-d950-518a-b567fe18ff21@users.sourceforge.net>
Date:   Wed, 1 Aug 2018 14:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3d4a4864-3b48-94a7-39c3-0f0e3018f9d5@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:A7aVO3b77eFyaqBFuQ4cSP+yME/d8m94qxlqHrgvYBI1vwH1lCf
 YeSBz37ok9IH9lbQKcn99DNkwpQdPWBQYrR/aaZyzdcjtgToZCDeoXBXv93PrRYp5Chqkeh
 zIoAm+zIggG/MxCXWlHD7PKyOHcIjgCeDGTnGnQX9xe2KbAAHlREc5p3U152JFjIBQgCYHB
 lO7sCVjgKvhbM5D3INdYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iwrnFUePW6k=:F5HkQjLeMJuiVvlk0y9J1Q
 KiY1Hkr0/XwIY6RgjtPdH6cjej3CRZnJlZAns566gpzjjcZkHlR4c/54tPSAMeZ7YtrxM5M+w
 SCiWk/81FkHNdM8NCX7ogryh4ONky+d/OFyxdr02KiEmRMbS4NyAMRWGyCG0h4TjcW2GeoUG0
 npU1lmtUpFyzAIBENUtODyry5g8jcyEutnMAEskvNC8ocsGLThe4poCtIGK22Czrw4pb4fRPx
 DpXn7SX41kMsFGaxyzu58eNrkxMv7HSitVOYdEtK5vYLu5YXiJx94AcRGuZxr4s3tJqsHT7AZ
 2MtNe+bVFJ4bPE7OkoEimyyqOQZjXUCmJPfn8lmDpyajF/ekl5Cdp8rhViJMzLvex6RMA+Teq
 /NaL16sl3jsFhAEYU46AT6qnAp5MzmXBPdRiXihOnx2Zj78ng+rU8MPtBk5mqEHB4hHRPExVF
 hZQZo5tr0JtXS7egST7HJVRiqteARfMh2rQshkjgf/sshq3s1UvFGSTM1YEmOGiykl2zzSwhC
 0vPiupbeaAPi6QG1z5vLXeuOpOA0P8tOW20XylnNSTexJ9argz4VLnxaDc9+kzfwFntFaah17
 cvUARcbEJ/44wkk0cjhFxZHVsm0eeDWpxuG0eQylo04IJ74ou60TwHwqzsIvENHvZjsQqm548
 Pm2ZSP1n6jKK64oS8yUITF6UAHy12nHnHFd48qbecyh3MbW0sQjf4k1uG3aRw/QTj33eCSuLo
 99w97RGPXUVnyGXIC4+6v4vP01nCVPnbU2rgfw1VtSYf8dLVLtNfHy54duSoL2ZEtfsrxKSQ6
 2955U0T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 1 Aug 2018 14:16:01 +0200

Two rules of a script for the semantic patch language displayed
the same message.
Thus reduce duplicate SmPL code so that the desired data processing
is achieved by another nested SmPL disjunction in a single SmPL rule.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci | 50 ++++---------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 1e2278ff3261..292a029d5a51 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -11,12 +11,11 @@ virtual report
 
 @r1 exists@
 expression a;
-identifier x;
 position p1, p2;
-identifier fname =~ "free";
-identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
+identifier x, y,
+           fname =~ "free",
+           fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 @@
-
 (
 (atomic_dec_and_test@p1
 |atomic_long_dec_and_test@p1
@@ -28,14 +27,17 @@ identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 |atomic_long_dec_and_lock@p1
 )                           (&(a)->x, ...)
 )
-...
+ ...
 (
- fname@p2(a, ...);
+(fname@p2(a, ...)
+|fname2@p2(...)
+);
 |
- fname2@p2(...);
+ y = a
+ ...
+ fname@p2(y, ...);
 )
 
-
 @script:python depends on report@
 p1 << r1.p1;
 p2 << r1.p2;
@@ -44,38 +46,6 @@ coccilib.report.print_report(p1[0],
                              "atomic_dec_and_test variation before object free at line %s."
                              % (p2[0].line))
 
-@r4 exists@
-expression a;
-identifier x, y;
-position p1, p2;
-identifier fname =~ "free";
-@@
-
-(
-(atomic_dec_and_test@p1
-|atomic_long_dec_and_test@p1
-|atomic64_dec_and_test@p1
-|local_dec_and_test@p1
-)                           (&(a)->x)
-|
-(atomic_dec_and_lock@p1
-|atomic_long_dec_and_lock@p1
-)                           (&(a)->x, ...)
-)
-...
-y=a
-...
-fname@p2(y, ...);
-
-
-@script:python depends on report@
-p1 << r4.p1;
-p2 << r4.p2;
-@@
-coccilib.report.print_report(p1[0],
-                             "atomic_dec_and_test variation before object free at line %s."
-                             % (p2[0].line))
-
 @r2 exists@
 expression a;
 identifier F =~ "^atomic(?:64|_long)?_add_unless$", x;
-- 
2.18.0

