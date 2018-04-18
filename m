Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeDRRqy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:46:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDRRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:46:53 -0400
Date: Wed, 18 Apr 2018 13:46:51 -0400 (EDT)
Message-Id: <20180418.134651.2225112489265654270.davem@davemloft.net>
To: mpatocka@redhat.com
Cc: eric.dumazet@gmail.com, edumazet@google.com, joby.poriyath@citrix.com,
        bhutchings@solarflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
        <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
        <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Apr 2018 12:44:25 -0400 (EDT)

> The structure net_device is followed by arbitrary driver-specific data 
> (accessible with the function netdev_priv). And for virtio-net, these 
> driver-specific data must be in DMA memory.

And we are saying that this assumption is wrong and needs to be
corrected.
