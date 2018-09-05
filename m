Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159722077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv6iIYiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159722077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIEEz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:55:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41488 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEEz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:55:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so2397589plr.8;
        Tue, 04 Sep 2018 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NSdxTZvackXp364pB494RrnlBHOOsbz/cjAS4v8Yq0=;
        b=Kv6iIYiBXcHR3sj+y6p9JBGmpFP+nVhoa1y5EClasDtqbI5fPLxRnGQdvx8nyu5o7e
         CW52P3+cMsXYPiJ41WIvoeVkjg80TxSzeluhFY5v1TYeUW8aLEVEA2/k2K4ula/ATJRA
         zkQ+KnkWmLXnQBWBF7z9dx/RjzZNJYeZ89xKD8BvB34hroYSwLLheDMGolH1Ibh5Z5iq
         TSYEXfLtERLpjnr12qMpeDF0qAcWrh/EYb9PekO0Nx/L9QnWdbuycI5VNodbsJ+2cxRw
         u/YmSgQ5eg1w+4HZdVmTe/zuhHyO+2ctsFcqTcUU73tE5/5quc97h7rsUdxoxgbwIYxa
         hmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5NSdxTZvackXp364pB494RrnlBHOOsbz/cjAS4v8Yq0=;
        b=JBhQADVw1LNVJf9ZE+XMoqwDbK1WfAhl0do+UfGbbMIi95TSQyS99wPfY5zLNbNcIu
         LfcM1/1biYwLRe10o+EqRYYulbVH9n8ecfvNrXSDsTlc5Ra3NYLLd1XrhKtfp9utWLOc
         hKmKnIkckJMxC6qaediDwa+Cvg9cXxTYYth9vo9Avqe9+vOx0u4spl0h5465KSxV+/vx
         WRmzw7RR/7rpf6AilGo4LHM/o2Au4fs2vcV3frcjdso3BBetDskqHbPKjmHn6Dgmw75X
         SVLgQKyM25ZTLODb6s5AphDOWQeGpn48wA/rwNjDAf4mLZfrXVhfOeOECr/RxU85Cbd/
         /mBA==
X-Gm-Message-State: APzg51BZzBO8WUT35WLCmU92P1RTiY6K6nckl4V9+HHXnaD4hvyYZS+A
        1t7zPoH15yQwvW6IN943Wzpi2rvd
X-Google-Smtp-Source: ANB0VdZ0P/1gqV/AU01kpeVKNa2PWNaiGuCe0DSwY7ShizSOAMilpcEi10Yc1B+F+Nz+rMVUE4qAWQ==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr35313125pld.69.1536107276679;
        Tue, 04 Sep 2018 17:27:56 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u11-v6sm169981pgj.71.2018.09.04.17.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 17:27:55 -0700 (PDT)
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
To:     Moritz Fischer <mdf@kernel.org>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, alex.williams@ni.com,
        moritz.fischer@ettus.com, linux-kernel@vger.kernel.org
References: <20180905001535.19168-1-mdf@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <fa4fca9c-5950-8ec1-5746-91e51085cecf@gmail.com>
Date:   Tue, 4 Sep 2018 17:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905001535.19168-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 05:15 PM, Moritz Fischer wrote:
> Add basic PHYLINK support to driver.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi all,
> 
> as Andrew suggested in order to enable SFP as
> well as fixed-link support add PHYLINK support.
> 
> A couple of questions are still open (hence the RFC):
> 
> 1) It seems odd to implement PHYLINK callbacks that
>    are all empty? If so, should we have generic empty
>    ones in drivers/net/phy/phylink.c like we have for
>    genphys?

Yes it is odd, the validate callback most certainly should not be empty,
neither should the mac_config and mac_link_{up,down}, but, with some
luck, you can get things to just work, typically with MDIO PHYs, since a
large amount of what they can do is discoverable.

If you had an existing adjust_link callback from PHYLIB, it's really
about breaking it down such that the MAC configuration of
speed/duplex/pause happens in mac_config, and the link setting (if
necessary), happens in mac_link_{up,down}, and that's pretty much it for
MLO_AN_PHY cases.

