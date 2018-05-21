Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-791900-1526910537-2-17955494778469061623
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526910537; b=Id2vII9oZBiS648myKexyHNXH0Q7grFTx/kdKEEpmy4l1nNK0H
    BKVSR+69e8xXPPgH91tjURbYT7q7WAgPP/nPQoVjhTMR3HB7edI/zzpiE8nem2hI
    bPEo3+H0uV2PvElo5vDB0dLbaO12hY4TWj9OGa14rUyT13aba4Mcoh0bB4uYa2c+
    lGjpB0Go2rn84590xzVDrvGhzBXYMWKyZxWUCJowpf6mSn/FJcvWewW1Xmuu9xoX
    G8BgQIGBD47Csl1jXSafH8ctMCWwyuehEaWW6Qq0MvpaHkcpgnxFusmRnjOj8gbU
    pYqWhCTqtanGj6Yg9/+BZ2QEy2T8kzLKWJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526910537; bh=Ytvlcdl5jLlNc3iJ8ebN3S+BX2SKmN
    C6XYTGcaDtZhY=; b=VOZc8K5XOyqOw3sl8G3FEK+r/giakf7COCP9uF5wCfbxnC
    PgLlk5OG2lM6yiUBBmE+OUxTi94OcePvY5+NDwLF41g4zrH3MPLjLGEnQ3EMO9pU
    YOR6hDxj2bzbYhj8taBO+cLOFywBBbHrgLhL60OEGUNDOl4cGEeuBcjYKZrPfBdy
    yEak2xULmgRfdSdoxUhjGzDs56dAi7BS2dbJzzXectZU4lt5An6HKsFPgcEdURI8
    +lXWUsObY6F4nyo/EAq3mMac+kQTpuI2UehvOwtRLHOvwSE20vPdsH8RgmjcBVil
    xf6iQJdL1NzFcgZwi1g0K1xD+Oo7vU1OZugFj3Yw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=n3BKVU5W x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=nMDvjgu/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=n3BKVU5W x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=nMDvjgu/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAHEJoJLzw9yPu087hCZcog1DLSl6ITbxx42SAO/WWjIckYw8OyVNPSahdLwtUESx2zI+/hUtR8PNNuk4qw9W81OVwlgrUn2FnS+2C33bxiPvQmY96TZ
    y7CYCp4/QgI+NoX7thW/iN0qc2YPJqC/I5bDPG34YA81+pGSchDpS/y42PMBgavcsBLIS6TVq+dFM79yXv6thyQyCKUHxZUjbHQ+zVqycCHAh9WpTw/0o5Cm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=mXB9d546W9fpYdE2jbsA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeEUNsl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 09:48:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45023 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeEUNsi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 May 2018 09:48:38 -0400
X-Google-Smtp-Source: AB8JxZq2EJoSBW7uKgg7kq0FqJDQ8rUtSqNSznRZ2ssWflr+6odW8yTr/8oQcfteEw0gRP2JH52Q0w==
Date: Mon, 21 May 2018 15:48:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Message-ID: <20180521134830.GR30172@localhost>
References: <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
 <20180509131003.GC2285@localhost>
 <20180509135706.GB98604@atomide.com>
 <20180517100948.GI30172@localhost>
 <20180517171038.GL98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517171038.GL98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 10:10:38AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180517 10:12]:
> > [ Sorry about the late reply. ]
> > 
> > On Wed, May 09, 2018 at 06:57:06AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan@kernel.org> [180509 13:12]:
> > 
> > > > It seems we really should not be using the negative autosuspend to
> > > > configure the RPM behaviour the way these drivers do. Perhaps a new
> > > > mechanism is needed.
> > > 
> > > Hmm well simply defaulting to "on" instead of "auto" and setting the
> > > autosuspend_ms to 3000 by default might be doable. I think that way
> > > we can keep use_autosuspend() in probe. Let's hope there are no
> > > existing use cases that would break with that.
> > 
> > No, defaulting to "on" (i.e. calling pm_runtime_forbid()) wouldn't work
> > either as that would also prevent the device from runtime suspending
> > just as the current negative autosuspend delay does.
> 
> Well in that case we should just stick with -1 value for the
> autosuspend. And just do pm_runtime_put_sync_suspend() after
> probe and on close.

That won't work either as a negative autosuspend delay prevents runtime
suspend completely (by grabbing an extra RPM reference).

> > I fail to see how we can implement this using the current toolbox. What
> > you're after here is really a mechanism for selecting between two
> > different runtime PM schemes at runtime:
> > 
> > 	1. normal serial RPM, where the controller is active while the
> > 	   port is open (this should be the safe default)
> 
> Agreed. And that is the case already.

Yes, but it's not really the case today as since omap-serial (and
8250-omap) sets a negative autosuspend at probe and hence does not
runtime-suspend when the port is closed. So that's the long-standing bug
which needs fixing.

> > 	2. aggressive serial RPM, where the controller is allowed to
> > 	   suspend while the port is open even though this may result in
> > 	   lost characters when waking up on incoming data
> 
> In this case it seems that the only thing needed is to just
> configure the autosuspend delay for the parent port. The use of
> -1 has been around since the start of runtime PM AFAIK, so maybe
> we should just document it. I guess we could also introduce
> pm_runtime_block_autoidle_unless_configured() :)

The implications of a negative autosuspend delay are already documented
(in Documentation/power/runtime_pm.txt); it's just the omap drivers that
gets it wrong when trying to do things which aren't currently supported
(and never have been).

So I still think we need a new mechanism for this.

> > For normal ttys, we need a user-space interface for selecting between
> > the two, and for serdev we may want a way to select the RPM scheme from
> > within the kernel.
> > 
> > Note that with my serdev controller runtime PM patch, serdev core could
> > always opt for aggressive PM (as by default serdev core holds an RPM
> > reference for the controller while the port is open).
> 
> So if your serdev controller was to set the parent autosuspend
> delay on open() and set it back on close() this should work?

Is it really the job of a serdev driver to set the autosuspend delay of
a parent controller? Isn't this somethings which depends on the
characteristics of the controller (possibly configurable by user space)
such as the cost of runtime suspending and resuming?

The patch I posted works with what we have today; if a parent serial
controller driver uses aggressive runtime PM by default or after having
been configured through sysfs to do so.

What I'm getting at here is that the delay should be set by the serial
driver implementing aggressive runtime PM. Then all we need is a
mechanism to determine whether an extra RPM reference should be taken at
tty open or not (configurable by user space, defaulting to yes).

Specifically, the serial drivers themselves would always use
autosuspend and not have to deal with supporting the two RPM schemes
(normal vs aggressive runtime PM).

Thanks,
Johan
