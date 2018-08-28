Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EEBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEEE20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyuRYx3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEEE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeH1KYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:24:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38531 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1KYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:24:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so670223wmi.3;
        Mon, 27 Aug 2018 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U9919BREIvoIqs8DzW3rklUW2cQNy1dqy3JBmeEstPI=;
        b=GyuRYx3ETiTZMaq05bf6Vdfy5TwGjb/5QpnyHcmmH3GFpW18PPdMcjlw8angNcj5lL
         IG4c7d0UemGIVsbi9DIr9otggzO2y7tjUHRpqFvWMHtX6S/MbDn/u5xJui9bEm4fDp/I
         Mc+D4iXWLYjImEs7GL6SqE3pKgWsInqjSV+4wljFcuhQMisHgmgFXrinFlhGJFoe2V2T
         hD+PW6STwbqbCNAEYnH7qbtDgLtEHs+16H1h2MxzUaILnh4c10BGQgim+vJ6QZKJPmyS
         uVT/5Ypl8hV4KCJRKGDS5IQWp2MZlHawSis4jvdmonblTilzRTT/dFHrSpQVLgINjDGa
         UjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U9919BREIvoIqs8DzW3rklUW2cQNy1dqy3JBmeEstPI=;
        b=tCSR9x3BgE6eNHjz27boZ9c3ZE5Qh0lc1+m2HAE6xjZouxUeNdY393qNhqza5AGnJJ
         bo0PYkCCNkWAF8T6qq5kk25SOCVtqcy5kcLiiPh9EEo6QQCk65hB9cbm3o0TCoB1QvbX
         IKsTRoTgVbs1xGrnBOO2E8XQyLJFtjVyX0QmoirvzRWZzxHAWUfI8KEmAnktPiLJNx8P
         lcw1yo/MV5Ysd7AK5Ya8SGmH1P360hRkBkiIwD0LH35PDjMzQ4tzxPxyaN0xU2+hzHfe
         weHGakJxoAz2Fr3EC2u1vt4JuqyRNHT2xNuloHVLST0BjwC3dIAOpumuBWHgzjYi6cIx
         GZpw==
X-Gm-Message-State: APzg51DXiLkkB/NKyWs9o21155XObaT7H9aTteALIQNDPO7dTN4b3/BV
        UnARFHa4bZOZGEn5IW9L7BDiCSyA
X-Google-Smtp-Source: ANB0VdZGyiCQQcwIU7sPA6BX8n5fM0Cj+18Jkinlq6WZR8hUBf0O8GW1xuutPawXQhBiubsaGQsUBg==
X-Received: by 2002:a1c:bb0a:: with SMTP id l10-v6mr365368wmf.32.1535438065381;
        Mon, 27 Aug 2018 23:34:25 -0700 (PDT)
Received: from [192.168.19.74] (host31-52-53-68.range31-52.btcentralplus.com. [31.52.53.68])
        by smtp.googlemail.com with ESMTPSA id 124-v6sm915322wmk.20.2018.08.27.23.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 23:34:24 -0700 (PDT)
Subject: Re: [PATCH] staging: Convert to using %pOFn instead of
 device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-44-robh@kernel.org>
From:   Ian Arkver <ian.arkver.dev@gmail.com>
Message-ID: <a7c26cd7-2c56-7ec3-6c90-76998fcb4998@gmail.com>
Date:   Tue, 28 Aug 2018 07:34:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-44-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/2018 02:52, Rob Herring wrote:
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
>   drivers/staging/media/imx/imx-media-dev.c | 11 ++++++-----
>   drivers/staging/media/imx/imx-media-of.c  |  4 ++--
>   drivers/staging/mt7621-eth/mdio.c         |  4 ++--
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> index b0be80f05767..818846f8c291 100644
> --- a/drivers/staging/media/imx/imx-media-dev.c
> +++ b/drivers/staging/media/imx/imx-media-dev.c
> @@ -89,8 +89,8 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
>   
>   	/* return -EEXIST if this asd already added */
>   	if (find_async_subdev(imxmd, fwnode, devname)) {
> -		dev_dbg(imxmd->md.dev, "%s: already added %s\n",
> -			__func__, np ? np->name : devname);
> +		dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
> +			__func__, np ? np : devname);

This won't work for the np==NULL case I think since devname is just a 
string.

Regards,
Ian
>   		ret = -EEXIST;
>   		goto out;
>   	}
> @@ -105,19 +105,20 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
>   	if (fwnode) {
>   		asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
>   		asd->match.fwnode = fwnode;
> +		dev_dbg(imxmd->md.dev, "%s: added %pOFn, match type FWNODE\n",
> +			__func__, np);
>   	} else {
>   		asd->match_type = V4L2_ASYNC_MATCH_DEVNAME;
>   		asd->match.device_name = devname;
>   		imxasd->pdev = pdev;
> +		dev_dbg(imxmd->md.dev, "%s: added %s, match type DEVNAME\n",
> +			__func__, devname);
>   	}
>   
>   	list_add_tail(&imxasd->list, &imxmd->asd_list);
>   
>   	imxmd->subdev_notifier.num_subdevs++;
>   
> -	dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
> -		__func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
> -
>   out:
>   	mutex_unlock(&imxmd->mutex);
>   	return ret;
> diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
> index acde372c6795..cb74df356576 100644
> --- a/drivers/staging/media/imx/imx-media-of.c
> +++ b/drivers/staging/media/imx/imx-media-of.c
> @@ -79,8 +79,8 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
>   	int i, num_ports, ret;
>   
>   	if (!of_device_is_available(sd_np)) {
> -		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
> -			sd_np->name);
> +		dev_dbg(imxmd->md.dev, "%pOFn: %s not enabled\n", __func__,
> +			sd_np);
>   		/* unavailable is not an error */
>   		return 0;
>   	}
> diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
> index 7ad0c4141205..9ffa8f771235 100644
> --- a/drivers/staging/mt7621-eth/mdio.c
> +++ b/drivers/staging/mt7621-eth/mdio.c
> @@ -70,7 +70,7 @@ int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,
>   	_port = of_get_property(phy_node, "reg", NULL);
>   
>   	if (!_port || (be32_to_cpu(*_port) >= 0x20)) {
> -		pr_err("%s: invalid port id\n", phy_node->name);
> +		pr_err("%pOFn: invalid port id\n", phy_node);
>   		return -EINVAL;
>   	}
>   	port = be32_to_cpu(*_port);
> @@ -249,7 +249,7 @@ int mtk_mdio_init(struct mtk_eth *eth)
>   	eth->mii_bus->priv = eth;
>   	eth->mii_bus->parent = eth->dev;
>   
> -	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%s", mii_np->name);
> +	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
>   	err = of_mdiobus_register(eth->mii_bus, mii_np);
>   	if (err)
>   		goto err_free_bus;
> 
