Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507022151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507022151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbeITCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:17:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60410 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbeITCRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:17:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g2jEg-0004D6-Gz; Wed, 19 Sep 2018 22:38:10 +0200
Message-ID: <1537389479.10305.94.camel@sipsolutions.net>
Subject: Re: [PATCH crypto-next 03/23] lib80211: Remove VLA usage of skcipher
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-wireless@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 19 Sep 2018 22:37:59 +0200
In-Reply-To: <20180919021100.3380-4-keescook@chromium.org> (sfid-20180919_041111_811472_0A3A2E21)
References: <20180919021100.3380-1-keescook@chromium.org>
         <20180919021100.3380-4-keescook@chromium.org>
         (sfid-20180919_041111_811472_0A3A2E21)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 19:10 -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
> with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
> which uses a fixed stack size.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 

I know this lib80211 stuff landed on my plate as the maintainer (and the
others are probably more or less copies thereof), but honestly I don't
even have a device I could test this on, and quite possibly never had
(after the old non-mac80211 b43 driver was killed.)

So basically I'll just trust you to be doing the right thing, since you
probably did the same transformation on other code that is better
tested...

johannes

