Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeDRSA0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:00:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752530AbeDRSAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:00:25 -0400
Date: Wed, 18 Apr 2018 21:00:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: eric.dumazet@gmail.com, mpatocka@redhat.com, edumazet@google.com,
        joby.poriyath@citrix.com, bhutchings@solarflare.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
Message-ID: <20180418205539-mutt-send-email-mst@kernel.org>
References: <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
 <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
 <5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com>
 <20180418.134721.283381724211219025.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418.134721.283381724211219025.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 01:47:21PM -0400, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Wed, 18 Apr 2018 09:51:25 -0700
> 
> > I suggest that virtio_net clearly identifies which part needs a specific allocation
> > and does its itself, instead of abusing the netdev_priv storage.
> > 
> > Ie use a pointer to a block of memory, allocated by virtio_net, for virtio_net.
> 
> +1

I can do this, but just FYI it's all of 16 bytes which is only mapped
for DMA temporarily - and not all of it - a byte here, a byte there.
The amount of hoops one has to jump through just to get 1 byte from
device nowdays is annoying.

-- 
MST
