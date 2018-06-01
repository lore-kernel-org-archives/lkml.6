Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeFAMZ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:25:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38085 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFAMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:25:25 -0400
X-Google-Smtp-Source: ADUXVKI3/epnZholzzaDudiLZtoBFFoCfAPPHLWQXnbs6Bwp9gOOkwn4TvJggRqZQWHrH9MxYOe84Q==
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] ipv6: omit traffic class when calculating flow hash
References: <20180601112948.93BE7A0C48@unicorn.suse.cz>
To: Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Herbert <tom@herbertland.com>, David Ahern <dsahern@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <d6083b5b-1f8c-7a43-9186-391f905cf8c8@6wind.com>
Date: Fri, 1 Jun 2018 14:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601112948.93BE7A0C48@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/06/2018 à 12:34, Michal Kubecek a écrit :
> Some of the code paths calculating flow hash for IPv6 use flowlabel member
> of struct flowi6 which, despite its name, encodes both flow label and
> traffic class. If traffic class changes within a TCP connection (as e.g.
> ssh does), ECMP route can switch between path. It's also incosistent with
nit: s/incosistent/inconsistent

> other code paths where ip6_flowlabel() (returning only flow label) is used
> to feed the key.
> 
> Use only flow label everywhere, including one place where hash key is set
> using ip6_flowinfo().
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
