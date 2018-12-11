Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160BA2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CpMJl7pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160BA2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeLKOjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:39:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55842 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeLKOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:39:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so2441551wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QD3eJs/RaEFfBBcOak7at7J5XZS3rHC6GMqA/4qo2JE=;
        b=CpMJl7pqUmM5M5gdmlDWsZSyzrLV2h5NybK4gJFeQxAT/PnGYf4x9sTQFM+cwMrM/L
         mJLvm32K99KXFv7zwWiHuAAJWi0ARa04mVliBSaV5zTJ/85tSF4HBuUhydsFwIwgq1PC
         fRtCSYx7/tJ6gBoND4XqVgXgBhAZhUQ7hdrMdypuUdc501Kc9HUrVNf4kT0WxS0ftCUP
         tMZJ8tlldoRp9cSYW2OLMYHTOSU1b0Nj71AqOLDVaH1thu4Gb9+ZInppJ+UaQLKPZAGo
         vUJnqJiKXbinCjaE/dDiEKMv7m3I6q0Fx9NLocKlShqnJueoQQvg5K74LT/RqF34xQhh
         FkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QD3eJs/RaEFfBBcOak7at7J5XZS3rHC6GMqA/4qo2JE=;
        b=rNFJH51fdNWbaN7eLDy8xdCGknqxBS/uA7U0+WKIBp3TsDYIZv/+GRbi6Dl5ctedVO
         VFSV0hrFr8BLsNF0u8ym9CN8rkMAeuPzkGpWAdyct7/eGRd8NsEIaNrwnHuO1kSsg28a
         VfG6QFvrCl4GlZrpfVLJNH4AdSFdfmEdpVR7VC8h6O4G7HneZyWI/5AlOdh61V3DQKkB
         vuWuSjyzgxgYGiTQNtexbaTNSPpoE4PzCyqlo4iu1XVDOF7e7osxddWstv7mu6e9r7XZ
         r9YZh/1Yl+H2HCEuBXET0IEXGQqygbcBfQJX6yjEa5NPq1LLUMwdnF1Gdc1La1FEiyq/
         crFg==
X-Gm-Message-State: AA+aEWZtSjDFeQaRIunHu6vv5k0gpDBgHhk3Hc54MQv21UAS1d4X/e8f
        BfynQTw/fdAEp8Jp5Fb2x4V4kw==
X-Google-Smtp-Source: AFSGD/W39xHPT4eyXXzepuA82xS6hyVMU31nUqHw4EPBUjPMfFO3ijoACBQhkihSZjwMJsdrM/NNpA==
X-Received: by 2002:a1c:aad2:: with SMTP id t201mr2482648wme.148.1544539162989;
        Tue, 11 Dec 2018 06:39:22 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id v1sm19160147wrw.90.2018.12.11.06.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 06:39:22 -0800 (PST)
Message-ID: <48899a9beb0c32103ae7edea14cec890779d498e.camel@baylibre.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 11 Dec 2018 15:39:19 +0100
In-Reply-To: <1543498917-98605-2-git-send-email-jian.hu@amlogic.com>
References: <1543498917-98605-1-git-send-email-jian.hu@amlogic.com>
         <1543498917-98605-2-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 21:41 +0800, Jian Hu wrote:
> Add new clock controller compatible and dt-bingdings headers
> for the Everything-Else domain of the g12a SoC
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |  1 +
>  include/dt-bindings/clock/g12a-clkc.h              | 93
> ++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index e950599..0833006 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  		"amlogic,gxbb-clkc" for GXBB SoC,
>  		"amlogic,gxl-clkc" for GXL and GXM SoC,
>  		"amlogic,axg-clkc" for AXG SoC.
> +		"amlogic,g12a-clkc" for G12A SoC.


Binding description is not aligned with what the driver does.
If you are going take clock input from DT, it needs to be documented.

In the meantime this has been done [0] for you but you'll have to rebase.

[0]: 20181203171640.12110-3-jbrunet@baylibre.com

