Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFEOy5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:54:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37258 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeFEOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:54:56 -0400
Date: Tue, 05 Jun 2018 10:54:53 -0400 (EDT)
Message-Id: <20180605.105453.339908802413146875.davem@davemloft.net>
To: arnd@arndb.de
Cc: pablo@netfilter.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        ecklm94@gmail.com, pabeni@redhat.com, willemb@google.com,
        edumazet@google.com, dsahern@gmail.com, kafai@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: provide udp*_lib_lookup for nf_tproxy
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605114056.1239571-1-arnd@arndb.de>
References: <20180605114056.1239571-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue,  5 Jun 2018 13:40:34 +0200

> It is now possible to enable the libified nf_tproxy modules without
> also enabling NETFILTER_XT_TARGET_TPROXY, which throws off the
> ifdef logic in the udp core code:
> 
> net/ipv6/netfilter/nf_tproxy_ipv6.o: In function `nf_tproxy_get_sock_v6':
> nf_tproxy_ipv6.c:(.text+0x1a8): undefined reference to `udp6_lib_lookup'
> net/ipv4/netfilter/nf_tproxy_ipv4.o: In function `nf_tproxy_get_sock_v4':
> nf_tproxy_ipv4.c:(.text+0x3d0): undefined reference to `udp4_lib_lookup'
> 
> We can actually simplify the conditions now to provide the two functions
> exactly when they are needed.
> 
> Fixes: 45ca4e0cf273 ("netfilter: Libify xt_TPROXY")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Pablo, I'm going to apply this directly to fix the link failure.

Thanks Arnd.
