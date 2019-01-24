Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40562C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028FB218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X3PSMAHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfAXQPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:15:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54264 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfAXQPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rpTWy4V5hOfZl0Z6Q3iTnTMvdBi/wlLMW6IJVwwGTf4=; b=X3PSMAHbKwrOC9cPHJQyh5TRHt
        7Vmvy/SmdQowVxTmu+VfVlLDkOq1fYMKtH0wYMcj6o2djEAHpJuZZODHHKSNjxn2RqPCmZuQ3IvoN
        9PtR/VIbQdtRFvDyOTTfttZgtmIILYQcKLV4xGBWUHipBOn0hdsH+Zty+Ct7HwMPnLwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gmhfD-0001lX-Hs; Thu, 24 Jan 2019 17:15:35 +0100
Date:   Thu, 24 Jan 2019 17:15:35 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-ID: <20190124161535.GH482@lunn.ch>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
 <20190124155137.GD482@lunn.ch>
 <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:07:41PM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Jan 24, 2019 at 04:51:37PM +0100, Andrew Lunn wrote:
> > On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> > > Set up link interrupt if connection is handled by phylink otherwise
> > > link state change detection for in-band-status doesn't work.
> > 
> > Hi Thomas
> > 
> > Please ensure the maintainers of the driver are at least on Cc:
> 
> ... and other interested parties!

Hi Russell

get_maintainer.pl does not list you, so it can be hard to know who
those other interested parties are. I have local knowledge, so added
you :-)

      Andrew
