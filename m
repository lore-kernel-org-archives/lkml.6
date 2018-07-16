Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A329ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC22208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC22208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeGPRz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:55:27 -0400
Received: from mout.web.de ([217.72.192.78]:56205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeGPRz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:55:27 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNeK-1fSzFC3Y8C-00TlPT; Mon, 16
 Jul 2018 19:26:54 +0200
Subject: [PATCH v2 2/8] Coccinelle: atomic_as_refcounter: Omit placeholder
 specifications from a SmPL constraint
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
Message-ID: <7f7e6a42-3ff1-2495-57df-fb3b09cc1a21@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:26:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sCg6NmCNwHSvSvA26jEhyFmvk/PUvxS4emnu6wpCVaPzSHycaD7
 XQLfd3qHFxZsyuU92L6eJruh7sUcGKeHEiih5VJktplyaw1v1uorcQieuidMfK1jZe+RSeh
 TLy+2fRbwlTQjn8oN4pQ0hlmT0vxsySAbTaWan/rqULD1caSqySxI+0dK4RgYuETFLqm0nH
 QMcs3qoxzSIcuXnMf2Dzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lG7LaQbtrXU=:pFiADWQ7kxGwBNATJePk13
 k7Q+gnjCHmHWJ5Kc86LPjhwiDEIQthpN0LM9QAM+BOWhc4a8+74IETmmrAsQSren4BSdR0ch9
 0FAx0AdxGUz4rZGfvVW3Y6s24cg7PWCKfHDtAc76K0SPmOIfZ6im9/wu8rBdfXDfo+DvQTwSk
 1EwbpBxoPo1gbL8oRHaYG8fnmCfrw/nRNxBZjzU/IA7lLXnU+HwL9h8DIVfuMENJpMr6nfz6S
 8wEfleq8iP84AwAZiMjCObfAYUJ4+HY2UNDu+vtdzuKN6+v+R6eOYL0DLAsrMMwHIY/P3aKGM
 rP5vxt8sjpyuuln7bx+tl/xTxRYvyoqr3b7uUL0pcTB42VSY4auHr5RKcae+7hA6MIhJifTYp
 6YZ/ELCtqhCl0hH4jXWTRWQ4ahil2IBIC04MOUTeJzU98XgTjRlkRbvDxVELd9xPBtu4lhBsb
 pzKrVwn5Kr1ufII7gW2u59YP79sCqVY6rCsfD7xClTCjwvQFgCrh6wys5B6+xCWpHijhTswm5
 2r2IOe1yee1VWoiPHQXUozEyBrSzZSB72wBpK90w3tEqcIxAC+Qc95+NeYUs8vqWViqg1/PLW
 6nUfhzhJHoUJD4hWsF8bJ8IUlVCwYiC8TjTzas73j2FPym7uxEBuJYbhfXqLEGZuwjrt4IB/Y
 6R3V4nM3hBNxCNASUD6Bkssa2vO8JtvnjR9gVQ6GFypwK3u287UnEvI8mUU0MM09YMzAp4bPb
 TTci/zlseU77l1IKeUlKVcR8N1mVLO7sJLkYmejhpM/6BKUoloVz1dbhk+m18Em2vzIGcQOjd
 0QxLibN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 17:34:56 +0200

A string was enclosed by placeholder specifications for
regular expressions as constraints for metavariables in a script
for the semantic patch language.
The desired search functionality can be achieved also without
the notation “.*”. Thus delete it at a specific place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 61fcaf5e45a3..46d27b2b1dff 100644
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
-- 
2.18.0

