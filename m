Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968380AbeCSRxh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:53:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33561 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965733AbeCSRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:53:33 -0400
X-Google-Smtp-Source: AG47ELu12A95cad/T5Xvo46N/RxoWJduPvXluE6I350YSr704hNBcRqsQp/xaozpsMBR+UuoIwCPfw==
Date: Mon, 19 Mar 2018 11:53:28 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Honggang LI <honli@redhat.com>
Cc: dledford@redhat.com, matanb@mellanox.com, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        noaos@mellanox.com
Subject: Re: [PATCH] IB/mlx5: Set the default active rate and width to QDR
 and 4X
Message-ID: <20180319175328.GF1225@ziepe.ca>
References: <20180316023713.30323-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316023713.30323-1-honli@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:37:13AM +0800, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> commit f1b65df5a232 ("IB/mlx5: Add support for active_width and
> active_speed in RoCE"). Before this patch applied, the mlx5_ib
> driver set default active_width and active_speed to IB_WIDTH_4X
> and IB_SPEED_QDR.
> 
> When the RoCE port is down, the RoCE port did not negotiate the
> active width with remote side. The active width is zero. If run
> ibstat to require the port status, ibstat will panic as it read
> invalid width from sys file.
> 
> This patch restores the original behavior.
> 
> Fixes: f1b65df5a232 ("IB/mlx5: Add support for active_width and active_speed in RoCE").
> Signed-off-by: Honggang Li <honli@redhat.com>
> Reviewed-by: Hal Rosenstock <hal@mellanox.com>
> Reviewed-by: Noa Osherovich <noaos@mellanox.com>
>  drivers/infiniband/hw/mlx5/main.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-next, thanks

Jason
