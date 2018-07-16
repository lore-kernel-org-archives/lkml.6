Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD6E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeGPSHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:07:47 -0400
Received: from mout.web.de ([212.227.17.12]:53729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeGPSHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:07:47 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M413W-1fx43W3nnu-00rWOr; Mon, 16
 Jul 2018 19:39:13 +0200
Subject: [PATCH v2 8/8] Coccinelle: atomic_as_refcounter: Use format string
 directly in the first SmPL rule
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
Message-ID: <0cfb32cf-2580-abee-b84c-40cf1ac78541@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ezgVSoFrqWr7Vu06y/k1+pMZcdruNwQeCnN6Uyp56YQeZDTmAXs
 LDIDORyNwnVtzjQ+VfUIlOKllj//kz8MMd9pOgEDWxol7IWSijv6U6sb5g62gqWcTysoCCH
 8gMd3K/LfEM9YkSmF/xFeMfeALKWc+WfGt7nk3t4EHCSV5BUlbdBZLUwVERnW4dk2TfFkTL
 ad5gNLqF7rxYTV2JZFGlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FYu3d5xqtgs=:QP2si8989GJQFaF5T3s/a5
 RfNH/Psi3JHyJyK+JEDBAfHB/6xTaZ6JtIaoQsnYxmQjEPb1GYB09pFYZn5nlxeZIOX1pAeNZ
 9bqU4n9eC74OK7CoOyl/ND09/RKbr8yZILCUT3yq/AUyTFFP5XSNKAGDTqcsZJ7SkTzCIPzCK
 fK9/rX5vqIG/zlmJFYImbPPNGRBpFpdYMHozFKK9dfMmnAV262+LXauuxxF4rNySxU+7tTZtK
 HiFdpkYaPwWbrakBkejMLQnBgVToONrBrOeAsbPybReN3DKqQ6r1czm3boXRpocX3Ko4PFQV3
 s/nbwmnGYMLDX3mlQSxjieX9UR1GcjuO/GFSzK5JDfGPiK2/zrfSDSwyOwb8yN4ZlTyGQC8ay
 CYOtszJQJZJ2/TWFhd80+VT6oeMvQgy2dpqdSonRVsqMa1iSWqMt0kQcwu1CvO1oTN6fgWAh1
 hkQLKvm3sO1jjd0bEw7sv84xuK3sUxYI8dQeWCD6pisFizwZ2flTD5+Nyi2wcqqBJr462ehWy
 vqJ5baAoWPMCmv748UAvLgqvYaJoapN2/sOKJqq37Xo1LneiSSzMb7TD/c2xuXdefY4vM+7//
 TGhYX20hS3IHPEWGCAMgJdaiUE6gqN6KCvSFjovCjmKkz2I6BHzboEjc2EAOGgmivGK4GXsc4
 YQanzCGDY9ryqiGaU5bfclUhcfhi44eIGh4iTYEfz2qSj3QsB/TQ9HId26ZMXYYKmoZCtAfvW
 QZTCSvAYllQf+YkwN8I7bJq+d37xvU6YzGceaLgouG96uPSrkTvZOxD4HJaTYoXyD1d9V3hXG
 0SHmyS1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 18:45:55 +0200

A format string was assigned to the Python variable “msg” before it was
used in a rule of a script for the semantic patch language.
Delete this extra variable so that the specified string object
is directly used for the desired data output.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index c9b838941024..c2b55a5babb0 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -40,8 +40,9 @@ identifier fname2 =~ "(?:call_rcu|de(?:l|stroy)|(?:queue|schedule)_work)";
 p1 << r1.p1;
 p2 << r1.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
-coccilib.report.print_report(p1[0], msg % (p2[0].line))
+coccilib.report.print_report(p1[0],
+                             "atomic_dec_and_test variation before object free at line %s."
+                             % (p2[0].line))
 
 @r2 exists@
 expression a;
-- 
2.18.0

