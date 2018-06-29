Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CD4C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F4274A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785F4274A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935218AbeF2IZE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:25:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964855AbeF2IYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:24:42 -0400
Received: from localhost (unknown [64.206.165.227])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2426C97;
        Fri, 29 Jun 2018 08:24:40 +0000 (UTC)
Date:   Fri, 29 Jun 2018 04:24:39 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Willy Tarreau <w@1wt.eu>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180629082439.GA15660@kroah.com>
References: <20180628134227.GA1719@arbeit>
 <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de>
 <20180628204516.GA29146@amd>
 <20180629064147.GA3219@arbeit>
 <20180629071724.GA10079@amd>
 <CAMuHMdXaPz3ckT1cPZed4e=iwk3nb75UBGC66hm+b+xRDNNnNg@mail.gmail.com>
 <20180629072912.GB10079@amd>
 <CAMuHMdW1NX=BwJE0eauRLkRj1se4iRNGdxHXeajNQ-dKDhnPKw@mail.gmail.com>
 <20180629080717.GA12112@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629080717.GA12112@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:07:17AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > There's no reason 2. should be in kernel ("mechanism, not policy").
> > >
> > > Given 1. is not really more complicated than the morse
> > > trigger... please just help with pattern trigger if you want this to
> > > happen.
> > 
> > Ah, you want to do the conversion to morse code in userspace?
> > Yes, that makes sense.
> 
> Yes, that's what I want.

We all want a pony :)

Seriously, this is a very simple module, works well, and makes some
system's life much easier as there is no external dependancy on a
text-to-morse-code library needed.

If you don't want this cluttering up your kernel, don't built it in.

I think it should be taken as-is (well, with the few changes already
recommended).

thanks,

greg k-h
