Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1135939-1523543889-2-7621779321021784870
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523543888; b=E9Iv4z0T3lQUDtHJF8PzWFyhUgGhUpI2y/+TPyusZ+m4FDu4xd
    2/qwvwUgkrUuIve+ahFqchWG5yScKIjdi1ZKBD5bwt/ZTHalQRJytUwO6hYtL4qU
    w3hy6UQdObePlEO6Zm60gZFDucx2svxM+pODBZGlNuJbNbdd8uQabXGRt4oZoc4n
    IwGIe2p2FXfvaaRUr2RAan8z+kjzVlxLh+PAqEU2fo0qvx+xj1OQZJFQRCKHdxXl
    d1wvfd6xmN/i7rasuf7TxPS8Fvh90e42DCIjU72jpuGasNTLe7JvWnQQTBT16koZ
    iVjYSuUnHxfLmOoyMiWHisuMgYbIJTVoJh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523543888; bh=DtcGCZnyx94OsZGkd4k+fel4ZUstnw
    3xZjewMhxem+0=; b=nOwkMlQ33VmKnnV/OWMXeQlO29dUTyf1KZ3oTwpTMPQ/6p
    GIB/mRxDxx++y62llK9xSW4PTW534X1HgULN4aIRxBvdjtjgy3IMuUnR/3EB7Aoi
    iNHzVM/1qz2KmsI7oIIvXDPSh8i6IVnmtHgONHkAw53rPwUWZww36hy3/J1RA2ZY
    7kvU2HIcih8degpLfqBwcuE6miGVS3pfC/hxSN1wglcLvwPZ5Qe/X8y79UGGw3Rj
    Zl5z1UOWU7eMNBGS0V3+JOXgWL5TNDMOcELYKrkoiK9LYPz7td8cso0JAJkuxBPf
    fLst47rS4FdPxx8dni+EI091wpIWg9uNxp6Qy/SA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=0pmeFTzc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=0pmeFTzc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIv9eSNTQ9Koq0kVih3Ba+jhUSjnd/eCQ1ZJ1BsSf45hcsVS+qfVCUvTJBagVb+MjXj98WBXzO0XqP8rdyo9gpbAw+jJol7W9rt437vLwV/vwlVkfWDv
    lQFWB4R+PColVLR4q7ew6ZUmGMPDMD+KtBgp33JdL53986B+mGBNa12mUIiKC8WvHpfBE6urygm2B88k6m7UfFl2CUZkeCPBoyZMTETJJsDV7Go3nnHMdmi/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ENvI6J9HvWqDBaQt-aEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753217AbeDLOhH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:37:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56669 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbeDLOhG (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 10:37:06 -0400
Date: Thu, 12 Apr 2018 16:36:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Phil Elwell <phil@raspberrypi.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/4] lan78xx: Read LED modes from Device Tree
Message-ID: <20180412143655.GQ28963@lunn.ch>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> @@ -2097,6 +2098,25 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  		(void)lan78xx_set_eee(dev->net, &edata);
>  	}
>  
> +	if (!of_property_read_u32_array(dev->udev->dev.of_node,
> +					"microchip,led-modes",
> +					led_modes, ARRAY_SIZE(led_modes))) {
> +		u32 reg;
> +		int i;
> +
> +		reg = phy_read(phydev, 0x1d);
> +		for (i = 0; i < ARRAY_SIZE(led_modes); i++) {
> +			reg &= ~(0xf << (i * 4));
> +			reg |= (led_modes[i] & 0xf) << (i * 4);
> +		}
> +		(void)phy_write(phydev, 0x1d, reg);

Poking PHY registers directly from the MAC driver is not always a good
idea. This MAC driver does that in a few places :-(

What do we know about the PHY? It is built into the device or is it
external? If it is external, how do you know the LED register is at
0x1d?

The safest place to do this is in the PHY driver, and place these OF
properties into the PHY node.

	   Andrew
