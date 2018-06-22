Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFC7243D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFC7243D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeFVOio (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:38:44 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38302 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeFVOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:38:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fWNCr-0007Dr-2p; Fri, 22 Jun 2018 22:38:33 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fWNCn-0003Pw-Ju; Fri, 22 Jun 2018 22:38:29 +0800
Date:   Fri, 22 Jun 2018 22:38:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180622143829.rd2ys6ci7q3aupst@gondor.apana.org.au>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
 <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
 <6782b1c0-ea94-b07c-2fae-3fe3223bb22a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6782b1c0-ea94-b07c-2fae-3fe3223bb22a@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:27:59AM +0300, Stanimir Varbanov wrote:
> Hi Herbert,
> 
> On 06/21/2018 02:53 PM, Herbert Xu wrote:
> > On Thu, Jun 21, 2018 at 02:27:10PM +0300, Stanimir Varbanov wrote:
> >>
> >> OK, I just wanted to say that it is _not_ PRNG and the register names
> >> gives us wrong impression.
> > 
> > So does it generate one bit of output for each bit of hardware-
> > generated entropy like /dev/random? Or does it use a hardware-
> > generated seed to power a PRNG?
> 
> I believe it is the second one. Isn't the second one SP 800-90A?

In that case it should switch over to algif_rng.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
