Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389010-1523451482-2-14669119033142513572
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
    1523451481; b=YS/ZPwJyoiW4xNdg4Fr2jczd7CMnUUFF7/8uDVF5EHtfksHfnv
    P4vBSqg+YrJ0aDE1v7hmxLiUAKe7Dff7MSADoWqDVqqzSuNSDhP0tlhfep7HXAMv
    qHySGPQvvGAlyOqxck2tQSOclAHKnHEt5r6ugqmFQ5iysjS4M4V0s+cMl4IhYAL1
    TCHppBeb82u/OCNQ/2z2fK7RcQNv7ps9VeM4nEycrYqXWCulPPuLxVJQ6Dxau1DE
    /soRr09qfkeXKhB03tWIDTKG1uDL1YfXfZ7vYdoN65i3M9rz6DPUca5q8YhiWps+
    NM2rUVyo4mT5m63EqVlOzyHNVnfFJvogT9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523451481; bh=Vlmqscdb9WOaJw05UtIpgAf2bkDcUv
    xc1s8Mg/vSOp0=; b=EqE4cwum20nNyLP8rv/TPzRCCtduUMREPWgqhep/Ox5PF/
    n2NVBcIqw72eoK6289mwZMXlNTE6TNbqfZaflI7w3o2n0ohKXEfQnynIt6WNoe4U
    gWU+pPXSinsZEgXBDccIwvjpIzqBaojMZGsrbYjvVsLEkmceTzlZ2rRInztorqK2
    46+UOraBRSd6GckrHpCK/Pmvu9dHev8yvrmrQ1ADFomSyJhSUESgQMgMjKoMRlOD
    PjNC9YGC/xLIxos+az+KNIKCWQHTz8DAtDqVYQwiN9ge/4JIB8AS4OrtpDI5+atu
    wNgSMZjoOTfkRJSoLTHfynn7uwVldAmjh7TKA8JQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=JPpEyAdP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=JPpEyAdP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCefhC1cjAE6Ugh4Gm6a2gkNsgviOm6e1QUW/fTUf7j0qfaGyw+jcNNetkhGfSAGm/AhQbguuMEa+P8+Le+YmMy0F6Z9fdRRxxqM5b1uXVbdoHJ2j+3B
    rY/t3iayd/HcA96AHriLIs84wxP0azlDG6KxSaESOb2mfqsyiIGkYXjLZqODotpJwX7eX3A2rbOP9p9AXm8K5En2LbgKzvbSlk/yb3lPc6attrO5ZY49hLDw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=WUgVTCY3OSwdJr0erxEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDKM5m (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 08:57:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55654 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753219AbeDKM5l (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 11 Apr 2018 08:57:41 -0400
Date: Wed, 11 Apr 2018 14:57:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Phil Elwell <phil@raspberrypi.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan78xx: Correctly indicate invalid OTP
Message-ID: <20180411125737.GB6119@lunn.ch>
References: <1523440757-127451-1-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523440757-127451-1-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:59:17AM +0100, Phil Elwell wrote:
> lan78xx_read_otp tries to return -EINVAL in the event of invalid OTP
> content, but the value gets overwritten before it is returned and the
> read goes ahead anyway. Make the read conditional as it should be
> and preserve the error code.

Hi Phil

Do you know that the Fixes: tag should be for this? When did it break?

Thanks
	Andrew
