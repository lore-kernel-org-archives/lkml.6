Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48042147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfBRGna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:43:30 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46551
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbfBRGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:43:30 -0500
X-IronPort-AV: E=Sophos;i="5.58,383,1544482800"; 
   d="scan'208";a="296474504"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 07:43:26 +0100
Date:   Mon, 18 Feb 2019 07:43:26 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, yellowriver2010@hotmail.com,
        Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        cheng.shengyu@zte.com.cn, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
In-Reply-To: <201902181122502228026@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902180740550.3111@hadrien>
References: HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com,52c07e7c-eec7-792b-0b03-b5cb46ddeab3@web.de <201902181122502228026@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2117660207-1550472207=:3111"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2117660207-1550472207=:3111
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 18 Feb 2019, wen.yang99@zte.com.cn wrote:

> > > when != e = id achieves this behavior.
> >
> > I can not agree to this view completely because of the meaning that is connected
> > with these variable identifiers.
> >
> > Both metavariables share the kind “expression”. So I can imagine
> > that there is an intersection for the source code match possibility.
> > But one was intentionally restricted to the kind “local idexpression” so far.
> >
> > Which data element should not get reassigned here (before a corresponding
> > null pointer check)?
> >
>
> Thank you for your comments.
> We did some experiments:
> +id = of_find_device_by_node@p1(x)
> +... when != e = id
> ...
> Or:
> ...
> + ... when != id = e
>
> The number of issuses found by these two methods is the same.
> When != e = id achieves this behavior.

They are the same because neither issue arises.  I would have a hard time
saying which one is more reasonable to test, since both are extremely
unlikely.

julia


>
> In addition, we feel that we should probably accept this patch first, use it to find more memory leaks, and solve the actual problems in the kernel code.
> As for the patch itself, we can continue to pursue perfect in the process of using it to solve practical problems.
>
> Regards,
> Wen
--8323329-2117660207-1550472207=:3111--
