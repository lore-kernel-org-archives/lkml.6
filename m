Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB76C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7344D217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pJHQVQ/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfAXQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:07:51 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42832 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfAXQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=paPYfLESwHDWr/Ps5iB2kIupjGr4ieD7j25i6QHY1Nk=; b=pJHQVQ/dFMd8rRR65Kp9+Oroc
        dXyCxYx8o1UW5FebmI8ACw+FJU7iM0TAySZhPWIlbL4gl4wYpgW2te2Y15myJJRQ/lOTega4WNiHb
        rcx1UrDUQZDwg97r76wg6p1MDnVCGf8ef6wJ/rGpBMkdFHhi1L9Vl4oxo1LHYWTDNrlRw=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55374 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gmhXZ-0003de-U2; Thu, 24 Jan 2019 16:07:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gmhXZ-0000wA-AI; Thu, 24 Jan 2019 16:07:41 +0000
Date:   Thu, 24 Jan 2019 16:07:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-ID: <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
 <20190124155137.GD482@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124155137.GD482@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:51:37PM +0100, Andrew Lunn wrote:
> On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> > Set up link interrupt if connection is handled by phylink otherwise
> > link state change detection for in-band-status doesn't work.
> 
> Hi Thomas
> 
> Please ensure the maintainers of the driver are at least on Cc:

... and other interested parties!

> Thanks
> 	Andrew
> 
> > 
> > Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 16066c2d5b3a..0fbfe1945a69 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -3405,7 +3405,7 @@ static int mvpp2_open(struct net_device *dev)
> >  		valid = true;
> >  	}
> >  
> > -	if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
> > +	if (priv->hw_version == MVPP22 && port->link_irq && port->phylink) {
> >  		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
> >  				  dev->name, port);
> >  		if (err) {

This still looks fishy to me.  mvpp2_link_status_isr() has handling in
it that is safe to be called for non-phylink cases, so presumably the
right fix is to drop the "&& !port->phylink" completely?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
