Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B7FC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47FF20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47FF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJEJYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:24:32 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:55698 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeJEJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:24:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g8FqK-0007Eq-64; Fri, 05 Oct 2018 10:27:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g8Fpk-00014j-PO; Fri, 05 Oct 2018 10:27:16 +0800
Date:   Fri, 5 Oct 2018 10:27:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matthias.bgg@gmail.com, Liam.Merwick@oracle.com,
        Jim.Quigley@oracle.com, linux-crypto@vger.kernel.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>, dgilbert@redhat.com
Subject: Re: [PATCH] hwrng: document the quality field
Message-ID: <20181005022716.ljqj3kkgu3osntia@gondor.apana.org.au>
References: <20180925162924.378725-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925162924.378725-1-mst@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:35:18PM -0400, Michael S. Tsirkin wrote:
> quality field is currently documented as being 'per mill'.  In fact the
> math involved is:
> 
>                 add_hwgenerator_randomness((void *)rng_fillbuf, rc,
>                                            rc * current_quality * 8 >> 10);
> 
> thus the actual definition is "bits of entropy per 1024 bits of input".
> 
> The current documentation seems to have confused multiple people
> in the past, let's fix the documentation to match code.
> 
> An alternative is to change core to match driver expectations, replacing
> 	rc * current_quality * 8 >> 10
> with
> 	rc * current_quality / 1000
> but that has performance costs, so probably isn't a good option.
> 
> Fixes: 0f734e6e768 ("hwrng: add per-device entropy derating")
> Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> 
>  drivers/char/hw_random/core.c | 4 ++--
>  include/linux/hw_random.h     | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
