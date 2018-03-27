Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbeC0RE5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:04:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbeC0REp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:04:45 -0400
Date: Tue, 27 Mar 2018 13:04:29 -0400 (EDT)
Message-Id: <20180327.130429.1060831999612495885.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH net V2] vhost: correctly remove wait queue during poll
 failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
References: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Mar 2018 20:50:52 +0800

> We tried to remove vq poll from wait queue, but do not check whether
> or not it was in a list before. This will lead double free. Fixing
> this by switching to use vhost_poll_stop() which zeros poll->wqh after
> removing poll from waitqueue to make sure it won't be freed twice.
> 
> Cc: Darren Kenny <darren.kenny@oracle.com>
> Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
> Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - tweak the commit log for to match the code

Applied and queued up for -stable, thank you.
