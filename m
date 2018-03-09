Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932173AbeCIPPZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:15:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:52428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:15:24 -0500
Date: Fri, 09 Mar 2018 10:15:20 -0500 (EST)
Message-Id: <20180309.101520.1551234308448290917.davem@davemloft.net>
To: Jose.Abreu@synopsys.com
Cc: niklas.cassel@axis.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, pavel@ucw.cz, niklass@axis.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: remove superfluous wmb() memory
 barriers
From: David Miller <davem@davemloft.net>
In-Reply-To: <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
References: <20180308103006.1197-1-niklas.cassel@axis.com>
        <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Fri, 9 Mar 2018 10:26:11 +0000

> Sorry but I know at least two architectures which don't do a
> wmb() upon an writel [1] [2]. This can be critical if if we are
> accessing the device through some slow or filled bus which will
> delay accesses to the device IO. Notice that writel and then
> readl to the same address will force CPU to wait for writel
> completion before readl, but in this case we are using DMA and
> then writel so I think a wmb() before the writel is a safe measure.

Wait a second.

This is not about whether there is an explicit memory barrier
instruction placed in the writel() implementation.

Are you saying that the cpu(s) in question will reorder stores in
their store buffers, even if they are to real memory vs. IOMEM?

That's really dangerous.
