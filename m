Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-257651-1525244384-2-1762087538837918791
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525244383; b=jYAL6WN/boDEimQDmV/zrQKTY6Ej9nYpe/DiHVEV4p6qKt6/SG
    vh6fphsmlyM8VOhGYSL0tByr3oqR7rjXEwb/gWzAePVogijrYMacV2FwHZ9t00T6
    Pbaz4JPllT6jl+PRfVAtZcdqbGpxa3WjESTnu3NbCHBa7t8o8NoC8KRCCTlxx3dH
    UnwwXtvrucONQwjcxCFSGKWPUT++AHjtq64NuUoPLYRNfM+ADNgYSKLbXv3ZlETz
    K/Qg7zQr/VKtN/TtpC3ICepgb4UM/WVoJdrl4viTgTHy5QIHHXv3znd7HxGCSlcJ
    o4V+z02OPF4mQhpZp1Ntr8CLDOcJsRhDJjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525244383; bh=hEnxURXdc4D4USRTLtpQU2BwoKXAMF
    xg7uY6+oD3cG4=; b=iYskGnDFPD2X0P7o0UUb0pWFwyeZlIb11qSDmJRe9shVpc
    kSFqJRDVukr5Sh/zvZbw4ZzG0wcEg3f+rur7cN3ZPiljNe9KcLouuy6WIdrmN349
    girLX7sPHLoocH/d4KgIVe4+h4Uu2J5KcZTy/sYu+2oM74uICpcbcETPQqaAzhjL
    iBhSbdsi6nuEYdtLozC4s4Lv/auDtSSuKn24RPAIYQk63yMptVVuI77Yz1V3cvkQ
    rLkzXAaC28kaAM6TWeuAznOBlBr2c9PyRn6UAjyL+BwE//lWkbrZYg89230hrrU+
    /gjIybgHoduZd2DU+QRWmp9aYSetKMpTFQ3Rs7rg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIOigC6T4kITeS62hNoIklVxKw1Pu0EfoBvgs/XMnKtMWT0BuIno53RgDeFl0ZzCVZRBIqS1W+pSS052f3PW8vQLzwgvDBXZEG8fJnmjaKhI8I61XXr2
    dq2zAluehHok3ho8zVykuuQNXcvLFDiquJ44stpjcNcC6KqUwj65wmLMxjCtqOxKs24lphWCQ9IsZANasSwJSZlrGpDsOFMlZkzRRAY4eLlZ3pHpwlLYLfxY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=jDrsW6gQXJ2z9ZZLjAEA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeEBG7h (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 02:59:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:16595 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeEBG7h (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 2 May 2018 02:59:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="51660223"
Date: Wed, 2 May 2018 09:59:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/4] platform: x86: intel_cht_int33fe: Fix dependencies
Message-ID: <20180502065930.GD12870@kuha.fi.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-2-heikki.krogerus@linux.intel.com>
 <80c86dfd-acd1-6c51-298b-250394818ade@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c86dfd-acd1-6c51-298b-250394818ade@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 11:53:24AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 30-04-18 14:41, Heikki Krogerus wrote:
> > The driver will not probe unless bq24190 is loaded, so
> > making it a dependency.
> 
> Hmm, the dependency is pure run-time, with this Kconfig
> change if a user now decides to builtin the intel_cht_int33fe
> driver, the bq24190 driver must also be builtin, I'm not sure
> if that is a good thing.

OK. That should be possible to sort out with something like this:

depends on CHARGER_BQ24190=y || CHARGER_BQ24190=INTEL_CHT_INT33FE

I'll fix this one.

> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/i2c/busses/Kconfig   | 3 +--
> >   drivers/platform/x86/Kconfig | 4 ++--
> >   2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 8d21b9825d71..fce9f2ca0570 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -202,8 +202,7 @@ config I2C_CHT_WC
> >   	  Note this controller is hooked up to a TI bq24292i charger-IC,
> >   	  combined with a FUSB302 Type-C port-controller as such it is advised
> > -	  to also select CONFIG_CHARGER_BQ24190=m and CONFIG_TYPEC_FUSB302=m
> > -	  (the fusb302 driver currently is in drivers/staging).
> > +	  to also select CONFIG_TYPEC_FUSB302=m.
> >   config I2C_NFORCE2
> >   	tristate "Nvidia nForce2, nForce3 and nForce4"
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 39d06dd1f63a..1dbd9d547e60 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -866,6 +866,7 @@ config ACPI_CMPC
> >   config INTEL_CHT_INT33FE
> >   	tristate "Intel Cherry Trail ACPI INT33FE Driver"
> >   	depends on X86 && ACPI && I2C && REGULATOR
> > +	depends on CHARGER_BQ24190
> >   	---help---
> >   	  This driver add support for the INT33FE ACPI device found on
> >   	  some Intel Cherry Trail devices.
> > @@ -877,8 +878,7 @@ config INTEL_CHT_INT33FE
> >   	  i2c drivers for these chips can bind to the them.
> >   	  If you enable this driver it is advised to also select
> > -	  CONFIG_TYPEC_FUSB302=m, CONFIG_CHARGER_BQ24190=m and
> > -	  CONFIG_BATTERY_MAX17042=m.
> > +	  CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m.
> >   config INTEL_INT0002_VGPIO
> >   	tristate "Intel ACPI INT0002 Virtual GPIO driver"
> > 

Thanks,

-- 
heikki
