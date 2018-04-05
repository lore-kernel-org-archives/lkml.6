Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDEPHy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:07:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:07:53 -0400
Date: Thu, 5 Apr 2018 08:07:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, dnelson@redhat.com, gustavo@embeddedor.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180405150748.GA5716@infradead.org>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  struct xcast_addr_list {
> -	struct list_head list;
>  	int              count;
> +	u64              mc[0];

Please use the standard C99 syntax here:

	u64              mc[];

> +				mc_list = kmalloc(sizeof(*mc_list) +
> +						  sizeof(u64) * netdev_mc_count(netdev),
> +						  GFP_ATOMIC);

kmalloc_array(), please.
