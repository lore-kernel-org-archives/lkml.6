Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0B52192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfBQLsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 06:48:04 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:21655 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbfBQLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 06:48:04 -0500
X-IronPort-AV: E=Sophos;i="5.58,380,1544482800"; 
   d="scan'208";a="369731760"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2019 12:48:02 +0100
Date:   Sun, 17 Feb 2019 12:48:02 +0100 (CET)
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
Subject: Re: [PATCH v6] coccinelle: semantic code search for missing
 put_device()
In-Reply-To: <1c152067-0135-79d7-1285-4bb9925054c8@web.de>
Message-ID: <alpine.DEB.2.21.1902171246560.2444@hadrien>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com> <8e7ba7c0-b7fe-a1f0-d28b-0c716ecbcfdb@web.de> <alpine.DEB.2.21.1902171235570.2444@hadrien> <1c152067-0135-79d7-1285-4bb9925054c8@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Feb 2019, Markus Elfring wrote:

> >>> +@search exists@
> >>> +local idexpression id;
> >>> +expression x,e,e1;
> >>> +position p1,p2;
> >>> +type T,T1,T2;
> >>> +@@
> >>> +
> >>> +id = of_find_device_by_node@p1(x)
> >>> +... when != e = id
> >>
> >> I suggest to increase your software development attention also for
> >> another implementation detail.
> >> Source code analysis triggers challenges for safe data flow handling.
> >> the semantic patch language supports search specifications for
> >> the exclusion of specific assignments.
> >>
> >> Does this SmPL code contain a questionable order for the source
> >> and target metavariables?
> >> Can the following variant be more appropriate?
> >>
> >> + ... when != id = e
> >
> > This is possible, but I think unlikely.
>
> Would you dare to interpret my update suggestion (reordering of two identifiers)
> as a required SmPL script correction?

I didn't suggest to reorder anything.  Both are needed.

And, no I don't consider it to be a required suggestion.  In practice,
reassigning such a variable is very unlikely.

julia
