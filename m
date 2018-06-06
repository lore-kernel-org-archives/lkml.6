Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 599B3607E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeFFNdd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:33:33 -0400
Received: from mail.us.es ([193.147.175.20]:59300 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751946AbeFFNd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:33:29 -0400
Date: Wed, 6 Jun 2018 15:33:24 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        ecklm94@gmail.com, pabeni@redhat.com, willemb@google.com,
        edumazet@google.com, dsahern@gmail.com, kafai@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: provide udp*_lib_lookup for nf_tproxy
Message-ID: <20180606133324.537naj6trahiq26f@salvia>
References: <20180605114056.1239571-1-arnd@arndb.de>
 <20180605.105453.339908802413146875.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605.105453.339908802413146875.davem@davemloft.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:54:53AM -0400, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue,  5 Jun 2018 13:40:34 +0200
> 
> > It is now possible to enable the libified nf_tproxy modules without
> > also enabling NETFILTER_XT_TARGET_TPROXY, which throws off the
> > ifdef logic in the udp core code:
> > 
> > net/ipv6/netfilter/nf_tproxy_ipv6.o: In function `nf_tproxy_get_sock_v6':
> > nf_tproxy_ipv6.c:(.text+0x1a8): undefined reference to `udp6_lib_lookup'
> > net/ipv4/netfilter/nf_tproxy_ipv4.o: In function `nf_tproxy_get_sock_v4':
> > nf_tproxy_ipv4.c:(.text+0x3d0): undefined reference to `udp4_lib_lookup'
> > 
> > We can actually simplify the conditions now to provide the two functions
> > exactly when they are needed.
> > 
> > Fixes: 45ca4e0cf273 ("netfilter: Libify xt_TPROXY")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Pablo, I'm going to apply this directly to fix the link failure.

BTW, could you also pick this fix for net-next?

http://patchwork.ozlabs.org/patch/924706/

Thanks.
