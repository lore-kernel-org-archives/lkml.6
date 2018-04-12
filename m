Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254786-1523546495-2-7618987347704965086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523546494; b=qXIZiuyFuQyOTlLnJFyKxUS9jVSOSItOlk3jwK9PZtF72tKA2R
    cRMpT5fWLcorXi9IrsKMPb+bP4q/n0/TWuAlZ4cNHv3t8vZZaBG9OP0CWrDaYMRN
    qoIhVE3hioAdSiHV0XTDLMqy6ejE7RGQMYACOdP5Y8NyRp5Y0yaxRsOrDvDSsoIc
    zhdxbBefyK1hmYudGx0nkQBH8qBJLrQtZ1fPkL6Og0LYBJ3QfKtO1peiAAJyqyQc
    7SNjHaowQ7qXTFr225uoYRDxIsRbtVuyku6DrcT3DPGb7cyVjutciPZzZ+el/Gwd
    TblXhsHN1XNgvQ21I1dhZnAH+QraxirPcNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523546494; bh=M6MO/D8kKB
    CorVq3nGPQyicsNNY6Ej4+buLfTB8lwFc=; b=UHnceCKk7bveJ8rZcFYcWdm6FJ
    umcHBQc4GJ9KPN6uyUuw2HkMmr4fqAU25a4sqvn3DupBlbcYKLlkMj5gJay44Z5q
    jHR1l4emJHe82VicZlsSy6I7M6TzdNJo/UvsorZCBwaROp880Qq4XEMV1+93eRr7
    FGZyIBpvTFexJFSeAUMdLooqJR8nFrRYJMJdWqPPbR3ClTzU22zeh5D8ZgRehaG2
    5F9xTL7BzYk0I4Bv9HXFf7XzBOfhjRL2rnpvZSOYDvCHszXZuM/mmeupmVLPuv9Q
    uutbcDndnDmXzI2srf0hekWJQ+y+BzbA6I8THmGUNcaAZrFJOVgiF2L6QfjA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6nOkTdUKBcMbF1UwPefVCiUFDKTHIPJrR/jZHfTxS4vmBL23jGXkQGw+wRB9xCjfsE2lS62UPmD5XobS7rZcM16UsUto0ikFH35pQBhmzTifB5VWXZ
    Ljt8FARXz/SxkrovzrnaYyJEFHr7tt57j5KuTbVHnxKNDRrk0Ti2e/YViEDbGXsrULDkpLAwwfq0wSbKRnES1KqcFwucsliz00KHmRNKWiq2jmsCKqbn3SYe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=-mWGVWDaP3wA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=kil8HlhKtMPG8N79MCMA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeDLPVN convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 12 Apr 2018 11:21:13 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24743 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753625AbeDLPVL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 11:21:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,442,1517900400";
   d="scan'208";a="13105923"
From: <Woojung.Huh@microchip.com>
To: <andrew@lunn.ch>, <phil@raspberrypi.org>
CC: <UNGLinuxDriver@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
        <rdunlap@infradead.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 3/4] lan78xx: Read LED modes from Device Tree
Thread-Topic: [PATCH 3/4] lan78xx: Read LED modes from Device Tree
Thread-Index: AQHT0mYDUWzYJ1048kSod0NWy6oe+6P9p/WA//+U1pA=
Date: Thu, 12 Apr 2018 15:21:09 +0000
Message-ID: <9235D6609DB808459E95D78E17F2E43D40D17852@CHN-SV-EXMX02.mchp-main.com>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
 <20180412143655.GQ28963@lunn.ch>
In-Reply-To: <20180412143655.GQ28963@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > @@ -2097,6 +2098,25 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
> >  		(void)lan78xx_set_eee(dev->net, &edata);
> >  	}
> >
> > +	if (!of_property_read_u32_array(dev->udev->dev.of_node,
> > +					"microchip,led-modes",
> > +					led_modes, ARRAY_SIZE(led_modes))) {
> > +		u32 reg;
> > +		int i;
> > +
> > +		reg = phy_read(phydev, 0x1d);
> > +		for (i = 0; i < ARRAY_SIZE(led_modes); i++) {
> > +			reg &= ~(0xf << (i * 4));
> > +			reg |= (led_modes[i] & 0xf) << (i * 4);
> > +		}
> > +		(void)phy_write(phydev, 0x1d, reg);
> 
> Poking PHY registers directly from the MAC driver is not always a good
> idea. This MAC driver does that in a few places :-(
Agree but, some are for workaround unfortunately.

> What do we know about the PHY? It is built into the device or is it
> external? If it is external, how do you know the LED register is at
> 0x1d?
This register is not defined in include/linux/microchipphy.h. :(
Also agree that there parts should be applied to internal PHY only.

