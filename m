Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C08C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6F12245E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6F12245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbeKPQbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:31:04 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:37664 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:31:04 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gNXTz-00053z-Sf; Fri, 16 Nov 2018 14:19:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gNXTy-00021M-OI; Fri, 16 Nov 2018 14:19:58 +0800
Date:   Fri, 16 Nov 2018 14:19:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] crypto: ecc - regularize scalar for scalar
 multiplication
Message-ID: <20181116061958.yary7zcu5m3pnolb@gondor.apana.org.au>
References: <20181111174002.30929-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111174002.30929-1-vt@altlinux.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:40:02PM +0300, Vitaly Chikunov wrote:
> ecc_point_mult is supposed to be used with a regularized scalar,
> otherwise, it's possible to deduce the position of the top bit of the
> scalar with timing attack. This is important when the scalar is a
> private key.
> 
> ecc_point_mult is already using a regular algorithm (i.e. having an
> operation flow independent of the input scalar) but regularization step
> is not implemented.
> 
> Arrange scalar to always have fixed top bit by adding a multiple of the
> curve order (n).
> 
> References:
> The constant time regularization step is based on micro-ecc by Kenneth
> MacKay and also referenced in the literature (Bernstein, D. J., & Lange,
> T. (2017). Montgomery curves and the Montgomery ladder. (Cryptology
> ePrint Archive; Vol. 2017/293). s.l.: IACR. Chapter 4.6.2.)
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Cc: kernel-hardening@lists.openwall.com
> ---
> 
> Changes from v1:
> - No code changes, only description updates to be more informative.
> 
>  crypto/ecc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
