Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E9FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9246214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="GeZeGItH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9246214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIQN7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:59:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36926 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeIQN7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:59:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id t140-v6so6974252lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nRmzbtqjLEY7FqouRot4ZW0r6LEUGDxmvttZoEcKink=;
        b=GeZeGItH8NPG3eGdb3pu+fnfRKpM4GKfOj/YXdcuCAqLYuY940xguVjYbznitThwlv
         4gz+OkrlisQRza+4TpjSqO1cAi2SuVi/lHUVKPKs93h5d4SpyIT5GslrBJP1+VgjiD1H
         N1CqHHeDB9vUWiTLTDi4lfGX5UkyyekYH4ZGHm3wmSFwEb2hw4edT9IjwUJKqeYYEMng
         m91347qJq4LsE6wvutHOgCPqVhOEAMg5lRUpj7c3jXSB1SXcuhZUFwzvfn7JVkwmep21
         NDNJU1u32tDr5aCL/mKkghmblL0euQE/i+49I5K/PDtkSdSl6A9sjVyJIYKB9L18biig
         PRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nRmzbtqjLEY7FqouRot4ZW0r6LEUGDxmvttZoEcKink=;
        b=qS0UU4dpDveq0PRcETwza+SNGg4dN+XZykY/P6PDigH6DOakmGxnCGgdAHoXpSeJlD
         ONFzAxJ8iDClUeNmFP9RDxKXeT0fCQUS85A3mmfPpLONkLNmdzs46PJPKg3zseHCcHeu
         Ff2Vm0aYHPBkfUDRdo4tGwSQJzdxVunC0RPUwgkvcHheifCwxkHzCUKzQjPL972FbmKA
         LyiIrxg791dRQCNioPGv+ElKcp3EBdMAvLkf4GcpM59C7JaEeZR7veX3bHZqJbe31FVA
         jH1zUddoTqavD+Akh/StF6jHdtYAquZKwLsYuWIKN8ZNwC9SPs6mjoQ0BYBM6pco2B/h
         CQOg==
X-Gm-Message-State: APzg51Ans3SbCRwjxnmTZjDnDVCu8N9hlTFMNKzA5i0Nq/J0C/+5am4g
        oTG1i1X2EPtKZs+pTMCE2I92uQ==
X-Google-Smtp-Source: ANB0Vdb1ath1xcoOR5FeVPgvsCt4Ki7Vm5DZMKdhzGGTZdSIANo+ffNvOTwgTZuEul4q/gO+b/KXgA==
X-Received: by 2002:a19:8f57:: with SMTP id r84-v6mr2921873lfd.131.1537173199406;
        Mon, 17 Sep 2018 01:33:19 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.107])
        by smtp.gmail.com with ESMTPSA id m8-v6sm2751595ljj.10.2018.09.17.01.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 01:33:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-binding: mediatek: Add binding document for
 MediaTek GMAC
To:     Biao Huang <biao.huang@mediatek.com>, davem@davemloft.net,
        robh+dt@kernel.org
Cc:     honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        sean.wang@mediatek.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
 <1537165763-13112-2-git-send-email-biao.huang@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <fb327132-0830-9df0-434e-06bb0033bac4@cogentembedded.com>
Date:   Mon, 17 Sep 2018 11:33:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537165763-13112-2-git-send-email-biao.huang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 9:29 AM, Biao Huang wrote:

> The commit adds the device tree binding documentation for the MediaTek
> GMAC found on Mediatek MT2712.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>   .../devicetree/bindings/net/mediatek-gmac.txt      |   45 ++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/mediatek-gmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek-gmac.txt b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
> new file mode 100644
> index 0000000..14876ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
> @@ -0,0 +1,45 @@
> +MediaTek Gigabit Ethernet controller
> +=========================================
> +
> +The gigabit ethernet controller can be found on MediaTek SoCs.
> +
> +* Ethernet controller node
> +
> +Required properties:
> +- compatible: Should be
> +	"mediatek,mt2712-eth": for MT2712 SoC
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain the MAC interrupts
> +- interrupt-names: the name of interrupt in the interrupts property. These are
> +	"macirq": For MT2712 SoC
> +- clocks: the clock used by the controller
> +- clock-names: the names of the clock listed in the clocks property. These are
> +	"axi", "apb", "mac_ext", "ptp", "ptp_parent", "ptp_top": For MT2712 SoC
> +- mac-address: See ethernet.txt in the same directory
> +- power-domains: phandle to the power domain that the ethernet is part of

    This (required) prop is absent in your example.

> +- phy-mode: See ethernet.txt file in the same directory.
> +- reset-gpio: gpio number for phy reset.
> +
> +Example:
> +
> +eth: eth@1101c000 {

eth: ethernet@1101c000 {

> +		compatible = "mediatek,mt2712-eth";
> +		reg = <0 0x1101c000 0 0x1200>;
> +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "macirq";
> +		phy-mode ="rgmii";
> +		mac-address = [00 55 7b b5 7d f7];
> +		clock-names = "axi",
> +			      "apb",
> +			      "mac_ext",
> +			      "ptp",
> +			      "ptp_parent",
> +			      "ptp_top";
> +		clocks = <&pericfg CLK_PERI_GMAC>,
> +			 <&pericfg CLK_PERI_GMAC_PCLK>,
> +			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
> +			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
> +			 <&topckgen CLK_TOP_APLL1_D3>,
> +			 <&topckgen CLK_TOP_APLL1>;
> +		reset-gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
> +	};

MBR, Sergei
