Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94393C5ACCD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FB92150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FB92150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJQOPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:15:19 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:37446 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeJQOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:15:18 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gCf9U-0001rD-65; Wed, 17 Oct 2018 14:17:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gCf9J-0002HD-Ub; Wed, 17 Oct 2018 14:17:41 +0800
Date:   Wed, 17 Oct 2018 14:17:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: inside-secure: safexcel - fix memory allocation
Message-ID: <20181017061741.qr23stkwqf36fet6@gondor.apana.org.au>
References: <20181008191712.GA12892@embeddedor.com>
 <CAGXu5j+a=81mGFrF5igMXe46mv_PsqzUKCzLWj0oCEMk1PY62g@mail.gmail.com>
 <9fa270bc-502d-5ff5-2acb-88ababcc9262@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa270bc-502d-5ff5-2acb-88ababcc9262@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:44:02PM +0200, Gustavo A. R. Silva wrote:
> Hi all,
> 
> On 10/9/18 12:20 AM, Kees Cook wrote:
> > On Mon, Oct 8, 2018 at 12:17 PM, Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >> The original intention is to allocate space for EIP197_DEFAULT_RING_SIZE
> >> *pointers* to struct, so sizeof(priv->ring[i].rdr_req) should be
> >> sizeof(*priv->ring[i].rdr_req).
> >>
> >> Addresses-Coverity-ID: 1473962 ("Sizeof not portable")
> >> Fixes: 9744fec95f06 ("crypto: inside-secure - remove request list to improve performance")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> 
> Friendly ping. Who can take this?

Well I tried to take it but it doesn't apply against cryptodev.
So I presume this can go into the tree that carried the change
which it depended on?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
