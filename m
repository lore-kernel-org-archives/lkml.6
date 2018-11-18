Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B18C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66092080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DiFb6Q+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66092080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeKSDY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:24:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39514 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeKSDY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=xQB0r42k+YuzJqyqge/V0Jk+zt0IIqmgMSS+vHAExdQ=;
        b=DiFb6Q+cc7IYf2L3Hk8b5jRuvDel71RfSvQrw2fvZ453db5yv+I62DnU2Odt3zqVwrnW+SYX9CDEwK2hGY9GfsUNqwnMW6InbPRUJ7oJA8dV9mnwIjCOXv/kDq6yxcnNhsxDIZ/TRkTIO4H35ZDmlXBiiKrOTrvSFI/fttkNunw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOQTr-0001ej-IH; Sun, 18 Nov 2018 18:03:31 +0100
Date:   Sun, 18 Nov 2018 18:03:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: net: phy: add bindings for the IC Plus
 Corp. IP101A/G PHYs
Message-ID: <20181118170331.GB5591@lunn.ch>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117182007.14791-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 07:20:02PM +0100, Martin Blumenstingl wrote:
> The IP101A and IP101G series both have various models. Depending on the
> board implementation we need a special property for the IP101GR (32-pin
> LQFP package) PHY:
> pin 21 ("RXER/INTR_32") outputs the "receive error" signal by default
> (LOW means "normal operation", HIGH means that there's either a decoding
> error of the received signal or that the PHY is receiving LPI). This pin
> can also be switched to INTR32 mode, where the interrupt signal is
> routed to this pin. The other PHYs don't need this special handling
> because they have more pins available so the interrupt function gets a
> dedicated pin.
> 
> This adds two properties to either select the "receive error" or
> "interrupt" function of pin 21. Not specifying any function means that
> the default set by the bootloader is used. This is required because the
> IP101GR cannot be differentiated between other IP101 PHYs as the PHY
> identification registers on all of these is 0x02430c54.

Hi Martin

Not being able to identify the device is a real problem here.

I did wonder about adding a property which tells you if this is the R
variant, but the binding you suggests seems equally good.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
