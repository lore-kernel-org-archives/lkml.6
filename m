Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A004ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E66E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E66E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeGPSIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:08:19 -0400
Received: from mout.web.de ([212.227.17.12]:45187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeGPSIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:08:19 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6LH-1fkK3r3yDL-005GbU; Mon, 16
 Jul 2018 19:34:37 +0200
Subject: [PATCH v2 6/8] Coccinelle: atomic_as_refcounter: Use nested
 disjunctions in the first SmPL rule
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
Message-ID: <15372138-088d-81ce-3d3e-0b95f5d91ce9@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fjCgl41eUfHtlnROsoSyP7cFAFiYnDim7VIrp0gfN0cl86pSiTV
 sNyDjsnmwSTli69qrTQO1NPp0y6Vc/7VRFB/dNqo0JtRAwoD+qTtHJMgs0847IbZsATx///
 A7OYdan/AFAJCyFnLIjqrNQkgm2+e0v7jJAi/vyEukuSYS94sgBYbL5ZzzZf7lIdn85a7re
 BLgW7SFl0Y7oEUZdokpCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8HRv+vg3Afs=:EynoDwGQHxJ0WfMDSs00fa
 lNC3i5b8S1TIfbX/Tqw9VGPnfWGD6lMCurkvoDgBXyjWbJVV06tMsBaR45tApxGulwoLp4rpQ
 Gr9qxTEEnbf1Q0arllRUFTH5LGjol7K516yW1cKKSHVnGScGobLIJ6uSWp86oP+KkwKDfUiUI
 /NXVXSQ3GwcXFf/YEAzoLopFhrJh6dnMnesFFF4qN7zZV48DPTwMqb/JbJtMemTEyCmo/n0q+
 i948U1cFPvslGmt1xiH/Ur2l0xB9A1ExTNuCpH/nT+fpKf73Q4uXo8r05h0IRqv/ZPm5BLy2E
 x8dqeDU9CELX4Xxw5v41LSF2teVC/ZAQzTsXDR/c5q9YY2nFDPFKnd/YFP5riGtEEg4AerROO
 TtVhmApAW49I5YHy3JedezFX2P+qs/9mdpvFmBQLTR9BtROocSPizLvV38JEfy0/lEdE7t/XR
 zszbNM2vFuw+5RcZ9kv/zYqnWb825ej62Iu52YBFzE5/tl7ysaeYFwKYFHJ1YUu9ZP3MCt/aD
 Sl+KiPlx4JPKX4Qcov2OsroFj2CqabYEJ8RhMNrXmlBP3YL04IV0jnA/K1hRWhrLY6uI9NgFV
 pmCxhURwdu3m/VQ9+dEDVp6PgLeUQuCOwmGsm5/v6xHKGEjS3JEf3aHOt1biCXqUJeQ/cU72+
 qoByDcX8azPCvXPVN8IdSKepNSAfhw6Uk/YBnxvLsi0Bkedz3Qzd/Ljf/5VgdHm0uYWWqg4+2
 tn0myj4SLttm1Ovy3H71aS6ynwIRrODcaRXbOwtFBNfkdlspNQyUGEB30CPPGoOVyBhhuxGmc
 CHFUjgk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 18:22:53 +0200

Six function names were specified for a search of function calls
by the means of a disjunction in the rule of a script for
the semantic patch language.
Refactor them into two groups so that the SmPL code repetition
could be reduced a bit.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci  | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 4484bea6c9d8..7eae23dc9ea8 100644
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
-- 
2.18.0

