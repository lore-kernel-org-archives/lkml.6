Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeBAK11 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:27:27 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:6872 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751520AbeBAK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:27:23 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511823600";
   d="scan'208";a="311591428"
Date: Thu, 1 Feb 2018 11:27:19 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: cocci@systeme.lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: Coccinelle: zalloc-simple: Delete function "kmem_cache_alloc"
 from SmPL rules
In-Reply-To: <22276745-4723-4391-4460-07f0820ae85b@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802011125460.3135@hadrien>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com> <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net> <alpine.DEB.2.20.1802011040110.3135@hadrien> <22276745-4723-4391-4460-07f0820ae85b@users.sourceforge.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Feb 2018, SF Markus Elfring wrote:

> >> The function "kmem_cache_alloc" was specified despite of the technical
> >> detail that this function does not get a parameter passed which would
> >> correspond to such a size information.
> >>
> >> Thus remove it from the first two SmPL rules and omit the rule "r4".
> >
> > Nack.
>
> I find such a rejection surprising once more.
>
>
> > It should be supported by the size determined in another way.
>
> I am curious on how our different views could be clarified further
> for this special software situation.
>
> * Do we agree that a proper size determination is essential for every
>   condition in the discussed SmPL rules together with forwarding
>   this information?

No.  I don't mind a few false positives.  The user can look at the answer
and see if it is a false positive or not.

Furthermore, I told you how to address this function so that the size
issue would be taken care of.  That is the patch that I would accept.

>
> * How can a name be ever relevant (within the published SmPL approach)
>   for a function when it was designed in the way that it should generally
>   work without a size parameter?

No idea what this means.

julia
