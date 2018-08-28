Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543EFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DDB20856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4hYT9xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DDB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeH1Xds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:33:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44460 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Xds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:33:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so1157913plb.11;
        Tue, 28 Aug 2018 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wm6d/jnxDzwRsDfYlYJGy9Pujr4BrIWfWbcNMgF3UKU=;
        b=T4hYT9xVVnH5NDOrKt9mpUe6qmWxHSuBtxmBXDSPRsYWDdrcixtb72wB51Jd1DP4Mg
         5QHm0ldvK8MOZY9z0r/y0agDEDwXMUvLQtVN1r3sT+l9RnaBMwKJa1u5DlaiO1bZV2QO
         FMe8hjKnXyfCr21KJenHUjZGEdXwXRACraxjb2qU8Yqc0nx4W07dcoI4Rcwb7vIxTcJt
         O2bvhyRkRDRhmEqh2FkYRJF1VMjPIKscpnYt8mhWLrXELH5LeSeulcVYBSPCTRETVU6C
         jPNRe3Q8niAtV7swg6/PAhaKzNqt8lp8q/NOdwtRez3jUT/4NACdJ3ksjVtfBUCJ8L4E
         Lq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Wm6d/jnxDzwRsDfYlYJGy9Pujr4BrIWfWbcNMgF3UKU=;
        b=ritdDevEqLCQhJDJBV0WgDrdsiMmAmZ5n/nk0LwIZ/5vbc4OlYYhR7+N/2bbS9E50H
         CmnB3+xssIhRYV2P/DhXW0qE8epqg2YRC6HvWcWV7ZieAATN8rWShGQsZ9LxkB4b0syW
         UwR8YxGcV88yaJYPGpVjOQ7ShxjfugaXvMSRHQFSY9SOOCxD8jYfFfXceCvTlDjhnIpd
         xUpQb1Bxl01MK7cCA5m4A73/mh/28jWIRvo0clkXn8Lp6XTUurf+aL3bKk35uRUv8d/g
         PutI01kHS3Dv3mdBnE0eQLH1IN1+/h7yhj6yKKb6ierpSfB/NNdQhOqMo2Ba2Qb+zVdU
         7PGA==
X-Gm-Message-State: APzg51DJMmX/IxOxM50vBHo+AQkgwoawkBsrfXTiJJSBXyVPGc+Dzyo/
        SzoPEFa7KguMGGA/9BXDmWpHQQwE
X-Google-Smtp-Source: ANB0VdaEzoLzxIw7pbMfeIdQSSGquyTBUfjvSUEx+Bal17mfjXXRpFpKT8sxO4kC41dvlh9p2wfxKg==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr2863606plb.108.1535485239476;
        Tue, 28 Aug 2018 12:40:39 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id b18-v6sm6490016pgk.15.2018.08.28.12.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:40:38 -0700 (PDT)
Subject: Re: [PATCH net] net: bcmgenet: use MAC link status for fixed phy
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535484795-31871-1-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <4a2baac2-ee6c-f7e9-1bd6-674c55c5fb2a@gmail.com>
Date:   Tue, 28 Aug 2018 12:40:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535484795-31871-1-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 12:33 PM, Doug Berger wrote:
> When using the fixed PHY with GENET (e.g. MOCA) the PHY link
> status can be determined from the internal link status captured
> by the MAC. This allows the PHY state machine to use the correct
> link state with the fixed PHY even if MAC link event interrupts
> are missed when the net device is opened.
> 
> Fixes: 8d88c6e ("net: bcmgenet: enable MoCA link state change detection")

The 12-digit sha1 for that commit would be 8d88c6ebb34c

> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Doug!

> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.h |  3 +++
>  drivers/net/ethernet/broadcom/genet/bcmmii.c   | 10 ++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index b773bc0..14b49612a 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -186,6 +186,9 @@ struct bcmgenet_mib_counters {
>  #define UMAC_MAC1			0x010
>  #define UMAC_MAX_FRAME_LEN		0x014
>  
> +#define UMAC_MODE			0x44
> +#define  MODE_LINK_STATUS		(1 << 5)
> +
>  #define UMAC_EEE_CTRL			0x064
>  #define  EN_LPI_RX_PAUSE		(1 << 0)
>  #define  EN_LPI_TX_PFC			(1 << 1)
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index 5333274..4241ae9 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -115,8 +115,14 @@ void bcmgenet_mii_setup(struct net_device *dev)
>  static int bcmgenet_fixed_phy_link_update(struct net_device *dev,
>  					  struct fixed_phy_status *status)
>  {
> -	if (dev && dev->phydev && status)
> -		status->link = dev->phydev->link;
> +	struct bcmgenet_priv *priv;
> +	u32 reg;
> +
> +	if (dev && dev->phydev && status) {
> +		priv = netdev_priv(dev);
> +		reg = bcmgenet_umac_readl(priv, UMAC_MODE);
> +		status->link = !!(reg & MODE_LINK_STATUS);
> +	}
>  
>  	return 0;
>  }
> 


-- 
Florian
