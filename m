Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FCC6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003DA2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="A0+sB9i5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOsLZtRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003DA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJHIGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:06:45 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59037 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbeJHIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:06:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 4ECD5D54;
        Sun,  7 Oct 2018 20:57:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 07 Oct 2018 20:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=jp51mYmsfdY9Bt+IJdNDS5qfDr
        /IlFOQTnPbtdGmhNg=; b=A0+sB9i58PBIaJep1liMX+v4yllzQYi/EZG6T2mnXz
        7i2ilfu22sAX5sb/0Eu5DuPnjcY13C16GV8IqOu2jJTLzavQs/Q/7VF91A00avN+
        /4ztU/TYYHsfJbqasT2mrp9SQe5fM7ROpDb4dXl2+F3glf7cBzbZ2bnHZkFSDQT4
        D9eUvNqE7VSL2JhnKBdQm1qL5F1d+RuKhY8rxYFpayR/irzjkrvHt5GT5r9eeySh
        wquNOI883XqdQdEJfwwPsxdTK+V5y93zfPj0E9x2ahro9UYwLBujp5HtTDlH+1aE
        r1jSeAkTetrd6XhoYUOQqc3QSMQlkCejFXVbW3CMWEQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=jp51mYmsfdY9Bt+IJdNDS5qfDr/IlFOQTnPbtdGmh
        Ng=; b=fOsLZtRNNphWemYvEPvg1Bv08r6nZdZY8sYGbAaoNxqOEPgDHEe9X25HK
        YIqnU60ti4I7JVHZBLFriTTV/Gsq84oc/7VwzNXbJTHq8LtaGRMO5fYKGdztGsKm
        AylQf9B28OqaRWbtvtUDrOViB5Hd9sSWUJOqQj7vRRCCt9ws+eh7S/wTXqqwPDbf
        X3CR3guwgF39mn5IxizOudJFjBak2CJginkdW1iZIG3Rh69FGLWRMCVznZuGlJH7
        nX2Bs5hVh48mNC+aauuU9/GP0zSk5LvFCA985qjPtvy1riNVQgQSsJOOZ+KOEXQO
        yu/p/02TWJrarH7LdcjEH8iwGiU+Q==
X-ME-Sender: <xms:fKu6WzHOobuHzQ69t5XNGCjsxOPrkV36sDQSeT0Mew7Z74UGbfd_TA>
X-ME-Proxy: <xmx:fKu6W2uxCQ9kCwua-fEoilxfHWDgV4C8iM6rhQ98m1_r2IFJS5uamw>
    <xmx:fKu6W3QrTYRqk-XcbKKauC-fiHv2AcL3Om0NCtEMQmt2JF8bTxqC9A>
    <xmx:fKu6W5HmsotvNLurPbugpiQ9lMhfUMppAawo1V6k6k48MpaRzp1sbA>
    <xmx:fKu6W0dViX84ZH_W7EzRBH5HN8i9QNKrrFgy3uX4MEtS34Pf4QMD9w>
    <xmx:fKu6WxrLvKkenPP-IebPWLyt71vtHXmmxvyCDFVv_MqCvJa7K92D4w>
    <xmx:fau6W8_aCo5JUT25JGtIaW0J3CVYqquR-jE6aIKTsYj1nhpgRY2VGg>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05F15E47E1;
        Sun,  7 Oct 2018 20:57:28 -0400 (EDT)
Message-ID: <ee398ff59257b33e64ba7b641bf29096972a5006.camel@mendozajonas.com>
Subject: Re: [PATCH net-next 1/2] net/ncsi: Add NCSI Broadcom OEM command
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "Justin . Lee1 @ Dell . com" <Justin.Lee1@Dell.com>,
        "joel @ jms . id . au" <joel@jms.id.au>,
        "linux-aspeed @ lists . ozlabs . org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "christian @ cmd . nu" <christian@cmd.nu>
Date:   Mon, 08 Oct 2018 11:57:24 +1100
In-Reply-To: <20181005190126.983734-1-vijaykhemka@fb.com>
References: <20181005190126.983734-1-vijaykhemka@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-05 at 12:01 -0700, Vijay Khemka wrote:
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

Hi Vijay,

Looks good, and I've tested this on a BMC with a Broadcom network
controller and it properly sets a MAC address. A question below about the
response handler:

> ---
>  net/ncsi/Kconfig       |  6 ++++
>  net/ncsi/internal.h    |  8 +++++
>  net/ncsi/ncsi-manage.c | 70 +++++++++++++++++++++++++++++++++++++++++-
>  net/ncsi/ncsi-pkt.h    |  8 +++++
>  net/ncsi/ncsi-rsp.c    | 42 ++++++++++++++++++++++++-
>  5 files changed, 132 insertions(+), 2 deletions(-)
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
> index 091284760d21..e5bfd9245b5d 100644
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
> @@ -643,9 +676,10 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  	struct ncsi_channel *nc = ndp->active_channel;
>  	struct ncsi_channel *hot_nc = NULL;
>  	struct ncsi_cmd_arg nca;
> +	struct ncsi_oem_gma_handler *nch = NULL;
>  	unsigned char index;
>  	unsigned long flags;
> -	int ret;
> +	int ret, i;
>  
>  	nca.ndp = ndp;
>  	nca.req_flags = NCSI_REQ_FLAG_EVENT_DRIVEN;
> @@ -685,6 +719,40 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
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
> index d66b34749027..bc20f7036579 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -596,12 +596,52 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
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
> +	/* Increase mac address by 1 for BMC's address */
> +	saddr.sa_data[ETH_ALEN - 1]++;

Is this convention documented somewhere, and could you provide a link to
it if so?

Also what happens here if the final byte of the address is 0xff, this
will overflow and not carry right?

> +	ret = ops->ndo_set_mac_address(ndev, &saddr);
> +	if (ret < 0)
> +		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");

Also a minor nitpick, there's a bonus "'" in this message.

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


