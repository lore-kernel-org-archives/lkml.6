Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FDC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7586C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="Jp1Vp26M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdeO24Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7586C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJLILZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:11:25 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46167 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeJLILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:11:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id C6728C8F;
        Thu, 11 Oct 2018 20:41:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Oct 2018 20:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=z1fgj2d+suX+knPafrN7OTjMsn
        77IfeCCYKPlT6cnxM=; b=Jp1Vp26MuC83jA/zj6x/qqXS7alSHokDj8M+9PxmqK
        e3Y5Hai9irnJ7jki9dOeyCY9Wuz+IVdFbe2KnN6pAAvEBQZknYM0dt3cHnj14yZq
        LUDJBHhCAIWNJgKjnEvdTbrxU5yOeg9xtppE5LcJU8IooGypa6Cd7zY1Z6JVVC39
        Vt3joIaXv7SDYkNuqNtYIFSOSSyOWecNl5L9vmuwar8pXHajEnRZfyfjcgv2L1+F
        JqJzOVmW8yQRrJzidPhQjo+swaz+U+S5/Mayj5o6BFt8NITWONl0oAz3Tq2lai7F
        gbIPgks/9jLIuPzv2edGVP1ye57svu+0iePqzCs/fZnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=z1fgj2d+suX+knPafrN7OTjMsn77IfeCCYKPlT6cn
        xM=; b=GdeO24Hz7WOQDpai6hAl4ZVX084PGP1XUQ09+eh7pPc57BB8wmF8etrkp
        bFW5Vw6zM0XaN7xCiWKzh9G7OaslSB5kbO1gNSnOpm/WNdFgUORJ6nBTCXQ2lfLL
        LJ+0cqR/1qeRiXOaJy3MIEosPqEybtvefn+w+D7Sf5InKJzyxTLVLurqCnd9gjIT
        kXAwWK/MCaJ320a/qJOVfQfRxe69g5SIp20LwUhgnKomReVHStwR+Nc8inm59dk2
        4WbSWYI2wDO+pRPOMpVrZIYNWrp03uPNwkcgNvrd0/nQBYtlRZUHJcuP/EomHEue
        527LfHli25PbwXOMZAlB0z5kD+czQ==
X-ME-Sender: <xms:we2_W6xYYY7qDiwGjJaC-URQ7sraEeW2VLMmwIr3MVAPKFlLtprsWw>
X-ME-Proxy: <xmx:we2_W3Y8wIYGNN5LtHa7kko-59f-aE7w8-bQK3SAg_BNihZQO1mhQg>
    <xmx:we2_WyGZQML2OezeW2Sq3osPa7aOcx14Cxf_HVlglAh1bAAEAVwxmw>
    <xmx:we2_Ww3R8lNpYKpl26_tbCXlcueUqdPUqu5o0qu2LxF28Ht6Ejj4Ag>
    <xmx:we2_WydxHTIMDz0DcU9WhF-1gaZ-weriquk8PKfXOAvmF8sOpte3zw>
    <xmx:we2_WzNfFhNzdjr3a9gZisRFoEWwAUgDKf_wQTc4he9DcGVeJQ73WQ>
    <xmx:wu2_W-v1Jf2-5uJNauPoScURDzzYfCRZPl7ITDV4368N8XukCUVs1g>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 99A7BE4439;
        Thu, 11 Oct 2018 20:41:34 -0400 (EDT)
