Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeFBUdn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 16:33:43 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45437 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFBUdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 16:33:41 -0400
X-Google-Smtp-Source: ADUXVKJs75kCyhO+yrLOyf5EAVz3IZqMfkQ2H0mc1cPeUXaTeB7spTegKg/G47aCf1uJNzWZhC2fvA==
Subject: Re: [PATCH net v2] ipv6: omit traffic class when calculating flow
 hash
To: Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>, Ido Schimmel <idosch@idosch.org>
References: <20180602080528.54B27A0C48@unicorn.suse.cz>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0d6c6732-ee1b-3533-fc06-f97c9a87eb1a@gmail.com>
Date: Sat, 2 Jun 2018 14:33:38 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180602080528.54B27A0C48@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/18 1:40 AM, Michal Kubecek wrote:
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
> ---
> v2: introduce and use an inline helper as suggested by David Ahern
> 
>  include/net/ipv6.h        | 5 +++++
>  net/core/flow_dissector.c | 2 +-
>  net/ipv6/route.c          | 4 ++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 

Acked-by: David Ahern <dsahern@gmail.com>
