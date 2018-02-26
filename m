Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691517-1519644527-2-13035504341235735058
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
    t=1519644526; b=r3WJ7NaVnuocxiKw1UMK59FHxEGekGEkxzLO7TkMDNZQlJV
    MY7jrDYR6ojGiBkHdmLY0wui5RoeSEmb7gRADFBpAslrSSwbxwQkCshhp70EMdiM
    T7uGFAGSrEWJZbVw/Ii/b+KmYZBXAyvnQaXFsv+Kikyi42zj5ywYwAh8IEGyXazg
    nUC1Hlh+ZzTgPmSkchgaGSdD6Zur+3qlhpil4amBRcSDRRP8jOj+O7WMor8yQGjl
    2J+ctEJMKug/v+JjZWSjFtzg0nedoAcufkzzEl6YzFE/URyx+gbnVh5iGCZO9X2e
    ayxF8OIncF60f2wwCpOGLZoI/4Lyo/LGcd1KPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519644526; bh=rBbJvqjiMTRqGg9f6BJ7lhEjwilJcu0M1uJc7PZUl/s=; b=k
    fI7sp2KhUwpK50sWplDV6s06GtbcALE9WbBhZWbauW08Z/XKEgmSBDM6Jd6laXyI
    3dDr/emLUaQZa3m5mDiLppbQhfX5AFECr3KUZmjvRCRX6fU6D/cQnkYTGQFsS2U9
    IP93eiCQBrgMdYKjluxOXS3j0CkZL3siJ9MjRDx1AnFlBWaKKQ331mcaAQAtrpC9
    NNJwUCyZvcCpuWPg3wvZvd7mnG3DNEYHix8AjulDp9jrzjtUF519I7xDmJNM8wSV
    zAsBAj+Q0X8X3Ph1qPQ3rE7iTJ0wPxk+U5DOPGFR7rA9BLNYToirZMn1o/TZ3gtb
    QpvZ7LCO1kcLZ4+6vW+IQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeBZL2m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 06:28:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:63292 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbeBZL2l (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 06:28:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="20844176"
Message-ID: <1519644517.10722.179.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
        ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date: Mon, 26 Feb 2018 13:28:37 +0200
In-Reply-To: <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
         <1519638828.10722.153.camel@linux.intel.com>
         <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
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

On Mon, 2018-02-26 at 10:45 +0000, John Garry wrote:

> > > > > > >  for supporting an 8250-compatible UART with
> > > > > > > the following profile/features:
> > > > > > > - platform device
> > > > > > > - polling mode (i.e. no interrupt support)
> > > > > > > - ACPI FW
> > > > > > 
> > > > > > Elaborate this one, please.
> > > > > 
> > > > > So we need to define our own HID here, and cannot use PNP
> > > > > compatible
> > > > > CID
> > > > > (like PNP0501) as we cannot use the 8250 PNP driver.
> > > > 
> > > > Why not? What are the impediments?
> > > > 
> > > 
> > > To support the host controller for this device, we will create an
> > > MFD,
> > > i.e. platform device, per slave device.
> > 
> > There is no answer here...
> > 
> > > > > This is related to the Hisi LPC ACPI support, where we would
> > > > > create
> > > > > an
> > > > > MFD (i.e. platform device) for the UART.
> > > > 
> > > > Why you can't do properly in ACPI?
> > 
> > No answer here either.
> > 
> > Sorry, but with this level of communication it's no go for the
> > series.
> > 
> 
> Sorry if my answers did not tell you want you want to know.
> 
> My point was that the 8250_pnp driver would be used for a pnp_device, 
> but we are creating a platform device for this UART slave so would 
> require a platform device driver, that which 8250_dw.c is. But I will 
> check on pnp device support.

Perhaps it's not visible, though below is a description of the drivers
we have:

8250_dw - OF/ACPI driver for Synopsys DW (+ DW DMA)
8250_lpss - PCI driver for Synopsys DW (+ DW DMA)
8250_of -  generic 8250 compatible driver for OF
8250_pci - generic 8250 compatible driver for PCI
8250_pnp - generic 8250 compatible driver for ACPI

8250_* (except core parts) - custom glue drivers per some IPs

By description you gave your driver fits 8250_pnp if ACPI tables crafted
properly.

Share the ACPI excerpt and we can discuss further how to improve them.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
