Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F23C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D26208B4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="oeqvjrAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D26208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeGDQCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:02:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:32009 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeGDQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:02:30 -0400
X-Greylist: delayed 95643 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 12:02:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530720145;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mB4pAmMghSxnrZeovVb7zCicOmTH8rcry9VuO7p2MLI=;
        b=oeqvjrAhc2xLKgB1O16VEgNedfhu1j62/Ag/qfHc5aR1d9hZchNV8F73+x/fRX6dWw
        cwk+bbfLBcaQUdsvNRapjjEFTwK4XBGraCAeRyCjxq5Qwr1fTVqr4RIYjweosLygjXhj
        AwrJ5k294LOS1WXMNzCThFxJxMj9phsVtCtTe5vfdqP4FSrEy1WUe/YrYZhtLs0w0//1
        4JxUojk4vDKe4tHqjGtlAFQ9km22u4qOva2MnqbdA3002E3pA0xU0v7gnSoeGB4VhMyB
        sY5mixmocy3SZbn9uGFzidvegyRjxg3/x1GQQmHUkRDOMO4w2AJTV3r78lre9NKLR7nD
        p5wg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZWvq/+MyXt/DL7RMJdiLJGyP6DV1aaeuWHpp71U="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u64G2514U
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Jul 2018 18:02:05 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 3/6] crypto: Add Qcom prng driver
Date:   Wed, 04 Jul 2018 18:02:03 +0200
Message-ID: <19909549.EUeuX9KOs7@tauon.chronox.de>
In-Reply-To: <20180703060434.19293-4-vkoul@kernel.org>
References: <20180703060434.19293-1-vkoul@kernel.org> <20180703060434.19293-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. Juli 2018, 08:04:31 CEST schrieb Vinod Koul:

Hi Vinod,

> +static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
> +			 unsigned int slen)
> +{
> +	return 0;
> +}

One more question: is it not possible to mix in data into the DRNG? I thought 
it would be possible with the Qualcomm DRBG.

Note, I am asking because of my /dev/random drop-in-replacement 
implementation, any RNG from the kernel crypto API can be configured to be 
used as an output DRNG. Though, this will only work if the DRNG also accepts 
seed from the software noise sources.

Ciao
Stephan


