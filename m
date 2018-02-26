Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeBZSuZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:50:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45642 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:50:23 -0500
Date: Mon, 26 Feb 2018 13:50:22 -0500 (EST)
Message-Id: <20180226.135022.860881687141218018.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        sergei.shtylyov@cogentembedded.com, christoffer.dall@linaro.org,
        brouer@redhat.com
Subject: Re: [PATCH V4 net 3/3] tuntap: correctly add the missing XDP flush
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519443146-9089-3-git-send-email-jasowang@redhat.com>
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
        <1519443146-9089-3-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Sat, 24 Feb 2018 11:32:26 +0800

> We don't flush batched XDP packets through xdp_do_flush_map(), this
> will cause packets stall at TX queue. Consider we don't do XDP on NAPI
> poll(), the only possible fix is to call xdp_do_flush_map()
> immediately after xdp_do_redirect().
> 
> Note, this in fact won't try to batch packets through devmap, we could
> address in the future.
> 
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Fixes: 761876c857cb ("tap: XDP support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, and all 3 patches queued up for -stable.

Thanks.
