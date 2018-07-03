Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D9421925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D9421925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeGCHgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:36:00 -0400
Received: from mout.web.de ([212.227.15.3]:48145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932098AbeGCHfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:35:36 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCNY9-1fR91a1PRx-009AQN; Tue, 03
 Jul 2018 09:35:27 +0200
Subject: [PATCH 1/6] Coccinelle: atomic_as_refcounter: Omit placeholder
 specifications from two SmPL constraints
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
Message-ID: <420481d3-0ec7-3990-30b3-0ef2118e5be8@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GgxJUwqfXaJ6RP5uSwVR8VwtElIf6r/oBIFXhRDyO5CW7wwf8iH
 /SsFSqVBcHSJfRVnaajhZmC1NPUn7q4bOGEl/PJNnsVGNnID8kvy8ZQaLUuY/OApRP8OzYm
 QmOjzTV3T9OY6QqaoOZlL93pjU7GkpdGvuEqU5zR97GqdCpLntU4AsmxTMB3J7hcoT+mvUl
 KNsPB8jjaVBPBh6sl3JTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lrijex5WGto=:OBUrH4ucMZyjso+H2ZYJkR
 V/pebeZ1sGYGUQNEtxXbjXRfPWjeIA3ZnQIHuKryW0pvPlXhtxFLRYNImsjY2JHdRGYoSDJJi
 JWiw584gNDC4GEjGcNIRJc9RNIh+BYYoFsf7/2dZTQ2In9N21ZvMJ/jozVCbpXCKAjIGHGG02
 PIw5HhLtWf7QBRph7VHlpR/BUKVBtDDkzvJrQHBYqio7rTSZWDLE2X/htnGn1wR+AB9rxHAke
 SfA5UDKggmoAonD/Ae4VPUqKR3+cUMiJzXoN8zOlN+CjCCY4GkE6HbMKKuyepEohOsG1tZCzt
 ywIAsgMtdZ8vOkkEWkh8tuOgSXmX/bApv+mPHHpYrRNpHa3WYBYtKYmalYclV3XqJ8iVSGwoP
 it1A0LfE6qYjkZ0mU4k+g71M8ImphSToAGZzrcm9zUIilmPBlVOd31EbP0a8Ml6syQvETGnm+
 rqR6320e9VpByvsXhU2Lqu7Idv4CLosLQJwyLujKidhFRvLcwFQsn6IZUs1Ws38gpm7OjHtut
 wMXmwjW9K+7xZECWmMJfeF6kCjC6TDKSb4ZIA+U5OZqlB8Tw8Ui6anjHW1/eEEnruRW1oA8kI
 XMgWrnRDKBOvBQnMYIh5zeS6dVko3nxzGVwskL6xvxcuPswapJesPfhRwalqPrawJ0NXEEjpp
 Fl94Pd812+ohzq0SZNEHi6amHiol057GiN5tUtT3qXB0DcZEcGYptCC9dgGUEYGEKVgxcFO38
 6DJHNEDnRTAho1ssgjXKIfO9cZ+Y1fTUnfVg2Q3rXgVKNUWkfb53sapeEDqLWCTgAEUrSTjYS
 rSOkd9i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Jul 2018 16:33:46 +0200

A string was enclosed by placeholder specifications for
regular expressions as constraints for metavariables in a script
for the semantic patch language.
The desired search functionality can be achieved also without
the notation “.*”. Thus delete it.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 988120e0fd67..94373a35744e 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -12,7 +12,7 @@ virtual report
 @r1 exists@
 identifier a, x;
 position p1, p2;
-identifier fname =~ ".*free.*";
+identifier fname =~ "free";
 identifier fname2 =~ ".*destroy.*";
 identifier fname3 =~ ".*del.*";
 identifier fname4 =~ ".*queue_work.*";
@@ -60,8 +60,7 @@ coccilib.report.print_report(p1[0], msg % (p2[0].line))
 @r4 exists@
 identifier a, x, y;
 position p1, p2;
-identifier fname =~ ".*free.*";
-
+identifier fname =~ "free";
 @@
 
 (
-- 
2.18.0

