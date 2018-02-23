Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493875-1519407128-2-15163643317385950968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519407127; b=tEkN0iGxRkwnfo2LBEIT40Yo4f7WGMD6I/U5MOcDUWCdH16
    KZRhoczmYPzNMHiJFNmoMfk6oi3swlYY96atteATpFXYbZfxADZPGy+l3dZQ5A9W
    GFflz4It1tGlW8UJvReuWUel/B0nwu7jzsCWLDsooExFAWh0MWazKND1fpgvaJaP
    bT3wcmU64aP5t5g9SdVtO4EVxybDE2M1a3oPICvc/A8243gYo6WQaCeTl2hfRSe/
    TST4C9Bfo7E96KKSJwmgmUaMbF9nqQLt+uAvtfE1uI/6qOefVBxtzsod0w4kAxPJ
    rt07OZyFkL3gP2raNhEzkKfJ98G5SeUdqh0cALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519407127; bh=QrCIRLupZcuQMcNelqCHiFLe1oArP0jTaHL9tmOZA48=; b=Y
    nGRVYnnWXAQ39fw1QolBjVTsCXQR9JyKSvqpVTrZFMbuloRRxuEFMLZEmXTmm5S0
    zmsqFNQxGYYiN/glpDdGb/lCS3GBvrIi7/g187EEWM2H5Z22+Oiq5GUafrpaeN40
    2pbTyIgPRTDs0zPH4XRn2njI5OYL/j1s6FM8kUgLLm9LpSB3O0mexe9woLY3+qC3
    +/ivdBs1gFfVZOkIQdIyPCb++CE7IPieRFGvGOqBLIRCXoMNKEt2GBe0jGtPTA0X
    2Uwlt2Aqcj135NebXCXsHDlHrfJ8iX90s6cqCy5LMpPozC3ilMcUwIavlBkXsxtS
    A7vKgalFYuBPFIQY8rxMA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBWRcC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 12:32:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:1496 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBWRcB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 12:32:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="29304156"
Message-ID: <1519407117.10722.124.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
        ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date: Fri, 23 Feb 2018 19:31:57 +0200
In-Reply-To: <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-23 at 11:02 +0000, John Garry wrote:
> On 23/02/2018 10:30, Andy Shevchenko wrote:
> > On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
> > > There is a requirement
> 
> > Where?
> 
> We require it for a development board for our hip06 platform.

Okay, and this particular platform uses Synopsys IP?

> > >  for supporting an 8250-compatible UART with
> > > the following profile/features:
> > > - platform device
> > > - polling mode (i.e. no interrupt support)
> > > - ACPI FW
> > 
> > Elaborate this one, please.
> 
> So we need to define our own HID here, and cannot use PNP compatible
> CID 
> (like PNP0501) as we cannot use the 8250 PNP driver.

Why not? What are the impediments?

> This is related to the Hisi LPC ACPI support, where we would create
> an 
> MFD (i.e. platform device) for the UART.

Why you can't do properly in ACPI?

> > > - IO port iotype
> > > - 16550-compatible
> > > 
> > > For OF, we have 8250_of.c, and for PNP device we have 8250_pnp.c
> > > drivers. However there does not seem to any driver satisfying
> > > the above requirements. So this RFC is to find opinion on
> > > modifying the Synopsys DW 8250_dw.c driver to support these
> > > generic features.
> > 
> > Synopsys 8250 is a particular case of platform drivers. It doesn't
> > satisfy "8250-compatible UART" requirement.

> Right, but I wanted to try to use the generic parts of the driver to 
> support this UART to save writing yet another driver.

It's still odd. Why this one, why not 8250_foo_bar to touch instead?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
