Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E3E21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E3E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeJQPPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:15:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40672 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeJQPPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:15:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1E03720DB5; Wed, 17 Oct 2018 09:20:44 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id DCFE0208F4;
        Wed, 17 Oct 2018 09:20:33 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:20:34 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: inside-secure: safexcel - fix memory allocation
Message-ID: <20181017072034.GD28572@kwain>
References: <20181008191712.GA12892@embeddedor.com>
 <CAGXu5j+a=81mGFrF5igMXe46mv_PsqzUKCzLWj0oCEMk1PY62g@mail.gmail.com>
 <9fa270bc-502d-5ff5-2acb-88ababcc9262@embeddedor.com>
 <20181017061741.qr23stkwqf36fet6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017061741.qr23stkwqf36fet6@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 17, 2018 at 02:17:41PM +0800, Herbert Xu wrote:
> On Tue, Oct 16, 2018 at 09:44:02PM +0200, Gustavo A. R. Silva wrote:
> > On 10/9/18 12:20 AM, Kees Cook wrote:
> > > On Mon, Oct 8, 2018 at 12:17 PM, Gustavo A. R. Silva
> > > <gustavo@embeddedor.com> wrote:
> > >> The original intention is to allocate space for EIP197_DEFAULT_RING_SIZE
> > >> *pointers* to struct, so sizeof(priv->ring[i].rdr_req) should be
> > >> sizeof(*priv->ring[i].rdr_req).
> > >>
> > >> Addresses-Coverity-ID: 1473962 ("Sizeof not portable")
> > >> Fixes: 9744fec95f06 ("crypto: inside-secure - remove request list to improve performance")
> > >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > 
> > 
> > 
> > Friendly ping. Who can take this?
> 
> Well I tried to take it but it doesn't apply against cryptodev.
> So I presume this can go into the tree that carried the change
> which it depended on?

I would say this should go in cryptodev. The issue is probably because
of other changes that got applied in the meantime. Gustavo can probably
rebase his patch on top of cryptodev, and re-send it.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