>  
>  - #clock-cells: should be 1.
>  
> diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-
> bindings/clock/g12a-clkc.h
> new file mode 100644
> index 0000000..b55e6e1
> --- /dev/null
> +++ b/include/dt-bindings/clock/g12a-clkc.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson-G12A clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __G12A_CLKC_H
> +#define __G12A_CLKC_H
> +
> +#define CLKID_SYS_PLL				0
> +#define CLKID_FIXED_PLL				1
> +#define CLKID_FCLK_DIV2				2
> +#define CLKID_FCLK_DIV3				3
> +#define CLKID_FCLK_DIV4				4
> +#define CLKID_FCLK_DIV5				5
> +#define CLKID_FCLK_DIV7				6
> +#define CLKID_GP0_PLL				7
> +#define CLKID_CLK81				10
> +#define CLKID_MPLL0				11
> +#define CLKID_MPLL1				12
> +#define CLKID_MPLL2				13
> +#define CLKID_MPLL3				14
> +#define CLKID_DDR				15
> +#define CLKID_DOS				16
> +#define CLKID_AUDIO_LOCKER			17
> +#define CLKID_MIPI_DSI_HOST			18
> +#define CLKID_ETH_PHY				19
> +#define CLKID_ISA				20
> +#define CLKID_PL301				21
> +#define CLKID_PERIPHS				22
> +#define CLKID_SPICC0				23
> +#define CLKID_I2C				24
> +#define CLKID_SANA				25
> +#define CLKID_SD				26
> +#define CLKID_RNG0				27
> +#define CLKID_UART0				28
> +#define CLKID_SPICC1				29
> +#define CLKID_HIU_IFACE				30
> +#define CLKID_MIPI_DSI_PHY			31
> +#define CLKID_ASSIST_MISC			32
> +#define CLKID_SD_EMMC_A				33
> +#define CLKID_SD_EMMC_B				34
> +#define CLKID_SD_EMMC_C				35
> +#define CLKID_AUDIO_CODEC			36
> +#define CLKID_AUDIO				37
> +#define CLKID_ETH				38
> +#define CLKID_DEMUX				39
> +#define CLKID_AUDIO_IFIFO			40
> +#define CLKID_ADC				41
> +#define CLKID_UART1				42
> +#define CLKID_G2D				43
> +#define CLKID_RESET				44
> +#define CLKID_PCIE_COMB				45
> +#define CLKID_PARSER				46
> +#define CLKID_USB				47
> +#define CLKID_PCIE_PHY				48
> +#define CLKID_AHB_ARB0				49
> +#define CLKID_AHB_DATA_BUS			50
> +#define CLKID_AHB_CTRL_BUS			51
> +#define CLKID_HTX_HDCP22			52
> +#define CLKID_HTX_PCLK				53
> +#define CLKID_BT656				54
> +#define CLKID_USB1_DDR_BRIDGE			55
> +#define CLKID_MMC_PCLK				56
> +#define CLKID_UART2				57
> +#define CLKID_VPU_INTR				58
> +#define CLKID_GIC				59
> +#define CLKID_SD_EMMC_B_CLK0			60
> +#define CLKID_SD_EMMC_C_CLK0			61
> +#define CLKID_HIFI_PLL				71
> +#define CLKID_VCLK2_VENCI0			77
> +#define CLKID_VCLK2_VENCI1			78
> +#define CLKID_VCLK2_VENCP0			79
> +#define CLKID_VCLK2_VENCP1			80
> +#define CLKID_VCLK2_VENCT0			81
> +#define CLKID_VCLK2_VENCT1			82
> +#define CLKID_VCLK2_OTHER			83
> +#define CLKID_VCLK2_ENCI			84
> +#define CLKID_VCLK2_ENCP			85
> +#define CLKID_DAC_CLK				86
> +#define CLKID_AOCLK				87
> +#define CLKID_IEC958				88
> +#define CLKID_ENC480P				89
> +#define CLKID_RNG1				90
> +#define CLKID_VCLK2_ENCT			91
> +#define CLKID_VCLK2_ENCL			92
> +#define CLKID_VCLK2_VENCLMMC			93
> +#define CLKID_VCLK2_VENCL			94
> +#define CLKID_VCLK2_OTHER1			95
> +#define CLKID_FCLK_DIV2P5			96
> +
> +#endif /* __G12A_CLKC_H */


