Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C922417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0+ta6QN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C922417D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeGEGB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbeGEGBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:01:23 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F592417D;
        Thu,  5 Jul 2018 06:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530770482;
        bh=gFJaGH6cBrJHX8uajhXZVxA/sy7ZT8chrMNIjP7Zkec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0+ta6QN6ooOSSODju+9rpNrHxjKihj7xNXYCncaXJkGpL9wrYB5xqWgfKVjcBymn
         3KO+zuGlD/MZF7O1hrDAoRLGEWiwsjGhHJ54AlXZ/8cENEo3V+4HDAgqKxZAdTLy2c
         93mtaQWqf2WsHIK5tmDLm/YljdLp38APdkwnMak8=
Date:   Thu, 5 Jul 2018 11:31:14 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 3/6] crypto: Add Qcom prng driver
Message-ID: <20180705060114.GG22377@vkoul-mobl>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-4-vkoul@kernel.org>
 <19909549.EUeuX9KOs7@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19909549.EUeuX9KOs7@tauon.chronox.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 04-07-18, 18:02, Stephan Mueller wrote:
> Am Dienstag, 3. Juli 2018, 08:04:31 CEST schrieb Vinod Koul:
> > +static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
> > +			 unsigned int slen)
> > +{
> > +	return 0;
> > +}
> 
> One more question: is it not possible to mix in data into the DRNG? I thought 
> it would be possible with the Qualcomm DRBG.
> 
> Note, I am asking because of my /dev/random drop-in-replacement 
> implementation, any RNG from the kernel crypto API can be configured to be 
> used as an output DRNG. Though, this will only work if the DRNG also accepts 
> seed from the software noise sources.

The v1 hardware supports seeding but the register is Read Only for SW and
only trusted zone (firmware) can write.

v2 hardware slice does not have seeding. v2 seeding is not accessible to
SW.

So in short, it is not available for us to use :(

-- 
~Vinod