Message-ID: <0291dc2447720438a25c9c922252ab71e92985dd.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Date:   Fri, 12 Oct 2018 11:41:31 +1100
In-Reply-To: <20181011230518.3204700-1-vijaykhemka@fb.com>
References: <20181011230518.3204700-1-vijaykhemka@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 16:05 -0700, Vijay Khemka wrote:
> This patch adds OEM Broadcom commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
> 
> ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> getting mac address.
> ncsi_rsp_handler_oem_bcm: This handles response received for all
> broadcom OEM commands.
> ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> set it to device.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  net/ncsi/Kconfig       |  6 ++++
>  net/ncsi/internal.h    |  8 +++++
>  net/ncsi/ncsi-manage.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  net/ncsi/ncsi-pkt.h    |  8 +++++
>  net/ncsi/ncsi-rsp.c    | 40 +++++++++++++++++++++++-
>  5 files changed, 131 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ncsi/Kconfig b/net/ncsi/Kconfig
> index 08a8a6031fd7..7f2b46108a24 100644
> --- a/net/ncsi/Kconfig
> +++ b/net/ncsi/Kconfig
> @@ -10,3 +10,9 @@ config NET_NCSI
>  	  support. Enable this only if your system connects to a network
>  	  device via NCSI and the ethernet driver you're using supports
>  	  the protocol explicitly.
> +config NCSI_OEM_CMD_GET_MAC
> +	bool "Get NCSI OEM MAC Address"
> +	depends on NET_NCSI
> +	---help---
> +	  This allows to get MAC address from NCSI firmware and set them back to
> +		controller.
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index 3d0a33b874f5..45883b32790e 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -71,6 +71,13 @@ enum {
>  /* OEM Vendor Manufacture ID */
>  #define NCSI_OEM_MFR_MLX_ID             0x8119
>  #define NCSI_OEM_MFR_BCM_ID             0x113d
> +/* Broadcom specific OEM Command */
> +#define NCSI_OEM_BCM_CMD_GMA            0x01   /* CMD ID for Get MAC */
> +/* OEM Command payload lengths*/
> +#define NCSI_OEM_BCM_CMD_GMA_LEN        12
> +/* Mac address offset in OEM response */
> +#define BCM_MAC_ADDR_OFFSET             28
> +
>  
>  struct ncsi_channel_version {
>  	u32 version;		/* Supported BCD encoded NCSI version */
> @@ -240,6 +247,7 @@ enum {
>  	ncsi_dev_state_probe_dp,
>  	ncsi_dev_state_config_sp	= 0x0301,
>  	ncsi_dev_state_config_cis,
> +	ncsi_dev_state_config_oem_gma,
>  	ncsi_dev_state_config_clear_vids,
>  	ncsi_dev_state_config_svf,
>  	ncsi_dev_state_config_ev,
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 091284760d21..75504ccd1b95 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -635,6 +635,39 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
> +
> +/* NCSI OEM Command APIs */
> +static void ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
> +{
> +	int ret = 0;
> +	unsigned char data[NCSI_OEM_BCM_CMD_GMA_LEN];
> +
> +	nca->payload = NCSI_OEM_BCM_CMD_GMA_LEN;
> +
> +	memset(data, 0, NCSI_OEM_BCM_CMD_GMA_LEN);
> +	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_BCM_ID);
> +	data[5] = NCSI_OEM_BCM_CMD_GMA;
> +
> +	nca->data = data;
> +
> +	ret = ncsi_xmit_cmd(nca);
> +	if (ret)
> +		netdev_err(nca->ndp->ndev.dev,
> +			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
> +			   nca->type);
> +}
> +
> +/* OEM Command handlers initialization */
> +static struct ncsi_oem_gma_handler {
> +	unsigned int	mfr_id;
> +	void		(*handler)(struct ncsi_cmd_arg *nca);
> +} ncsi_oem_gma_handlers[] = {
> +	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm }
> +};
> +
> +#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
> +
>  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  {
>  	struct ncsi_dev *nd = &ndp->ndev;
> @@ -685,6 +718,43 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  			goto error;
>  		}
>  
> +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
> +		nd->state = ncsi_dev_state_config_oem_gma;
> +		break;
> +	case ncsi_dev_state_config_oem_gma:
> +		nca.type = NCSI_PKT_CMD_OEM;
> +		nca.package = np->id;
> +		nca.channel = nc->id;
> +		ndp->pending_req_num = 1;
> +
> +		/* Check for manufacturer id and Find the handler */
> +		struct ncsi_oem_gma_handler *nch = NULL;
> +		int i;
> +

This has the opposite affect, now if we do compile with
CONFIG_NCSI_OEM_CMD_GET_MAC we get:

../net/ncsi/ncsi-manage.c: In function ‘ncsi_configure_channel’:
../net/ncsi/ncsi-manage.c:769:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
   struct ncsi_oem_gma_handler *nch = NULL;
   ^~~~~~

Perhaps we should lay this out slightly differently. For example we could go
through the ncsi_dev_state_config_oem_gma state regardless and call some other
function that finds and calls the handler, or does nothing if the config option
isn't set.

Regards,
Sam

> +		for (i = 0; i < ARRAY_SIZE(ncsi_oem_gma_handlers); i++) {
> +			if (ncsi_oem_gma_handlers[i].mfr_id ==
> +					nc->version.mf_id) {
> +				if (ncsi_oem_gma_handlers[i].handler)
> +					nch = &ncsi_oem_gma_handlers[i];
> +				else
> +					nch = NULL;
> +
> +				break;
> +			}
> +		}
> +
> +		if (!nch) {
> +			netdev_err(ndp->ndev.dev, "No handler available for GMA with MFR-ID (0x%x)\n",
> +				   nc->version.mf_id);
> +			nd->state = ncsi_dev_state_config_clear_vids;
> +			schedule_work(&ndp->work);
> +			break;
> +		}
> +
> +		/* Get Mac address from NCSI device */
> +		nch->handler(&nca);
> +#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
> +
>  		nd->state = ncsi_dev_state_config_clear_vids;
>  		break;
>  	case ncsi_dev_state_config_clear_vids:
> diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
> index 0f2087c8d42a..4d3f06be38bd 100644
> --- a/net/ncsi/ncsi-pkt.h
> +++ b/net/ncsi/ncsi-pkt.h
> @@ -165,6 +165,14 @@ struct ncsi_rsp_oem_pkt {
>  	unsigned char           data[];      /* Payload data      */
>  };
>  
> +/* Broadcom Response Data */
> +struct ncsi_rsp_oem_bcm_pkt {
> +	unsigned char           ver;         /* Payload Version   */
> +	unsigned char           type;        /* OEM Command type  */
> +	__be16                  len;         /* Payload Length    */
> +	unsigned char           data[];      /* Cmd specific Data */
> +};
> +
>  /* Get Link Status */
>  struct ncsi_rsp_gls_pkt {
>  	struct ncsi_rsp_pkt_hdr rsp;        /* Response header   */
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index d66b34749027..31672e967db2 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -596,12 +596,50 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
>  	return 0;
>  }
>  
> +/* Response handler for Broadcom command Get Mac Address */
> +static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
> +{
> +	struct ncsi_rsp_oem_pkt *rsp;
> +	struct ncsi_dev_priv *ndp = nr->ndp;
> +	struct net_device *ndev = ndp->ndev.dev;
> +	int ret = 0;
> +	const struct net_device_ops *ops = ndev->netdev_ops;
> +	struct sockaddr saddr;
> +
> +	/* Get the response header */
> +	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> +
> +	saddr.sa_family = ndev->type;
> +	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
> +	ret = ops->ndo_set_mac_address(ndev, &saddr);
> +	if (ret < 0)
> +		netdev_warn(ndev, "NCSI: Writing mac address to device failed\n");
> +
> +	return ret;
> +}
> +
> +/* Response handler for Broadcom card */
> +static int ncsi_rsp_handler_oem_bcm(struct ncsi_request *nr)
> +{
> +	struct ncsi_rsp_oem_pkt *rsp;
> +	struct ncsi_rsp_oem_bcm_pkt *bcm;
> +
> +	/* Get the response header */
> +	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> +	bcm = (struct ncsi_rsp_oem_bcm_pkt *)(rsp->data);
> +
> +	if (bcm->type == NCSI_OEM_BCM_CMD_GMA)
> +		return ncsi_rsp_handler_oem_bcm_gma(nr);
> +	return 0;
> +}
> +
>  static struct ncsi_rsp_oem_handler {
>  	unsigned int	mfr_id;
>  	int		(*handler)(struct ncsi_request *nr);
>  } ncsi_rsp_oem_handlers[] = {
>  	{ NCSI_OEM_MFR_MLX_ID, NULL },
> -	{ NCSI_OEM_MFR_BCM_ID, NULL }
> +	{ NCSI_OEM_MFR_BCM_ID, ncsi_rsp_handler_oem_bcm }
>  };
>  
>  /* Response handler for OEM command */


