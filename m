Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8271C64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9692B2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9692B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJEJ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 05:28:29 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:55752 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJEJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 05:28:29 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g8FuF-0007L2-Tv; Fri, 05 Oct 2018 10:31:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g8FuD-000173-LW; Fri, 05 Oct 2018 10:31:53 +0800
Date:   Fri, 5 Oct 2018 10:31:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srikanth Jampala <Jampala.Srikanth@cavium.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgadam@cavium.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH cryptodev-2.6 1/4] crypto: cavium/nitrox - fix warnings
 while printing atomic64_t types
Message-ID: <20181005023153.67kvuohxnrtc4frl@gondor.apana.org.au>
References: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 01:49:07PM +0530, Srikanth Jampala wrote:
> fix compilation warnings with nitrox_debugfs.c while printing
> atomic64_t types on arm64. typecast the atomic64_read() value to u64
> 
> This issue is reported by Ard Biesheuvel
> 
> drivers/crypto/cavium/nitrox/nitrox_debugfs.c:62:30:
> warning: format ‘%lld’ expects argument of type ‘long long int’,
>          but argument 3 has type ‘long int’ [-Wformat=]
>   seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
>                               ^
> Fixes: 2a8780be9c26 (crypto: cavium/nitrox - updated debugfs information)
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
> Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_debugfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
