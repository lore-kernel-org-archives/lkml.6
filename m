Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D580C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35342229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgWZX0o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfBNEIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:08:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41767 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBNEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:08:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so8279124otk.8;
        Wed, 13 Feb 2019 20:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FHjYxu7Jk8F/P7ztEa+3T83GGUonTnlldCSU+p8OU6I=;
        b=bgWZX0o7u1LOgFcJOz+Z1LaT+sF9pIXqK8eEOiJ9+mnzhFZDVeUeyCvhLf3qZOHIma
         kAtq7vkR8HiNuWyMAdT0vFVCk/4acrJDUVHtMZ2K+2saqG8Snp1mYu+6liCZRKr2ua6n
         tMClpeYXObMbshj12v5a1iw/kxso24Rbtblq+A8U9/s10NRXEfBaq8t8nvUEyVpnICEA
         KPE5sCdH4HE2KBDf/r6ZfW4AdBrW7MY3B178BaAptOp2ICNA13UY+WBdyVP81KfNDd/V
         5hHx/SJ76D364kYzbRrdTV8dcVAhc63PEjORuVfvVro2Bz42PCVODE9PUkcxln0YCMma
         RCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FHjYxu7Jk8F/P7ztEa+3T83GGUonTnlldCSU+p8OU6I=;
        b=PFVLyb0L5K7LSD6x4p8YI0MqmgRfzT2+b8EgapLo/zbjOc0NnT98aEHAAcbuzXhlBc
         dZIYRFPAevXZa4B/GjmvGsRdNgLll16kDvGvRSivqH3+CuFa8HWvJPJQnmiM4znOUbUx
         wQ0MaQsxALxI7CFIcB3rgA80kALVAyijzjyRvGw1C15U4NT1yXtxOduxMG0TDq+2PrZp
         pp5zJUUrRuMr7UsSerz0kAV28OsnhnEu7fWLOEZ6HdG+J6mdwjK68nxIYCYxUBdSczRc
         E+KfGLFTTkybzdiWy4fGGMpmhZUv7xOSeAtlMpob5jliSDBGmo4Sg3kSxGdj/1qCI6Da
         Y37w==
X-Gm-Message-State: AHQUAubo7Ws6PPJ9a9wtb4QoN+LsEjAnhGC8uqkLtTbiR/W/Q9CyluCt
        XX00D2BDG9aAO+xAfOipSYA=
X-Google-Smtp-Source: AHgI3IaOBU8sw5piQTYkFhW0FM8siVBjjmkXdG4KBQnaQO44MAYCb6qy/wU2w/FwDykZtSdVvGtrVQ==
X-Received: by 2002:aca:ac45:: with SMTP id v66mr1008066oie.134.1550117331671;
        Wed, 13 Feb 2019 20:08:51 -0800 (PST)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id k38sm597426otk.67.2019.02.13.20.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 20:08:50 -0800 (PST)
Subject: Re: [PATCH net-next 2/2] net: hns3: add fixup handle for hns3 driver
To:     Jian Shen <shenjian15@huawei.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
 <1550118667-119947-3-git-send-email-shenjian15@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <a9086c2f-9d15-b3d0-9809-44385d6281ff@gmail.com>
Date:   Wed, 13 Feb 2019 20:08:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550118667-119947-3-git-send-email-shenjian15@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2019 8:31 PM, Jian Shen wrote:
> The default led configuration of marvell 88E1510 is not fit
> for hns3 driver, this patch fixes it.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> index 84f2878..4c8346e 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2016-2017 Hisilicon Limited.
>  
>  #include <linux/etherdevice.h>
> +#include <linux/marvell_phy.h>
>  #include <linux/kernel.h>
>  
>  #include "hclge_cmd.h"
> @@ -125,6 +126,13 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
>  	return le16_to_cpu(mdio_cmd->data_rd);
>  }
>  
> +static int hclge_phy_marvell_fixup(struct phy_device *phydev)
> +{
> +	phydev->dev_flags |= MARVELL_PHY_M1510_HNS3_LEDS;
> +
> +	return 0;
> +}
> +
>  int hclge_mac_mdio_config(struct hclge_dev *hdev)
>  {
>  	struct hclge_mac *mac = &hdev->hw.mac;
> @@ -168,6 +176,15 @@ int hclge_mac_mdio_config(struct hclge_dev *hdev)
>  	mac->phydev = phydev;
>  	mac->mdio_bus = mdio_bus;
>  
> +	/* register the PHY board fixup (for Marvell 88E1510) */
> +	ret = phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1510,
> +					 MARVELL_PHY_ID_MASK,
> +					 hclge_phy_marvell_fixup);
> +	/* we can live without it, so just issue a warning */
> +	if (ret)
> +		dev_warn(&hdev->pdev->dev,
> +			 "Cannot register PHY board fixup\n");

You don't need to register a fixup for passing your flags, you can do
that at the time you attach to the PHY:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/phy.h#n945


> +
>  	return 0;
>  }
>  
> @@ -240,6 +257,8 @@ void hclge_mac_disconnect_phy(struct hnae3_handle *handle)
>  	if (!phydev)
>  		return;
>  
> +	phy_unregister_fixup_for_uid(MARVELL_PHY_ID_88E1510,
> +				     MARVELL_PHY_ID_MASK);
>  	phy_disconnect(phydev);
>  }
>  
> 

-- 
Florian
