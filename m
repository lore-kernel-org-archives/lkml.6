Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeB1RWl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:22:41 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753414AbeB1RWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:22:32 -0500
Date: Wed, 28 Feb 2018 12:22:31 -0500 (EST)
Message-Id: <20180228.122231.1811613646832502397.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: disable NAPI only when enabled during
 XDP set
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
References: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Feb 2018 18:20:04 +0800

> We try to disable NAPI to prevent a single XDP TX queue being used by
> multiple cpus. But we don't check if device is up (NAPI is enabled),
> this could result stall because of infinite wait in
> napi_disable(). Fixing this by checking device state through
> netif_running() before.
> 
> Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Yes, mis-paired NAPI enable/disable are really a pain.

Probably, we can do something in the interfaces or mechanisms to make
this less error prone and less fragile.

Anyways, applied and queued up for -stable, thanks!
