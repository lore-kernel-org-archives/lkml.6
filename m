Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeBHN7I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:59:08 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64234
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeBHN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:59:06 -0500
X-IronPort-AV: E=Sophos;i="5.46,478,1511823600";
   d="scan'208";a="254083239"
Date: Thu, 8 Feb 2018 14:58:56 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Dan Carpenter <dan.carpenter@oracle.com>
cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/coccinelle/misc/shift.cocci: detect < or > that
 should be a shift
In-Reply-To: <20180208135350.e4yljburdpq7f5ny@mwanda>
Message-ID: <alpine.DEB.2.20.1802081457350.13345@hadrien>
References: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr> <20180208135350.e4yljburdpq7f5ny@mwanda>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2018, Dan Carpenter wrote:

> On Thu, Feb 08, 2018 at 01:53:54PM +0100, Julia Lawall wrote:
> > This checks for a comparison using < or > between two constants,
> > considering both explicit constants (1, 2, etc) and macros defined
> > with #define.  False positives are possible in the latter case, when
> > a macro may have multiple possible definitions and it is indeed
> > necessary to check the value.  There are currently two such false
> > positives, in drivers/net/ethernet/chelsio/cxgb3/sge.c:
> >
> >        q->fl[0].use_pages = FL0_PG_CHUNK_SIZE > 0;
> >        q->fl[1].use_pages = FL1_PG_CHUNK_SIZE > 0;
> >
>
> We could eliminate both these false postives by ignoring >> vs >.  Did
> searching for > actually find any bugs?  I think you were right that
> right shifting a constant is way less common than left shifting and I
> have some smatch scripts where I ignore right shifting bugs.
>
> On the other hand, two false positives are not a big deal.

I found no bugs with > at the moment.  I figured that the person could
have just as easily written 0 < FL0_PG_CHUNK_SIZE, so it was not worth
making a special case.  But if anyone wants me to drop the case id > cst,
then I can do that.

thanks,
julia
