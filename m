Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeFAO2u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:28:50 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46412 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeFAO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:28:47 -0400
Date: Fri, 01 Jun 2018 10:28:43 -0400 (EDT)
Message-Id: <20180601.102843.1873090277840412224.davem@davemloft.net>
To: ktkhai@virtuozzo.com
Cc: ebiggers@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tom@quantonium.net, viro@ZenIV.linux.org.uk, edumazet@google.com
Subject: Re: [PATCH net] kcm: Fix use-after-free caused by clonned sockets
From: David Miller <davem@davemloft.net>
In-Reply-To: <c1d76abc-5d6f-bd0a-9c84-1c5ed8119e8f@virtuozzo.com>
References: <9f485659-6d6f-9047-b9ad-b0e4084be88d@virtuozzo.com>
        <c1d76abc-5d6f-bd0a-9c84-1c5ed8119e8f@virtuozzo.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>
Date: Fri, 1 Jun 2018 14:30:38 +0300

> (resend for properly queueing in patchwork)
> 
> kcm_clone() creates kernel socket, which does not take net counter.
> Thus, the net may die before the socket is completely destructed,
> i.e. kcm_exit_net() is executed before kcm_done().
> 
> Reported-by: syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Applied and queued up for -stable, thanks.
