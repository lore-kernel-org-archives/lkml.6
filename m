Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F34C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4621771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE4621771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeHHUDc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:03:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42884 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbeHHUDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:03:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6FDA22084E; Wed,  8 Aug 2018 19:42:45 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 75D8D207E5;
        Wed,  8 Aug 2018 19:42:44 +0200 (CEST)
Date:   Wed, 8 Aug 2018 19:42:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        linux-gpio@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port
 direction once per transfer
Message-ID: <20180808194242.7540ce12@xps13>
In-Reply-To: <3260564.acbQT1CZaz@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-8-jmkrzyszt@gmail.com>
        <20180807205752.32cd3e53@bbrezillon>
        <3260564.acbQT1CZaz@z50>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Wed, 08 Aug 2018
18:55:35 +0200:

> Hi Boris,
> 
> On Tuesday, August 7, 2018 8:57:52 PM CEST Boris Brezillon wrote:
> > On Tue,  7 Aug 2018 00:29:13 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >   
> > > In its current shape, the driver sets data port direction before each
> > > byte read/write operation, even during multi-byte transfers.  Since
> > > performance of the driver is completely not acceptable on Amstrad Delta
> > > after it has been converted to GPIO bitbang, try to improve things a
> > > bit by setting the port direction only on first byte of each transfer.  
> > ...
> > I'd suggest a slightly different approach where the data pins
> > direction state is stored in the the priv struct and only changed when
> > required. This way you just have to add a test in
> > ams_delta_read/write_byte().  
> 
> Good idea, I'm going to use it, thanks.
> 
> Once done, may I also move that one earlier in the series so that it can be 
> applied while our discussion on GPIO bitmap changes still continues?

I think I may answer on his behalf: yes! You can move the GPIO bitmap
changes at the end of the series, checking that you never break the
bisectability. Then I could apply the major changes and let us iterate
on the GPIO bitmap stuff only.

Thanks,
Miquèl
