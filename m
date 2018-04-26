Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757142AbeDZWPV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:15:21 -0400
Received: from mail.us.es ([193.147.175.20]:34252 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756930AbeDZWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:15:19 -0400
Date: Fri, 27 Apr 2018 00:15:15 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] netfilter: fix nf_tables filter chain type build
Message-ID: <20180426221515.56pyozqb2nf6jadw@salvia>
References: <c8e42e35-ccff-471c-8c45-61f44855e21a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e42e35-ccff-471c-8c45-61f44855e21a@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 09:10:09PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors due to a missing Kconfig dependency term.
> Fixes these build errors:
> 
> net/ipv6/netfilter/nft_chain_nat_ipv6.o: In function `nft_nat_do_chain':
> net/ipv6/netfilter/nft_chain_nat_ipv6.c:37: undefined reference to `nft_do_chain'
> net/ipv6/netfilter/nft_chain_nat_ipv6.o: In function `nft_chain_nat_ipv6_exit':
> net/ipv6/netfilter/nft_chain_nat_ipv6.c:94: undefined reference to `nft_unregister_chain_type'
> net/ipv6/netfilter/nft_chain_nat_ipv6.o: In function `nft_chain_nat_ipv6_init':
> net/ipv6/netfilter/nft_chain_nat_ipv6.c:87: undefined reference to `nft_register_chain_type'

Thanks for sending a patch for this Randy.

We have a patch to address this that should fix this:

https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git/commit/?id=39f2ff0816e5421476c2bc538b68b4bb0708a78e

Thanks!
