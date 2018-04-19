Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3387646-1524151299-2-7547165917203967724
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
    1524151298; b=cB3MpLbEtaBZvzugMngFIPEhrlhIikIOthByojFxH2A9xBIzBd
    0t+QJ4uIj9KKp3eomJlb4QWLtyl+TnL1GrBb/n2QkhBbTCA2ToUAQE9n6AqhbH9H
    KK+4UwV/exsx1go5epj21CugcuEB9S072WPutnSHrapg3IBKXF08Mxa2t/e8AGni
    LkKecbEviwmIQ9aXl+oPZKsfHzuq1DgixQPPhxbUMDMR1ZEtO4GHuU/3mJDqdfpv
    4q5AzKIZhvyJWyiy4IEqXOG31jh55dSGxFfz6VaOvb4vZetDOGnSSBJaMjrKsgYk
    D1hL73y1jkEXZd5k0udhDLAbkdRzXn0NnJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524151298; bh=fimLDcEnrwpc3bmg4be261pYHItEIt
    Oj1az5TeuVd8Y=; b=ekLZvObCwB0VgMuzwRrhqWwxG6hBBU/vvtnpvZKTZjKGPz
    a4XR0AFBlNoyulNdTyHQzFRFQpVqKhExt0ZCGBvSe/DwWwCGfKTaN4tAI1FVoVvM
    BFFlvBB3M3wtTmQ4JGqf7B8jTDUlGJVWdXZLgjw2sdwDmTbr09VfGC41v9jWFKKC
    t/8Z8Z05+GjPy+porRmseUxKLO1jaJMrE6LxHBFcDxsw3HKtFyz+bJQl04CAb9QW
    H5swYnX0nh155hYtKGN004alpKJYpGcAa7SBRtI8aT0eVVhn01pokFZrsp5iEI1/
    IyqywqrA1r/9EptY7NbsDJ3qr9ffoWJyo1VlhI8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=w2DgWc/O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=w2DgWc/O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNPdtfNnDuGkhcll+nskuuS1nHLmjULi1+IBvMKf+ibhJj5K8apFcGzFr3XwCmFX2xuaCmHqAg83UH4ZV0m7BlpkCePix6u2YOfUvBqMBgl3BP26wBRE
    neNVmxE79hOApN+oXHS4Y8ZMYuxTXhjzD9pCBF1LR0JujiAxE+sg/lCDJsuy2e2CqN6zxzDQnX7j/4dDMLbqgCucbpPPvbrmW9fx56/XVK/0lK+KHn8Fnemu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=1QVlcQhT7T7X-otDeKQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDSPVI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:21:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34178 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751695AbeDSPVG (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 11:21:06 -0400
Date: Thu, 19 Apr 2018 17:20:56 +0200
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
Subject: Re: [PATCH v3 3/3] dt-bindings: Document the DT bindings for lan78xx
Message-ID: <20180419152056.GD29658@lunn.ch>
References: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
 <1524148325-78945-5-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524148325-78945-5-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:32:05PM +0100, Phil Elwell wrote:
> The Microchip LAN78XX family of devices are Ethernet controllers with
> a USB interface. Despite being discoverable devices it can be useful to
> be able to configure them from Device Tree, particularly in low-cost
> applications without an EEPROM or programmed OTP.
> 
> Document the supported properties in a bindings file.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
