Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD649C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706B720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lkj5jRYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706B720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJZHTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:19:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43358 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeJZHTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=sRzUYWbyKEufU5IhjPuexQ4WM3q4r2aEodM1kdvLuu4=;
        b=Lkj5jRYLeQNhtm0a1ZZNDxdvEVLAU1F8Xah/l2tev3OF0bNEkSqKdWpCZwkFctnLUBjOeA2ZvYNgorhv1j1KItM+zoCZUfFKhS/CfKfy5E7RqzLYZFJGbDwaB72ONmnVwYgI23/5Xu6JnGM8SmGcJSz0dPPo9TeK9eoC1mgSPjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gFoMc-0005aN-O6; Fri, 26 Oct 2018 00:44:26 +0200
Date:   Fri, 26 Oct 2018 00:44:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v8 28/28] net: WireGuard secure network tunnel
Message-ID: <20181025224426.GC6276@lunn.ch>
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

> > > +#if defined(CONFIG_PM_SLEEP) && !defined(CONFIG_ANDROID)
> >
> > I don't see any other code which uses this combination. Why is this
> > needed?
> 
> WireGuard clears private key material before going to sleep, so that
> ephemeral keys never live longer in ram than their expiration date.
> This works well for mostly everything, except Android devices where
> crazy out-of-tree wireless drivers (such as qcacld) will actually wake
> and sleep the phone constantly

Hi Jason

Out of tree is important here. To some degree, mainline does not care
about out of tree drivers. Putting in a bandaid for them does not help
get them fixed.

I would drop this bandaid. If the Android community decides to move
wireguard from mainline into their fork, they can put the bandaid back
in again, or get the driver fixed.

   Andrew
