Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC5ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35602150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tAiR5PT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35602150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbeISVk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:40:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47354 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeISVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:40:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8JFx0Wl099810;
        Wed, 19 Sep 2018 16:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=sbjxAMFLS5JO7yTaKfIu5mBEKm7wBGsoiYKE2RLGYME=;
 b=tAiR5PT7nRZGW9dlXPmpvcs+c8q6Fb1Nsam/TGfkl8bIPdtjX0mZ8K+s5kdClQd3dDmc
 4WYKZgu6RepBkcGr0JmrlmTo8bTfbnmAB/NNSydK3gRo1KH7WH8jygZbBjpD1GAINPkw
 3t9rCNmMAxEshuybzblsaCApJ+fUHXh7/Pxy8hWjL28hDPxzdw97btcPsBfzCG1nZl8y
 TLc7HitK/mC9qrqJk//jysZ4vObYvo5BNr/OAqZQxQXQ9t9CSJLnRCl2itLzkU9Ey4ho
 Orii4gjf3/5IxqaJHOfukaQk6KBqXw7MBbAAHS9r9DnMl4a/hUnXXIBuUmQO2lLoOLXl wA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mgt1pv076-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 16:01:37 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8JG1amr002339
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 16:01:36 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8JG1ZoV020895;
        Wed, 19 Sep 2018 16:01:35 GMT
Received: from [10.159.242.150] (/10.159.242.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Sep 2018 09:01:35 -0700
Subject: Re: [PATCH net-next] net: sun: fix return type of ndo_start_xmit
 function
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        alexander.h.duyck@intel.com, yanjun.zhu@oracle.com,
        jeffrey.t.kirsher@intel.com, tklauser@distanz.ch
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180919112132.26616-1-yuehaibing@huawei.com>
From:   Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <6f30b2a1-f60f-8b76-1707-95a89fd63087@oracle.com>
Date:   Wed, 19 Sep 2018 09:01:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919112132.26616-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9020 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2018 4:21 AM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>

> ---
>   drivers/net/ethernet/sun/ldmvsw.c         |  2 +-
>   drivers/net/ethernet/sun/sunbmac.c        |  3 ++-
>   drivers/net/ethernet/sun/sunqe.c          |  2 +-
>   drivers/net/ethernet/sun/sunvnet.c        |  2 +-
>   drivers/net/ethernet/sun/sunvnet_common.c | 14 ++++++++------
>   drivers/net/ethernet/sun/sunvnet_common.h |  7 ++++---
>   6 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
> index d42f47f..644e42c 100644
> --- a/drivers/net/ethernet/sun/ldmvsw.c
> +++ b/drivers/net/ethernet/sun/ldmvsw.c
> @@ -113,7 +113,7 @@ static u16 vsw_select_queue(struct net_device *dev, struct sk_buff *skb,
>   }
>   
>   /* Wrappers to common functions */
> -static int vsw_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t vsw_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	return sunvnet_start_xmit_common(skb, dev, vsw_tx_port_find);
>   }
> diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
> index f047b27..720b7ac 100644
> --- a/drivers/net/ethernet/sun/sunbmac.c
> +++ b/drivers/net/ethernet/sun/sunbmac.c
> @@ -950,7 +950,8 @@ static void bigmac_tx_timeout(struct net_device *dev)
>   }
>   
>   /* Put a packet on the wire. */
> -static int bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t
> +bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct bigmac *bp = netdev_priv(dev);
>   	int len, entry;
> diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
> index 7fe0d5e..1468fa0 100644
> --- a/drivers/net/ethernet/sun/sunqe.c
> +++ b/drivers/net/ethernet/sun/sunqe.c
> @@ -570,7 +570,7 @@ static void qe_tx_timeout(struct net_device *dev)
>   }
>   
>   /* Get a packet queued to go onto the wire. */
> -static int qe_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t qe_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct sunqe *qep = netdev_priv(dev);
>   	struct sunqe_buffers *qbufs = qep->buffers;
> diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
> index 12539b3..5901728 100644
> --- a/drivers/net/ethernet/sun/sunvnet.c
> +++ b/drivers/net/ethernet/sun/sunvnet.c
> @@ -247,7 +247,7 @@ static u16 vnet_select_queue(struct net_device *dev, struct sk_buff *skb,
>   }
>   
>   /* Wrappers to common functions */
> -static int vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	return sunvnet_start_xmit_common(skb, dev, vnet_tx_port_find);
>   }
> diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
> index d8f4c3f..baa3088 100644
> --- a/drivers/net/ethernet/sun/sunvnet_common.c
> +++ b/drivers/net/ethernet/sun/sunvnet_common.c
> @@ -1216,9 +1216,10 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
>   	return skb;
>   }
>   
> -static int vnet_handle_offloads(struct vnet_port *port, struct sk_buff *skb,
> -				struct vnet_port *(*vnet_tx_port)
> -				(struct sk_buff *, struct net_device *))
> +static netdev_tx_t
> +vnet_handle_offloads(struct vnet_port *port, struct sk_buff *skb,
> +		     struct vnet_port *(*vnet_tx_port)
> +		     (struct sk_buff *, struct net_device *))
>   {
>   	struct net_device *dev = VNET_PORT_TO_NET_DEVICE(port);
>   	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
> @@ -1321,9 +1322,10 @@ static int vnet_handle_offloads(struct vnet_port *port, struct sk_buff *skb,
>   	return NETDEV_TX_OK;
>   }
>   
> -int sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
> -			      struct vnet_port *(*vnet_tx_port)
> -			      (struct sk_buff *, struct net_device *))
> +netdev_tx_t
> +sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
> +			  struct vnet_port *(*vnet_tx_port)
> +			  (struct sk_buff *, struct net_device *))
>   {
>   	struct vnet_port *port = NULL;
>   	struct vio_dring_state *dr;
> diff --git a/drivers/net/ethernet/sun/sunvnet_common.h b/drivers/net/ethernet/sun/sunvnet_common.h
> index 1ea0b01..2b808d2 100644
> --- a/drivers/net/ethernet/sun/sunvnet_common.h
> +++ b/drivers/net/ethernet/sun/sunvnet_common.h
> @@ -136,9 +136,10 @@ struct vnet {
>   void sunvnet_set_rx_mode_common(struct net_device *dev, struct vnet *vp);
>   int sunvnet_set_mac_addr_common(struct net_device *dev, void *p);
>   void sunvnet_tx_timeout_common(struct net_device *dev);
> -int sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
> -			   struct vnet_port *(*vnet_tx_port)
> -			   (struct sk_buff *, struct net_device *));
> +netdev_tx_t
> +sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
> +			  struct vnet_port *(*vnet_tx_port)
> +			  (struct sk_buff *, struct net_device *));
>   #ifdef CONFIG_NET_POLL_CONTROLLER
>   void sunvnet_poll_controller_common(struct net_device *dev, struct vnet *vp);
>   #endif
> 
