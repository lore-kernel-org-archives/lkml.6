Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523541894-2-10230692486676286865
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
    1523541893; b=e4u1Jzz0kWC81VUYwHzQwKGfjrroIjh259feb2TVjFtuGzb61z
    uWmwhUIz7BNIstiil+jEoixkplMtuUDp9+9z+edSC5+3Z3UoZ0r1xbcelo/vdLiT
    pGg0tIBoSIiMp4RMMOz13VyVAFpuQnhTBomGP+74J1KEaH/yuhbd+j/r5D06rRtE
    sxCDJhPWapaMj6nGwN1moVzoKOFhuWOrYCmrZncpPh/k7OwgHuQcTQAcCuIXBdit
    dSOSOHgryF3xTw2w2vut3J5JL7O4r1AZUiDpQ08YTdYzYjdML9TjkYnyuC9uCsRt
    hBU1nv7qTKIxd8NLKRSQ90PtpmVHQkN1qDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523541893; bh=yY70CR/PWhRMVDCUVjNOaxB1p1DH03
    TR/7ibIx3CMb0=; b=ra9pl1LclcDX18W1WKRNI5yYL2mIbx6T9TjapwVCuRd1WT
    kVMhNvgd1lt2q4cm6kOmjhFh+jM39IXRQY+TOM/CDYX5g4uhRRocHAslytUJqVcp
    JGKoNR+R903ne/dHC5YmGe/wVRQerDYecHpYFjbT6h/+j3FpAGDRotR803tg9glA
    bh7F9ypRQW+FW3Fjmk5pMvYPdt4Dd5ldrnOgdmcWHUGMfwWlG8ReXQd2GRanJ3oT
    /Antn+kgMg/sxRr1JC87Nj8gY3zjaVqnQFu1fUU0WE217K2CUaWc1HmfBPiONi3o
    xdNCRsrQknEamoxMO9TAi4fuqqlRiN0whKEVO0pQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=B2w/0OZc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=B2w/0OZc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO4+UccAX7cKJR6g/E5LXyO4qaB1HG/RPxTgxX2AutRmyGY9u+Fhi9Guie++qJOE6O90Hb6MP7WqV/852kDUiPFTiWQaBxBDvSYeF/ZJhytOjYkT/Gnp
    D3mnzFY++ydE3PuLk0s7WAU/pHoVYXeZ4UWhcB/8ntYT4PaS4SWDd/INdt7oqBDhSeYm7e2kEpq1Z/BLcGif8tAcry8THYQlPCNUFN5La5q67U2eQGo0JvhI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1QVlcQhT7T7X-otDeKQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDLOEc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:04:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56541 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbeDLOEb (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 10:04:31 -0400
Date: Thu, 12 Apr 2018 16:04:09 +0200
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
Subject: Re: [PATCH 4/4] dt-bindings: Document the DT bindings for lan78xx
Message-ID: <20180412140409.GK28963@lunn.ch>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:55:36PM +0100, Phil Elwell wrote:
> The Microchip LAN78XX family of devices are Ethernet controllers with
> a USB interface. Despite being discoverable devices it can be useful to
> be able to configure them from Device Tree, particularly in low-cost
> applications without an EEPROM or programmed OTP.
> 
> Document the supported properties in a bindings file, adding it to
> MAINTAINERS at the same time.

Hi Phil

How you link an OF node to a USB device is not obvious. Could you
please include either a pointer to some binding documentation, or make
your example show it.

Thanks
	Andrew
