Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1114600-1523543206-2-8035184172761495065
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
    1523543206; b=EARKZuqJaoHmUDSxEwR6OGOrWK8M45t7BNBNPShasfC8e26XEx
    TpRaJG2EMBBmtM8UpO6QP4YL99Ah5sg+xy2wVFkFfqhmUi5mH9MoSUpmV+Ve5Zt6
    37A5NfAQiDqJKSdNVkew2Yx3l3MHy+JZG7S9IRHYkHJDwHX+LnTRLhE5Ocgm/7Hu
    AtWTgNSNzW8K7KK/uX36hGKbnWvnzFodv5vM7lh7PepPP+SdYTDOAQXB8Pi+M+fp
    SaqPgUdCZ4Hkgw/WWfpY0h8BOrR/JD+BP0TomJ4zgst61FgnE2q8Pr6LTqfbnOZ7
    5Y3c5vNQ0a8Eok88K9zwO6suxRrmkzoSkCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523543206; bh=vXlOnGe18LCJCvgqVOSjUx6jhOqEEo
    Trj2qMQbCjNxw=; b=jtDrTjXQNGzmJLOhTfZ9DImH0D98ojdMDr1WrF9gZQ/b/+
    Oja0CCmEfrD66Lqkymnzn5KOoRv8CN4e9k+arBT7R3XMQkYCqggQxdc3mK/p/nQj
    0KBcyEEQQK4DlrKo3JeUVGBS0jbrVi/cV4jUtd5h2zc820hXvqs9cLtJ5ZJnLZay
    NDby9XuKBetrM2zPYr609p9gnNQp09Xf/7tDntLXd8J6itojOsDUz6ZCYFkJGm9U
    uW2bzNE5icVGsUKz1r/e6P7L5AanvFtFy5kBa14EFHED17qd+kNMmKkKt9USJ3CF
    Gtnls6vlBmClnUMMQa1d8J7uOWKrHyYbfVzQZPKg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=UvXuqkAE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=UvXuqkAE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfErx957AU8iau1Tzbb1TF1WoJmu+RoAqhV+X6BL3EUh6LahG1Jz0rRGIeZSnODKX6esH1AG/7Bf+JFEjEVCDui0oyTNXMcuXw2b/4i+DUNmaX7uTDvYh
    UqT05Hlpx/uxAtk9ooYtOlbgNOM/Is1O6xBh6uEiOopAvqq18aQdzRw2UJ5iL7Nq7IiOZRqcoNaAXdqlfZobMaTolmg8RFPJoFfB7Hl3u5qCIeDWCDUzr7Aj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=oyrvq4AYYV935ZZ5LagA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDLO00 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:26:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56629 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeDLO0Z (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 12 Apr 2018 10:26:25 -0400
Date: Thu, 12 Apr 2018 16:26:15 +0200
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
Subject: Re: [PATCH 3/4] lan78xx: Read LED modes from Device Tree
Message-ID: <20180412142615.GO28963@lunn.ch>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:55:35PM +0100, Phil Elwell wrote:
> Add support for DT property "microchip,led-modes", a vector of two
> cells (u32s) in the range 0-15, each of which sets the mode for one
> of the two LEDs. Some possible values are:
> 
>     0=link/activity          1=link1000/activity
>     2=link100/activity       3=link10/activity
>     4=link100/1000/activity  5=link10/1000/activity
>     6=link10/100/activity    14=off    15=on
> 
> Also use the presence of the DT property to indicate that the
> LEDs should be enabled - necessary in the event that no valid OTP
> or EEPROM is available.

I'm not a fan of this, but at the moment, we don't have anything
better.

Please follow what mscc does, add a header file for the LED settings.

       Andrew

> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---
>  drivers/net/usb/lan78xx.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index d98397b..ffb483d 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2008,6 +2008,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  {
>  	int ret;
>  	u32 mii_adv;
> +	u32 led_modes[2];
>  	struct phy_device *phydev;
>  
>  	phydev = phy_find_first(dev->mdiobus);
> @@ -2097,6 +2098,25 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  		(void)lan78xx_set_eee(dev->net, &edata);
>  	}
>  
> +	if (!of_property_read_u32_array(dev->udev->dev.of_node,
> +					"microchip,led-modes",
> +					led_modes, ARRAY_SIZE(led_modes))) {
> +		u32 reg;
> +		int i;
> +
> +		reg = phy_read(phydev, 0x1d);
> +		for (i = 0; i < ARRAY_SIZE(led_modes); i++) {
> +			reg &= ~(0xf << (i * 4));
> +			reg |= (led_modes[i] & 0xf) << (i * 4);
> +		}

Please add range checks for led_modes[i] and return -EINVAL if the
check fails.

      Andrew
