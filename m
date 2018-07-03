Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE872C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E40208A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E40208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbeGCHbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:31:05 -0400
Received: from mout.web.de ([212.227.15.14]:33337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753831AbeGCHbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:31:04 -0400
Received: from [192.168.1.3] ([92.228.103.75]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYw31-1fdsYF2o31-00VkHH; Tue, 03
 Jul 2018 09:30:48 +0200
To:     Elena Reshetova <elena.reshetova@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org
References: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
Subject: [PATCH 0/6] Coccinelle: atomic_as_refcounter: Improvements for source
 code search specifications
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Date:   Tue, 3 Jul 2018 09:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NixHgcJO41MhS0ho1v6Xrx3OjQhLcR7vgN+JXg1TLGIwa9vUoVR
 ELzX/oaj9edLLWU90TtcUM4gUgbupq2/MWB1c3DRZVG25wWUnqYrkCjejblJA0seluJk5YD
 U+PSMsSG/hYVNDJKT7o8DP9GhexScrT2Nr+HFNADhQ0eG82kPXY/A0mIq/mbsbzEqPyk7ij
 DyFOB5BNk5z7WaSoEiEig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KpmuBE4+bL0=:C3HBI9dpwleE7huiZisPHv
 jBvWcAm+shxxIqNnay25ecPq8p2H6dFHvhx7oFyFwdt+9Hnn5WUDbdtP23NcphLhICWSpAM5K
 446UODPwaeCACXuOa32PyiowJjBYiqnnHbjc9wCHrCnJwj/jrbbdIC+MxhqRe2gmmRi46RO9A
 Kg0JmxLBSWI/fN9UZIR1nZID5LuISqhdVzC+/ULzGH51KbQDBeo7ZRDIqyB1eOlADrWRBUsYP
 qR8NwiFbtbmvc91KvvpmF+3zo6LkaLVofmLiSmK6cDebdZFsq1G57B9Bs0lIJuM3j72mfu1E/
 0MiiWwJCwTC43CTtX2XPlHAT/aEor1P4X+Wuf09p4XOJ49P/KYFvxzEgEzIaMPXjFnhhYEuBO
 SD94/PjbI9DUBI0nrs1+ytcF0MS3cInGnXt2qKEorQDoSD25wOUlhuN3QWqAdOJ7Yj8J+ul2f
 90/wZmdcgpqO3WvEX8pxXZZYX0od7kUFmqSI6X/MGbDn3pY+gHztqp61wt26htM9A2Y9soGq0
 fGzos7ZYxxZ1A5tsobuuEL6U9mkcnb08vLFWAM81U3j/nESDcGhGIB5YgxBbL4su3KiOV7xWC
 QOdgOsSwujRNaYPjmFjAOsnSXs2qAxbdcKk/XlJ7vX4iT/Q45ncQP+IhW5IYZNh3QBK2OWzp3
 6cw716BJ1q/yW/Jh2v9glDyxQnBolzMkLSKP+a3m4Gd801Ulh1GYDiUQ+eUHdretzIyINU4zy
 C2x86uucXrAgMbueYMaFEs/y96UD3hezYiNcrxUR/pRPpiDmj9Q0YtJxdFBMYPO2ztLgiVCGM
 MFAPS6+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Jul 2018 09:15:26 +0200

This source code search pattern was programmed in the way that
some implementation details could be improved further.
I suggest to avoid unnecessary code repetition also in this script
for the semantic patch language.

Markus Elfring (6):
  Omit placeholder specifications from two SmPL constraints
  Optimise a disjunction in the first SmPL rule
  Use type “expression” for another metavariable
  Replace disjunction by a constraint in two SmPL rules
  Use nested disjunctions in two SmPL rules
  Use format strings directly in SmPL rules

 .../coccinelle/api/atomic_as_refcounter.cocci | 104 +++++++-----------
 1 file changed, 39 insertions(+), 65 deletions(-)

-- 
2.18.0

