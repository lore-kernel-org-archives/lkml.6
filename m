Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeCLIzs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:55:48 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:36367 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:55:46 -0400
Date: Mon, 12 Mar 2018 09:55:42 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: David Miller <davem@davemloft.net>
Cc: Jose.Abreu@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, pavel@ucw.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: remove superfluous wmb() memory
 barriers
Message-ID: <20180312085541.GA406@axis.com>
References: <20180308103006.1197-1-niklas.cassel@axis.com>
 <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
 <20180309.101520.1551234308448290917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309.101520.1551234308448290917.davem@davemloft.net>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 10:15:20AM -0500, David Miller wrote:
> From: Jose Abreu <Jose.Abreu@synopsys.com>
> Date: Fri, 9 Mar 2018 10:26:11 +0000
> 
> > Sorry but I know at least two architectures which don't do a
> > wmb() upon an writel [1] [2]. This can be critical if if we are
> > accessing the device through some slow or filled bus which will
> > delay accesses to the device IO. Notice that writel and then
> > readl to the same address will force CPU to wait for writel
> > completion before readl, but in this case we are using DMA and
> > then writel so I think a wmb() before the writel is a safe measure.
> 
> Wait a second.
> 
> This is not about whether there is an explicit memory barrier
> instruction placed in the writel() implementation.
> 
> Are you saying that the cpu(s) in question will reorder stores in
> their store buffers, even if they are to real memory vs. IOMEM?
> 
> That's really dangerous.

Hello David,

Jose is simply responding to the commit message description of this patch.

You explained that there is an implicit memory barrier between physical memory
writes and those to MMIO register space, as long as you used writel().

I assumed that you meant writel() vs writel_relaxed(), where there latter
does not do an implicit barrier.

I also found this from you:
https://lwn.net/Articles/198995/

If my assumption was incorrect, please correct me.

As you seem to possess knowledge regarding this, you are probably the most
suited person to know if this patch simply needs a commit message rewrite,
or if it should be dropped completely.


Best regards,
Niklas
