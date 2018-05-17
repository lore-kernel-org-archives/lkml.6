Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1861431-1526547891-2-12839377096467798046
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
    1526547890; b=hvJniuah3zHstw/Iyy0TdItUUq1inNkynuVndEhogN5BtUwXVX
    h7O1M2D1yKltlVPdxO3UMxF1o6TPd7ldaA9vdCah7fCB0asyV5dOD3XrYk4UIjnB
    GRteZbX6qtbL3dZb4+zrf8BYE4rJO1RNT8v57v44Z8/O/bisBUD/bSVrXHf5c+/h
    kQDgMyoIflCsuTPWmVGuuj9ry0UgXl6YnG82KduabPO6/7iGgKaEmGAQWBunJ3iV
    1yLNtwtkIlkXTdntNU/Sc/AGL6sfdlIrrV2gIUct0avIl/FwG4C73wecT2ee2p8j
    Bx3G/nF72DHe3gm1aUkx+Bbo2+N2TqT6whuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526547890; bh=Oey0FByMwFh
    N1iDtEsnKGLjyGOVj5h3BPijwiIhJiIY=; b=byzALAtyU67fYTJb4W9qajeBteJ
    FkiWJEQhopgxH5aLpsrXkDrRUyrjM94PFfLj6jyEl6Krxck1KT3gisv832f72lIQ
    F7Neu1xFraZ3sxmuiw6Lr5MuvmXPscf67r1jMe8ubt2L0+ke1AP+Q7OqbYahk75D
    mIBcqcyPZoPVJlFqOElbKSiaIEneQpnXdK9/k6pjCV0Zpl4fa2YMGPFvPeHv15bX
    GdWuCl3liyM8eFRVTHngx0mXA7PbbO/g80dxxHznqGMYRmnhLsVwdCS5h3+oSh6D
    zZgN6O9xOX52L3Ep7sXrs80kYV0IvUeR8SsZJpSD0f8Un6nq+dhFlVRUSrQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ISTxAqOz x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ISTxAqOz x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKkQ7ej4pJZy08NsCaNFTOnZ30sjz7q9RVlELDIkxvOceqsiDjGVnHjzNASUgbZ6tNh3+RuPNVMKrMZTloNDar3r4MGj76VfpPh5CGJHZAqj4LoNfaMz
    p3Z36qq9YMe9G7UTZTxFl3/B+/cPwsT+DNFhclXb7aqDuMn9wLudGhu81mgJNTv2GsnMbMsRQ17tfql98miunYBU1QgmRScvqoF66sKu9ITJdGn3Va4kCPBq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=xjQjg--fAAAA:8 a=MPuteyk0RkJphlWHEaIA:9 a=wPNLvfGTeEIA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeEQJEr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeEQJEq (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:04:46 -0400
Date: Thu, 17 May 2018 11:04:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 115/190] Fix serial console on SNI RM400 machines
Message-ID: <20180517090428.GF25318@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183557.834541973@linuxfoundation.org>
 <1526429748.9159.95.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526429748.9159.95.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 01:15:48AM +0100, Ben Hutchings wrote:
> On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > 
> > 
> > [ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]
> > 
> > sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
> > is disabled. Correct usage of clk API to make it work with/without it.
> > 
> > Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)
> [...]
> 
> There's another related fix upstream:
> 
> commit c91261437985d481c472639d4397931d77f5d4e9
> Author: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Date:   Sat Sep 2 23:13:55 2017 +0300
> 
>     serial: sccnxp: Fix error handling in sccnxp_probe()
> 
> Ben.

Thanks, now queued up.

greg k-h
