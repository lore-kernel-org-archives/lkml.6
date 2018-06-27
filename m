Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3323D46
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA5+3VpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA3323D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeF0FJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbeF0FJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:09:02 -0400
Received: from localhost (unknown [106.201.61.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7041D23D46;
        Wed, 27 Jun 2018 05:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530076142;
        bh=PsakGYhj+FA1uDUkufZQhvSccmhBjIZTKSCH2HEsXRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA5+3VpMkgjU+VaiIMziXrlEaN5+a3Apnwn3WBBkIfdCzZVkQm/zwkb3Xrqdmffek
         n51rTbGALGoJfNy/fj/yHp0Zjn7F0ueAaMb8X85DbMwV/2A4kA6Q3VPxMbhLLdMk7F
         NprZgLeRNjXgC6uRqFPy9xAEDbZPM2gZqevDzctE=
Date:   Wed, 27 Jun 2018 10:38:53 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180627050853.GE22377@vkoul-mobl>
References: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
 <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
 <6782b1c0-ea94-b07c-2fae-3fe3223bb22a@linaro.org>
 <20180622143829.rd2ys6ci7q3aupst@gondor.apana.org.au>
 <20180622144809.GP27187@vkoul-mobl>
 <20180622145047.dqyxwptttivaca2s@gondor.apana.org.au>
 <70ED61EB-BD3E-48D1-8B4D-D7835494C035@chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ED61EB-BD3E-48D1-8B4D-D7835494C035@chronox.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-18, 19:57, Stephan Mueller wrote:
> Hi
> 
> 
> > Am 22.06.2018 um 16:50 schrieb Herbert Xu <herbert@gondor.apana.org.au>:
> > 
> >> On Fri, Jun 22, 2018 at 08:18:09PM +0530, Vinod wrote:
> >> 
> >> Okay I am doing the port taking the exynos-rng as a ref.
> >> Question is how to test it, how is one supposed to exercise the rng, any
> >> test utils/apps for that? Sorry for noob question, new to crypto
> >> interfaces.
> > 
> > algif_rng is available through the af_alg socket interface.
> > 
> You can use the libkcapi library at http://www.chronox.de/libkcapi.html
> 
> The RNG API is documented at http://chronox.de/libkcapi/html/ch03s15.html and http://chronox.de/libkcapi/html/ch03s16.html
> 
> A command line app is also present with kcapi-rng as documented at https://github.com/smuellerDD/libkcapi/blob/master/README.md

Thanks for the pointers, it helped me to test the driver :)

I have two follow up question on crypto:

 - If there a way to avoid using a global variable in driver to hold the
   pointer for driver memory? Looks like exynos driver does that.

   I understand that the crypto callback don't provide driver context as
   they copy the data structures passed in registration API, but a simpler
   way to get driver context would be desirable.

 - .seed seems to be mandatory, if I do not set it and even use
   .seedsize = 0, it panics at crypto_rng_reset(). So is .seed
   mandatory?

Thanks
-- 
~Vinod
