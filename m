Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeDRRpK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:45:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeDRRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:45:09 -0400
Date: Wed, 18 Apr 2018 13:45:07 -0400 (EDT)
Message-Id: <20180418.134507.1436128340000357572.davem@davemloft.net>
To: eric.dumazet@gmail.com
Cc: mpatocka@redhat.com, edumazet@google.com, joby.poriyath@citrix.com,
        bhutchings@solarflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
From: David Miller <davem@davemloft.net>
In-Reply-To: <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
        <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 18 Apr 2018 09:05:54 -0700

> Each virtio_net should probably allocate the exact amount of
> DMA-memory it wants, instead of expecting core networking stack to
> have a huge chunk of DMA-memory for everything.

Yes, if you need DMA'able memory, allocate DMA'able memory separately
and hang it off of the netdev instead of assuming you can just DMA
in/out of it.
