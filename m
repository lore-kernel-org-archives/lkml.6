Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0121BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710B2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4yAMnLmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A710B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJZHMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:12:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43351 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJZHMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=XVZcS4t52adeTwJ4tmQgFHbTMOppuK9xbOm1fmM/TlU=;
        b=4yAMnLmfSNrX7U0xmXaMR1RmrHkvpSdrTfgzvKo2/TQzchXAiNUHknUcC3FAsYbRPvwJYxNg0i29M2jSUNTmKPQSVXQP7jufG5R9cvYlpaRkn+GCdYnR1L9gwsZa2PlNsndz8xqywMub3S2lJu1VNj/iYbaU2E19If7gDgWLO28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gFoGA-0005Y4-8Q; Fri, 26 Oct 2018 00:37:46 +0200
Date:   Fri, 26 Oct 2018 00:37:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v8 28/28] net: WireGuard secure network tunnel
Message-ID: <20181025223746.GB6276@lunn.ch>
References: <20181018145712.7538-1-Jason@zx2c4.com>
 <20181018145712.7538-29-Jason@zx2c4.com>
 <20181020224706.GC14816@lunn.ch>
 <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +             net_dbg_ratelimited("%s: Could not decrypt invalid cookie response\n",
> > > +                                 wg->dev->name);
> >
> > It might be worth adding a netdev_dbg_ratelimited(), which takes a
> > netdev as its first parameter, just line netdev_dbg().
> 
> That sounds like it could be useful. Though, I'm trying hard to make
> the first patch submission _not_ need to touch any of the rest of the
> networking stack. I've actually got a small list of interesting
> networking stack changes that might be useful for WireGuard, but I
> think I'd prefer to submit these after this is all merged, and each
> one separately for a separate discussion, if that's okay with you.

Hi Jason

I can understand that. But on the flip side, CAKE reached something
like version 19 before it got merged. Wireguard is looking similar.
An addition like the above, is not controversial. You could submit
such a single patch in a weeks time when net-next reopens, and
probably version 1 or 2 will get accepted.

	 Andrew
