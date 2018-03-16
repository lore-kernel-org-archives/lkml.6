Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeCPO7i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:59:38 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40186 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeCPO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:59:36 -0400
X-Google-Smtp-Source: AG47ELulB+yKtVT9OCpwM71CdyGpOIf/1wbukti1ZXmmiH0MTWhG6rp7M5Q5GNgC0X7thq+EkPrktQ==
Subject: Re: [PATCH] IB/mlx5: Set the default active rate and width to QDR and
 4X
To: Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca,
        matanb@mellanox.com, leonro@mellanox.com, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, noaos@mellanox.com
References: <20180316023713.30323-1-honli@redhat.com>
From: Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <ec18ffec-d7af-9a52-2da3-d4abea23e1a0@dev.mellanox.co.il>
Date: Fri, 16 Mar 2018 10:59:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316023713.30323-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/2018 10:37 PM, Honggang LI wrote:
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

Reviewed-by: Hal Rosenstock <hal@mellanox.com>

> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 033b6af90de9..a48e9730fab8 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -388,6 +388,9 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
>  	if (err)
>  		goto out;
>  
> +	props->active_width     = IB_WIDTH_4X;
> +	props->active_speed     = IB_SPEED_QDR;
> +
>  	translate_eth_proto_oper(eth_prot_oper, &props->active_speed,
>  				 &props->active_width);
>  
> 
