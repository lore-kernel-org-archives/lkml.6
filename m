Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6DBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1FA20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuwAMB9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfAHShp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:37:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfAHSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:37:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so5061125wrt.11;
        Tue, 08 Jan 2019 10:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=r2oD1oZzoflkPdR2oIRWq1Duqfs2FKeqTyHvwkZ6Jt4=;
        b=GuwAMB9Q+kLSEebvNqoILD3fEUHGTB9fZ3MNKru/fJm7GtH/Zk2qcHkzK+j2nxv6gK
         U++B/1Q3lhfxwOX8hyMNGrc+Nc6gUJDF4UR9uF1Ut0TRsZq9tK8/bzqOHVCNVa35Ir7Z
         B6hLECFaxJUtDKGizIeKj5bqoscqINzUOSB8DJ7AysCkuzFALNOfEQsX5Zk740WegHVP
         JF80Wg4cOTBkm+DmJJi/uFl2OzhIGnJJ0k8M0+XMtgkrXhphLYDZ6rGV61bpRtAKTvuD
         t5ahgWy2ie8rAaOWyn9sRqy93OpHPcUFlF838c3P57cN4x+sg+jNXI1Sq0QR4GQQPvkX
         38jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2oD1oZzoflkPdR2oIRWq1Duqfs2FKeqTyHvwkZ6Jt4=;
        b=Q6eGQdJ93kJ/UF0w6nV2ZN6km7DR/w8hMq+T2vpu8pSxuUkpekLM/OBotiB22jNOIP
         HP0fiq9u7cCTAmqmrtoDzrkprlYCQ55wIiewrVbXixerd7OBQrYQ+lJ9d25z2UUyH7R7
         /uZDSlVdQog887qat2kyZojUK9+5yyUw4ZL2XpepTvawaIK/U5yCK5wgufDY/5nO7qp8
         97GsnJj2IjoIjI4Ef2eeUK9VyLQwIe6PGDyyVVI94cYCj9fM7/joqro65d7m5IRJI55C
         1cM31NXaUdqbILkwpUOGJPN3Q8ovSSlWsi+dOQXmA+ZlwRzIbwOSA6ORkNqSOmRaLOQi
         /YXg==
X-Gm-Message-State: AJcUukd3L2FAb0gUGbDHzBU9uxziUDmI+w3Y9pb+DRKvhqknVqc5i9pg
        VpgzFm6ylah9QmtGKJ9KopqDAIJ4
X-Google-Smtp-Source: ALg8bN6ezASsIpEhk+WyHQVswFc1PcG+GOzbsI5WT5Vbl4AJ28Pi0n3QN/t0Wlur8O1+s/hEGcrrqw==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr2338469wrm.115.1546972661539;
        Tue, 08 Jan 2019 10:37:41 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:50e8:fa09:6b66:e3da? (p200300EA8BE2E40050E8FA096B66E3DA.dip0.t-ipconnect.de. [2003:ea:8be2:e400:50e8:fa09:6b66:e3da])
        by smtp.googlemail.com with ESMTPSA id p10sm731378wrt.25.2019.01.08.10.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:37:40 -0800 (PST)
Subject: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
To:     Frank Wunderlich <frank-w@public-files.de>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@kernel.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190108160526.18928-1-frank-w@public-files.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
Date:   Tue, 8 Jan 2019 19:37:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108160526.18928-1-frank-w@public-files.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.01.2019 17:05, Frank Wunderlich wrote:
> From: Sean Wang <sean.wang@kernel.org>
> 
> linux 5.0-rc1 shows following warning on bpi-r2/mt7623 bootup:
> 
> [ 5.170597] WARNING: CPU: 3 PID: 1 at drivers/net/phy/phy.c:548 phy_start_aneg+0x110/0x144
> [ 5.178826] called from state READY
> ....
> [ 5.264111] [<c0629fd4>] (phy_start_aneg) from [<c0e3e720>] (mtk_init+0x414/0x47c)
> [ 5.271630] r7:df5f5eec r6:c0f08c48 r5:00000000 r4:dea67800
> [ 5.277256] [<c0e3e30c>] (mtk_init) from [<c07dabbc>] (register_netdevice+0x98/0x51c)
> [ 5.285035] r8:00000000 r7:00000000 r6:c0f97080 r5:c0f08c48 r4:dea67800
> [ 5.291693] [<c07dab24>] (register_netdevice) from [<c07db06c>] (register_netdev+0x2c/0x44)
> [ 5.299989] r8:00000000 r7:dea2e608 r6:deacea00 r5:dea2e604 r4:dea67800
> [ 5.306646] [<c07db040>] (register_netdev) from [<c06326d8>] (mtk_probe+0x668/0x7ac)
> [ 5.314336] r5:dea2e604 r4:dea2e040
> [ 5.317890] [<c0632070>] (mtk_probe) from [<c05a78fc>] (platform_drv_probe+0x58/0xa8)
> [ 5.325670] r10:c0f86bac r9:00000000 r8:c0fbe578 r7:00000000 r6:c0f86bac r5:00000000
> [ 5.333445] r4:deacea10
> [ 5.335963] [<c05a78a4>] (platform_drv_probe) from [<c05a5248>] (really_probe+0x2d8/0x424)
> 
> maybe other boards using this generic driver are affected
> 
Good that we added this warning to phylib, it seems usage of the phylib
API in this driver can be improved.

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 399f565dd85a..e48c06874a85 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -356,6 +356,7 @@ static int mtk_phy_connect(struct net_device *dev)
>  	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>  			 dev->phydev->advertising);
> +	phy_start(dev->phydev);
>  	phy_start_aneg(dev->phydev);
>  

In mtk_phy_connect() I would say this complete block can be removed.
All this is handled internally by phylib.

	dev->phydev->autoneg = AUTONEG_ENABLE;
	dev->phydev->speed = 0;
	dev->phydev->duplex = 0;

	phy_set_max_speed(dev->phydev, SPEED_1000);
	phy_support_asym_pause(dev->phydev);
	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
			 dev->phydev->advertising);
	phy_start_aneg(dev->phydev);

Could you please test this?

- phy_set_max_speed() is only needed if you want to reduce the
  max speed, typically if the PHY supports 1Gbps but the MAC
  supports 100Mbps only.

- The pause parameters are autonegotiated. Except you have a specific
  need you normally don't need to manually fiddle with this.

- phy_start_aneg() is called implicitly by the phylib state machine,
  you shouldn't call it manually except you have a good excuse.

And a further proposal:
Instead of the open-coded dev_info() in mtk_phy_connect_node()
you could use phy_attached_info().

>  	of_node_put(np);
> @@ -1821,7 +1822,6 @@ static int mtk_open(struct net_device *dev)
>  	else
>  		refcount_inc(&eth->dma_refcnt);
>  
> -	phy_start(dev->phydev);
>  	netif_start_queue(dev);
>  
>  	return 0;
> 

Calling phy_start() in the ndo_open callback is fine, you can leave
it there.
