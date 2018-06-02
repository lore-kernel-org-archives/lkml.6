Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeFBHyU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 03:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFBHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 03:54:15 -0400
Date: Sat, 2 Jun 2018 09:54:12 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Ido Schimmel <idosch@idosch.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH net] ipv6: omit traffic class when calculating flow hash
Message-ID: <20180602075411.y64k2cu7kz3ygp6d@unicorn.suse.cz>
References: <20180601112948.93BE7A0C48@unicorn.suse.cz>
 <20180601181929.GA16452@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601181929.GA16452@splinter>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 09:19:29PM +0300, Ido Schimmel wrote:
> On Fri, Jun 01, 2018 at 12:34:41PM +0200, Michal Kubecek wrote:
> > Some of the code paths calculating flow hash for IPv6 use flowlabel member
> > of struct flowi6 which, despite its name, encodes both flow label and
> > traffic class. If traffic class changes within a TCP connection (as e.g.
> > ssh does), ECMP route can switch between path. It's also incosistent with
> > other code paths where ip6_flowlabel() (returning only flow label) is used
> > to feed the key.
> > 
> > Use only flow label everywhere, including one place where hash key is set
> > using ip6_flowinfo().
> > 
> > Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> > Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> Please consider adding a test case to
> tools/testing/selftests/net/fib_tests.sh
> 
> Personally, I tested the patch by looping over different values of 'tos'
> for 'ip route get' and confirmed that the same nexthop is selected.

Thanks for the tip, I'll look into it next week.

Michal Kubecek
