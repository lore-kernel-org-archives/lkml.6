Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6200C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFAC2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XJfOh0zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFAC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeIDGrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:47:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38146 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:47:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w842Ojfl089319;
        Mon, 3 Sep 2018 21:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536027885;
        bh=m9hHxQQr906AdYWY849RiWQWoHygeTMifdUs3AbyEjY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XJfOh0zPLWnSsQeY3+2NDoioVxwcT4mgqks2pLt8U7gZTnJd414Py/pSqpRlp6W0n
         b8IYfXsVsEo1522G48PMbj5vwYAyNA4dXGFUlsmm8bHDhi6NKS+FjkRjWdIx8Clmwg
         WOIFsmBx99RWag/zpk+9Cz9Y7wngWMjTFBTyV2K0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w842Ojxs014513;
        Mon, 3 Sep 2018 21:24:45 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 3 Sep
 2018 21:24:45 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 3 Sep 2018 21:24:45 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w842OheG012755;
        Mon, 3 Sep 2018 21:24:44 -0500
Subject: Re: [PATCH] phy: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-39-robh@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9dcceda0-1d92-0a7a-feb1-887414021ac9@ti.com>
Date:   Tue, 4 Sep 2018 07:54:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-39-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tuesday 28 August 2018 07:22 AM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

I assume it should be okay to get this merged in the next merge window?

Thanks
Kishon
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/phy/broadcom/phy-bcm-cygnus-pcie.c    | 4 ++--
>   drivers/phy/broadcom/phy-brcm-sata.c          | 4 ++--
>   drivers/phy/marvell/phy-berlin-sata.c         | 6 +++---
>   drivers/phy/qualcomm/phy-qcom-qmp.c           | 2 +-
>   drivers/phy/rockchip/phy-rockchip-emmc.c      | 4 ++--
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 8 ++++----
>   drivers/phy/rockchip/phy-rockchip-typec.c     | 8 ++++----
>   drivers/phy/rockchip/phy-rockchip-usb.c       | 4 ++--
>   drivers/phy/tegra/xusb.c                      | 4 ++--
>   9 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
> index 0f4ac5d63cff..b074682d9dd8 100644
> --- a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
> +++ b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
> @@ -153,8 +153,8 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
>   		struct cygnus_pcie_phy *p;
>   
>   		if (of_property_read_u32(child, "reg", &id)) {
> -			dev_err(dev, "missing reg property for %s\n",
> -				child->name);
> +			dev_err(dev, "missing reg property for %pOFn\n",
> +				child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
> diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
> index 8708ea3b4d6d..ac57f5a41708 100644
> --- a/drivers/phy/broadcom/phy-brcm-sata.c
> +++ b/drivers/phy/broadcom/phy-brcm-sata.c
> @@ -600,8 +600,8 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>   		struct brcm_sata_port *port;
>   
>   		if (of_property_read_u32(child, "reg", &id)) {
> -			dev_err(dev, "missing reg property in node %s\n",
> -					child->name);
> +			dev_err(dev, "missing reg property in node %pOFn\n",
> +					child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
> diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
> index c1bb6725e48f..a91fc67fc4e0 100644
> --- a/drivers/phy/marvell/phy-berlin-sata.c
> +++ b/drivers/phy/marvell/phy-berlin-sata.c
> @@ -231,14 +231,14 @@ static int phy_berlin_sata_probe(struct platform_device *pdev)
>   		struct phy_berlin_desc *phy_desc;
>   
>   		if (of_property_read_u32(child, "reg", &phy_id)) {
> -			dev_err(dev, "missing reg property in node %s\n",
> -				child->name);
> +			dev_err(dev, "missing reg property in node %pOFn\n",
> +				child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
>   
>   		if (phy_id >= ARRAY_SIZE(phy_berlin_power_down_bits)) {
> -			dev_err(dev, "invalid reg in node %s\n", child->name);
> +			dev_err(dev, "invalid reg in node %pOFn\n", child);
>   			ret = -EINVAL;
>   			goto put_child;
>   		}
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 4c470104a0d6..baa59484a90c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1400,7 +1400,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>   
>   	ret = of_property_read_string(np, "clock-output-names", &init.name);
>   	if (ret) {
> -		dev_err(qmp->dev, "%s: No clock-output-names\n", np->name);
> +		dev_err(qmp->dev, "%pOFn: No clock-output-names\n", np);
>   		return ret;
>   	}
>   
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index b237360f95f6..19bf84f0bc67 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -337,8 +337,8 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	if (of_property_read_u32(dev->of_node, "reg", &reg_offset)) {
> -		dev_err(dev, "missing reg property in node %s\n",
> -			dev->of_node->name);
> +		dev_err(dev, "missing reg property in node %pOFn\n",
> +			dev->of_node);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 5049dac79bd0..24bd2717abdb 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1116,8 +1116,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   	}
>   
>   	if (of_property_read_u32(np, "reg", &reg)) {
> -		dev_err(dev, "the reg property is not assigned in %s node\n",
> -			np->name);
> +		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
> +			np);
>   		return -EINVAL;
>   	}
>   
> @@ -1143,8 +1143,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   	}
>   
>   	if (!rphy->phy_cfg) {
> -		dev_err(dev, "no phy-config can be matched with %s node\n",
> -			np->name);
> +		dev_err(dev, "no phy-config can be matched with %pOFn node\n",
> +			np);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 76a4b58ec771..c57e496f0b0c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -1145,8 +1145,8 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>   	}
>   
>   	if (!tcphy->port_cfgs) {
> -		dev_err(dev, "no phy-config can be matched with %s node\n",
> -			np->name);
> +		dev_err(dev, "no phy-config can be matched with %pOFn node\n",
> +			np);
>   		return -EINVAL;
>   	}
>   
> @@ -1186,8 +1186,8 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>   			continue;
>   
>   		if (IS_ERR(phy)) {
> -			dev_err(dev, "failed to create phy: %s\n",
> -				child_np->name);
> +			dev_err(dev, "failed to create phy: %pOFn\n",
> +				child_np);
>   			pm_runtime_disable(dev);
>   			return PTR_ERR(phy);
>   		}
> diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
> index 3378eeb7a562..269c86329cb8 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usb.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usb.c
> @@ -208,8 +208,8 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
>   	rk_phy->np = child;
>   
>   	if (of_property_read_u32(child, "reg", &reg_offset)) {
> -		dev_err(base->dev, "missing reg property in node %s\n",
> -			child->name);
> +		dev_err(base->dev, "missing reg property in node %pOFn\n",
> +			child);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index de1b4ebe4de2..5b3b8863363e 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -115,8 +115,8 @@ int tegra_xusb_lane_parse_dt(struct tegra_xusb_lane *lane,
>   
>   	err = match_string(lane->soc->funcs, lane->soc->num_funcs, function);
>   	if (err < 0) {
> -		dev_err(dev, "invalid function \"%s\" for lane \"%s\"\n",
> -			function, np->name);
> +		dev_err(dev, "invalid function \"%s\" for lane \"%pOFn\"\n",
> +			function, np);
>   		return err;
>   	}
>   
> 
