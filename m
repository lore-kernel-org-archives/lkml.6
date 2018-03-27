Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeC0RQ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:16:28 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43564 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeC0RQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:16:27 -0400
Date: Tue, 27 Mar 2018 13:16:24 -0400 (EDT)
Message-Id: <20180327.131624.64497520832369981.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: ymarkman@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, antoine.tenart@bootlin.com,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next] net: mvpp2: Use relaxed I/O in data path
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180327144905.23499-1-maxime.chevallier@bootlin.com>
References: <20180327144905.23499-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 27 Mar 2018 16:49:05 +0200

> From: Yan Markman <ymarkman@marvell.com>
> 
> Use relaxed I/O on the hot path. This achieves significant performance
> improvements. On a 10G link, this makes a basic iperf TCP test go from
> an average of 4.5 Gbits/sec to about 9.40 Gbits/sec.
> 
> Signed-off-by: Yan Markman <ymarkman@marvell.com>
> [Maxime: Commit message, cosmetic changes]
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> David, this patch should not conflict with other the pending PPv2 series I sent
> earlier ("[PATCH net-next 0/2] net: mvpp2: Remove unnecessary dynamic allocs")

Applied, but it is up to you to make sure the correct barriers are in place
such that undesirable memory and IOMEM operation reordering does not occur.

Said another way, you get to keep the pieces if this breaks things :-)
