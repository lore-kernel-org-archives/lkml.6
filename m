Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeDHQmF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:42:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDHQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:42:03 -0400
Date: Sun, 08 Apr 2018 12:42:00 -0400 (EDT)
Message-Id: <20180408.124200.2204489876311923873.davem@davemloft.net>
To: Vadim.Lomovtsev@caviumnetworks.com
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com, robin.murphy@arm.com,
        hch@infradead.org, gustavo@embeddedor.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v4] net: thunderx: rework mac addresses list to u64
 array
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
        <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri,  6 Apr 2018 12:53:54 -0700

> @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>  						  work.work);
>  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
>  	union nic_mbx mbx = {};
> -	struct xcast_addr *xaddr, *next;
> +	int idx = 0;

No need to initialize idx.

> +		for (idx = 0; idx < vf_work->mc->count; idx++) {

As it is always explicitly initialized at, and only used inside of,
this loop.
