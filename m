Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2877095-1521069945-2-689680792886817009
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521069945; b=L1J+HJHvXOTCC0rMQM3QkAKurXe2zzVws8Nf4SzgGyXhFgo
    gG8O8jR88ZrLt6KDoKVIK2XAEQaeBmeXXHiqwf+JYgrPnaH4MchA68I94EJV1U8i
    bXvlS8bYtL/TY1slSCnKd2hqYfJpfG0JQnv0KOc6swlSEx3Br/2dZRPxYZ1iP1f2
    efxIAqNov9h2JQyNF0miQVBXs5pZwlbXcBqzryjqS6/cTSxzezh9yD9Sxv7lG1Oq
    dHar409ICCg3TtNnWa45GUvNTyO1SJh3SfHThS2c7qy/FXeMaB0ubJr5dittQ3YW
    WTyyQFclyybDsl57Q4qv7ZQV3tMKUw8aQkFpIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521069945; bh=U7w6yzIvp/47gwRUMon116grDI
    kfxZnmZ9lv+H45i/0=; b=qTcUo0UQ/u4sae+oY+d0K37e0WW3DiwzOYq1R9Nnmt
    g/1TY9Q95V5UQhA3gKoGwTBs9VPP1eNKXZZ6L3RHU7kLsWj9jTSE/kM61VRU3gW8
    2FFHRKXimKRvP0Pr4pphfgNUEovisaAGksKI+hHqTEhRzPiD22FwYHvrkBaASfi3
    wxFP5UcP0A6tUIU83DK5GY52kxiS+Kj6/SIvyiXVTJmi5YHTBFxciDWSUAdpsJ6M
    r0Q0NEABkSQ4BjSbtsokgyEzO7B8VH/kWSMwfOK1nx2ygcCKxJOWhksiED0AtVrs
    lqBu62QkdLhv2xBPeYDajDUiP1ILW37c1DrN26RZDIiQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=ZqdM0nJH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=ZqdM0nJH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCNXZZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 19:25:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58123 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeCNXZY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 19:25:24 -0400
Date: Thu, 15 Mar 2018 00:25:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Graf <agraf@suse.de>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH] lan78xx: Connect phy early
Message-ID: <20180314232520.GB16379@lunn.ch>
References: <20180314145456.69029-1-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314145456.69029-1-agraf@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> @@ -2082,8 +2082,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  
>  	dev->fc_autoneg = phydev->autoneg;
>  
> -	phy_start(phydev);
> -
>  	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
>  
>  	return 0;
> @@ -2512,9 +2510,7 @@ static int lan78xx_open(struct net_device *net)
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = lan78xx_phy_init(dev);
> -	if (ret < 0)
> -		goto done;
> +	phy_start(net->phydev);

Should the debug message be moved as well?

       Andrew
