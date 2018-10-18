Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48284205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlFouIGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48284205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeJSClw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:41:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33391 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSClw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:41:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id m184-v6so1175137ybm.0;
        Thu, 18 Oct 2018 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/EFqlMuxuVGDn+3zaXiqtoxpQ6bDWMVzieFxenfjI4=;
        b=PlFouIGjFTScT6ytfUt0N08IsxymqRoArNfsGw6zgy6tOJBxEOK7ID3isz89woieEr
         kCahQZTdFz80OisOPyyeexMXsThlecY8K39pdGHbNc6hVqDwVU91ILeUggvc4lxQtgi0
         BJRRH0YzqsuaaBkxpG9IlaCNcM2DTaMSLSCwcokRiIbB0rpfRINpg01NE2j7LiuXgyJ/
         HT2ThX0ueCht9orXDfetKR9P7ivoKuSn1SQ4Zar5lSmGZH4ec1xF3O50m7xpTvsOKYig
         W1DxyTPLPzsvTByaZZ4Cncd3ov3uVLGipvlYhEZLf60QXACIL8YcaUD/5C0Z53Ymly5h
         57+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u/EFqlMuxuVGDn+3zaXiqtoxpQ6bDWMVzieFxenfjI4=;
        b=PwGJufYfShqIjPWjyXNAoUcv4Hu7fe+AmKTcyJkSB//Jmby5cR3nD9kszXKWQeaqNf
         v5wPyf5VtyyW2icq5kYrrd7F1U1TI/us9UkYwMcPXeJCm7QI2sjDm306fhDjhJz3HoO1
         vcS0ypv+lDRH8QftxdLwKoO4/rjXhhmUriu/yka8fxmoEQBj0SRo4or6nySs07eWWhuL
         x4MzZ9g6DBZYQbEu6Kk7AuCKFliTY25dW1PVQ+iZHOR+VRbnHD9dX5OxWgoQrNsCDmVY
         GVN6aMBW6FBzAWPlQs3D1+xnKRMpGlOHQe7jrdZdhEYeF3IR+ClSL/exdSQCEnm4jpen
         qhIA==
X-Gm-Message-State: ABuFfogZjO1I5fd0hSMh5g4pjKQeJh1rt3IDfRtK0qjOlO4QZyvBUw9t
        2UXKxr64YSrNPGMCuq87oqasnyWK
X-Google-Smtp-Source: ACcGV61X1L/5iCtqlx5ck6SEGxuaZO52kB5SCMiMyMVp3Iy3DN/fJWXKGPKFrV5uhbaiIEZrEYcntQ==
X-Received: by 2002:a25:2d19:: with SMTP id t25-v6mr6291866ybt.73.1539887973428;
        Thu, 18 Oct 2018 11:39:33 -0700 (PDT)
Received: from [10.67.48.209] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id l30-v6sm11865418ywa.104.2018.10.18.11.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:39:32 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
To:     Corentin Labbe <clabbe@baylibre.com>, andrew@lunn.ch,
        davem@davemloft.net, fugang.duan@nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
Date:   Thu, 18 Oct 2018 11:39:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 08:05 AM, Corentin Labbe wrote:
> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
> This is due to missing SPEED_.

But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
surely this would amount to the same code paths being taken or am I
missing something here?

> 
> Fixes: 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index a17cc97..75fd7c9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1946,7 +1946,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
>  
>  	/* mask with MAC supported features */
>  	if (fep->quirks & FEC_QUIRK_HAS_GBIT) {
> -		phy_set_max_speed(phy_dev, 1000);
> +		phy_set_max_speed(phy_dev, SPEED_1000);
>  		phy_remove_link_mode(phy_dev,
>  				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
>  #if !defined(CONFIG_M5272)
> @@ -1954,7 +1954,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
>  #endif
>  	}
>  	else
> -		phy_set_max_speed(phy_dev, 100);
> +		phy_set_max_speed(phy_dev, SPEED_100);
>  
>  	fep->link = 0;
>  	fep->full_duplex = 0;
> 


-- 
Florian
