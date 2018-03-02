Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428822AbeCBOyQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:54:16 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:46872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423277AbeCBOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:54:13 -0500
Date: Fri, 02 Mar 2018 09:54:11 -0500 (EST)
Message-Id: <20180302.095411.1270630534912987342.davem@davemloft.net>
To: pavel@ucw.cz
Cc: niklas.cassel@axis.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, Jose.Abreu@synopsys.com, niklass@axis.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180302091959.GC15948@amd>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
        <20180226214709.4359-3-niklas.cassel@axis.com>
        <20180302091959.GC15948@amd>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 2 Mar 2018 10:20:00 +0100

>> This barrier cannot be a simple dma_wmb(), since a dma_wmb() is only
>> used to guarantee the ordering, with respect to other writes,
>> to cache coherent DMA memory.
> 
> Could you explain this a bit more (and perhaps in code comment)?
> 
> Ensuring other writes are done before writing the "GO!" bit should be
> enough, no?

Indeed, the chip should never look at the descriptor contents unless
the GO bit is set.

If there are ways that it can, this must be explained and documented
since it is quite unusual compared to other hardware.

> (If it is not, do we need heavier barriers in other places, too?)

Right.
