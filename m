Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeCZPie (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:38:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52188 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeCZPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:38:32 -0400
Date: Mon, 26 Mar 2018 11:38:30 -0400 (EDT)
Message-Id: <20180326.113830.932262386304702367.davem@davemloft.net>
To: mdf@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, robh+dt@kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com
Subject: Re: [PATCH v5 2/2] net: ethernet: nixge: Add support for National
 Instruments XGE netdev
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180323204128.29783-2-mdf@kernel.org>
References: <20180323204128.29783-1-mdf@kernel.org>
        <20180323204128.29783-2-mdf@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Fri, 23 Mar 2018 13:41:28 -0700

> +static void nixge_hw_dma_bd_release(struct net_device *ndev)
> +{
> +	int i;
> +	struct nixge_priv *priv = netdev_priv(ndev);

Please order local variables from longest to shortest line (ie. reverse
christmas tree layout).

> +static int nixge_hw_dma_bd_init(struct net_device *ndev)
> +{
> +	u32 cr;
> +	int i;
> +	struct sk_buff *skb;
> +	struct nixge_priv *priv = netdev_priv(ndev);

Likewise.

> +static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
> +{
> +	u32 status;
> +	int err;
> +	/* Reset Axi DMA. This would reset NIXGE Ethernet core as well.
> +	 * The reset process of Axi DMA takes a while to complete as all
> +	 * pending commands/transfers will be flushed or completed during
> +	 * this reset process.
> +	 */

Please put an empty line between the local variable declarations
and this comment.
