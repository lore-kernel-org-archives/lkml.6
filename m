Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015BCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C632505D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C632505D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeGANTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 09:19:17 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53704 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeGANTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 09:19:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fZcFz-0003XC-D3; Sun, 01 Jul 2018 21:19:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fZcFw-0008Ad-47; Sun, 01 Jul 2018 21:19:08 +0800
Date:   Sun, 1 Jul 2018 21:19:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     efremov@linux.com
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] crypto: skcipher: remove the exporting of
 skcipher_walk_next
Message-ID: <20180701131908.jl5kg6gosrvkmc4p@gondor.apana.org.au>
References: <20180617174959.29864-1-efremov@linux.com>
 <20180619202357.10805-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619202357.10805-1-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:23:57PM +0300, efremov@linux.com wrote:
> The function skcipher_walk_next declared as static and marked as
> EXPORT_SYMBOL_GPL. It's a bit confusing for internal function to be
> exported. The area of visibility for such function is its .c file
> and all other modules. Other *.c files of the same module can't use it,
> despite all other modules can. Relying on the fact that this is the
> internal function and it's not a crucial part of the API, the patch
> just removes the EXPORT_SYMBOL_GPL marking of skcipher_walk_next.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
