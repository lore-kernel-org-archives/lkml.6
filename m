Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1944579-1524238789-2-83915878486912292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524238788; b=bT8A/8apUi1sMew+frSU9sk5Ljbjk3CcyLXADRLpUaPBV27sLf
    8RPD9xqWcPu/2anyFY9JL46U9B6Z426hnLBwnwhCvpB57PEkhqxjNigA3OqKE8vc
    YgONFTeFkLc8rwwO0nt+r3naojxFG34ER9EDFaaM4KGjLuA5P0D/FtwbBQr2kf2K
    ZnQqejMzVhPNPftkrx76h6rRbKTYVDzEOdcbT4995OusHVP0reOL9oDHtkG5uSVz
    1ElgR7sTRSABC+yZ179T8SOeqI2kUzoKDQr/7gIzABlKDJoAYe7tr0TiSlCPnemV
    ri1cVIA0eSqkEbIAU2m9o4Ap2A3QWhFyCT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524238788;
    bh=kEcN/2S5I2mKybykMVYM8VyYeEeFCcbY1F6TzkoVpw8=; b=R4HIEVJiUdx1
    hprJR9GQt7jB7PfJdQqYnCh8Gad28pV/zvcumL9/OWo+S1eoO2a59Li4Ki7pVzTo
    nbBvv7uynoHiFZnaqfwr5GoXZylNaCfgXGsFkcMuDv1n/03oOyzAkmxUtHPiuExs
    ojWgYUPWgFkGe58nGZf5h226Y4yUO19w8Xt54jR3VcM/wZUQZwo4ER8BbQlW5jTh
    olIyDO/ketPS/arc8JSFrGpXrZ8mWMy1jJ3kqUaCjCtjB4gGyQ6pmV1BB6hJBP/J
    hJTvD7aTHJQmoSPChFss5OgpPybqzitAPqY+ywkIpmfGw7A8ShjzaYQFG+WvYJB6
    sYIPNbpL+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHWZEWEllFLAbfHexM4zQMFMkmPSZRrAxy8Lb7W3IUq6/t6tTeVF45v4aOItngDEqQb48lM3hr4c2IHAyTn3hPI26ac5k/rc5XC5HPxNAr2ZKD0H5jhz
    mL6Ts1CXiCIyaDJph+3v9sebBs3+c0CQ3hbPT2u5iQxbTuZsBlSLByca1jVZWPSzmYXrUGUSGpa25UUyh9RNwlLUPtxlLl/9kDQ7Epf56ydkxjRhiRAxSdhO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=dSSbBeGmRD9XzgoCY8UA:9
    a=6LKGa95oTSmxmVlg:21 a=VJXZKpJDvFt0E2wt:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeDTPjc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 11:39:32 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45326 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755683AbeDTPja (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 20 Apr 2018 11:39:30 -0400
Date: Fri, 20 Apr 2018 11:39:27 -0400 (EDT)
Message-Id: <20180420.113927.810364321398349353.davem@davemloft.net>
To: phil@raspberrypi.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andrew@lunn.ch,
        f.fainelli@gmail.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 0/3] lan78xx: Read configuration from Device Tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524157180-27276-1-git-send-email-phil@raspberrypi.org>
References: <1524157180-27276-1-git-send-email-phil@raspberrypi.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phil Elwell <phil@raspberrypi.org>
Date: Thu, 19 Apr 2018 17:59:37 +0100

> The Microchip LAN78XX family of devices are Ethernet controllers with
> a USB interface. Despite being discoverable devices it can be useful to
> be able to configure them from Device Tree, particularly in low-cost
> applications without an EEPROM or programmed OTP.
> 
> This patch set adds support for reading the MAC address and LED modes from
> Device Tree.
> 
> v4:
> - Rename nodes in bindings doc.
> 
> v3:
> - Move LED setting into PHY driver.
> 
> v2:
> - Use eth_platform_get_mac_address.
> - Support up to 4 LEDs, and move LED mode constants into dt-bindings header.
> - Improve bindings document.
> - Remove EEE support.

Series applied, thanks Phil.
