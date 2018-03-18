Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754850AbeCRUgh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:36:37 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59714 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeCRUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:36:32 -0400
Date: Sun, 18 Mar 2018 16:36:31 -0400 (EDT)
Message-Id: <20180318.163631.750748793504057329.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Fix missing register
 lock in serdes_get_stats
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180318182305.24952-1-f.fainelli@gmail.com>
References: <20180318182305.24952-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 18 Mar 2018 11:23:05 -0700

> We can hit the register lock not held assertion with the following path:
...
> mv88e6xxx_get_ethtool_stats() calls mv88e6xxx_get_stats() which calls both
> chip->info->ops->stats_get_stats(), which holds the register lock, and
> chip->info->ops->serdes_get_stats() which does not. Have
> chip->info->ops->serdes_get_stats() be running with the register lock held to
> avoid such assertions.
> 
> Fixes: 436fe17d273b ("net: dsa: mv88e6xxx: Allow the SERDES interfaces to have statistics")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
