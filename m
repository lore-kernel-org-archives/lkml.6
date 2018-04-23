Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755154AbeDWN6s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:58:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeDWN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:58:46 -0400
Date: Mon, 23 Apr 2018 09:58:44 -0400 (EDT)
Message-Id: <20180423.095844.822486182037441168.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: eric.dumazet@gmail.com, alexei.starovoitov@gmail.com,
        songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: introduce a new tracepoint for
 tcp_rcv_space_adjust
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524237506-11011-1-git-send-email-laoar.shao@gmail.com>
References: <1524237506-11011-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 20 Apr 2018 23:18:26 +0800

> tcp_rcv_space_adjust is called every time data is copied to user space,
> introducing a tcp tracepoint for which could show us when the packet is
> copied to user.
> 
> When a tcp packet arrives, tcp_rcv_established() will be called and with
> the existed tracepoint tcp_probe we could get the time when this packet
> arrives.
> Then this packet will be copied to user, and tcp_rcv_space_adjust will
> be called and with this new introduced tracepoint we could get the time
> when this packet is copied to user.
> With these two tracepoints, we could figure out whether the user program
> processes this packet immediately or there's latency.
> 
> Hence in the printk message, sk_cookie is printed as a key to relate
> tcp_rcv_space_adjust with tcp_probe.
> 
> Maybe we could export sockfd in this new tracepoint as well, then we
> could relate this new tracepoint with epoll/read/recv* tracepoints, and
> finally that could show us the whole lifespan of this packet. But we
> could also implement that with pid as these functions are executed in
> process context.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> ---
> v2 -> v3: use sock_gen_cookie in tcp_event_sk as well.
>           Maybe we could init sk_cookie in the stack then in other code
>           path we just read it other than set it. If that is needed I
>           will do it in another new patch.
> v1 -> v2: use sk_cookie as a key suggested by Eric.

Applied, thank you.
