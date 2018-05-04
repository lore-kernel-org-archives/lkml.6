Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeEDRXk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:23:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40563 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeEDRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:23:39 -0400
Date: Fri, 4 May 2018 19:23:37 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
Message-ID: <20180504172337.GC13899@kwain>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-3-antoine.tenart@bootlin.com>
 <e338472c-1f26-e49b-9a2d-7942e6ed4288@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e338472c-1f26-e49b-9a2d-7942e6ed4288@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Fri, May 04, 2018 at 10:04:48AM -0700, Florian Fainelli wrote:
> On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> > SFP connectors can be solder on a board without having any of their pins
> > (LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
> > and the overall link status reporting is left to other layers.
> > 
> > In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
> > This mode is set when it is not possible for the SFP code to get the
> > link status and as a result the link status is reported to be always UP
> > from the SFP point of view.
> 
> Why represent the SFP in Device Tree then? Why not just declare this is
> a fixed link which would avoid having to introduce this "unknown" state.

The other solution would have been to represent this as a fixed-link.
But such a representation would report the link as being up all the
time, which is something we wanted to avoid as the GoP in PPv2 can
report some link status. This is achieved using SFP+phylink+PPv2.

And representing the SFP cage in the device tree, although it's a
"dummy" one, helps describing the hardware.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
