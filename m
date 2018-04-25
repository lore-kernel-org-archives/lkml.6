Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-424520-1524646864-2-10136937444448899822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524646863; b=IHzpKk3uQQCtE3phS4bj83/hcO8pIUxRHFtNR+1j55+HcJgGvw
    bg1ULG0YJ9OCfGa5dw/BLp+XJ3ZUtsNWFnrqYQCMn7nCV4+OYn2IIY4+vb7ZATat
    YSgt4KEDBX6/QwjlnhiF3cmxoWBJmHLVmhoBI7xq+wLf1nAFEPgcYpRVBPTs6Xw1
    0RF+C2SjhehugFIRzkqNaOTxGp9TbKpUYUorYapZ6tqWmdbyaehhp4R0SWroMPBj
    Z19Do7M8hfsjIC1V7Tvgverp3+9stz5BUB4eMXqd3r8gG3Ed53CrvuOgRTy9DLRj
    /Wd+3aL0cvhv1ELVD0UoRvut519z6+kQ3wiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524646863; bh=V13EvU9OGx
    fAfFChE5wJsSN6wD/cT8v+oH/PeEhRYSI=; b=d4hphthFZ16DKXsyPAD6ngEZej
    Na86oVkZ+vpHo6EVGTXUFcfLX9X6VCsz+mEZJqRJgW/ksueIsbETggPmZy4v4CCb
    J2MB+ZvmUlq+XtHu5JsRWfmLmD5W3H7Le0LxshsacxVndUAIM1UheJeVBHHle0FR
    y7qZg7P6Vk22nPXsiYrpxVsRv/UMxySIN4Y/HVeBRnw//joeMkFJaAi26wldHnpU
    W94zEbOSf9wRjQemVwtbw9X7xGtn0iE7PsPGpaAedlug8v8VXDLnfuH7upcJCECn
    9PoyDfJV8LkW+kW1DHEwk0tvk9Zx+SCPEGH8qQX1cESDay8upNUydzVJzsZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGfqJnv/UipEBs4BqPQ2kMR70GzTHuGT6ZoVH89kEwr0u7EDMWToIDsKGfWDtqGoZT1GDQOiRW8wSwVHW6sP5guTpJs0VNah3Upb0k5Kj1nmytVI5gy5
    A7eLf7/CtFPsiImrjrMU4WcFXLRNvkuQMwnkCplAzJetkqLtOLEWpe/nrYXqnxutIkHkpXyCp0JHMncySR73y4LrUYkhiR160WFafee9RffBWCbqwbI00iKF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=tfi1UkxUlFUStMbF-Y4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeDYJBA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 05:01:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46637 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeDYJA6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Apr 2018 05:00:58 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Johan Hovold <johan@kernel.org>,
        Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, Rob Herring <robh@kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
        <frederic.danis.oss@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC][PATCH 0/1] serdev: Support HS-UART serdev slaves over tty
Date: Wed, 25 Apr 2018 11:00:47 +0200
Message-ID: <1821148.enBAg0iGPe@aspire.rjw.lan>
In-Reply-To: <20180425074736.GK4615@localhost>
References: <20180424082954.11453-1-shrirang.bagul@canonical.com> <b4947b3c-15b3-15ea-e1b7-38169f11d0f9@redhat.com> <20180425074736.GK4615@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, April 25, 2018 9:47:36 AM CEST Johan Hovold wrote:
> On Tue, Apr 24, 2018 at 11:16:38PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 24-04-18 19:18, Johan Hovold wrote:
> > > [ Adding some more people on CC. ]
> > > 
> > > On Tue, Apr 24, 2018 at 04:29:53PM +0800, Shrirang Bagul wrote:
> > >> On systems using Intel Atom (Baytrail-I) SoC's, slave devices connected on
> > >> HSUART1/2 ports are described by the ACPI BIOS as virtual hardware using
> > >> HID's INT3511/INT3512 [1].
> > >>
> > >> As a consequence, HW manufacturers have complete freedom to install any
> > >> devices on-board as long as they can be accessed over serial tty
> > >> interface. Once such device is Dell Edge 3002 IoT Gateway which sports
> > >> ZigBee & GPS devices on the HS-UART ports 1 & 2 respectively.
> > >>
> > >> In kernels before the introduction of 'Serial Device Bus (serdev)'
> > >> subsystem, these devices were accessible using /dev/ttySx nodes. But,
> > >> kernels since 4.15 can no longer do so.
> > >>
> > >> Post 4.15, with CONFIG_SERIAL_DEV_BUS=y, serdev port controller driver
> > >> handles the enumeration for the slaves connected on these ports. Also,
> > >> /dev/ttySx device nodes for these ports are no longer exposed to the
> > >> userspace.
> > >>
> > >> This patch implements a new driver which binds to the ACPI serdev slaves
> > >> enumerated by the serdev port controller and exposes /dev/ttyHSx device
> > >> nodes which the userspace applications can use. Otherwise, upgrades to 4.15
> > >> or higher kernels would certainly render these devices unusable.
> > >>
> > >> Considering serdev is new and evolving, this is one approach to solving
> > >> the problem at hand. An obvious drawback is the change in the tty device
> > >> node name from ttySx => ttyHSx, which means userspace applications have to
> > >> be modified (I know that this is strongly discouraged). For the same
> > >> reason, I am submitting these patches as RFC.
> > >>
> > >> If there are other/better ways of solving this or improving on the
> > >> proposed solution, that will be most helpful.
> > > 
> > > Yeah, I don't think this is the right solution to this problem. It seems
> > > we need to blacklist (or maybe even use whitelists) ACPI-ids until there
> > > are drivers for the slave devices that would otherwise be claimed by
> > > serdev.
> > 
> > FWIW I've been using this patch for a while for realtek UART attached bluetooth:
> > https://github.com/jwrdegoede/linux-sunxi/commit/bc904e3703940600ca66c65fcdb0a8cb01dff55d
> > which is a gross hack.
> > 
> > If we're going to do a whitelist for this, it better support some sort of
> > wildcards as there are a LOT of BCM2E?? devices which need to be on the
> > whitelist. I think a blacklist would actually be better though, this also
> > documents which devices are lacking a proper kernel (where applicable).
> 
> Yeah, you guys know the ACPI space better than I do. I just fear that
> if we go with the blacklist approach, we'll be playing a whack-a-mole
> with this for a long time when people start upgrading there systems to
> 4.15 and discover that their serial ports are gone.
> 
> Since this would qualify as a severe regression, me may need to consider
> adding a serdev whitelist for every ACPI id we add to a serdev driver
> instead.

OK, so let's have the ACPI discussion on linux-acpi pretty please.

Could this be resent with a CC to linux-acpi for some more complete context?

