Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCVSd1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:33:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59218 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeCVSd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:33:26 -0400
Date: Thu, 22 Mar 2018 14:33:24 -0400 (EDT)
Message-Id: <20180322.143324.294736014572721617.davem@davemloft.net>
To: joe@perches.com
Cc: f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH] etherdevice.h: net/core: Add ether_addrs.c and
 global ether_<foo>_addr
From: David Miller <davem@davemloft.net>
In-Reply-To: <1358caea6069381c231ae9bf6ffb7126cca04321.1521622752.git.joe@perches.com>
References: <bd247d15-4b10-3a57-16fe-7ba6908e8bfe@gmail.com>
        <1358caea6069381c231ae9bf6ffb7126cca04321.1521622752.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Wed, 21 Mar 2018 02:03:37 -0700

> There are multiple instances of static const arrays for broadcast
> and zero ethernet addresses used for various purposes.
> 
> Add const u8 ether_<foo>_addr[ETH_ALEN] globals to consolidate these uses.
> 
> Miscellanea:
> 
> o Move and rename the eth_reserved_addr_base declaration to this file
>   and declare it extern to avoid possible multiple static definitions
> o Add compilation to the Makefile
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> Not sure this is the best place for this.  Better ideas welcomed.

Well, for one thing you will need to export the symbols.

As for location, anything referencing these symbols or calling helpers
which do should depend upon ethernet.
