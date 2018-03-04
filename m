Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeCDJZX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:25:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37875 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbeCDJZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:25:21 -0500
Date: Sun, 4 Mar 2018 10:25:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Stefan Chulski <stefanc@marvell.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Yan Markman <ymarkman@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
 FIFO on port 0
Message-ID: <20180304102518.1963cb8a@windsurf.home>
In-Reply-To: <bd3a0e716e1c44938b7a216ea54b9c7e@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-4-antoine.tenart@bootlin.com>
        <20180302171117.2344a893@windsurf.lan>
        <bd3a0e716e1c44938b7a216ea54b9c7e@IL-EXCH01.marvell.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 4 Mar 2018 06:29:59 +0000, Stefan Chulski wrote:

> > Is there a reason to hardcode 10KB for port 0, and 3KB for the other ports ?
> > Would there be use cases where the user may want different configurations
> > ?
> 
> Design requirement are 10KB TX FIFO for the 10Gb/sec and 2.5KB for the 2.5Gb/sec.

What is a "design requirement" ? Is it a HW design limitation ?

> Since only port 0 support 10Gb/sec and ports 1&2 support up to 2.5Gb/sec.
> I don't see any reason to change this configurations.
> Also TX FIFO size could be set only during probe.
> 
> > It's just that it feels very "hardcoded" to enforce specifically those numbers.
> > 
> > Also, does it make sense to mention the CP110 here ? Is this 19 KB limitation
> > a limit of the PPv2.2 IP, or of the CP110 ?  
> 
> PPv2.2 IP is part of 110 communication processor.

Thanks, I know this :-)

> Next communication processor will has different Packet processor or next generation of PPv2.x
> Limit is PPv2.2 TX FIFO.

So, the limitation has nothing to do with CP110 really, it's just a
limitation of PPv2.2, and mentioning CP110 in the comment doesn't make
much sense, correct ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
