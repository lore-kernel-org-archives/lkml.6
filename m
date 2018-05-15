Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEOWVe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:21:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38605 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEOWVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:21:32 -0400
X-Google-Smtp-Source: AB8JxZrtP/990aXd5vTrUO3JXNYQI25NM5mq9W/Em9z65GGcMicCuv1trDAGd3PBY50LVQ2rPJunCA==
Date: Tue, 15 May 2018 16:21:25 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        dledford@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] {net, IB}/mlx5: Use 'kvfree()' for memory allocated
 by 'kvzalloc()'
Message-ID: <20180515222125.GA20160@ziepe.ca>
References: <20180513070041.24246-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513070041.24246-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 09:00:41AM +0200, Christophe JAILLET wrote:
> When 'kvzalloc()' is used to allocate memory, 'kvfree()' must be used to
> free it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 -> v2: More places to update have been added to the patch
> ---
>  drivers/infiniband/hw/mlx5/cq.c                            | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/vport.c            | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

I agree with Eric on the need for fixes lines in v3..

> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
> index 77d257ec899b..6d52ea03574e 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -849,7 +849,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
>  	return 0;
>  
>  err_cqb:
> -	kfree(*cqb);
> +	kvfree(*cqb);

For the infiniband part:

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Since this is mostly ethernet, can it go through netdev? thanks

Jason
