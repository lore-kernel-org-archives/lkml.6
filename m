Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6081222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PRFzCRVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407903AbfBNQ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:27:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52243 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407873AbfBNQ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vucx8758cGzm43U1rAYb+qpEgQ61u/ffR6SX7xymdf0=; b=PRFzCRVAYC+xnOIAdDsW9eZ3Qa
        JZgvCzlP+tVwBUJpzCfXz9ZMKjOvIbYheleaep8qmx3Vaf5nF3XvYL9KDPKR1tqaSZR18yEamBAAf
        RB6PpZLwNJuAMjuAdO6sD1rD7oP4imTUwCnbVzt86exS/izzVRW/EdNZOuZSFokADbjk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1guJrW-0003xD-Bq; Thu, 14 Feb 2019 17:27:46 +0100
Date:   Thu, 14 Feb 2019 17:27:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Message-ID: <20190214162746.GI708@lunn.ch>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
 <20190213181554.GB708@lunn.ch>
 <VI1PR04MB4880C9EF6C9EBFCAA2209DD596670@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4880C9EF6C9EBFCAA2209DD596670@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> The extra node for mdio seems to complicate things somewhat. 
> Just adding this node seems not enough.  How to find out easily if a child 
> of a enetc port node is a mdio node?

You copy somebody else code :-)

https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/net/dsa/mv88e6xxx/chip.c#L2765

	Andrew
