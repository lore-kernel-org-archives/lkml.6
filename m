Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E392C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99EE2195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfBQMwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 07:52:31 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20978 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727534AbfBQMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 07:52:31 -0500
X-IronPort-AV: E=Sophos;i="5.58,380,1544482800"; 
   d="scan'208";a="369734265"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2019 13:52:28 +0100
Date:   Sun, 17 Feb 2019 13:52:28 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
In-Reply-To: <10836645-5b19-a748-56d7-c0572a76ab4d@web.de>
Message-ID: <alpine.DEB.2.21.1902171350500.2444@hadrien>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com> <8e7ba7c0-b7fe-a1f0-d28b-0c716ecbcfdb@web.de> <alpine.DEB.2.21.1902171235570.2444@hadrien> <1c152067-0135-79d7-1285-4bb9925054c8@web.de> <alpine.DEB.2.21.1902171246560.2444@hadrien>
 <782fd1c3-80ff-a296-b3a2-351257bb13b3@web.de> <alpine.DEB.2.21.1902171304520.2444@hadrien> <10836645-5b19-a748-56d7-c0572a76ab4d@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-712726055-1550407948=:2444"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-712726055-1550407948=:2444
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 17 Feb 2019, Markus Elfring wrote:

> >> If you would insist on the specification of such an assignment exclusion
> >> for a SmPL ellipsis:
> >> Can we agree on a correct order?
> >
> > I don't get your point.
>
> I propose to take another closer look at a bit of SmPL code.
>
>
> > There is no correct order.
>
> I have got an other software development view here.
>
>
> > Each order expresses something different.
>
> I agree to this information.
>
>
> > The order that is currently in the semantic patch is the one
> > that is more likely in practice.
>
> Please check once more.
>
> …
> +@search exists@
> +local idexpression id;
> +expression x,e,e1;
> +position p1,p2;
> …
> +@@
> +
> +id = of_find_device_by_node@p1(x)
> +... when != e = id
> …
>
> Or:
>
> …
> + ... when != id = e
> …
>
>
> Which SmPL specification will achieve the desired software behaviour?

The desired behavior is to check whether the allocated value is saved in
some other variable (typically a structure field) and thus it doesn't need
to be freed just because the original local variable goes out of scope at
the end of the function.  when != e = id achieves this behavior.

julia
--8323329-712726055-1550407948=:2444--
