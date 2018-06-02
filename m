Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeFBJjg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:39:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45951 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751297AbeFBJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:39:32 -0400
X-ME-Proxy: <xmx:02USW8CeVr7xH0_9RPhUo6_GSaFccf9XL8ju35bXC6FysUSCvNpTDQ>
X-ME-Proxy: <xmx:02USW0GxQBbsl9hDMQwYbHFlA7KcuPqUr-VBEECDpQy_rwti9DszcQ>
X-ME-Proxy: <xmx:02USWzfbWMZAvmTQwHEhIPqU0rwkQeHLvBX9PuY25pN8zxSjCEu7bw>
X-ME-Proxy: <xmx:02USW6yU5AmbNr-NoX10wcNCCLCvo9bfwDSzKRWBedA8Kc8pOUsNYA>
X-ME-Proxy: <xmx:02USWyfL_uz3nZO625SMKm514efmwdPDS2DKpMfWPMBnzj9ytgsxgw>
X-ME-Proxy: <xmx:02USW2LEz0DUAVF4jtYakAzIpRM_hzZF2EB1VMcMk0AURMC3xG7BkA>
X-ME-Sender: <xms:02USW2rbOgM4peAuhJP81l1eRCrilodXGEm3Q5fk0GNq1JcWMgEFuw>
Date: Sat, 2 Jun 2018 12:39:28 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH net v2] ipv6: omit traffic class when calculating flow
 hash
Message-ID: <20180602093928.GA28635@splinter>
References: <20180602080528.54B27A0C48@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602080528.54B27A0C48@unicorn.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 09:40:34AM +0200, Michal Kubecek wrote:
> Some of the code paths calculating flow hash for IPv6 use flowlabel member
> of struct flowi6 which, despite its name, encodes both flow label and
> traffic class. If traffic class changes within a TCP connection (as e.g.
> ssh does), ECMP route can switch between path. It's also incosistent with
> other code paths where ip6_flowlabel() (returning only flow label) is used
> to feed the key.
> 
> Use only flow label everywhere, including one place where hash key is set
> using ip6_flowinfo().
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>
