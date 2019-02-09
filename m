Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9206DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A9921919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549714320;
	bh=fN7sar4GE0z/T20kBtGteuxrbwVlJbQ04Dy04cWL1ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lonh+xkwX2bS4wlmcjmWZWx42YXCdwXPtaoXJyroq8zN+s2nsQkarH8F7f3nK8KdG
	 BCXS73jiA5144ZZ0TYvuIYBfO2gcU2StdB+9GuGwthVgOPi1bxGMtzRx/hsSvGqlfJ
	 6mC2loTxsxULYwD/sdjgdg6wus4mu245KXchXT2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfBIML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:11:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:32820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfBIML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:11:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4D82084D;
        Sat,  9 Feb 2019 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549714317;
        bh=fN7sar4GE0z/T20kBtGteuxrbwVlJbQ04Dy04cWL1ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z391bQWoKnIK/edsNtbIPR7IRvAZtfAoJhnqW4XmE/6KTJcio+lASyp4CmWPwplVl
         S9l5Y60m8cGnnqZiH6C4I339FMtZIHb7GkmzAd8jC+LP/b+Om50bt/czGvE+LTBjbd
         FB9gR1WWP04QHtrNBFQDldSySt/9ikxfPpvQhDG8=
Date:   Sat, 9 Feb 2019 13:11:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
Message-ID: <20190209121154.GB17668@kroah.com>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
 <20190129130658.GA19205@linux-8ccs>
 <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
 <20190206172151.56fcce6c@lwn.net>
 <alpine.DEB.2.21.1902081649290.2144@nanos.tec.linutronix.de>
 <CAOFm3uE9DakoBsPv6GrSfeHMQOoGsFBj61o-p0YfxmEvjYRsvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uE9DakoBsPv6GrSfeHMQOoGsFBj61o-p0YfxmEvjYRsvg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 10:37:17AM +0100, Philippe Ombredanne wrote:
> > + * states, that the module is licensed under one of the compatible BSD
> > + * license variants. The detailed and correct license information is again
> > + * to be found in the corresponding source files.
> > + *
> >   * There are dual licensed components, but when running with Linux it is the
> >   * GPL that is relevant so this is a non issue. Similarly LGPL linked with GPL
> >   * is a GPL combined work.
> 
> Just to add to your points, I have seen a few times folks create
> out-of-tree modules and use a MODULE_LICENSE "Proprietary" with a
> proper GPL license notice at the top just to ensure that the code
> would not be able to link with and use symbols exported with
> EXPORT_SYMBOL_GPL().

That's very odd, but oh well, people do strange things :)

> This further reinforces the relevance of your argument as
> MODULE_LICENSE can be used also as a pure technical solution that is
> not making any licensing statement. So much so that a rewrite could
> instead use something akin to EXPORT_SYMBOL_PRIVATE/INTERNAL/NON_API (
> as 0 or 1) and MODULE_CAN_USE_PRIVATE/INTERNAL/NON_API_SYMBOLS ( as 0
> or 1) and not deal with anything license-related? After all this is
> mostly a binary flag.

No, let's leave the export symbol stuff as-is for now please.  Let's
just focus on cleaning up this odd string mess so that we can move on to
the larger goal of getting everything in-tree properly classified.

thanks,

greg k-h
