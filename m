Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F7EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F250B208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F250B208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeGPRxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:53:18 -0400
Received: from mout.web.de ([217.72.192.78]:58265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbeGPRxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:53:17 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJkt6-1fe0m240bk-001BFl; Mon, 16
 Jul 2018 19:24:39 +0200
Subject: [PATCH v2 1/8] Coccinelle: atomic_as_refcounter: Delete an
 unnecessary SmPL rule
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
Message-ID: <ba3ffd66-7c04-cf3a-6c70-af7ba704b1b5@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ojc3ObnvaJd3sm/GGkF4B5rXssatoHQHLAJT2WifsLlezNRTFuh
 Ic4gT/9r0X33s09P0DwTH2eCu0R1rjy0IoSvqDqzgi229j3MFq9/rZbsd9wmFDlOQQ4eaRM
 ZXxe+9EUllJnzGv4IRHrShi21WOyxEqF69Q/OAlCHpfBK1IpjBXRhMVOK5M0/fz7LMg+Wxj
 uSvmnz6tFbw7rfV/onyEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NSL4GdE2vyg=:03FNK6GidgOMmmjIlw5zLo
 VQLAd5xA3Gwj72k2YisENvCgiLJCF9J9vsrkZr4CWzwV1NupP/qLFU6PJU7UiI0H9J6BqlqFo
 4Fi1yo1wwCbFtWoHprG1kLuEacLRqhCJLPzrcFthr75p9Jd7owBrCsmtEpVIrJm48p4U8+awD
 lK9b5PqWMWuEDn+Y9G97ABNYWN58SYHgkv8F4IgOMhgk3F1BIH1CSPDHSmjj27H5TRUEqx+RS
 epQg+eTDjV3HQqQiUpDuMimjylyydj7hXGxJjSE12k2NRIxmHUJY/hIM7H2mr6mRDMr+y9+Er
 XbsNyLhC61F9EfI/dzRAvzwoZ0NkwKVrs40UQRzMmL7lLtltZzvCZ7N9vHp8OJmQIXxEpqnQj
 eNl4/lF5d5/7GxGsTOyw0G0xOWMuTiNyutaS6UlpyARKXmzhZZ4ttwEugFu2v3FyDndzbr4GZ
 WjEQfziweTNAiZj3RW6qOxDYQL7RippJNPiBIpMC5ndJU2vnSrhYmtrWVf4gQfOYbS68QBAhe
 WVyJu811D9SsoOLiNiA2x8zpd1pmmPkbr2r1zh6JAJyf6iHGzJ5MCtV1l6V9OB+co+vzr9heh
 Mx+GSEVBxVBLxutZ1DWfN43Si1yr17WJT2lKfX6uJrj32aGnAWfn8EYxarr3Lf8N0KGTgIZrY
 wrKbfh6FkE4PdL1W8AeuaGwfUr11++6Mr6hbeqbvcu2R1zbwyCTi66Rr4hrwLhodt67ehziUh
 x03rZO/JJv4asx91xbXuZo1lkeDaa/zv1p1Fh/YApWvA/Tio8LG3j70gZxPbPacdokXGuWaQZ
 Xt43gN8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 17:15:26 +0200

A search was specified in the rule “r4” for function calls which should be
found by the rule “r1” already in a script for the semantic patch language.
It is useless to repeat a source code search there just to determine
that a variable assignment was performed also for an input parameter
of such a function call (while the same message will be displayed so far).
Thus delete an inappropriate search specification.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../coccinelle/api/atomic_as_refcounter.cocci | 33 -------------------
 1 file changed, 33 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 988120e0fd67..61fcaf5e45a3 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -57,39 +57,6 @@ p2 << r1.p2;
 msg = "atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
-@r4 exists@
-identifier a, x, y;
-position p1, p2;
-identifier fname =~ ".*free.*";
-
-@@
-
-(
- atomic_dec_and_test@p1(&(a)->x)
-|
- atomic_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_lock@p1(&(a)->x, ...)
-|
- atomic_long_dec_and_test@p1(&(a)->x)
-|
- atomic64_dec_and_test@p1(&(a)->x)
-|
- local_dec_and_test@p1(&(a)->x)
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
-msg = "atomic_dec_and_test variation before object free at line %s."
-coccilib.report.print_report(p1[0], msg % (p2[0].line))
-
 @r2 exists@
 identifier a, x;
 position p1;
-- 
2.18.0

