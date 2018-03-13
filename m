Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeCMSPo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:15:44 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49522 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeCMSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:15:42 -0400
Date: Tue, 13 Mar 2018 14:15:40 -0400 (EDT)
Message-Id: <20180313.141540.1209207885849202206.davem@davemloft.net>
To: arnd@arndb.de
Cc: edumazet@google.com, jiri@mellanox.com, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: fix sysctl_fb_tunnels_only_for_init_net
 link error
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180313114515.2037554-1-arnd@arndb.de>
References: <20180313114515.2037554-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 12:44:53 +0100

> The new variable is only available when CONFIG_SYSCTL is enabled,
> otherwise we get a link error:
> 
> net/ipv4/ip_tunnel.o: In function `ip_tunnel_init_net':
> ip_tunnel.c:(.text+0x278b): undefined reference to `sysctl_fb_tunnels_only_for_init_net'
> net/ipv6/sit.o: In function `sit_init_net':
> sit.c:(.init.text+0x4c): undefined reference to `sysctl_fb_tunnels_only_for_init_net'
> net/ipv6/ip6_tunnel.o: In function `ip6_tnl_init_net':
> ip6_tunnel.c:(.init.text+0x39): undefined reference to `sysctl_fb_tunnels_only_for_init_net'
> 
> This adds an extra condition, keeping the traditional behavior when
> CONFIG_SYSCTL is disabled.
> 
> Fixes: 79134e6ce2c9 ("net: do not create fallback tunnels for non-default namespaces")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
