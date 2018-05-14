Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeENASy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:18:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51378 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeENASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:18:53 -0400
Date: Sun, 13 May 2018 20:18:51 -0400 (EDT)
Message-Id: <20180513.201851.1296027654181841669.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiyou.wangcong@gmail.com, eric.dumazet@gmail.com, mst@redhat.com
Subject: Re: [PATCH net V2] tun: fix use after free for ptr_ring
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
References: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 May 2018 10:49:25 +0800

> We used to initialize ptr_ring during TUNSETIFF, this is because its
> size depends on the tx_queue_len of netdevice. And we try to clean it
> up when socket were detached from netdevice. A race were spotted when
> trying to do uninit during a read which will lead a use after free for
> pointer ring. Solving this by always initialize a zero size ptr_ring
> in open() and do resizing during TUNSETIFF, and then we can safely do
> cleanup during close(). With this, there's no need for the workaround
> that was introduced by commit 4df0bfc79904 ("tun: fix a memory leak
> for tfile->tx_array").
> 
> Reported-by: syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Jason, please address Cong Wang's concerns.

Thank you.
