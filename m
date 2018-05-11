Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEKBaR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:30:17 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:45748 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeEKBaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:30:15 -0400
X-Google-Smtp-Source: AB8JxZoLd43ux1+RQ54EQAKLJw2UWThco/m5ixF0Q5q0vqAVa7ACJneK1zRnzELWkk+Zvai79pde5Q==
Date: Fri, 11 May 2018 09:30:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20180511013003.GG8958@leo.usersys.redhat.com>
References: <20180511071716.038a9095@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511071716.038a9095@canb.auug.org.au>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 07:17:16AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   0e8411e426e2 ("ipv4: reset fnhe_mtu_locked after cache route flushed")
> 
> is missing a Signed-off-by from its author.

Opps, My bad.

> After route cache is flushed via ipv4_sysctl_rtcache_flush(), we forget
> to reset fnhe_mtu_locked in rt_bind_exception(). When pmtu is updated
> in __ip_rt_update_pmtu(), it will return directly since the pmtu is
> still locked. e.g.
>
> + ip netns exec client ping 10.10.1.1 -c 1 -s 1400 -M do
> PING 10.10.1.1 (10.10.1.1) 1400(1428) bytes of data.
> From 10.10.0.254 icmp_seq=1 Frag needed and DF set (mtu = 0)
>
> --- 10.10.1.1 ping statistics ---
> 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

I shouldn't add comments with the '---' lines. David reminded me before. But
I didn't realise it when pasted the ping logs. Another lesson learned...

Thanks Stephen.

Regards
Hangbin
