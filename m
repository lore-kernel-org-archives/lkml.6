Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2635071-1523457121-2-14275656444476875340
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
    1523457120; b=U//WEEUoc3FzIr33kaYcD6D1T/9g8m/kNhRfJzTf84AyyUqWvt
    lOw0WCyW6zyrU5XQFjsmVQN/oL07eXSA5L5uYNzoZfLRPAVetijd9yoxspsxB1VC
    FMjtjEuWuWOMHoNosYY6fBuR37O8GbfjIUYvJ5RAHe6j+bPK/rMT0+7GTSv7p0XU
    uOLhpu+R8l+VJtAKiI6ox9MltDRKAL3ovDcXJRTFavDdX9ysjG3zI5+QmxjewsBa
    FbWmai8YBAhEKXTdq+7mUYACPW1lJUJxpFKgbrzkRoAHhlfs1Y98m1IXI6eWYZ1k
    DKX4P8W7aYk5BI3S66lGibBs2ISkdSWHFaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523457120;
    bh=Y/b4Gk7wEofzA8bjqEBWyeBqQZ5PJR2pWLVw2BGNlUk=; b=vvq6uKsU8euN
    JuoPdqevSiLnZkY0+xY3PdBJP9WRAy37dskkqhWfg0b2okK1CpiEUB5SVV41sZZM
    K7t5EhjOnLr5Vg0r4tPGMZV6Jnqg/XieCULBqM59hUHtc6L2nowiTNyJf1udEXIE
    MjWPLWE4q5V3RWdyq9mJX5CdLEw+BoA4YmKk4YJjv2txcjtbyrG5AiSSSS03EKIU
    UKtWZK5snqgIxdWtExjnJh9tSZDwskd9elujrP1KfvDA9aIFma7D7gZfSCIzJKxP
    Tp4Kbo08jWO6cRPWV8tYkBrykPjL6fLItTZ7/EJJ4WelnoOw0Ja0+vu6WJ2MI6cE
    BB/mVOEWaA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfGtYBlx31a5bKz4AUMX7j5a7D7iAkm01TsmSdjFaNSOHpcSSWIWxuLeIjphaUnIMEMfQ32HtJB5kNtu40IArFFHcKOFkGzY9sq1RQlJMy4sCoESsodNG
    tQLhuBV3kE2lBwpgZkmzgUnlWAioPxieGgQDHdLlcF1ikFtT5EnEgGNbbpyqOR+geWcY+WifqJ9eSCa7vAqNstYfWE93dkmuhCSgS1tq+XzJcnXjgJ0sGVbp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=vuCMTfJbORzl9BQQsbkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeDKOba (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 10:31:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41218 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeDKOb2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 10:31:28 -0400
Date: Wed, 11 Apr 2018 10:31:27 -0400 (EDT)
Message-Id: <20180411.103127.1511048337167278763.davem@davemloft.net>
To: phil@raspberrypi.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan78xx: Correctly indicate invalid OTP
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523440757-127451-1-git-send-email-phil@raspberrypi.org>
References: <1523440757-127451-1-git-send-email-phil@raspberrypi.org>
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
Date: Wed, 11 Apr 2018 10:59:17 +0100

> lan78xx_read_otp tries to return -EINVAL in the event of invalid OTP
> content, but the value gets overwritten before it is returned and the
> read goes ahead anyway. Make the read conditional as it should be
> and preserve the error code.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Applied with appropriate Fixes: tag added, and queud up for -stable.

Thanks.
