Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D4FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576932089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubmWw/Cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576932089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeJAXOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:14:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43580 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAXOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:14:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id a4-v6so961648eds.10;
        Mon, 01 Oct 2018 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Aj8shganbvjDsN9UJ/Pvy0xgWfxpZesL1v8N/0NCPY=;
        b=ubmWw/CrbHYOdrdoBJ2QrweZxPB1sylchXosUsFNsEeMHA/o5PgJVDun45KXFdLoDi
         0RF6eZuGIUTbLG4pMVm+zy5ZSLYGU50dhY3Gq2hG1FEFOMn2JfctChZguVeS5B+vc3Sm
         mJYDIEZ+GlHCNAggvMOBElN6wWLMB2bpdh7rGuDZk8YBV0HV2a3B8PxZFRrWiaEQekkm
         kO3BPG8QteSN9y72p8R3annwOSDDdHB/rcZFgL2M/OFNhICJ1MWPHLDiLsl9yx2mDRwT
         N05S5+C5/iuXBqOdB8JzS22eJBw8NQ0TCpBOLQh5s2tnFqTKeoY1I+jIZymcBIuPtyPx
         aeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4Aj8shganbvjDsN9UJ/Pvy0xgWfxpZesL1v8N/0NCPY=;
        b=Ryyp7QtsQsVCX4cYLjH9/gLEyvZfrw2EnXZCYF3tGwio5QKG8vo3aIe+bigIIiM2Rr
         aAiG/p3YKXxtCO3FnE7ctFdzEudvcZsxTbt8af+Eh1lWZMnFJTMSW+UjFoYgRAh9aLLw
         +iNGcsdqfeK59XYIZZ/oYTgJVEdiDkBjjkIMGT5fbMqZIDS60hF8w6J38IrFMZAPLYni
         9Kfx2PIWUQv6RP3F1EqmnxYmQkxAngmfHLOYS3Dk9GWclq/0A2xjxoAEOOKTGmLN8ZNP
         QE2k6naaX7NYey8/2+J/5EzTOtuk/Znq4SA+llZIw8wqyEa9aOBeWcLYdD4i8oTf41/B
         +W6w==
X-Gm-Message-State: ABuFfoj36FGac59IvoQpoo2c7Gabr955VNq/KddQcGMZO9koLBnCOkHd
        CwQid9b0r7LIuS2W5bu/laG9s0d/
X-Google-Smtp-Source: ACcGV63xvuYdpJznHTRqniRZPLm+n4SKB4CtxZX1LHJHohuvf3+1IxNNLCUTzFhlwtfoY+YQjnh9bw==
X-Received: by 2002:a17:906:3105:: with SMTP id 5-v6mr15164075ejx.227.1538411756678;
        Mon, 01 Oct 2018 09:35:56 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id n41-v6sm2255697edd.7.2018.10.01.09.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:35:55 -0700 (PDT)
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
To:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
References: <20181001095714.26024-1-antoine.tenart@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <25a88126-2397-a1fb-0c0d-06504bb348ca@gmail.com>
Date:   Mon, 1 Oct 2018 09:35:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001095714.26024-1-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 02:57 AM, Antoine Tenart wrote:
> This patch adds support for the NETIF_F_RXFCS feature in the Mscc
> Ethernet driver. This feature is disabled by default and allow an user
> to request the driver not to drop the FCS and to extract it into the skb
> for debugging purposes.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/mscc/ocelot.c       | 2 +-
>  drivers/net/ethernet/mscc/ocelot_board.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 1a4f2bb48ead..eb5119e7e60b 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -1606,7 +1606,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
>  	dev->ethtool_ops = &ocelot_ethtool_ops;
>  	dev->switchdev_ops = &ocelot_port_switchdev_ops;
>  
> -	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
>  	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  
>  	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> index 3cdf63e35b53..245452a0f244 100644
> --- a/drivers/net/ethernet/mscc/ocelot_board.c
> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> @@ -126,11 +126,16 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
>  			len += sz;
>  		} while (len < buf_len);
>  
> -		/* Read the FCS and discard it */
> +		/* Read the FCS */
>  		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
>  		/* Update the statistics if part of the FCS was read before */
>  		len -= ETH_FCS_LEN - sz;
>  
Don't this needs to be len -= sz;


> +		if (unlikely(dev->features & NETIF_F_RXFCS)) {
> +			buf = (u32 *)skb_put(skb, ETH_FCS_LEN);
> +			*buf = val;

and here len -= ETH_FCS_LEN

since "len" is later used for accounting how many bytes have been
received by the network device?

I am bit confused by the use of "buf", but presumably if NETIF_F_RXCFS
is turned on, the FCS needs to be part of the buffer passed to the
network stack, so adjusting len accordingly is required anyway.
-- 
Florian