> 
> 2) If this is ok, then I'll go ahead rework this with
>    a DT binding update to deprecate the non-'mdio'-subnode
>    case (since there are no in-tree users we might just
>    change the binding)?
> 
> 3) I'm again not sure about the 'select PHYLINK', wouldn't
>    wanna break the build again...
> 
> Thanks again for your time!
> 
> Moritz
> 
> ---
>  drivers/net/ethernet/ni/Kconfig |   1 +
>  drivers/net/ethernet/ni/nixge.c | 115 +++++++++++++++++++++++---------
>  2 files changed, 83 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ni/Kconfig b/drivers/net/ethernet/ni/Kconfig
> index c73978474c4b..80cd72948551 100644
> --- a/drivers/net/ethernet/ni/Kconfig
> +++ b/drivers/net/ethernet/ni/Kconfig
> @@ -21,6 +21,7 @@ config NI_XGE_MANAGEMENT_ENET
>  	depends on HAS_IOMEM && HAS_DMA
>  	select PHYLIB
>  	select OF_MDIO if OF
> +	select PHYLINK
>  	help
>  	  Simple LAN device for debug or management purposes. Can
>  	  support either 10G or 1G PHYs via SFP+ ports.
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 74cf52e3fb09..a0e790d07b1c 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/of_platform.h>
> +#include <linux/phylink.h>
>  #include <linux/of_irq.h>
>  #include <linux/skbuff.h>
>  #include <linux/phy.h>
> @@ -165,7 +166,7 @@ struct nixge_priv {
>  	struct device *dev;
>  
>  	/* Connection to PHY device */
> -	struct device_node *phy_node;
> +	struct phylink *phylink;
>  	phy_interface_t		phy_mode;
>  
>  	int link;
> @@ -416,20 +417,6 @@ static void nixge_device_reset(struct net_device *ndev)
>  	netif_trans_update(ndev);
>  }
>  
> -static void nixge_handle_link_change(struct net_device *ndev)
> -{
> -	struct nixge_priv *priv = netdev_priv(ndev);
> -	struct phy_device *phydev = ndev->phydev;
> -
> -	if (phydev->link != priv->link || phydev->speed != priv->speed ||
> -	    phydev->duplex != priv->duplex) {
> -		priv->link = phydev->link;
> -		priv->speed = phydev->speed;
> -		priv->duplex = phydev->duplex;
> -		phy_print_status(phydev);
> -	}
> -}
> -
>  static void nixge_tx_skb_unmap(struct nixge_priv *priv,
>  			       struct nixge_tx_skb *tx_skb)
>  {
> @@ -859,17 +846,15 @@ static void nixge_dma_err_handler(unsigned long data)
>  static int nixge_open(struct net_device *ndev)
>  {
>  	struct nixge_priv *priv = netdev_priv(ndev);
> -	struct phy_device *phy;
>  	int ret;
>  
>  	nixge_device_reset(ndev);
>  
> -	phy = of_phy_connect(ndev, priv->phy_node,
> -			     &nixge_handle_link_change, 0, priv->phy_mode);
> -	if (!phy)
> -		return -ENODEV;
> +	ret = phylink_of_phy_connect(priv->phylink, priv->dev->of_node, 0);
> +	if (ret < 0)
> +		return ret;
>  
> -	phy_start(phy);
> +	phylink_start(priv->phylink);
>  
>  	/* Enable tasklets for Axi DMA error handling */
>  	tasklet_init(&priv->dma_err_tasklet, nixge_dma_err_handler,
> @@ -893,8 +878,7 @@ static int nixge_open(struct net_device *ndev)
>  err_rx_irq:
>  	free_irq(priv->tx_irq, ndev);
>  err_tx_irq:
> -	phy_stop(phy);
> -	phy_disconnect(phy);
> +	phylink_disconnect_phy(priv->phylink);
>  	tasklet_kill(&priv->dma_err_tasklet);
>  	netdev_err(ndev, "request_irq() failed\n");
>  	return ret;
> @@ -908,9 +892,9 @@ static int nixge_stop(struct net_device *ndev)
>  	netif_stop_queue(ndev);
>  	napi_disable(&priv->napi);
>  
> -	if (ndev->phydev) {
> -		phy_stop(ndev->phydev);
> -		phy_disconnect(ndev->phydev);
> +	if (priv->phylink) {
> +		phylink_stop(priv->phylink);
> +		phylink_disconnect_phy(priv->phylink);
>  	}
>  
>  	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
> @@ -1076,13 +1060,31 @@ static int nixge_ethtools_set_phys_id(struct net_device *ndev,
>  	return 0;
>  }
>  
> +static int
> +nixge_ethtool_set_link_ksettings(struct net_device *ndev,
> +				 const struct ethtool_link_ksettings *cmd)
> +{
> +	struct nixge_priv *priv = netdev_priv(ndev);
> +
> +	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> +}
> +
> +static int
> +nixge_ethtool_get_link_ksettings(struct net_device *ndev,
> +				 struct ethtool_link_ksettings *cmd)
> +{
> +	struct nixge_priv *priv = netdev_priv(ndev);
> +
> +	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
> +}
> +
>  static const struct ethtool_ops nixge_ethtool_ops = {
>  	.get_drvinfo    = nixge_ethtools_get_drvinfo,
>  	.get_coalesce   = nixge_ethtools_get_coalesce,
>  	.set_coalesce   = nixge_ethtools_set_coalesce,
>  	.set_phys_id    = nixge_ethtools_set_phys_id,
> -	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
> -	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
> +	.get_link_ksettings     = nixge_ethtool_get_link_ksettings,
> +	.set_link_ksettings     = nixge_ethtool_set_link_ksettings,
>  	.get_link		= ethtool_op_get_link,
>  };
>  
> @@ -1225,11 +1227,52 @@ static void *nixge_get_nvmem_address(struct device *dev)
>  	return mac;
>  }
>  
> +static void nixge_validate(struct net_device *ndev, unsigned long *supported,
> +			   struct phylink_link_state *state)
> +{
> +}
> +
> +static int nixge_mac_link_state(struct net_device *ndev,
> +				struct phylink_link_state *state)
> +{
> +	return 0;
> +}
> +
> +static void nixge_mac_config(struct net_device *ndev, unsigned int mode,
> +			     const struct phylink_link_state *state)
> +{
> +}
> +
> +static void nixge_mac_an_restart(struct net_device *ndev)
> +{
> +}
> +
> +static void nixge_mac_link_down(struct net_device *ndev, unsigned int mode,
> +				phy_interface_t interface)
> +{
> +}
> +
> +static void nixge_mac_link_up(struct net_device *ndev, unsigned int mode,
> +			      phy_interface_t interface,
> +			      struct phy_device *phy)
> +{
> +}
> +
> +static const struct phylink_mac_ops nixge_phylink_ops = {
> +	.validate = nixge_validate,
> +	.mac_link_state = nixge_mac_link_state,
> +	.mac_an_restart = nixge_mac_an_restart,
> +	.mac_config = nixge_mac_config,
> +	.mac_link_down = nixge_mac_link_down,
> +	.mac_link_up = nixge_mac_link_up,
> +};
> +
>  static int nixge_probe(struct platform_device *pdev)
>  {
>  	struct nixge_priv *priv;
>  	struct net_device *ndev;
>  	struct resource *dmares;
> +	struct device_node *mn;
>  	const u8 *mac_addr;
>  	int err;
>  
> @@ -1286,7 +1329,13 @@ static int nixge_probe(struct platform_device *pdev)
>  	priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
>  	priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
>  
> -	err = nixge_mdio_setup(priv, pdev->dev.of_node);
> +	mn = of_get_child_by_name(pdev->dev.of_node, "mdio");
> +	if (!mn) {
> +		dev_warn(&pdev->dev, "No \"mdio\" subnode found, defaulting to legacy\n");
> +		mn = pdev->dev.of_node;
> +	}
> +
> +	err = nixge_mdio_setup(priv, mn);
>  	if (err) {
>  		netdev_err(ndev, "error registering mdio bus");
>  		goto free_netdev;
> @@ -1299,10 +1348,10 @@ static int nixge_probe(struct platform_device *pdev)
>  		goto unregister_mdio;
>  	}
>  
> -	priv->phy_node = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> -	if (!priv->phy_node) {
> -		netdev_err(ndev, "not find \"phy-handle\" property\n");
> -		err = -EINVAL;
> +	priv->phylink = phylink_create(ndev, pdev->dev.fwnode, priv->phy_mode,
> +				       &nixge_phylink_ops);
> +	if (IS_ERR(priv->phylink)) {
> +		err = PTR_ERR(priv->phylink);
>  		goto unregister_mdio;
>  	}
>  
> 


-- 
Florian
