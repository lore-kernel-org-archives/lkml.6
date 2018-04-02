Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2915920-1522670683-2-7128398710974236135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522670682; b=UeJGL9gtbSXA4T/Fh3pjsNz8e3yT+FSzyGUM7Pnm8Moeokb8x2
    5qBSaEy/ewWB4IEwn/5yznX6Vyn8x7DPWuCuE6/B88CKKIQCgxGUA1YEqoYTmfth
    B+5ENWZFDGfhLl7mc04Lt3JLGhZ4bwzVYJmK2qEgv5KDBKjtkQBYDsREMSTNQO14
    pi3kBGqC/gy1vxPpKKm/JbY/zbuqD9DyUix8qowbUtYZuzITyX4EpkR4GBsplwdP
    xBDPvUSYXU+KpEAfjiqxla6x+d8iVTlrhJl8Nbevc2RSigMfbeyLPgvuk5Jg34ha
    mr9qYcew7iVQrZyy0j98KNwTZwFhyoBj/0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522670682; bh=oIIqnmsjyrtUhKE7T0qdQyYVCx1E6h
    QGhNUWAEZY4tA=; b=s14hBh+JlmrupEmzQWd9apnPKu0/Xo/0DuGdGkDsq+CWRA
    rn36b1VYm3vuBqVtbP8L2P/iOwI1MCmBmwJZ7nz++Y9DgCjMuJ2H/VLxL65Ko9cG
    xVq3VbS0E7FDdPBe2k+B3J0ZW6Nvl+zY+rVVTRSv0/iybN12DJ6Ccp4dcCM2kdxB
    Ev/7jQVpGai5Ojt6rDjQ0jT/fwXzuVyzvrGsnMWapVZYDGdHwHHS15uAMJjv/bLy
    OH60rmvzldP+xJ3tHoQ4yYE6RT6un5MPQXSKFoHyl1HKJ4RNi/VaMcGhYB+3orzH
    rJ8sZe8hSn3fZgJblHzCLsYMj28AbC90HzeMAyyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=JvjUmmv3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=JvjUmmv3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDBB/SEheCqt7YYsO1vvWyQqAyouBt/SRuExfSKhAFggTPImCyTHVO6vdMCpQHHfYI6HZ8c58tLooi5GZqFQEtii0eVyzlEqagi1v57K7Idudg/KIny
    /y11hcjNmJ2acfYMagcvSGUxxWLaGzAnRm0H3gIXdYulOWVwpj1N16wTAnYAG3UTyeTqeVkVU7vCShIhLdGC4BxfIxvLeLW62bvTyQgQQyV6TRE0K8Fp0eM2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeDBME1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 08:04:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48783 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeDBMEZ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 2 Apr 2018 08:04:25 -0400
Date: Mon, 2 Apr 2018 14:04:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Question] MFD driver that handles clocks/resets and populates
 child nodes
Message-ID: <20180402120414.GA8159@lunn.ch>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> The maintainer of DWC3, Felipe Balbi, requested to
> split the glue layer driver into small parts such as
> reset, regulator, phy, etc.

What exactly did Felipe ask for? Did he ask that the patch be split
up, one patch per reset, regulator, phy etc?

Are all these resources used just by the DWC3? Or is it a true MFD,
multiple functions?

	 Andrew
 
