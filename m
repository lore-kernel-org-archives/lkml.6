Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B17C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CBA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ma13g5Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CBA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeFTIwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:11 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56125 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754666AbeFTIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:51:50 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5EDEF25B7A7;
        Wed, 20 Jun 2018 18:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1529484708; bh=n/5BrlfLdT8LVLhAIAvdJ0U0p5LFzKu5nHFPNGkGlII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ma13g5Znv5ArrVe2nDJnQfwtqYu5OWAZSWUcWpmHKOiH2ZIjK3m7UhTgrzwx8O7mV
         fNPxj1Uh6t68jf0VHuZfPLG2/Ba6bouxMUOr4joW0ife5rN6R7wR0Xi0dlyYEbnBke
         LwDl9zzEEPHNjukqC7e7NqW3dKPi9MZN8TNsr29Q=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 471359407DF; Wed, 20 Jun 2018 10:51:46 +0200 (CEST)
Date:   Wed, 20 Jun 2018 10:51:46 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ofir Drang <ofir.drang@arm.com>
Subject: Re: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
Message-ID: <20180620085145.7bxfbu7bi45sftnk@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
 <CAOtvUMc8D9DQFC6vZ+GnaVBg5uFVrQmOrnSQKz7ZPHGh4BCsZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMc8D9DQFC6vZ+GnaVBg5uFVrQmOrnSQKz7ZPHGh4BCsZg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:57:15PM +0300, Gilad Ben-Yossef wrote:
> On Tue, Jun 19, 2018 at 3:58 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Hi Gilad,
> >
> > On Thu, May 24, 2018 at 4:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> >> The patch set enables the use of CryptoCell found in some Renesas R-Car
> >> Salvator-X boards and fixes some driver issues uncovered that prevented
> >> to work properly.
> >
> > With DEBUG enabled on R-Car H3, I see lots of
> >
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x00000098)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000C0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D8)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000E0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F8)
> >
> > during boot. Is that expected?
> 
> Yes. The condition itself it is reporting is not necessarily bad. It
> means that driver
> did not act on certain HW notification during interrupts and that's
> OK, we don't act on all of them
> depending on configuration - e.g. if you have CONFIG_FIPS enabled and
> an active TEE module or not.
> 
> I can rate_limit the message if it bothers you but other than that it
> is a harmless debug print.

Rate limiting sounds like an excellent idea to me.
