Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934409AbeDXNdB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:33:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50356 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933338AbeDXNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:32:58 -0400
Date: Tue, 24 Apr 2018 16:32:25 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Alex Vesker <valex@mellanox.com>, Erez Shitrit <erezsh@mellanox.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Feras Daoud <ferasda@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: fix ipoib_start_xmit()'s return type
Message-ID: <20180424133224.GA6766@yuvallap>
References: <20180424131549.2859-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131549.2859-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=835
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:15:47PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index 161ba8c76..cf291f90b 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1094,7 +1094,7 @@ static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
>  
> -static int ipoib_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t ipoib_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
>  	struct rdma_netdev *rn = netdev_priv(dev);
> -- 
> 2.17.0
> 
