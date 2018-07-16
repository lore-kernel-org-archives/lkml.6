Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2121C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2121C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeGPSEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:04:11 -0400
Received: from mout.web.de ([212.227.17.11]:49553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbeGPSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:04:11 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 14:04:10 EDT
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdmyV-1gNprh21Vj-00j1vC; Mon, 16
 Jul 2018 19:30:30 +0200
Subject: =?UTF-8?Q?[PATCH_v2_4/8]_Coccinelle:_atomic=5fas=5frefcounter:_Use_?=
 =?UTF-8?Q?type_=e2=80=9cexpression=e2=80=9d_for_another_metavariable?=
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
Message-ID: <d9561774-a7ed-f9f8-796c-2ba2cb9f7732@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7lxRFp9yoiRPkmRz691KFqcvidMEO9oyKP8Lkt1SJIuI8ff5LRh
 PnF/Y1kat0v6luR7XU9OfYUytbZt9tfkCaj938qge/uKvxXqU7ZJ9QnRBsmRrbNW3BweNtr
 TVfJozw+BbRcFqR5u7v+MXhZbt52ayfjs2yCLcjy6KnhbpD2JQjcA/8jArBbpMGgJirpTmt
 xLsvdFy826DLlgXLMPzeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RlOhJkGDV2Q=:DR6JeESAO5s/7nOqvGQH5W
 sZejivGkaj8RTaStRROdx3annpmYrRQqVVYYfmg/SyU0Vel+YyFQNloGtwC4erCNFvO0pFM2l
 ynvr8so8VUEL5J2AMk8mSc1LDrssSNSRtUBILgZJPSM4TivS2T0d/GROTn0zOs54F/79tLACl
 qLi7ZZDcgRhoOWyaYfRXemj2WJr/J4TI7uIlvKegB7ASNe+XZtGrSP9H5YntEaArEHdAC0Wms
 S0i/L88xsSUeyShf6vEMw2SWcVgflpUW0vJWAGr9FSbiI9Z039GaFfK/lBRKoHPJY02TNCAeD
 4bl/5ICn7l2DTNq9AQxNlHlFD2PbeKtG2PqqLCWVR0pRQpdQ46SHxoqSN8NL/FCa8YuBBxqvU
 xl3ww8J8PvBlxtCLSsPQceodMwnnYpKNjGqVRewLses4MyjHPfaFvlVwIInzrNqMuFNaV8MP6
 TbGB7Ce/JKHUX6Ae2cAiFPXtSlmLuwPWDxLRQWy0Iz9kgDf6aEZPp+NadEof6LldJ4BeiD3RE
 VodKj22Uuz2OT9S3JsdUSjyTCeOlo8inTKl3jpbQDLrcRqFLG0LuxG4gR8TDwWkDj8Zs7lllx
 SK/cUKqtM1OV5M0xGxiCzQow4Jvlh6hKit8J9pZfZmgCWXdwFePaxaga3l2u4JyzaKMtIPJMj
 A4ZUO7yXPg6NsDHKRqRURYn1W11rcsOSF5aBT/Qx8GSger6IiEmB9qehLhTHIOLkQt0H51vFx
 vtPx+9a4uzBNIpwdbGJKirHzQu2mt8OjQBsmMqMzidXx9+JNzqiuEan4etFb76X2H2Z+Ih5Hs
 4j+hYhx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 18:00:54 +0200

The metavariable “a” is enclosed by parentheses in two rules of
a script for the semantic patch language.
Replace its type by “expression” so that the corresponding source code
search becomes more powerful.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 4da83ccfa6f6..62b0132d65fc 100644
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
 
 @r2 exists@
-identifier a, x;
+expression a;
+identifier x;
 position p1;
 @@
 
-- 
2.18.0

