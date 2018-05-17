Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882526-1526549232-2-10405411235605087122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526549232; b=l3PG7uvOR3IAHcvZQexZecH2oRmMlB9kJFtKdkLs7L/s2ZGNhy
    a0XaOKvl4M61Mu+SaX9z1kryJwJlflfGn56yeX8shhlkALFhgcvFXtKEVkVYP331
    2p3XwKi3OFBmBNAu/6GsoaRRtK1Wu7n+S00VAS+Y4J98oI95Kve3tJlMXauvEu1h
    MMZCWVU1Lb7bHBba1MziMOLxreuL5QRKvnceNIHOMsXguhJX5ge1D4qcBCnz7a+t
    JaQQkj3aHk/YBgQuNRw+KrjrEfQH4cCIoHzr6tJPtkt4L3LnO2H8fiWyDIaZGcjB
    uRhGdnGrdd02Pp0BPz0Mb0en6vxigV1hF6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526549232; bh=riLolUZ06Ip
    ChQIvO73wVqy5S52htPczydDmBOy9abU=; b=GWMgdq2CENSHTlcOFPu/ggE0P/R
    Yx9zI6heXpeozGvsV36/ayF+us0CBG71fGFeDGaruZG5FJl8xrfVVGNhhy4kgAFZ
    8E5NhFYgRkz3pGtALSIeScPzffx9NhTLL+tJSNn8CycYUFfTOqJoYHfXIw9lP0fx
    /Ygob+u/Bk2UJbTKA+vgOngqUr10bOxWUkQft4jmHSKfUUoKbMHqPY20xg0entNf
    5BBypveKHN5zkXcoiI+lD12HaXv878fZ7jwJ5PQAuWF17Y+THRwMH36Ru1UdDiMX
    hvRzc9MZLarhcBfgtE9sLX0TKmySV9Ze0OOOFh+87T2qX1LFIpqRVpxKM5g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cfczaq9B x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cfczaq9B x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAB9BCqsonIQm1mLjNGvxB3hXAX9oR7yodRxXe6ov+BM8i10OrZ2yqYvwPWbfQeRRGZS/Aelj7WZbhu4wXkMvvfIJ960NYwuuiqqwCEozNMdWzLdDq8J
    gr0O57lek9GlSb+9ocR42hYuGjFcfRNZk6C8NzHTBG0K2MLdtPvZd963CXv86nuDV6XeWUJfyGiIXc0Zuq+rZec/ZboOuKoNQgbt72Z0xT/AXhw4lKWxkYKm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=xjQjg--fAAAA:8 a=ddRsLXPaNLc0Q8qpMgMA:9 a=wPNLvfGTeEIA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeEQJ1A (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeEQJ07 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:26:59 -0400
Date: Thu, 17 May 2018 11:26:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 115/190] Fix serial console on SNI RM400 machines
Message-ID: <20180517092641.GJ25318@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183557.834541973@linuxfoundation.org>
 <1526429748.9159.95.camel@codethink.co.uk>
 <20180517090428.GF25318@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517090428.GF25318@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 11:04:28AM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 16, 2018 at 01:15:48AM +0100, Ben Hutchings wrote:
> > On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > 
> > > 
> > > [ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]
> > > 
> > > sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
> > > is disabled. Correct usage of clk API to make it work with/without it.
> > > 
> > > Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)
> > [...]
> > 
> > There's another related fix upstream:
> > 
> > commit c91261437985d481c472639d4397931d77f5d4e9
> > Author: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > Date:   Sat Sep 2 23:13:55 2017 +0300
> > 
> >     serial: sccnxp: Fix error handling in sccnxp_probe()
> > 
> > Ben.
> 
> Thanks, now queued up.

Nope, breaks the build :(

I'll leave it as-is, this is a very low-frequency path.

thanks,

greg k-h
