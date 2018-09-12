Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB9C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700B520892
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tiGtsVTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700B520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeILUWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:22:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeILUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Als5C0Vm4BIHbX4V4aMVnmCnsKAj8SwhrTQZQVORpMs=; b=tiGtsVTwMd7uchTjqnbQuQAh/
        OEunGt/OG0ACGxwC++bnAA9+KNghwBoK9PSGDOxrEOuqd2pWxFL2ZkdNptqV8dEZhNyCbQTTwfE8O
        bIa5ituljmWoXef4EUgk0QTaWW/ef28MpbQnl84YnfIsGp8qpLRNkAGlX5Fh+/u63OxNQmUFQFRPC
        FojIo8GrWW5C6PckwNLr7tVD3Mop6TcS+Tr5ZyvlPPw3WAHTqLCEjP3iK9tuYuT+5ub1xS62E/asp
        uBkx+8xkrDFC2NTl+4gqYboLakSUvRcJLkM2mxz7Dz9oWxR/SDIrZXGzbMDdje3kGioKdJ8tOHMf9
        dCvXtol2g==;
Received: from [177.97.26.110] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g06tC-0006r5-5v; Wed, 12 Sep 2018 15:17:11 +0000
Date:   Wed, 12 Sep 2018 12:17:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2] staging: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180912121705.010a999d@coco.lan>
In-Reply-To: <20180828154433.5693-7-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
        <20180828154433.5693-7-robh@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Aug 2018 10:44:33 -0500
Rob Herring <robh@kernel.org> escreveu:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Steve Longerbeam <slongerbeam@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-media@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - fix conditional use of node name vs devname for imx
> 
>  drivers/staging/media/imx/imx-media-dev.c | 15 ++++++++++-----
>  drivers/staging/media/imx/imx-media-of.c  |  4 ++--
>  drivers/staging/mt7621-eth/mdio.c         |  4 ++--

It would be better if you had submitted the staging/media stuff
on a separate patch, as they usually go via the media tree.

As I don't foresee any conflicts on that part of the code,
I'm Ok if Greg pick it and submit via his tree.

So,

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

If you prefer instead that I would pick the media part, please
split it into two patches.

Regards,
Mauro

>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> index b0be80f05767..3f48f5ceb6ea 100644
> --- a/drivers/staging/media/imx/imx-media-dev.c
> +++ b/drivers/staging/media/imx/imx-media-dev.c
> @@ -89,8 +89,12 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
> 
>  	/* return -EEXIST if this asd already added */
>  	if (find_async_subdev(imxmd, fwnode, devname)) {
> -		dev_dbg(imxmd->md.dev, "%s: already added %s\n",
> -			__func__, np ? np->name : devname);
> +		if (np)
> +			dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
> +			__func__, np);
> +		else
> +			dev_dbg(imxmd->md.dev, "%s: already added %s\n",
> +			__func__, devname);
>  		ret = -EEXIST;
>  		goto out;
>  	}
> @@ -105,19 +109,20 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
>  	if (fwnode) {
>  		asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
>  		asd->match.fwnode = fwnode;
> +		dev_dbg(imxmd->md.dev, "%s: added %pOFn, match type FWNODE\n",
> +			__func__, np);
>  	} else {
>  		asd->match_type = V4L2_ASYNC_MATCH_DEVNAME;
>  		asd->match.device_name = devname;
>  		imxasd->pdev = pdev;
> +		dev_dbg(imxmd->md.dev, "%s: added %s, match type DEVNAME\n",
> +			__func__, devname);
>  	}
> 
>  	list_add_tail(&imxasd->list, &imxmd->asd_list);
> 
>  	imxmd->subdev_notifier.num_subdevs++;
> 
> -	dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
> -		__func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
> -
>  out:
>  	mutex_unlock(&imxmd->mutex);
>  	return ret;
> diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
> index acde372c6795..163437e421c5 100644
> --- a/drivers/staging/media/imx/imx-media-of.c
> +++ b/drivers/staging/media/imx/imx-media-of.c
> @@ -79,8 +79,8 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
>  	int i, num_ports, ret;
> 
>  	if (!of_device_is_available(sd_np)) {
> -		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
> -			sd_np->name);
> +		dev_dbg(imxmd->md.dev, "%s: %pOFn not enabled\n", __func__,
> +			sd_np);
>  		/* unavailable is not an error */
>  		return 0;
>  	}
> diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
> index 7ad0c4141205..9ffa8f771235 100644
> --- a/drivers/staging/mt7621-eth/mdio.c
> +++ b/drivers/staging/mt7621-eth/mdio.c
> @@ -70,7 +70,7 @@ int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,
>  	_port = of_get_property(phy_node, "reg", NULL);
> 
>  	if (!_port || (be32_to_cpu(*_port) >= 0x20)) {
> -		pr_err("%s: invalid port id\n", phy_node->name);
> +		pr_err("%pOFn: invalid port id\n", phy_node);
>  		return -EINVAL;
>  	}
>  	port = be32_to_cpu(*_port);
> @@ -249,7 +249,7 @@ int mtk_mdio_init(struct mtk_eth *eth)
>  	eth->mii_bus->priv = eth;
>  	eth->mii_bus->parent = eth->dev;
> 
> -	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%s", mii_np->name);
> +	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
>  	err = of_mdiobus_register(eth->mii_bus, mii_np);
>  	if (err)
>  		goto err_free_bus;
> --
> 2.17.1



Thanks,
Mauro
