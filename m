Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703C8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478272171F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393142AbeLWEBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:01:25 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:38944 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeLWEBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:01:25 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gauwx-0008HQ-3Y; Sun, 23 Dec 2018 12:01:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gauwm-0004n2-L9; Sun, 23 Dec 2018 12:01:00 +0800
Date:   Sun, 23 Dec 2018 12:01:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dave Watson <davejwatson@fb.com>
Cc:     Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 00/12] x86/crypto: gcmaes AVX scatter/gather support
Message-ID: <20181223040100.lemyilorwoc36kq5@gondor.apana.org.au>
References: <cover.1544471415.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:56:28PM +0000, Dave Watson wrote:
> This patch set refactors the x86 aes/gcm AVX crypto routines to
> support true scatter/gather by adding gcm_enc/dec_update methods.
> 
> It is similar to the previous SSE patchset starting at e1fd316f.  
> Unlike the SSE routines, the AVX routines did not support
> keysize 192 & 256, this patchset also adds support for those
> keysizes.
> 
> The final patch updates the C glue code, passing everything through
> the crypt_by_sg() function instead of the previous memcpy based
> routines.
> 
> Dave Watson (12):
>   x86/crypto: aesni: Merge GCM_ENC_DEC
>   x86/crypto: aesni: Introduce gcm_context_data
>   x86/crypto: aesni: Macro-ify func save/restore
>   x86/crypto: aesni: support 256 byte keys in avx asm
>   x86/crypto: aesni: Add GCM_COMPLETE macro
>   x86/crypto: aesni: Split AAD hash calculation to separate macro
>   x86/crypto: aesni: Merge avx precompute functions
>   x86/crypto: aesni: Fill in new context data structures
>   x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
>   x86/crypto: aesni: Introduce READ_PARTIAL_BLOCK macro
>   x86/crypto: aesni: Introduce partial block macro
>   x86/crypto: aesni: Add scatter/gather avx stubs, and use them in C
> 
>  arch/x86/crypto/aesni-intel_avx-x86_64.S | 2125 ++++++++++------------
>  arch/x86/crypto/aesni-intel_glue.c       |  353 ++--
>  2 files changed, 1117 insertions(+), 1361 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
