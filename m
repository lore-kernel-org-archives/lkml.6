Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1135939-1523543476-2-9467445030544731989
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
    1523543475; b=LbiV+Fs9YOOLMYOX453LBK2LxxYSwLdME6+YW7Aolslmmi46pn
    4OPu/kvum3Kj61qDwgHYKotk7pAU/vIeyKra/8hi3rsw7Xxzd+lyt6cmp0i/3zyb
    Q/3/GiS6LEWkTK/VrCQEe8fDAfq/vpnV30FuRxKhbpbNpkwTAXvMwA/UTEuA2GqR
    WPs9HMIsxMs1VAgrJJ0crDFOSW2UeSHEepvgOXOQEVIYjYdR/ILAwReOjl0s1nlw
    cWu49A7zQoEc6ml0j74K4jqWvDhROa7B7WSPqpYklU9zZT67VOO7H0/Z2us9zg91
    vy99W4kzGkMBebI4NgsO5X+lJd9onHgHxh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523543475; bh=3YJ/uNSH/n1kMPEfUZle0oIyFHiHHN
    f7A7eQk1E5SzI=; b=myIS75au6hkcIvvddxuvdBppf/JI/zgIxDQlVys6lMFIgV
    b6hbyUGTuQd2Ds/+4pTSPxIrfUqoqJvqpJely4E1rvKdcHDZgUqGfZXq0fFomEXZ
    9polEXWDEUCdfJ/uToIEDZHizyi1sEHphMQfRKtanw0FZkzsaGkic4rB+1XVeTj6
    3zn8eIBxaWoLRRSIoGSRtvxH8AnoFI3InHX6VemVgWhW1dDSsQHrmrhTPpBhTymV
    XvaBCbFeAgpxKpzncvoVi2FceCQPjWxg5iH01me0kp0OlNl45eRX5LzwPNHIzqHw
    msfhgNQbWT4YNoBSy+mhM2AwIPQLD6pqLm/XhkZw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=jaFRv/sS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=jaFRv/sS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPYTromIpTxjhPycY2E2fMWw1zLI4uyfrHPbBbUU4eT8UeMzfOs/sYdUgGuQX1NGgjpkYyk8IBh1kCd/fWL/L4Y9eY5lwO80aEz7oVitciiUWpi5xb0e
    XFlsHmzQSsrCK1TUS3qBrHswf2FVJV0W80kef9WeI76Pte+I+pny/8Ta+C78pMvO7QYylaGlUs7TG+YL/yYNaD45DFsAYG6PMdL+5dj2aPGYF0xkwhOORqTu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1QVlcQhT7T7X-otDeKQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDLOaS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:30:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56643 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbeDLOaP (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 10:30:15 -0400
Date: Thu, 12 Apr 2018 16:30:07 +0200
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
Message-ID: <20180412143007.GP28963@lunn.ch>
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

It would be good to document what happens when there is an EEPROM. Is
OF used in preference to the EEPROM?
   
Andrew
