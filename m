Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeCWRGY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:06:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43986 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeCWRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:06:21 -0400
Date: Fri, 23 Mar 2018 13:06:19 -0400 (EDT)
Message-Id: <20180323.130619.2053176034900779506.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: yuval.shaia@oracle.com, ilant@mellanox.com, borisp@mellanox.com,
        saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/mlx5: Fix use-after-free
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180322184456.GA22259@embeddedgus>
References: <20180322184456.GA22259@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 22 Mar 2018 13:44:56 -0500

> _rule_ is being freed and then dereferenced by accessing rule->ctx
> 
> Fix this by copying the value returned by PTR_ERR(rule->ctx) into a local
> variable for its safe use after freeing _rule_
> 
> Addresses-Coverity-ID: 1466041 ("Read from pointer after free")
> Fixes: 05564d0ae075 ("net/mlx5: Add flow-steering commands for FPGA IPSec implementation")
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Use a short subject prefix as suggested by Yuval Shaia.
>  - Add Yuval's Reviewed-by.

Applied to net-next.

Thank you.
