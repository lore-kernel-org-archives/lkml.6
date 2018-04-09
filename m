Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDIPAV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:00:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDIPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:00:19 -0400
Date: Mon, 09 Apr 2018 11:00:16 -0400 (EDT)
Message-Id: <20180409.110016.166919257730352493.davem@davemloft.net>
To: Vadim.Lomovtsev@caviumnetworks.com
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com, robin.murphy@arm.com,
        hch@infradead.org, gustavo@embeddedor.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v5] net: thunderx: rework mac addresses list to u64
 array
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180409132448.22278-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
        <20180409132448.22278-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Mon,  9 Apr 2018 06:24:48 -0700

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> It is too expensive to pass u64 values via linked list, instead
> allocate array for them by overall number of mac addresses from netdev.
> 
> This eventually removes multiple kmalloc() calls, aviod memory
> fragmentation and allow to put single null check on kmalloc
> return value in order to prevent a potential null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

Applied, thanks.
