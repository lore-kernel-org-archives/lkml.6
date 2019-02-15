Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7C206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfBOICm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:02:42 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:61873 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391063AbfBOICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:02:41 -0500
X-IronPort-AV: E=Sophos;i="5.58,372,1544482800"; 
   d="scan'208";a="369523313"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 09:02:18 +0100
Date:   Fri, 15 Feb 2019 09:02:18 +0100 (CET)
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
Subject: Re: [v4] coccinelle: semantic patch for missing put_device()
In-Reply-To: <f4bc7f71-efee-5e0f-3209-82681ddc85be@web.de>
Message-ID: <alpine.DEB.2.21.1902150900270.2896@hadrien>
References: <201902151452197117145@zte.com.cn> <alpine.DEB.2.21.1902150754380.2896@hadrien> <f4bc7f71-efee-5e0f-3209-82681ddc85be@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Feb 2019, Markus Elfring wrote:

> >> So I plan to modify the following to capture both cases:
> >> -local idexpression id;
> >> +expression id;
> >
> > I'm not sure that this is a good idea.
>
> Why have you got doubts here?
>
>
> > There is likely no need for a put in the latter case.
>
> I have got understanding difficulties for such information.
> What did you try to express with this sentence finally?

The whole goal of the semantic patch is to ensure that put_device is
called when needed.  If the value is stored in a structure, then someone
else will likely take care of calling put_device later when the structure
is destroyed.

julia
