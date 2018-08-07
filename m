Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25062C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DAB21A6D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAZQ7VyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DAB21A6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbeHGFYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeHGFYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:24:51 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0444921A12;
        Tue,  7 Aug 2018 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533611560;
        bh=2BdmmLKi3KfEeausvCatgJDvKatadRAb3+e4a+A2J+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAZQ7VyUdohaGM6i9pCa/F5zmx/CMUho1FaSXmFE55tj7/GBuefy2hG35O9mYbnNf
         uVZKTuFjp/8CIpKyHPW8cEr0+m6Vteo9Ov+UA8bIrKsEaaQGw/SEfHc9B2PWA2olho
         vIl469bNpK9OkF63FxkC4+T3l/eA6pJOhf422m/k=
Date:   Mon, 6 Aug 2018 20:12:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        stable@vger.kernel.org
Subject: Re: [PATCH] crypto: remove speck
Message-ID: <20180807031237.GA779@sol.localdomain>
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806230437.21431-1-Jason@zx2c4.com>
 <20180807011937.GA133621@gmail.com>
 <CAHmME9oTApV-zHD60QPryaoQf45ODpG25Da5FgB8c+LO162gWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oTApV-zHD60QPryaoQf45ODpG25Da5FgB8c+LO162gWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:38:23PM -0400, Jason A. Donenfeld wrote:
> On 8/6/18, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > For context, in your commit message can you include a link to my email
> > mentioning Android's Speck decision
> > (https://marc.info/?l=linux-crypto-vger&m=153359499015659)?
> 
> Sure.
> 
> >
> > Also: "speck" => "Speck".
> 
> Ack.
> 
> >
> > Also I think the fscrypt code points should be reserved so they don't
> > get reused for something else:
> >
> > #define FS_ENCRYPTION_MODE_SPECK128_256_XTS    7	/* removed */
> > #define FS_ENCRYPTION_MODE_SPECK128_256_CTS    8	/* removed */
> 
> I thought about this too, but it occurred to me it's highly improbable
> these were ever used, and I thought it shinier not to leave scars. But
> if you feel strongly about it, no problem, I'll fix that up and send
> in a v2 shortly.
> 
> >
> > For the record, I think the statements Paul and I have made evaluating
> > Speck from a technical perspective remain substantially accurate.
> 
> It wasn't my intention to relitigate this, hence the rather short
> commit message. You said your thing, Tomer said his, and now I'm just
> trying to clear out the leftover soda cans.
> 

Sure, neither do I.  My intention is more to make it clear that we still don't
know of any "backdoor" in Speck, or any weakness that would compromise its use
in practice.

I mention this because people are naturally going to be curious about that, e.g.
speculating that Google found a "backdoor" -- remember that we do have some good
cryptographers!  I'm just stating what we know, out of honesty and openness; I
don't really intend to be arguing for Speck with this statement, and in any case
we already made the decision to not use Speck.

Thanks,

- Eric
