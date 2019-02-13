Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD324C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDA9222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbfBMTwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:52:23 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:14249 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfBMTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:52:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,366,1544482800"; 
   d="scan'208";a="369313067"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 20:52:21 +0100
Date:   Wed, 13 Feb 2019 20:52:21 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [PATCH v3] Coccinelle: semantic patch for missing put_device()
In-Reply-To: <c10e0bf1-4830-7ee4-5b21-70b521dd6c36@web.de>
Message-ID: <alpine.DEB.2.21.1902132050200.2655@hadrien>
References: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn> <c10e0bf1-4830-7ee4-5b21-70b521dd6c36@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2019, Markus Elfring wrote:

> > The of_find_device_by_node() takes a reference to the underlying device
> > structure, we should release that reference.
>
> I have got another concern for further software development considerations.
>
> How do you think about to describe here if it can be determined
> by source code analysis that the desired release should be performed
> only in the same function implementation (or not)?
>
> How much does this aspect influence the source code search confidence?
>
>
> > +    when != e1 = (T)id
> > +    when != e2 = &id->dev
> > +    when != e3 = get_device(&id->dev)
> > +    when != e4 = (T1)platform_get_drvdata(id)
>
> I have got another idea for a bit of software fine-tuning at such a place.
> I am unsure if it can become relevant to reduce the number of metavariables
> here by introducing a SmPL disjunction.
>
> +    when != ex = \( (T)id \| &id->dev \| get_device(&id->dev) \| (T1)platform_get_drvdata(id) \)

There is no need for the disjunction.  There is also no need for the
different variables.  Different variables are only needed when the when
conditions are on different ...s

julia

>
>
> Regards,
> Markus
>
