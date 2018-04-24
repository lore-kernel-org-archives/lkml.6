Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934648AbeDXNhM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:37:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934178AbeDXNhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:37:05 -0400
Date: Tue, 24 Apr 2018 16:36:53 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: ks8851: fix ks_start_xmit()'s return type
Message-ID: <20180424133653.GB6766@yuvallap>
References: <20180424131705.4155-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131705.4155-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:17:02PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> ---
>  drivers/net/ethernet/micrel/ks8851_mll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
> index f3e9dd47b..a732fdeb5 100644
> --- a/drivers/net/ethernet/micrel/ks8851_mll.c
> +++ b/drivers/net/ethernet/micrel/ks8851_mll.c
> @@ -1020,7 +1020,7 @@ static void ks_write_qmu(struct ks_net *ks, u8 *pdata, u16 len)
>   * spin_lock_irqsave is required because tx and rx should be mutual exclusive.
>   * So while tx is in-progress, prevent IRQ interrupt from happenning.
>   */
> -static int ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
> +static netdev_tx_t ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
>  {
>  	int retv = NETDEV_TX_OK;
>  	struct ks_net *ks = netdev_priv(netdev);
> -- 
> 2.17.0
> 
