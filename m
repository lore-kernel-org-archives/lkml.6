Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37709C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E8B214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E8B214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeIZR4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:56:09 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:55329 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:56:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 2A83C2B52035;
        Wed, 26 Sep 2018 13:43:32 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sU3MTPeWw88H; Wed, 26 Sep 2018 13:43:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id CB6CF2B52098;
        Wed, 26 Sep 2018 13:43:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2-TJZTp5AAHW; Wed, 26 Sep 2018 13:43:30 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 9359A2B52035;
        Wed, 26 Sep 2018 13:43:30 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 6D19760177; Wed, 26 Sep 2018 13:43:30 +0200 (CEST)
Date:   Wed, 26 Sep 2018 13:43:30 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] l2tp: fix return type of ndo_start_xmit function
Message-ID: <20180926114330.GA1487@alphalink.fr>
References: <20180926103839.28584-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926103839.28584-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:38:39PM +0800, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/l2tp/l2tp_eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index 8aadc4f..4173cb1 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c
> @@ -77,7 +77,8 @@ static void l2tp_eth_dev_uninit(struct net_device *dev)
>  	 */
>  }
>  
> -static int l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t
> +l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)

Return type and function name are generally kept on the same line:
+static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb,
+				      struct net_device *dev)

Anyway,
Acked-by: Guillaume Nault <g.nault@alphalink.fr>

