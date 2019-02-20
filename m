Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46412089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sHixtFW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBTTb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:31:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60135 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfBTTbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+fHmZQEH9Ry/t8knZAJdwNhSo4WDUZlFGnMRsd7kX30=; b=sHixtFW/70WmrC3y+U7HxsyP4p
        78xxwhiyt17Rj8qx/e62Um0fEgIxhsEEBYCf+UoX49kag0sTQgXMNaxFv+ohj663fYSNZUhD4bnQJ
        DvlKPIe51BfexMmthKqK5lkPWksgeG5/nVjfnP+6opJRRblebnqOc6S5Q81tXztN2Xc8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gwXaU-0001QY-En; Wed, 20 Feb 2019 20:31:22 +0100
Date:   Wed, 20 Feb 2019 20:31:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marcel Reichmuth <Marcel.Reichmuth@netmodule.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: add missing phy address offset
Message-ID: <20190220193122.GA5302@lunn.ch>
References: <20190220181426.2970-1-marcel.reichmuth@netmodule.com>
 <d4e6e37b-01c2-3141-8e30-b7e8c252c0ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e6e37b-01c2-3141-8e30-b7e8c252c0ef@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:27:16AM -0800, Florian Fainelli wrote:
> On 2/20/19 10:15 AM, Marcel Reichmuth wrote:
> > When phys do not start at address 0 like on the mv88e6341 the wrong
> > phy address is used and therefore the slave ports can not be
> > initialized. This patch adds the proper offset to the phy address.
> > 
> > Signed-off-by: Marcel Reichmuth <marcel.reichmuth@netmodule.com>
> 
> You are supposed to describe the port to PHY mapping using the binding,
> so for instance:
> 
> ports {
> 	port@0 {
> 		reg = <0>;
> 		phy-handle = <&phy1>;
> 	};
> 
> };
> 
> mdio {
> 	phy1: phy@1 {
> 		reg = <1>;
> 	};
> };
> 
> etc. is not that working for you?


The Espressobin does exactly this:

arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts 

It also uses the 6341.

	Andrew
