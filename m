Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-466278-1525874770-2-14049572190120573968
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
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525874769; b=KQktnv7qvxIy4aWwRVrbLYYZW9bcahejMuTIb2nzg0KayZ8/dD
    siVASpDlqHDAFcSlZYyCfNIsN2Trl1rYF85hjv9xhIP/93fOjnw858hM4FMdAOKO
    HQs0vaopy8iBpBsRQDd5EXQSgsC23szmCct2WH4s093YTOvFCeoT+vJyONGwj0pq
    WjGuZX21NMEtND5KUCkobgvbw8DFf91mRpLWjb98iigH6/WV34KMF+L1ThJKa+O1
    +klmSMoWGkbqNi+1EPXHl4Eqipj7mmlTK8stWbRpfqaTWlnDUMMdPPi87AszBJAa
    8gWJK4uxCkYdtYSUoBgnS3LBC0eXH4RxeqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525874769; bh=x6T0e0zzWZQONe2hPpCdmFWTgPURaa
    vKos42YsIP/Ws=; b=kHIyutLe3niwwCx/G7NHazZxdek9pSzrXHcQdFZVaAM94u
    GsbzGrg73nlXfx/31QrtER/31CFwaIQH9DHMjaNEMxdTDTfmzlf1m0Q4Dhb+chlg
    IPfM2hM7+IrTH9V1iXZsPDIhJa/inAbztjPBXliXWhnOY2VrLvAtcdp/ljPGG1J6
    HIFQacRVfR2OrHa/wpkWgL0YxGbOKKbiHF3zAPGw75MuD6BSTQW72zmmUWykEKXE
    oLY5sqMG04B+RRwo+ChF7pKqpUWCopJ1k2P+fkm38S3fdeBASgj3PndJJlARhr3a
    k0zrM0RIEDq8zn8W9Woj1m+1oHR2lacgzsTB1IfA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBWDhcUYjhUFfwlhUtq+toN/ZkITECx6hDr86VB9BrtTg51dqfVmPay7He0mYbUNy95WfWFxdklj1T6hcFOPdBsFpL8WCa2/19OS7OxkSOkKYv9xQrE3
    IdLotUQmdK0rM5QX4u8Rrx0OdXTzrXnAKSMlLw1I6wosrb/m+Ra8v2eO8IlOsIqRkXFQBKovvzygKcK0STw4ZgoDxeT1qI8AFaVd9qMtSTkZcE3meG0DBiim
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Pf7XFVqDR4rZxVO0ShQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756541AbeEIOF5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 10:05:57 -0400
Received: from muru.com ([72.249.23.125]:41420 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756375AbeEIOFy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 10:05:54 -0400
Date: Wed, 9 May 2018 07:05:50 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: Serdev runtime PM (was: Re: [PATCH 4/7] dt-bindings: gnss: add
 u-blox binding)
Message-ID: <20180509140550.GC98604@atomide.com>
References: <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180508155608.3bzcbepsmoskhlox@earth.universe>
 <20180509091831.GA2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509091831.GA2285@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Johan Hovold <johan@kernel.org> [180509 09:20]:
> On Tue, May 08, 2018 at 05:56:08PM +0200, Sebastian Reichel wrote:
> > I think using open/close for runtime pm is good enough for GPS,
> > since it regularly sends data and draws lots of power anyways.
> > But devices, that have an out-of-band wakeup signal can do proper
> > runtime PM of the serial port without loosing characters.
> 
> Yeah, there may be some applications where this is possible. And this is
> not the case for GPS, but not just because of a generally higher power
> consumption, but due to the fact that we cannot afford having the first
> message in every report burst be dropped.

Well most of the phone implementations use one or two out of band
GPIOs to first wake the UART before any data is sent. For serdev
this can be called from the serdev consumer write function for TX.
For RX, the serdev consumer needs to implement an interrupt handler
and wake up the parent UART before serdev RX.

> > Note, that OMAP does not reach deep idle states with active
> > serial port. This is not acceptable for low power devices.
> 
> Sure, but note that OMAP is the only serial driver which currently
> implements this kind of aggressive runtime PM (besides a couple of
> usb-serial drivers). This means that a serdev driver can never rely on
> this being the case, and therefore needs to be restrictive about how
> long the port is kept open if it cares about power at all.

Well by default we don't allow lossy UART. It needs to be manually
configured via /sys for the timeout. With serdev, this can all be
done with no /sys configuration needed for the cases with GPIO
wake irqs :)

Regards,

Tony
