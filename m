Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeDXSww (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:52:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeDXSwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:52:51 -0400
Date: Tue, 24 Apr 2018 20:52:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180424185239.GG19011@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
 <20180330135422.GA28244@lunn.ch>
 <20180330141634.GD14180@piout.net>
 <20180330145008.GE28244@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330145008.GE28244@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I realise now that I didn't reply to this comment:

On 30/03/2018 16:50:08+0200, Andrew Lunn wrote:
> > The fact is that ocelot doesn't have separate controls. The port is
> > either forwarding or not. If it is not forwarding, then there is nothing
> > to tell the HW to do.
> 
> Think about the following sequence:
> 
> ip link set lan0 up
> 
> After this command, i expect to see packets on lan0 arrive at the
> host, tcpdump to work, etc. This probably means the port is in
> 'forwarding' mode, or for B53, STP is disabled.
> 

On Ocelot, forwarding packets to the host (i.e. forwarding frames
received on the port to the cpu port) is separate from bridging ports
together. So after that command, the host can receive packets on lan0.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
