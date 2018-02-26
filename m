Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2793630-1519647679-2-12285662237574186138
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
    t=1519647678; b=rdXeIXfFIApUdHNd9FYcV1eVHK2+56bgaszsogL5awSmF/2
    bzfsUJwoA1NdZny6dCdYzTHvL4E7hsjr1HGNNo/GMi/382+1D/Or9kJcDUNzdEWc
    1P0FhYA+5jjoLtURMbl+HKeDCaGi16lTITHlf53M7dsgwFbOeFCtR+buPdHa13Ho
    xJmB3794+nmfsaATlP1ZZChSzuVNc38qpxY4cgQ6Dcv8SZqBXg2TGPYg8D6jgpfj
    BnKjoEKVpKh4OZIm9reeJNEHEwIGJ3NwJS6zRM0WNu6MVKJtFY0mN0z0TG4LmLhn
    MD4fqDOSLl8D3BBDL2lz6IeXWm8NFtpd2tIKvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519647678; bh=RqrdA1vB9H1/So4rHjSun8vKs+O0YGrNotYZ5FvaRvI=; b=G
    WZktT3fn0p1YuOdF0bT6vkS8IvSZqJO2/KNvAPHgTGnygBHUilMkl0l1Dm8p8zQC
    RiAUgvMfC6hHJzQkgWZ1rc1JAnu0armsUXk+sdkKCf6UQeRlbnNMD/Q4E/RVnero
    Gk/vX30S/qFHEvCufRPtvMJN1q1sREK4c8SDdq4EDRiFbkCgc3+ggTCZF0M1VUhn
    k6zYA5eJjh2GhyQiv4tpiw+o9P+Ec1fKTiQs2o4EwSM9ixKOnxpfh7HwkFs0gVIx
    pYTU721B5CFIcpPN4ZNWGeI8Bl5XVS1Blf/vDktr675PIlRZ443UQO6mmowyEVD7
    /q5RUhWFjGqex81xzhVLA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeBZMVO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 07:21:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:51293 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeBZMVO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 07:21:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="20854166"
Message-ID: <1519647669.10722.184.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
        ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date: Mon, 26 Feb 2018 14:21:09 +0200
In-Reply-To: <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
         <1519638828.10722.153.camel@linux.intel.com>
         <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
         <1519644517.10722.179.camel@linux.intel.com>
         <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
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

On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:
> > > > > > Why you can't do properly in ACPI?
> > > > 
> > > > No answer here either.
> > > > 
> > > > Sorry, but with this level of communication it's no go for the
> > > > series.
> > > > 
> > > 
> > > Sorry if my answers did not tell you want you want to know.
> > > 
> > > My point was that the 8250_pnp driver would be used for a
> > > pnp_device,
> > > but we are creating a platform device for this UART slave so would
> > > require a platform device driver, that which 8250_dw.c is. But I
> > > will
> > > check on pnp device support.
> 
> Hi Andy,
> 
> > Perhaps it's not visible, though below is a description of the
> > drivers
> > we have:
> > 
> > 8250_dw - OF/ACPI driver for Synopsys DW (+ DW DMA)
> > 8250_lpss - PCI driver for Synopsys DW (+ DW DMA)
> > 8250_of -  generic 8250 compatible driver for OF
> > 8250_pci - generic 8250 compatible driver for PCI
> > 8250_pnp - generic 8250 compatible driver for ACPI
> > 
> > 8250_* (except core parts) - custom glue drivers per some IPs
> > 
> > By description you gave your driver fits 8250_pnp if ACPI tables
> > crafted
> > properly.
> > 
> > Share the ACPI excerpt and we can discuss further how to improve
> > them.
> > 
> 
> For a bit of background, MFD support was discussed here initially:
> https://lkml.org/lkml/2017/6/13/796
> 
> Here is the ACPI table:
> Scope(_SB) {
>    Device (LPC0) {
>      Name (_HID, "HISI0191")  // HiSi LPC
>      Name (_CRS, ResourceTemplate () {
>        Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>      })
>    }
> 
>    Device (LPC0.CON0) {
>      Name (_HID, "HISI1031")
>      // Name (_CID, "PNP0501") // cannot support PNP
>      Name (LORS, ResourceTemplate() {
>        QWordIO (
>          ResourceConsumer,
>      MinNotFixed,     // _MIF
>      MaxNotFixed,     // _MAF
>      PosDecode,
>      EntireRange,
>      0x0,             // _GRA
>      0x2F8,           // _MIN

>      0x3fff,          // _MAX

Shouldn't be 0x2ff ?

>      0x0,             // _TRA
>      0x08,            // _LEN
>      , ,
>      IO02
> 
> 
> The latest framework changes and host driver patchset are here:
> https://lkml.org/lkml/2018/2/19/465
> 

It still doesn't explain impediments you have.

Just few approaches comes to my mind:
 - move UART outside of parent device
 - register PNP driver manually for that cell instead of MFD
 - use serial8250 platform driver (I totally forgot that we have a
generic platform driver, so, it might be what you need to use at the
end)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
