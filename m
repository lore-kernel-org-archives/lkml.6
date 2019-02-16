Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FEEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D5222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfBPIeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:34:12 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42032
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfBPIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:34:12 -0500
X-IronPort-AV: E=Sophos;i="5.58,376,1544482800"; 
   d="scan'208";a="296376402"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:34:09 +0100
Date:   Sat, 16 Feb 2019 09:34:08 +0100 (CET)
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
Subject: Re: [v5] coccinelle: semantic code search for missingput_device()
In-Reply-To: <10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de>
Message-ID: <alpine.DEB.2.21.1902160933350.3212@hadrien>
References: <201902161504357846572@zte.com.cn> <10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1058747191-1550306049=:3212"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1058747191-1550306049=:3212
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 16 Feb 2019, Markus Elfring wrote:

> > Thanks, We will change it to something like this:
> > In a function, for a local variable obtained by of_find_device_by_node()
>
> How do you think about another wording approach?
>
> 1. Precondition:
>    It will be checked where the return value is stored from
>    a call of the function “of_find_device_by_node”.
>
> 2. The source code search will be continued with …
>
>
> > Thank you, but a local variable is necessary.
>
> Would you like to take additional storage possibilities for a safer
> analysis approach into account?
>
> Is the restriction “local” really sufficient when such a pointer
> could be copied to other variables?

I've lost track of the original semantic patch, but perhaps it needs a

when != e1 = e

julia

>
>
> >> Can it happen that on other function will perform the desired reference release?
> >
> > Thanks.
> > Because the information of this local variable is not passed to the external function,
> > this situation does not exist.
>
> Will copied pointers matter here?
>
>
> > But it's over 80 characters.
>
> Long string literals can be accepted because of error message search concerns
> around a tool like “grep”.
>
>
> >> Will any more advanced error diagnostics be eventually developed?
> >
> > Hello, we are just doing the practical work in this field.
>
> Are you aware of additional software design options from computer science
> and existing analysis tools?
>
>
> > We also hope that it can support cross-function/cross-file/data stream analysis
> > and other functions.
>
> This functionality will need further clarification.
>
>
> > We are also analyzing the principle and code implementation of coccinelle,
> > hoping to contribute a little.
>
> I am curious on how this situation will evolve further.
>
> Regards,
> Markus
>
--8323329-1058747191-1550306049=:3212--
