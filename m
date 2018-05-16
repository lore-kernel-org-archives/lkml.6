Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223910-1526473740-2-119011492491314182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526473739; b=JJGkWqSnA+thYtkboLvYTWMfTC6u5Wow/Arr18FNPZIoLWFV7Z
    hfVKDLccwDGDN2eY50fmFaUeTuJ/2YKjcgaN/KD9mkG3rHtup4K6YFlyTf5pvjbo
    q4nBNOwzl5h9pLOx7yyRfFxAkHUvN/O9I0wd1H5v6HBP3Z9+vpwiVyaRB8pzW1OF
    qJvbV/b5h9TewEg5NCBT7YeMfZ6S9cLEdEj118S9IuU5vVKaommxH1Aha3o8MX9c
    xNr2g0hvOCyULjF//pwY81VUbw+rLP+im+ixUsWWr1ePZt+DDJOfn9tDOAEdTLdL
    ZeGMgsbxRyVsDrwtmT+HKwGokXtVXHSKu0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526473739; bh=XCdVMqHKSOzDMefbim9/L6/k4omLZx
    LbyMVRkc+Z1Kg=; b=bZlzCxn/AAWbqfWC6sMfmpmqSppJ3SDBWiaWA/Fnmz7Mbp
    DJvHH4RNNBOqsKWLfA67yIsk+0cifQuu1kO8RlQOVPIxjlVHVCoBad6TXTiV7bcg
    LIefLqJjhfOYrvBCP2yfI7soGiKdNYl0rJJyBNIy3bIN8N5wlKy7PswsHFqXI0L5
    SIr8k80rEpdnfs56NVqRizQsSCsXqRtQ0Lp/F3Nz81uguKy87Pp9QyH5ncDK5r/l
    c4PRt5PTxHpVzDfkPk/5AmTji0B/NiHJu4H8UBJ6ND5n6H1EZFRaWMGIuQgy/AGD
    olqhkfzRrrQtiHY9ajNmZs6YhRBG1P3Mis+U/QBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=lunn.ch header.i=@lunn.ch header.b=57C+Ui6H x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=lunn.ch header.i=@lunn.ch header.b=57C+Ui6H x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFo1YWJEBKHv6my5I7INPeG5tqkV9HdMkbZ4l4B+CfoL0c7no/u/zQkVeoG961OrqLZZT7F8caizXv6+3DLhbhORIX3uRqtOZCNRj4yrE7EEWkeGc9wY
    S1t+qophmV6Uh7nadJTuuoKhDV1hoyG9sJuF9OSFFMIeTtGOnfN8zlNELkJDh0+kmhtBbfiD3lKJatjpgKixp5EBtVWpTWgKqy+9PXbPA92k37w7GIW/0X38
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sb4BWfqoS26idbJNdK4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEPM2l (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 08:28:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:32967 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbeEPM2j (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 16 May 2018 08:28:39 -0400
Date: Wed, 16 May 2018 14:27:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RENESAS ETHERNET DRIVERS"
        <linux-renesas-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
        <linux-omap@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] of: mdio: Fall back to
 mdiobus_register() with NULL device_node
Message-ID: <20180516122752.GC22000@lunn.ch>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <CAMuHMdXfOOgADe1my9Y3s3b9_OsXPjbqq1PPFR9izZWhtPuaFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfOOgADe1my9Y3s3b9_OsXPjbqq1PPFR9izZWhtPuaFg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 10:54:12AM +0200, Geert Uytterhoeven wrote:
> Hi Florian,
> 
> Thanks for your series!
> I like the effect on simplifying drivers.
> 
> On Wed, May 16, 2018 at 1:56 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > This patch series updates of_mdiobus_register() such that when the device_node
> > argument is NULL, it calls mdiobus_register() directly. This is consistent with
> > the behavior of of_mdiobus_register() when CONFIG_OF=n.
> 
> IMHO the CONFIG_OF=n behavior of of_mdiobus_register() (which I wasn't
> aware of) is inconsistent with the behavior of other of_*() functions,
> which are just empty stubs.
> 
> So I'm wondering if you should do it the other way around, and let
> mdiobus_register() call of_mdiobus_register() if dev->of_node exists?

Hi Geert

dev->of_node is often not the correct OF node. The mdio properties are
often embedded inside a MAC driver, and use an 'mdio' container
node. This container node is needed, not the device node.

> I haven't looked at the ACPI handling, but perhaps this can be moved
> inside mdiobus_register() as well?

The ACPI binding for MDIO and PHYs has not been defined yet.

    Andrew
