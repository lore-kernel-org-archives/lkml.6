Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeB0Phj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:37:39 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:56602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbeB0Phh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:37:37 -0500
Date: Tue, 27 Feb 2018 10:37:33 -0500 (EST)
Message-Id: <20180227.103733.38369293607878900.davem@davemloft.net>
To: arnd@arndb.de
Cc: mcroce@redhat.com, mika.westerberg@linux.intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] ipvlan: fix building with modular IPV6
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180226094159.2519438-1-arnd@arndb.de>
References: <20180226094159.2519438-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 10:41:30 +0100

> We no longer depend on IPV6, but that now causes a link error with
> CONFIG_IPV6=m and CONFIG_IPVLAN=y:
> 
> drivers/net/ipvlan/ipvlan_core.o: In function `ipvlan_queue_xmit':
> ipvlan_core.c:(.text+0x1440): undefined reference to `ip6_route_output_flags'
> drivers/net/ipvlan/ipvlan_core.o: In function `ipvlan_l3_rcv':
> ipvlan_core.c:(.text+0x1818): undefined reference to `ip6_route_input_lookup'
> 
> This adds back the dependency on IPV6, with the option of building without
> IPV6, but forcing IPVLAN to be a module when IPV6 is a module.
> 
> Fixes: 94333fac44d1 ("ipvlan: drop ipv6 dependency")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
