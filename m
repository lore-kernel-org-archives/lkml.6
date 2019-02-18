Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F320BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F1C2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfBRKkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:40:08 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48747 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:40:07 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D96932000F;
        Mon, 18 Feb 2019 10:40:03 +0000 (UTC)
Date:   Mon, 18 Feb 2019 11:40:03 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 01/13] net: mvpp2: do not call
 phylink_mac_change if there is no event
Message-ID: <20190218104003.GB3784@kwain>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-2-antoine.tenart@bootlin.com>
 <20190215170553.ur725djxoudtnjne@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190215170553.ur725djxoudtnjne@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Feb 15, 2019 at 05:05:53PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Feb 15, 2019 at 04:32:29PM +0100, Antoine Tenart wrote:
> > This patch makes the link interrupt handler to avoid calling
> > phylink_mac_change when there are no event.
> 
> The reasoning being?

The interrupt can fire for a number of reasons, some of which may not be
related to changes in the MAC state (it can fire upon errors or counter
wraparound).

This interrupt handler currently checks if an event occurred bu checking
if the cause of the interrupt is a link change. I wanted to extend this
logic to phylink to avoid having two link change handlers (phylink and
!phylink) being called in different ways.

Anyway, the only cause unmask so far is the link one, so it won't make
any difference so far. We can probably drop this one for now.

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
