Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDRRzj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:55:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752687AbeDRRzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:55:22 -0400
Date: Wed, 18 Apr 2018 13:55:21 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: David Miller <davem@davemloft.net>
cc: eric.dumazet@gmail.com, edumazet@google.com, joby.poriyath@citrix.com,
        bhutchings@solarflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
In-Reply-To: <20180418.134721.283381724211219025.davem@davemloft.net>
Message-ID: <alpine.LRH.2.02.1804181354490.17942@file01.intranet.prod.int.rdu2.redhat.com>
References: <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com> <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com> <5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com> <20180418.134721.283381724211219025.davem@davemloft.net>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2018, David Miller wrote:

> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Wed, 18 Apr 2018 09:51:25 -0700
> 
> > I suggest that virtio_net clearly identifies which part needs a specific allocation
> > and does its itself, instead of abusing the netdev_priv storage.
> > 
> > Ie use a pointer to a block of memory, allocated by virtio_net, for virtio_net.
> 
> +1

And what about the other networking drivers that may do the same thing?

Mikulas
