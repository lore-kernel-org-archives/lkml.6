Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C35FC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DC1206B2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rd+oTleL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DC1206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJGX4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:56:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56205 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeJGX4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Pi7VlZyxnMW9Tbk6adpnTj9xJQoSEAqf1EgiuwoeIr4=;
        b=rd+oTleLJl37a8pAqTyb/UUWQBsmhBIUfIuT467Yeet6/LjhoF3zPeFYMOrHdtN7N5uyyulldafQuteKshAmPpPZx19Kz1UINB38Lukc0FFJcf92RmhGOXwTKp0e/hg3FMXVbw5fYbEwxwiIoWm6hhe1LPdhNs+n81v15IHpOcg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g9CDv-0005ki-Q8; Sun, 07 Oct 2018 18:48:07 +0200
Date:   Sun, 7 Oct 2018 18:48:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181007164807.GA21302@lunn.ch>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006235414.GA11773@lunn.ch>
 <CAHmME9ocMekP+jauihMGKq04to0_jQTjhv=r2wVEcqmLtKJu2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ocMekP+jauihMGKq04to0_jQTjhv=r2wVEcqmLtKJu2A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 03:57:38AM +0200, Jason A. Donenfeld wrote:
> Hey Andrew,
> 
> On Sun, Oct 7, 2018 at 2:01 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > The BUG() statements all seemed to be removed. Thanks.
> >
> > We still have 1 errors, 193 warnings, 7529 lines checked from
> > checkpatch. There are still some Macros flow control statements in
> > them, despite me pointed them out multiple times.
> >
> > Im not reviewing this version any further. Until you get the very
> > basics right, i doubt this patch is going to make much progress
> > towards inclusion.
> 
> Dave mentioned he wanted the Zinc stuff to be all set before looking
> at this, so I've been focusing my efforts mostly on that. But I
> haven't forgotten about your reviews, and seeing as you're actually
> interested in looking at this now, I'll be sure to address everything
> you've mentioned for v8. When I'm reasonably sure that's all done,
> I'll let you know, so that you're not disappointed again.

Hi Jason

This is the sort of thing you should state in the patchset version
history. It is O.K. to say i will address this later, but you need to
communicate that. Otherwise reviewers just get frustrated that
comments are getting repeatedly ignored and why should they bother
reviewing it. And without reviewers willing to review your code, it
will never get into mainline.

