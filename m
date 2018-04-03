Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeDCQpt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:45:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59758 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeDCQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:45:48 -0400
Date: Tue, 3 Apr 2018 17:45:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org, opendmb@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: bcmgenet: Fix sparse warnings in
 bcmgenet_put_tx_csum()
Message-ID: <20180403164545.GK30522@ZenIV.linux.org.uk>
References: <20180402225856.4351-1-f.fainelli@gmail.com>
 <20180402225856.4351-2-f.fainelli@gmail.com>
 <20180403162933.GJ30522@ZenIV.linux.org.uk>
 <20180403.123305.1783530733365447500.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403.123305.1783530733365447500.davem@davemloft.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 12:33:05PM -0400, David Miller wrote:

> Yes Al, however the pattern choosen here is probably cheaper on little endian:
> 
> 	__beXX val = x;
> 	switch (val) {
> 	case htons(ETH_P_FOO):
> 	 ...
> 	}
> 
> This way only the compiler byte swaps the constants at compile time,
> no code is actually generated to do it.

That's not obvious, actually - depends upon how sparse the switch ends
up being.  You can easily lose more than a single byteswap insn on
worse cascase of comparisons.
