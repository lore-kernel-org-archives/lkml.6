Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4AD2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4AD2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJLNyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:54:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53884 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:54:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gAqqu-0005mX-Os; Fri, 12 Oct 2018 14:23:12 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gAqqs-0005Le-GA; Fri, 12 Oct 2018 14:23:10 +0800
Date:   Fri, 12 Oct 2018 14:23:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Michael Schupikov <michael@schupikov.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/testmgr.c: fix sizeof() on COMP_BUF_SIZE
Message-ID: <20181012062310.4z2porvtpib5imfn@gondor.apana.org.au>
References: <20181007115810.27779-1-michael@schupikov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007115810.27779-1-michael@schupikov.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 01:58:10PM +0200, Michael Schupikov wrote:
> After allocation, output and decomp_output both point to memory chunks of
> size COMP_BUF_SIZE. Then, only the first bytes are zeroed out using
> sizeof(COMP_BUF_SIZE) as parameter to memset(), because
> sizeof(COMP_BUF_SIZE) provides the size of the constant and not the size of
> allocated memory.
> 
> Instead, the whole allocated memory is meant to be zeroed out. Use
> COMP_BUF_SIZE as parameter to memset() directly in order to accomplish
> this.
> 
> Fixes: 336073840a872 ("crypto: testmgr - Allow different compression results")
> 
> Signed-off-by: Michael Schupikov <michael@schupikov.de>
> ---
>  crypto/testmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
