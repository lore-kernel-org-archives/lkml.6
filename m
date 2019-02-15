Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A095C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011082192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfBOGzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:55:17 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55618 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbfBOGzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:55:17 -0500
X-IronPort-AV: E=Sophos;i="5.58,371,1544482800"; 
   d="scan'208";a="369514453"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 07:55:14 +0100
Date:   Fri, 15 Feb 2019 07:55:14 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     julia.lawall@lip6.fr, markus.elfring@web.de, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        wang.yi59@zte.com.cn, yamada.masahiro@socionext.com,
        yellowriver2010@hotmail.com, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: semantic patch for missing put_device()
In-Reply-To: <201902151452197117145@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902150754380.2896@hadrien>
References: 1550126293-27839-1-git-send-email-wen.yang99@zte.com.cn,201902151422261425412@zte.com.cn,alpine.DEB.2.21.1902150723110.2896@hadrien <201902151452197117145@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Feb 2019, wen.yang99@zte.com.cn wrote:

> Hi Julia, thank you very much.
>
> > > >> In a function, for variables returned by calling of_find_device_by_node(),
> > > > Do variables really get returned?
> > > > The provided pointer should usually be stored somewhere.
> > >
> > > Thank you very much, we will consider this situation and submit a next version to fix it.
> >
> > I don't know what Markus is talking about here, so I'm not sure that a
> > change is needed.
>
> I think Markus means that we need to deal with two situations:
> 1,  The return value of of_find_device_by_node () is assigned to a variable, such as:
> pdev = of_find_device_by_node(np);
> 2,  The return value of of_find_device_by_node() is assigned to a variable in a structure, such as:
> dev->pdev = of_find_device_by_node(args.np);
>
> So I plan to modify the following to capture both cases:
> -local idexpression id;
> +expression id;

I'm not sure that this is a good idea.  There is likely no need for a put
in the latter case.

julia

> ...
> id = of_find_device_by_node@p1(x)
>
> > > >> + "ERROR: missing put_device;"
> > > >Will change confidence considerations result in another fine-tuning for this message?
> > >
> > > Thank you, we will change "ERROR" to "WARNING".
> >
> > I think ERROR is fine. If it is a real positive than it is a real
> > problem. Warning is for things that look ugly, but don't have any impact
> > on the execution.
>
> OK, I will keep it.
> Thanks.
>
> Regards,
> Wen
