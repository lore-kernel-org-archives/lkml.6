Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E3D21925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394934AbfBONYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:24:45 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28438 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfBONYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:24:44 -0500
X-IronPort-AV: E=Sophos;i="5.58,372,1544482800"; 
   d="scan'208";a="369582185"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 14:24:40 +0100
Date:   Fri, 15 Feb 2019 14:24:40 +0100 (CET)
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
In-Reply-To: <a35e9d4a-1166-c794-732e-3e7ec0063c77@web.de>
Message-ID: <alpine.DEB.2.20.1902151423370.3617@hadrien>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn> <94e4b3e6-87a4-aea2-dfef-44d308f0fb4f@web.de> <alpine.DEB.2.20.1902151400440.3617@hadrien> <a35e9d4a-1166-c794-732e-3e7ec0063c77@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-453697585-1550237080=:3617"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-453697585-1550237080=:3617
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 15 Feb 2019, Markus Elfring wrote:

> >>> +id = of_find_device_by_node@p1(x)
> …
> >>> +if (id == NULL || ...) { ... return ...; }
> >>> +... when != put_device(&id->dev)
> >> …
> >>> +    when != if (id) { ... put_device(&id->dev) ... }
> >> …
> >>
> >> I would interpret this SmPL code in the way that the if statement
> >> for the pointer check is “optional” in this line.
> >> Is it an extra and redundant SmPL specification when the reference
> >> release function could eventually be found just anywhere within
> >> an implementation?
> >
> > The proposed when code is correct.
>
> I agree that this SmPL code can work in the way it was designed.
>
>
> > It is not redundant, because it checks for a particular control-flow pattern.
>
> It took another moment until I dared to express a different software
> development opinion also on this implementation detail.
>
> Does the first SmPL when specification include the case that a call
> of the function “put_device” can occur within a branch of an if statement?

It does include that, but there is another execution path where the
put device is not present.  But given the test in the if in the when code,
on that execution path id is NULL, an so there is no need to put it.

julia
--8323329-453697585-1550237080=:3617--
