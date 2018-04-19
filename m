Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414120-1524151190-2-2393314880958740204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524151190; b=m1Y2x9VCAFgha1PNdfDZduiZb7y15wwO4xc97HlZN6ASJp4Mj0
    9OANsyTa/2x3CQp7K3lk1qDoDMxVj5Pu02JDe05jkLuXCyCEh0jR51RU0tiTEKhp
    m1Iez9csZciysYA0M4NfgrE1a7I06bQr10tqBYpy0GFmwzKMJs74+BMhBkYTOunw
    ru5AQatRl2Nc91EtBScf6hwV5O7/Jhi+k4dJrLADPVR3Tni9sbTngs4goxYZf8RT
    EIFu9QeUZH/Z2I4P3GLx9xL+M5PZHVEbkdbvNfsK8WWBcSqwYGUvXSF38ufTTC1s
    0yokXf5CtjmI3BJPiXrp+YEp7nR8kId48Upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524151190; bh=ysZvG2FwZ/7624Jvn5l8fapPKajt46
    1WWvUVssLFknw=; b=CK4WBe7268dry3Zue503Ws4PqqtyBNP8eZ4IMkxM6QX4Av
    Y+WKz3K7wYbk1QFcmUCxuTleL0kWGkVSHVc+t6lpbeS1v9UIReRdix73daihcG1H
    0/NnSe7ITo1UgM0vR0osWdRwSdyhSCxulBB5B4gKUikWpf8zvx5xoXii9okwzzzi
    P7fVy+LTtI9AQ9YFs6PhbtTZNx3QQk8ozi2P8cxgERXY0GvrwHaBOQRbmN6xuT/z
    zrskHs0GsJlsVVAcSHEwD27PhZlPiY8EPpGK/AUPiZGOuN5ZDjyIBo/v+SvwaEgY
    VO37jDXeRWdoZKcWqJAG9c5DnALmOgD6lZaLHvnA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=h9AqDPjg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=h9AqDPjg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAMiMuKmgjqkGvOVEcthTS9q+Wsq99fpAK/zQdr/RZZRgu2N1JJPxkmFNYOS7Tn7kvgH9aIL92qYF14ex3YGiW6ABh8mzujQixftxAVSYEj++mfkLhfN
    zxK9jI4yxhZ6/YsCLIU3at/Pimwpyb50wmC/aUT4M0AMxoipELEhEz9FGF1eo3FwSCizBeWh+r2xphWsdtteJMpiNUOdamjd/tbsOfczBBF/4SUAXwzfLsKk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=z6y-UFRqdrYUv7qvHaYA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDSPTl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:19:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34159 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753290AbeDSPTh (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 11:19:37 -0400
Date: Thu, 19 Apr 2018 17:19:21 +0200
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
Subject: Re: [PATCH v3 2/3] lan78xx: Read LED states from Device Tree
Message-ID: <20180419151921.GC29658@lunn.ch>
References: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
 <1524148325-78945-4-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524148325-78945-4-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> @@ -2077,6 +2085,28 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  	mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
>  	phydev->advertising |= mii_adv_to_ethtool_adv_t(mii_adv);
>  
> +	if (phydev->mdio.dev.of_node) {
> +		u32 reg;
> +		int len;
> +
> +		len = of_property_count_elems_of_size(phydev->mdio.dev.of_node,
> +						      "microchip,led-modes",
> +						      sizeof(u32));
> +		if (len >= 0) {
> +			/* Ensure the appropriate LEDs are enabled */
> +			lan78xx_read_reg(dev, HW_CFG, &reg);
> +			reg &= ~(HW_CFG_LED0_EN_ |
> +				 HW_CFG_LED1_EN_ |
> +				 HW_CFG_LED2_EN_ |
> +				 HW_CFG_LED3_EN_);
> +			reg |= (len > 0) * HW_CFG_LED0_EN_ |
> +				(len > 1) * HW_CFG_LED1_EN_ |
> +				(len > 2) * HW_CFG_LED2_EN_ |
> +				(len > 3) * HW_CFG_LED3_EN_;
> +			lan78xx_write_reg(dev, HW_CFG, reg);
> +		}
> +	}
> +

Humm. Not nice. But i cannot think of a cleaner way of doing this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
