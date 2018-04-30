Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeD3BeY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 21:34:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:54024 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeD3BeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 21:34:19 -0400
Date: Sun, 29 Apr 2018 21:34:17 -0400 (EDT)
Message-Id: <20180429.213417.1622456092178936722.davem@davemloft.net>
To: edumazet@google.com
Cc: netdev@vger.kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ka-cheong.poon@oracle.com, eric.dumazet@gmail.com
Subject: Re: [PATCH v4 net-next 0/2] tcp: mmap: rework zerocopy receive
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180427155809.79094-1-edumazet@google.com>
References: <20180427155809.79094-1-edumazet@google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Apr 2018 08:58:07 -0700

> syzbot reported a lockdep issue caused by tcp mmap() support.
> 
> I implemented Andy Lutomirski nice suggestions to resolve the
> issue and increase scalability as well.
> 
> First patch is adding a new getsockopt() operation and changes mmap()
> behavior.
> 
> Second patch changes tcp_mmap reference program.
> 
> v4: tcp mmap() support depends on CONFIG_MMU, as kbuild bot told us.
> 
> v3: change TCP_ZEROCOPY_RECEIVE to be a getsockopt() option
>     instead of setsockopt(), feedback from Ka-Cheon Poon
> 
> v2: Added a missing page align of zc->length in tcp_zerocopy_receive()
>     Properly clear zc->recv_skip_hint in case user request was completed.

Looks great, series applied, thanks Eric.
