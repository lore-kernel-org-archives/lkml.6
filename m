Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933979AbeEWScn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:32:43 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeEWScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:32:42 -0400
Date: Wed, 23 May 2018 14:32:40 -0400 (EDT)
Message-Id: <20180523.143240.210663170832759811.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        hannes@stressinduktion.org, edumazet@google.com
Subject: Re: [PATCH net] tuntap: correctly set SOCKWQ_ASYNC_NOSPACE
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526970064-29711-1-git-send-email-jasowang@redhat.com>
References: <1526970064-29711-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 May 2018 14:21:04 +0800

> When link is down, writes to the device might fail with
> -EIO. Userspace needs an indication when the status is resolved.  As a
> fix, tun_net_open() attempts to wake up writers - but that is only
> effective if SOCKWQ_ASYNC_NOSPACE has been set in the past. This is
> not the case of vhost_net which only poll for EPOLLOUT after it meets
> errors during sendmsg().
> 
> This patch fixes this by making sure SOCKWQ_ASYNC_NOSPACE is set when
> socket is not writable or device is down to guarantee EPOLLOUT will be
> raised in either tun_chr_poll() or tun_sock_write_space() after device
> is up.
> 
> Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
