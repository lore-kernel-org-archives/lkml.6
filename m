Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEPSxf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:53:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44022 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:53:33 -0400
Date: Wed, 16 May 2018 14:53:32 -0400 (EDT)
Message-Id: <20180516.145332.1546960873264.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiyou.wangcong@gmail.com, avagin@virtuozzo.com, mst@redhat.com
Subject: Re: [PATCH net] tuntap: fix use after free during release
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526474373-16685-1-git-send-email-jasowang@redhat.com>
References: <1526474373-16685-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 May 2018 20:39:33 +0800

> After commit b196d88aba8a ("tun: fix use after free for ptr_ring") we
> need clean up tx ring during release(). But unfortunately, it tries to
> do the cleanup blindly after socket were destroyed which will lead
> another use-after-free. Fix this by doing the cleanup before dropping
> the last reference of the socket in __tun_detach().
> 
> Reported-by: Andrei Vagin <avagin@virtuozzo.com>
> Acked-by: Andrei Vagin <avagin@virtuozzo.com>
> Fixes: b196d88aba8a ("tun: fix use after free for ptr_ring")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
