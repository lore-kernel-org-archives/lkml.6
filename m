Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1114600-1523542045-2-10209154191927225654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523542045; b=HGOJ3kKnWzj9CeOr7C4RApKWTocXDOG/NTzXVp0w4eTAyuHFTE
    1nfzIU6Ldezp8zlLv2fwiAIDFiwl+2TWdko9ysPXJ42kXcgJtAV6D5htfwx6zzZt
    2zvFXeKkfHUn6eLneZ4fW/dFinpcHXCogPidqCVRi7DoxwaNOwzLq+Hqhqa+Vgt9
    npUaFBTV29EQtdFcrsnfhWGotYXin8xFwSgqF+CLEsNrWXMGtFp37/gsTLo+kJY3
    F7vmosjXZTL3xMz+xMlxK22ff6QB+Zq4EDkqidCl2cVhNKu4tqA1LfsJVnQJRDBh
    NkQR14/2vjxrUdN4is+d5mWWUxYJqdniIHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523542045; bh=WcV7tp4dLHBxTiLdbAiMBZkwXFhIfL
    8n8UjLl5Qt748=; b=W5sAnoBRAMHdLHyO0alUj47n9wRgLme7RFh9y80Wk+Hexu
    sQ/zUK40FjbMzdSjZVYapKZ/SlVf4CyL7R1pwEI9DlgzknVJKtG4UlUad/GZwP9M
    jek+OprupQTnMS2/vZs6fBYueUTqxfVrT9QZrAfz8rZheNw0ckpcBgaCADCbJbg4
    YcAXtcyALgMCpGs4PXTUj2uetxnwFxGiDQx4RGSsNH/5p0I8u0oJHQHRaQlBEdCh
    FmTyTgk6Xjpmu3V0AfYxEQKLBIQO5w+sjUnGmL+qs32Oib6opysB0lM3OkGg4rnC
    FiWA7klWoysKRqqrGo1LmvDX6hd7cYe9KLhD0WaA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=Xb3XlEhJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=Xb3XlEhJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBIAgS55b/DOiTuuKrFNo0wD+EZ6RLhVT0ne+X23/VJVBhNBazAaQX53Sj3ZkkQsrGhcCw4csWOw4nzgFmw85gPVcKE9CNxLUNBcdmkJym1UOxQF6Pcn
    8Lth54j+/0BQZx6Te0ss6EYSjTBBy7YwdntbylXIQNi38vAJ/gJTOvEaSvXXAamZwIzHrvEElRh9hwO+vnzVC4THqNxQVgGWyoz4GbvClKXD4rj2VsDz9Gi+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=oFDSapUtEFTxtmjfRvAA:9 a=j5FkOq9PeY42n-j8:21
    a=KqlWfbsfBvygfaWi:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDLOGw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:06:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56555 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752355AbeDLOGv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 10:06:51 -0400
Date: Thu, 12 Apr 2018 16:06:40 +0200
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
Subject: Re: [PATCH 1/4] lan78xx: Read MAC address from DT if present
Message-ID: <20180412140640.GL28963@lunn.ch>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-2-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523541336-145953-2-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Phil

> -			ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
> -			ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
> +		mac_addr = of_get_mac_address(dev->udev->dev.of_node);

It might be better to use the higher level eth_platform_get_mac_address().

   Andrew
