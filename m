Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523542650-2-1593468952506354861
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
    1523542650; b=Rws2k/J5e06lD2hCjqStQb14gP4l/ezq6JCcX1UIPcBLX+kx5y
    IdmsOifGkXHv6VAzfR7gqRcr8pgaZyeocqWyxbOMO1VU10BkzOuEq5yuJ6AMFgd8
    KtCDTCCvicZr14EdXBgIPEb52D7t5bUZZQeQOlFk5fhf3VquZ5yYIfLEnYaqJC/c
    SgP5CcXafaQhWSSyefr5blYmBZ53VVe9LNtjjlQYxkf81vzPs7gebIBsyQond8+E
    rkUmuQOD8hNRF40XnMVNjvmwx9E2F34mQmHeIvBz2vqExvlcbHb/rpiXTT5zSk7d
    WAEJLqBlqlS45IyNWarinKcsY2+uGIuszSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523542650; bh=5DP704nQ+C/lrMMPkhBdzMmRy4fMBU
    yFPvW39SlMpH0=; b=oG3LeiLIVMsDSc699wRC/yT75r2ocOtE6Zzo7M/sfUL34O
    nPqbNjxmsFZFc5E0eF++S8U7b2vPiafp8jUHodrhLknrhd22SnNGxqSyIIeVIRwD
    ZePzLqLVpvczCcEBawBEBnKuls4fbAhfTBhycHXM3meNxrUgCA9s/unbyDKabysj
    PiurRjjxbX6ntp3Pz0fucH4bXaxCS1IHRkW1KfbUpZM53qBFc7jIo4UpxZqWn1te
    yPppM2Rc3JiodWekqyzaVrW9egzXsOCURksOSPNa8erepE4YGvHgI8FxsSE4yyte
    O9S+erJvKXNAj9p4ctJzHNitfA49d+IrLDVbM5JA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=Co1TI5jR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=Co1TI5jR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOB2IaeUUkJBcbl082JqvgOZAzOYzHWA5VeWlh0bVcor3LPsXRHo1zRph21HaItq7tTCIKHAoteM6K0EHIGr67EMIUKqOCS/l6IfmlPOApeZ7YrVOwSa
    uns8q++0WCIgPP+dZaCFdRydeioiufDDrLTY78CUz8XBtTcz6rZkbzf/V/XaIhm5YLXE4M+lKFSgfDa6ost+0nDVAFRTbJ+5vQQ0VOxFz9AxzL93oWd9vFMo
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=rMJZ2uwF09yAsjI6l6MA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeDLOQk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:16:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56588 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753027AbeDLOQj (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 10:16:39 -0400
Date: Thu, 12 Apr 2018 16:16:30 +0200
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
Subject: Re: [PATCH 2/4] lan78xx: Read initial EEE setting from Device Tree
Message-ID: <20180412141630.GM28963@lunn.ch>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-3-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523541336-145953-3-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:55:34PM +0100, Phil Elwell wrote:
> Add two new Device Tree properties:
> * microchip,eee-enabled  - a boolean to enable EEE
> * microchip,tx-lpi-timer - time in microseconds to wait after TX goes
>                            idle before entering the low power state
>                            (default 600)

Hi Phil

This looks wrong.

What should happen is that the MAC driver calls phy_init_eee() to find
out if the PHY supports EEE. There should be no need to look in device
tree.

	Andrew
