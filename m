Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF540208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF540208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeGPRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:50:44 -0400
Received: from mout.web.de ([212.227.17.12]:56197 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbeGPRuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:50:44 -0400
Received: from [192.168.1.3] ([77.191.164.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1g3QX73dxR-012IRF; Mon, 16
 Jul 2018 19:22:05 +0200
Subject: [PATCH v2 0/8] Coccinelle: atomic_as_refcounter: Adjustments for
 source code search specifications
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
Openpgp: preference=signencrypt
Message-ID: <5ca6ab58-e929-8468-74e2-012f987a0773@users.sourceforge.net>
Date:   Mon, 16 Jul 2018 19:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6043bdc9-529f-e93f-e509-e2dedd290a10@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OkckTojCntUt0qjXeJktqIGRxDYR9xYvWl9OvwoOJZfTVi9a477
 hRfRTYj5xtVMpKIrumXU+rcUmZyhlsZ8Etdzw1gRUrvkXqusZxungn9h2FjR4XaypMP2TOl
 tNOvFZH+aCLyZ+6EyZL53OE0arRVbBi4zk5vky5aDKJ4i2AZR1Mf8leuM6yy8mbCXfZrBYW
 BN3ov4M1cjy1+im8AeMdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oCxz+Xozkp8=:DGKW0yGRk2kqDg27MgDzhv
 bALrc76HFpF/IWwx7aCkEdr2jLcJ+fM292xiAtxLP4G0hocrSO1L62f4n1p1ur/5OfZqCYgnU
 NwE7SUVS/XARwjBBrbqKldm/qQ25jWC6Z+qUMglJqO7d99TKvwPjei1jClIYQLIWtefzlG34e
 HGk1uBqWOqzoRt56+MjqZbEdwHaRQ8bSGQkGLUgeqjR/8KDrU8gDE24sLzCW2bcZ+vmGYViVT
 TeTlbZjxrbot1+HjHeko1WbkJqCGafXUAOnUsG2LRK7ycx+MdhBMVapqpYSaeSa2gMWPz0w65
 pJ7USq02reQ654dIGUFU/bYGGg6/fNPLNjpitxNVd/UHe+EkIzPKxNeAMUmbcGpj9pilwR5CZ
 pKxnfMDIkD0970ts+kWNYROeLw967SV+AOy8XCJKj9y50hizhC3A5pg3QKl1FsbG5dzleZAJ2
 3ZjrnhpHKskyyzKmY5F70gC/93l8MM9a/+cjSn5R7oI5AsthTRNJlXUV86endPl8serhsV+C7
 FgmrFA6KZKje59GpvxAcHz7yZ8wncZPHzIMWhvemRPfVSGs1VeHXwmwjWKaqv5vN/zlY4njWp
 iVa8IrPxFZottjRlyFGrz43njFiIOslYXxbBcj0oTyksRq9uA/ujkWXEIihLgOHDbsntkcim7
 fp9PQU6mdtp7OP+sVfIUCLwgV2LlWUhMykp44qodgQyzI0dx8fo2+jXPk/rFrMQkE4W5jcj4K
 SKX41CL86y3XIkYWQk7DnElJTM/ypqz8fUTDZgxWdt5zErkyjGpsoTahhK21pB2gcvHrzjzmx
 5uTDPud
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Jul 2018 19:15:26 +0200

This source code search pattern was programmed in the way that
some implementation details could be improved further.
I suggest to avoid unnecessary code repetition also in this script
for the semantic patch language.

Markus Elfring (8):
  Delete an unnecessary SmPL rule
  Omit placeholder specifications from a SmPL constraint
  Optimise a disjunction in the first SmPL rule
  Use type “expression” for another metavariable
  Replace disjunction by a constraint in two SmPL rules
  Use nested disjunctions in the first SmPL rule
  Use string literals directly in two SmPL rules
  Use format string directly in the first SmPL rule

---

V2:
Possible changes were recombined after the deletion of a questionable
SmPL rule.

 .../coccinelle/api/atomic_as_refcounter.cocci | 108 ++++--------------
 1 file changed, 24 insertions(+), 84 deletions(-)

-- 
2.18.0

