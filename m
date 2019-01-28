Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4113C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40DD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F+I+Jwl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfA1HEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:04:41 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12573 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfA1HEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:04:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4ea96d0000>; Sun, 27 Jan 2019 23:04:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:04:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 27 Jan 2019 23:04:40 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:04:38 +0000
Subject: Re: [PATCH 1/5] dt-bindings: phy: tegra: Add Tegra186 support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <45ab054d-674f-fcdf-85cf-b07c049f0e7d@nvidia.com>
Date:   Mon, 28 Jan 2019 15:04:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125112525.10697-1-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548659053; bh=rayoCl61BzIwGrRGEnp5/2pChaoIExm0/6zTFGzT84I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=F+I+Jwl+IMABc5kL+vbHVcRMZP8XSuuyg5QLBA+vYVLIzoyTt2fBo6el9/3r+I/oe
         pGZE0CYo+1Iu94AwcwPiS02m3xYetDiM87Pve2A/LjcHSew3WtNTp+y5OxMBcEgUho
         FYswguh9xlMlC15yMReEG0bEeXS48Pr4KGCBqXqTIXViLmipUTqXp9ud3Tglivz44k
         gNzCsHtghEIjuSGgXzvH+MAp6JfN06gat/ecIv1cPhRQu2dvwiVu5mgGrc7Atv3wLr
         wPv1H8nHkD99CpcFQH5LDmYe7iSipT7C/tE6JOqI5l6Aj3qCEt+4xx8mvdJWVeRhoI
         HBTtA7t7KVhiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:25 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Extend the bindings to cover the set of features found in Tegra186. Note
> that, technically, there are four more supplies connected to the XUSB
> pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL), but
> the power sequencing requirements of Tegra186 require these to be under
> the control of the PMIC.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   .../bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
> index 3742c152c467..daedb15f322e 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
> @@ -36,11 +36,20 @@ Required properties:
>     - Tegra124: "nvidia,tegra124-xusb-padctl"
>     - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl"
>     - Tegra210: "nvidia,tegra210-xusb-padctl"
> +  - Tegra186: "nvidia,tegra186-xusb-padctl"
>   - reg: Physical base address and length of the controller's registers.
>   - resets: Must contain an entry for each entry in reset-names.
>   - reset-names: Must include the following entries:
>     - "padctl"
>   
> +For Tegra186:
> +- avdd-pll-erefeut-supply: UPHY brick and reference clock as well as UTMI PHY
> +  power supply. Must supply 1.8 V.
> +- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must supply
> +  3.3 V.
> +- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
> +- vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
> +
>   
>   Pad nodes:
>   ==========
