Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5EF222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JlHCeoes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfBOO42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:56:28 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53833 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfBOO42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dldtYif/dX4XCSUDkPWXBJDWGjlPLsUwDCWthZFiG6Y=; b=JlHCeoespOqqUOfLvCEu1kKpkX
        05Mc1JrJoCAjbdk8EYDIM4NJRC1OOH7/RWihzOaqM96/zV1qvnnLqm5Nir4n6T9poZJLCuj0qn7/o
        MlPPOpFT/Q2QoXFBUOuTNMdAiiUV3pHbxJ/r6tGxs0eSij890yLAf+L7pH25D05iikRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gueub-0006YJ-FN; Fri, 15 Feb 2019 15:56:21 +0100
Date:   Fri, 15 Feb 2019 15:56:21 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] enetc: Add ENETC PF level external MDIO
 support
Message-ID: <20190215145621.GO708@lunn.ch>
References: <1550225414-12125-1-git-send-email-claudiu.manoil@nxp.com>
 <1550225414-12125-4-git-send-email-claudiu.manoil@nxp.com>
 <20190215133459.GH5699@lunn.ch>
 <VI1PR04MB488080895C871B6B3ABA571D96600@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB488080895C871B6B3ABA571D96600@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I don't really see what bindings would need to be documented, as the node
> names and properties used so far are common.  Like, the "mdio" node name
> is common, the enetc ports are "pci" nodes, nothing special for these.
> What's missing?

Hi Claudiu

It is not well defined where to put phy nodes. Some drivers do allow
them directly in the MAC node, some drivers optionally allow an mdio
sub-node, others enforce an mdio sub-node. The name of the sub-node is
also not well defined.

So just documenting that the mdio sub-node is mandatory will help
people writing device trees for their boards.

       Andrew


