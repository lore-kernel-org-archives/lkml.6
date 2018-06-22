Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DDCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE692243F0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0hgA+Jiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE692243F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933509AbeFVOsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933346AbeFVOsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:48:19 -0400
Received: from localhost (unknown [122.167.114.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49A0243F2;
        Fri, 22 Jun 2018 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529678899;
        bh=6RqULXZCZPYi8z0UAneSVN/jEZJ0QySdDupELNKY4uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hgA+JiyYnZSxzNxTJjWUmydrjh6cKbi8OcvOmMDKtpa1ASY1ohZYAGbdNXrwjFON
         C0e/0oBiCQNqxSzK8PgaVHCXuSnb5qwVR+CiY2F9CoYAzCatysFtFCuHBySaWdkdoZ
         e8oHO/HGiKefKfysN3qvm73N7ykTBYIfCdO5z4CU=
Date:   Fri, 22 Jun 2018 20:18:09 +0530
From:   Vinod <vkoul@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180622144809.GP27187@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
 <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
 <6782b1c0-ea94-b07c-2fae-3fe3223bb22a@linaro.org>
 <20180622143829.rd2ys6ci7q3aupst@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622143829.rd2ys6ci7q3aupst@gondor.apana.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-18, 22:38, Herbert Xu wrote:
> On Fri, Jun 22, 2018 at 11:27:59AM +0300, Stanimir Varbanov wrote:
> > Hi Herbert,
> > 
> > On 06/21/2018 02:53 PM, Herbert Xu wrote:
> > > On Thu, Jun 21, 2018 at 02:27:10PM +0300, Stanimir Varbanov wrote:
> > >>
> > >> OK, I just wanted to say that it is _not_ PRNG and the register names
> > >> gives us wrong impression.
> > > 
> > > So does it generate one bit of output for each bit of hardware-
> > > generated entropy like /dev/random? Or does it use a hardware-
> > > generated seed to power a PRNG?
> > 
> > I believe it is the second one. Isn't the second one SP 800-90A?
> 
> In that case it should switch over to algif_rng.

Okay I am doing the port taking the exynos-rng as a ref.
Question is how to test it, how is one supposed to exercise the rng, any
test utils/apps for that? Sorry for noob question, new to crypto
interfaces.

-- 
~Vinod
