Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524067918-2-7954074480552614620
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
    1524067917; b=Cb7l00VomiYSOfP/3Xy+sLsU+0yGN+CZPdD7tqeGzlvfPXoS6V
    DOfsaXPVLMZ4TJV4CBkjXflQVLXq+YWb85daOTiLqksW3JiQoXy66IAEq1V/ep0n
    NX90e2ce9CKtgdtN5x1nH59m9vQvoHdxcw5ByJfQIPKz3K10vUQ7iLStgZVyYwUI
    cL9dP2OquTVZCALYEESSvo2xngGt4gTdrLChpV7xRPIQgPof1Uuw7V3AbbuROzbu
    jUKUdfjGddHADM2Fi35XFO14HdUXKsGkO3dYFamqjkNSb1UJTOYiXwOrAHNNeoHG
    U82DEXU4RdNn7g7FuvE0fLJGG8F2jFrDGjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524067917; bh=4l9G3EEmQhw5v1b+b7Fu+nITRWrqdJ
    pH6nq8H6G0OEU=; b=uZKhRduJrd+7bHBhlyeHEoxgvc4ei8RLlkvTlVeolki1L/
    lVMi9wVT48QCbBkY20EDe1FyJFeC6eDhUNmaWy8Rs4AGoYWNcRDga/SbalEr54kh
    PiLz0KW9nCPQm/8pZZ0fCaEcFfWApk43/aQfWDJww4Huu6Sh+o4TFPAfASUahhIu
    59lBJK2rVh96MAB+7kJ3syh99UQtupTDY8CFHTD4uFQzVvubw6l5cravA9S/NFxa
    vVqJiaa6yGhKbXNoIr25kEQAt8ofn7fVt079xudaIohEWaBSQHqWEUXVR2WVuZZg
    v8uKXVDyWr25KM9KTP3sHOh5/19MGMBU9FER9VgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=ogJtnJNd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=ogJtnJNd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNoJG3OcfiCmrxyYMi9dx5tboNQDixrfinz3YBe9tLGewUVd6nTUATHS1j/qadZ4TMKi6AVuRNgDOG2z7qXpzcXdEr9nSXNEyg9RuLoe0QOvEpOnbQZR
    mlcE6C9mVlKItIeIUMzwh3kZU/wkDpWNrnJr/e/Aa5PhdfhLVGCnqs+85xENWDjxhBiVmE6GFrPuyBxgB3O5U+z5oyItsSdJyoUtc9SwU71QXs1oo0iYWVWs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=IWe8NNME59luZAqdy3MA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeDRQLk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 12:11:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:32804 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbeDRQLj (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 18 Apr 2018 12:11:39 -0400
Date: Wed, 18 Apr 2018 18:11:21 +0200
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
Subject: Re: [PATCH v2 2/3] lan78xx: Read LED states from Device Tree
Message-ID: <20180418161121.GD3036@lunn.ch>
References: <1524066323-109628-1-git-send-email-phil@raspberrypi.org>
 <1524066323-109628-3-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524066323-109628-3-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 04:45:22PM +0100, Phil Elwell wrote:
> Add support for DT property "microchip,led-modes", a vector of zero
> to four cells (u32s) in the range 0-15, each of which sets the mode
> for one of the LEDs. Some possible values are:
> 
>     0=link/activity          1=link1000/activity
>     2=link100/activity       3=link10/activity
>     4=link100/1000/activity  5=link10/1000/activity
>     6=link10/100/activity    14=off    15=on
> 
> These values are given symbolic constants in a dt-bindings header.
> 
> Also use the presence of the DT property to indicate that the
> LEDs should be enabled - necessary in the event that no valid OTP
> or EEPROM is available.

Hi Phil

As i said last week, these are PHY properties, so should be in the PHY
node in device tree. It should be the PHY driver which parses these
properties and configures the LEDs, not the MAC.

	   Andrew
