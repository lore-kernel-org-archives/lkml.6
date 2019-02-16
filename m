Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579EAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28943222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfBPIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:32:28 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41909
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730494AbfBPIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:32:27 -0500
X-IronPort-AV: E=Sophos;i="5.58,376,1544482800"; 
   d="scan'208";a="296376296"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:32:25 +0100
Date:   Sat, 16 Feb 2019 09:32:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [v5] Coccinelle: semantic code search for missing put_device()
In-Reply-To: <6a07c337-533c-61c2-d033-575539309738@web.de>
Message-ID: <alpine.DEB.2.21.1902160931540.3212@hadrien>
References: <201902161529041506841@zte.com.cn> <alpine.DEB.2.21.1902160908150.3212@hadrien> <6a07c337-533c-61c2-d033-575539309738@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1848019999-1550305945=:3212"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1848019999-1550305945=:3212
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 16 Feb 2019, Markus Elfring wrote:

> >> We will modify the the if in the when code like this:
> >>
> >> @@ -22,7 +22,7 @@ if (id == NULL || ...) { ... return ...; }
> >>  ... when != put_device(&id->dev)
> …
> >> -    when != if (id) { ... put_device(&id->dev) ... }
> >> +    when != if (...) { ... put_device(&id->dev) ... }
> >
> > This looks ok.
>
> I have got another different software development opinion also for
> such SmPL code in the adjusted line.
> I find this specific source code search variant irrelevant
> because the shown reference release function should be found
> by the first SmPL when specification already.
> Would you like to determine generally if the desired function call
> is present at all?
>
> Thus I do not see a need (or requirement) for a duplicate search attempt.

Why don't you actually try it and see what the difference is rather than
repeatedly giving false information?

julia
--8323329-1848019999-1550305945=:3212--
