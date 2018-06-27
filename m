Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52478C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF4325797
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="q5+KthBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF4325797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeF0GNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:13:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12025 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeF0GNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530080019;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TKA0lov+0qkCpigiYEaioyVRzla8NfFU/xUgWgnY6M4=;
        b=q5+KthBMjxrSXkX1fuQJkUkaitK1nQysASJCR6GZQ/+yEWRR9KCtDSaAUPKU0WZHbM
        C82vOiA8PUgg87W59rZhGOQhxxRfSzKgALxt3nefuUG6sDGAP4IkXukrnWMZ2TMqyija
        UUwM9XVBFuf9C9d8CW80gcaZSTV174Q9UcVM4GoKwPa2yW9mTDgZN7xREMD488jpCse5
        haqj1OwUYkBVb2w+yBzH2G+Wwekguq//+4Ob1HIcCjOtLqLbob1Kir6aeUbCnPrLCSKO
        cU69lCxD7sPLyYjzq9QOei/cX5Lh6hkNeZFO+Xoe5EYZ1mwWcvYgSzR3hLdRwulMvkQR
        MLPw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq/Tly14H1nAt7oghSPofJc0EJAN2fP8qsY44dqiWA=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.10 AUTH)
        with ESMTPSA id j06b90u5R6DYtWp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 27 Jun 2018 08:13:34 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vinod <vkoul@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Date:   Wed, 27 Jun 2018 08:13:34 +0200
Message-ID: <52764537.cSZCttAJ1I@tauon.chronox.de>
In-Reply-To: <20180627050853.GE22377@vkoul-mobl>
References: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au> <70ED61EB-BD3E-48D1-8B4D-D7835494C035@chronox.de> <20180627050853.GE22377@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. Juni 2018, 07:08:53 CEST schrieb Vinod:

Hi Vinod,

> Thanks for the pointers, it helped me to test the driver :)
> 
> I have two follow up question on crypto:
> 
>  - If there a way to avoid using a global variable in driver to hold the
>    pointer for driver memory? Looks like exynos driver does that.
> 
>    I understand that the crypto callback don't provide driver context as
>    they copy the data structures passed in registration API, but a simpler
>    way to get driver context would be desirable.

Sure the kernel crypto API can and has to maintain a per-instance data 
structure.

See the crypto/drbg.c for instance.

static int drbg_kcapi_random(struct crypto_rng *tfm,
                             const u8 *src, unsigned int slen,
                             u8 *dst, unsigned int dlen)
{
        struct drbg_state *drbg = crypto_rng_ctx(tfm);

static int drbg_kcapi_seed(struct crypto_rng *tfm,
                           const u8 *seed, unsigned int slen)
{
        struct drbg_state *drbg = crypto_rng_ctx(tfm);

The key is:

        alg->base.cra_ctxsize   = sizeof(struct drbg_state);

during initialization since the kernel crypto API allocates that buffer for 
you and releases it during deallocation.
> 
>  - .seed seems to be mandatory, if I do not set it and even use
>    .seedsize = 0, it panics at crypto_rng_reset(). So is .seed
>    mandatory?

Well, seedsize = 0 just says that the RNG is ready to use after initialization 
(i.e. it does not need to be seeded after initialization).

That does not preclude that a caller wants to reseed.

And yes, .seed must be set.
> 
> Thanks



Ciao
Stephan


