Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D2ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670AE2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xeed1bjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670AE2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbeISSQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:16:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38737 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbeISSQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ZRgPvkGLdx/jDgEFJBdid4djCHeP2et5qQrSkCH3SdI=;
        b=Xeed1bjYLhc4ge3WTLOAZ4DWIHIyYroHKyR3qp8TPotEfZvvmuN0cL3aXkKGFLpd6gozdRc9SKcmUZevafxVC5vug6mYSR9Rv1ai+50yHljTauTfsMOTC3bqkYgsINSlX4LDxSitotJ6Ie0/hCVNOSDiF9sEya988QfBIdthzx4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g2bkr-0007Ow-Dy; Wed, 19 Sep 2018 14:38:53 +0200
Date:   Wed, 19 Sep 2018 14:38:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 20/20] net: WireGuard secure network tunnel
Message-ID: <20180919123853.GC26940@lunn.ch>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-21-Jason@zx2c4.com>
 <20180918233411.GB17466@lunn.ch>
 <CAHmME9rwVLu+H88Nq+kGaVfZsZjoVUM_SdosjSRRpreUd2uGuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rwVLu+H88Nq+kGaVfZsZjoVUM_SdosjSRRpreUd2uGuQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:04:01AM +0200, Jason A. Donenfeld wrote:
> Hi Andrew,
> 
> On Wed, Sep 19, 2018 at 1:34 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > I see this BUG_ON() is still here. It really needs to be removed. It
> > does not look like you need to crash the kernel here. Can you add in a
> > test of len >= 128, do a WARN and then return. I think you then leak
> > some memory, but i would much prefer that to a crashed machine.
> 
> Sure, I'll change it to that.

Great, thanks. I noticed there is at least one more BUG()
statements. It would be good to remove them all. BUG() should only be
used when something bad has already happened and we want to minimise
the damage by killing the machine immediately.

    Andrew
