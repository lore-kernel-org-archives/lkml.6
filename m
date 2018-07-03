Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF8FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE5121925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE5121925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeGCHh4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:37:56 -0400
Received: from mout.web.de ([212.227.15.4]:48929 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbeGCHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:37:52 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvS9z-1gHayN2aMF-010cEu; Tue, 03
 Jul 2018 09:37:40 +0200
Subject: [PATCH 2/6] Coccinelle: atomic_as_refcounter: Optimise a disjunction
 in the first SmPL rule
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
Message-ID: <a487edcd-8d53-be74-2034-3238fa7d4d68@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4/KHldn3JJOVodv0mTcsLcF0r+pNnUtzOQHg1OlQSG9pPwrh6ZR
 OmeSSQz6MOYD8LxRAzpkD76hJiCndCfTbx+sjMOJqIUaQCwn7F2G8Ui0aQ/PZXfsnqhGJi2
 qNUsCWYSY9FYfFAkUhTUGe2A+zZ8A7i9YD6sXsnGKv6eztFD7OPO1mc7X+/4z/LcMUip9i5
 2M/3DjSLxLFcIQAXFs2iQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jf6j+Rr+Nmk=:dwyhm49jZ0iVapM+88gX4O
 527E+MdxK01+c4AV1vwmi/vO31kUBTu5Cvoz8kLDyf0Pn9xCXDEmx5WcT3fB/KNOFezTLWbz3
 VkDBaDrHVhE0wwE5E82rDMTlN14FPiBQIqkPxsfjSYgXMxRXsYCKlXdvJqw0WMMtzEo1gKjtF
 ByekClO44pDg2ynlm2PUSfEmfOXzxF+uNRMQrPOS+xALAkNLnkeaL2Pxd7zAqj+FG1GafcVbM
 iIFe13fh1uxJFVOunDBlgKJ/+OYn66nYyW36QqFERiiWJRxQEyHeeBAYGB9jF/U9UrTV7U/fw
 nzcmUa6WN3zWUPzpYIOAQgM9dKmKA535aKSjigR3+WI8VxjacJJEMS/EIvjWeNROqd2U0EduU
 oBqg6c5S379tIEeKujXEajwto3SDPxq8gYM4toiWmt+WpWTyvq4WC54quLwy6OsEZb88GHvZF
 VFzRD3VfXJChtoJVcoe11EEph2vMPO0vQxyl6DfG7/hX85aQoTLqKDSIrsubUBOlOgMAhl4pM
 ZDbXpN8Zo4OBEq5DN2PAZp3mnM2Awu2ISnfhRILdtcIQ1mXqX5Itf/7DVWNmRF/Eenp1ldFjq
 xlDmBAcs1SaDpRMBetCKXTpW7UYet5pfhySzv4dJHhqo0ZmaXdfCFdKpfKKE1OvOJBlWywioF
 6XjMEwptASeUjzRYM24LmuvcCbTIVgYfAR2J2ix0PWYJeW6PLLL9/+OyZ/qIne6yu203XGLoc
 wg3NCs1Lkbk3EQksDm3cxytklRSmMV9i1z6d7kEBoZ8+NzVn71RJTS8SsFIMotpL/Z+xQzqmg
 P79yEwc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Jul 2018 17:14:01 +0200

The names “fname2” till “fname6” do not care for different function
parameters in the disjunction at the end of a rule in a script
for the semantic patch language.
Thus reduce this disjunction by using a regular expression with
an alternation for an optimised constraint.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 94373a35744e..5571eea04c7b 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -13,12 +13,7 @@ virtual report
 identifier a, x;
 position p1, p2;
 identifier fname =~ "free";
-identifier fname2 =~ ".*destroy.*";
-identifier fname3 =~ ".*del.*";
-identifier fname4 =~ ".*queue_work.*";
-identifier fname5 =~ ".*schedule_work.*";
-identifier fname6 =~ ".*call_rcu.*";
-
+identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 @@
 
 (
@@ -39,14 +34,6 @@ identifier fname6 =~ ".*call_rcu.*";
  fname@p2(a, ...);
 |
  fname2@p2(...);
-|
- fname3@p2(...);
-|
- fname4@p2(...);
-|
- fname5@p2(...);
-|
- fname6@p2(...);
 )
 
 
-- 
2.18.0

