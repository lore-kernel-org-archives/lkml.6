Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C102BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833B82086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833B82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeGCHk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:40:57 -0400
Received: from mout.web.de ([212.227.15.14]:58937 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbeGCHkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:40:55 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtmK-1fcUx13eKO-00X2jn; Tue, 03
 Jul 2018 09:40:43 +0200
Subject: =?UTF-8?Q?[PATCH_3/6]_Coccinelle:_atomic=5fas=5frefcounter:_Use_typ?=
 =?UTF-8?Q?e_=e2=80=9cexpression=e2=80=9d_for_another_metavariable?=
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
Message-ID: <c87de98e-9566-0bac-8264-8bc2a6e06d51@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:H7JSWUn6ue7iVEYOKeYIGvStTFLnps9gF8G3kKfgEC9egZE76KU
 znnVNLOWRI55XHT6rvxCWe0/mn77zh3/bThdD4+QBCVgVAxpbSzmFQiRTE2uOLVz6VITMti
 DhLVH1WAcnq9q9aQviVBWoJWy+C7nWwaF+bNfQp9cllPJUtvtwCq55ewES88WvKpyeeWotv
 zydi/VcRZYeuv/2VLeP1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:okEbuJBz/Bg=:Ff5QRBwnb9CG6vqkyX5g9K
 wsN5blu+7Tea/m9Korms+SL2+PfEomDwZ4V/2OX8/oFPjSbgV7z1Qz68cMEVTZ/Sbs0pexgwl
 UzvLZiyQvDg3pjIdMYhauOxxNimlnrdZukEKeD9R2oioRvLzolPdbETSFgcToefKX5P3Y3eD/
 hWbt6AfeH8irQvsGXhJvmy15RHpRgnaPEKLTW42y+qM4kv8jboV7ZSAox/FQ7sGyHMnIcfPBA
 vewnZA0EhH3HLcvxdSb4itmjfF5SbXUF54Q/Y7taiN6kkZpaUA6zAT0NT7FacN6bdzjT5TdLh
 YW0WKp0MweFWLez6xoTJANFFxWpoqxEzMypi+erm6blfkQeNc519qRYEeX8I5/epMrDJTZZiF
 9a950Tz4WGGlSy/Kxh4sC9h5bbIx353q+TNrtS23xJAvVbdkw6b3Hf424JnvQh9rphPgBxHEE
 haZtCpVdveIfuorYTpQ2VlBF9WQL3HkDa0Pl/PVznwHAEdje49xSl3TwoYtt/yXiP8pGV3sw+
 KnsDnX2Ofj/HPgSCzpQcTUz4yglL0+VF2REQ0wKZg/VoQBeiqtf/2i7jwvrKkfvh2iGei+QqH
 VEq9xf9jPOlbW9WoavFAEjy6B+dPeJaDtAfv7iLONwOzm8/2hHBAH4cA0IabE6uT2DdmZDKe2
 SDtQBtSoQ/UZZUUPYkEnAzcJW+UKowHXK/o3itsHCRMMB+YRTylT1+BjL4AYTxscDtf1sKdPy
 9R5Bnstnhf5IigyzLH3VvEcPP18sQ0Jn0TJ6rbufO0091I+54A6h7oWMbF7spAnHRTrs+Kkru
 8pwodhR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Jul 2018 17:55:27 +0200

The metavariable “a” is enclosed by parentheses in three rules of
a script for the semantic patch language.
Replace its type by “expression” so that the corresponding source code
search becomes more powerful.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 5571eea04c7b..57af2db9463e 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -10,7 +10,8 @@
 virtual report
 
 @r1 exists@
-identifier a, x;
+expression a;
+identifier x;
 position p1, p2;
 identifier fname =~ "free";
 identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
@@ -45,7 +46,8 @@ msg = "atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
 @r4 exists@
-identifier a, x, y;
+expression a;
+identifier x, y;
 position p1, p2;
 identifier fname =~ "free";
 @@
@@ -77,7 +79,8 @@ msg = "atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
 @r2 exists@
-identifier a, x;
+expression a;
+identifier x;
 position p1;
 @@
 
-- 
2.18.0

