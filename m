Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933174AbeB1RFR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:05:17 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeB1RFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:05:14 -0500
Date: Wed, 28 Feb 2018 12:05:13 -0500 (EST)
Message-Id: <20180228.120513.2059500299754394497.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2] net: mvpp2: Add hardware offloading for
 VLAN filtering
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228091413.10008-1-maxime.chevallier@bootlin.com>
References: <20180228091413.10008-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 28 Feb 2018 10:14:13 +0100

> Marvell PPv2 controller allows for generic packet filtering. This commit
> adds entries to implement VLAN filtering. The approach taken is :
> 
>  - Filter entries that would match on the presence of the VLAN tag
>    (existing VLAN detection, DSA / EDSA detection) will set the next
>    lookup ID to be for the VID.
> 
>  - For each VLAN existing on a given port, we add an entry that matches
>    this specific VID. If the incoming packet matches the VID entry, it is
>    set for the next lookup in the chain (LU_L2).
> 
>  - A Guard entry is added for each port, that will match if the incoming
>    packet didn't match any of the above VID entries. This entry tags the
>    packet to be dropped.
> 
> Due to this design, and the fact that the total 256 filter entries are
> also used for other purposes, we have a limit of 10 VLANs per port. To
> accommodate the case where we would need more VLANS on one port, this
> patch implements the ndo_set_features to allow for disabling of VLAN
> filtering using ethtool.
> 
> The default config has VLAN filtering disabled.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V2: Use correct order for local variable declarations

That looks better, applied, thank you.
