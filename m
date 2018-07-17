Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13CBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJSAXE5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CE720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeGQK4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:56:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45098 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:56:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so748309edq.12;
        Tue, 17 Jul 2018 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSOt/9opCq5LZKa+31aUC2IWePrkWCon9ZUvhpwOTx8=;
        b=OJSAXE5reKATT8cCUdWxI4jw0ntYv/p+lzfl+LjMCLo+x7SMgGSe27Whgmwgbf884U
         Li4qLd2+8aXiEoFdrxtrlOEEdKeBYD6rph68Or3nB91mhaguy07QxR9sbhbt5N3eUzjM
         fwB3Pkmk1c4I20UEuSSAxQw8NpvpIbHLgSnzddzhyNzBJk/coPl+R5w8iPImzekF0DIp
         XskmZVRSMoxClJ9ziJ4kDvcA8hI+Y4r7zBMwr9xgNAcJc7AuuII5jmEix+Sz+GC6285e
         PuXGEU0TyP8SvAhoZULzBUWiScvJ0RS3YMtVPC18OXjcByV5GIIeyteAQYIhve5ugtIO
         U5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gSOt/9opCq5LZKa+31aUC2IWePrkWCon9ZUvhpwOTx8=;
        b=JjMHjgvA4n3w+PBIHt48geHBIQ+tdsvPtNjXTUCEUqjTvOBT16G3EBvhaXmJXLzpnk
         jCof89uGf+u9QzQIeKiMM9Zil7kOyWOtbCuTX6BqadPr6rVz7/qF9Ut/j+CUq32FJ5K6
         stQcnWs++TubFDxxGe/JUNPm2Fqpmu5bf+SmINeMahHmUDb+T6yHfp9ppAtSUUD8SDxe
         N03NxF3vxwyVTZtIJobybGhj0WxMr5RVmKUjZjm8tJxwxvcMiLmI4tOfW/E7vWogyY5l
         afYUJ4+SbZi+vuCxXIx3G21EcHj5d1wEdZPRjoXFZMMlkDCMswKLxzaBsOeMft+P+/16
         Q2QQ==
X-Gm-Message-State: AOUpUlE7hS7U8XUlOpL62UmaRePcD252VB8l69jZPXfHrWdncGiWRByn
        uK927mT5ULneBw5Nv37cBOK4gUhu
X-Google-Smtp-Source: AAOMgpeRpgCsYaGx83s/Gm/jiDRnmtWGhNyh4vuDBo/jwNtw2yRdPovT5Eoo7Kkupxl4HuUNEVYyuQ==
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr1722901edo.47.1531823093999;
        Tue, 17 Jul 2018 03:24:53 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id p10-v6sm333832edh.9.2018.07.17.03.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 03:24:52 -0700 (PDT)
Subject: Re: [PATCH v5 05/11] clk: mediatek: add mt6765 clock IDs
To:     Mars Cheng <mars.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-6-git-send-email-mars.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <a7ede0bf-e905-bf37-7e21-60226f56b9ab@gmail.com>
Date:   Tue, 17 Jul 2018 12:24:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531817552-17221-6-git-send-email-mars.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/18 10:52, Mars Cheng wrote:
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>

Please provide a commit message.

Thanks,
Matthias

> ---
>  include/dt-bindings/clock/mt6765-clk.h |  313 ++++++++++++++++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6765-clk.h
> 
> diff --git a/include/dt-bindings/clock/mt6765-clk.h b/include/dt-bindings/clock/mt6765-clk.h
> new file mode 100644
> index 0000000..eb97e56
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt6765-clk.h
> @@ -0,0 +1,313 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6765_H
> +#define _DT_BINDINGS_CLK_MT6765_H
> +
> +/* FIX Clks */
> +#define CLK_TOP_CLK26M			0
> +
> +/* APMIXEDSYS */
> +#define CLK_APMIXED_ARMPLL_L		0
> +#define CLK_APMIXED_ARMPLL		1
> +#define CLK_APMIXED_CCIPLL		2
> +#define CLK_APMIXED_MAINPLL		3
> +#define CLK_APMIXED_MFGPLL		4
> +#define CLK_APMIXED_MMPLL		5
> +#define CLK_APMIXED_UNIV2PLL		6
> +#define CLK_APMIXED_MSDCPLL		7
> +#define CLK_APMIXED_APLL1		8
> +#define CLK_APMIXED_MPLL		9
> +#define CLK_APMIXED_ULPOSC1		10
> +#define CLK_APMIXED_ULPOSC2		11
> +#define CLK_APMIXED_SSUSB26M		12
> +#define CLK_APMIXED_APPLL26M		13
> +#define CLK_APMIXED_MIPIC0_26M		14
> +#define CLK_APMIXED_MDPLLGP26M		15
> +#define CLK_APMIXED_MMSYS_F26M		16
> +#define CLK_APMIXED_UFS26M		17
> +#define CLK_APMIXED_MIPIC1_26M		18
> +#define CLK_APMIXED_MEMPLL26M		19
> +#define CLK_APMIXED_CLKSQ_LVPLL_26M	20
> +#define CLK_APMIXED_MIPID0_26M		21
> +#define CLK_APMIXED_NR_CLK		22
> +
> +/* TOPCKGEN */
> +#define CLK_TOP_SYSPLL			0
> +#define CLK_TOP_SYSPLL_D2		1
> +#define CLK_TOP_SYSPLL1_D2		2
> +#define CLK_TOP_SYSPLL1_D4		3
> +#define CLK_TOP_SYSPLL1_D8		4
> +#define CLK_TOP_SYSPLL1_D16		5
> +#define CLK_TOP_SYSPLL_D3		6
> +#define CLK_TOP_SYSPLL2_D2		7
> +#define CLK_TOP_SYSPLL2_D4		8
> +#define CLK_TOP_SYSPLL2_D8		9
> +#define CLK_TOP_SYSPLL_D5		10
> +#define CLK_TOP_SYSPLL3_D2		11
> +#define CLK_TOP_SYSPLL3_D4		12
> +#define CLK_TOP_SYSPLL_D7		13
> +#define CLK_TOP_SYSPLL4_D2		14
> +#define CLK_TOP_SYSPLL4_D4		15
> +#define CLK_TOP_USB20_192M		16
> +#define CLK_TOP_USB20_192M_D4		17
> +#define CLK_TOP_USB20_192M_D8		18
> +#define CLK_TOP_USB20_192M_D16		19
> +#define CLK_TOP_USB20_192M_D32		20
> +#define CLK_TOP_UNIVPLL			21
> +#define CLK_TOP_UNIVPLL_D2		22
> +#define CLK_TOP_UNIVPLL1_D2		23
> +#define CLK_TOP_UNIVPLL1_D4		24
> +#define CLK_TOP_UNIVPLL_D3		25
> +#define CLK_TOP_UNIVPLL2_D2		26
> +#define CLK_TOP_UNIVPLL2_D4		27
> +#define CLK_TOP_UNIVPLL2_D8		28
> +#define CLK_TOP_UNIVPLL2_D32		29
> +#define CLK_TOP_UNIVPLL_D5		30
> +#define CLK_TOP_UNIVPLL3_D2		31
> +#define CLK_TOP_UNIVPLL3_D4		32
> +#define CLK_TOP_MMPLL			33
> +#define CLK_TOP_MMPLL_D2		34
> +#define CLK_TOP_MPLL			35
> +#define CLK_TOP_DA_MPLL_104M_DIV	36
> +#define CLK_TOP_DA_MPLL_52M_DIV		37
> +#define CLK_TOP_MFGPLL			38
> +#define CLK_TOP_MSDCPLL			39
> +#define CLK_TOP_MSDCPLL_D2		40
> +#define CLK_TOP_APLL1			41
> +#define CLK_TOP_APLL1_D2		42
> +#define CLK_TOP_APLL1_D4		43
> +#define CLK_TOP_APLL1_D8		44
> +#define CLK_TOP_ULPOSC1			45
> +#define CLK_TOP_ULPOSC1_D2		46
> +#define CLK_TOP_ULPOSC1_D4		47
> +#define CLK_TOP_ULPOSC1_D8		48
> +#define CLK_TOP_ULPOSC1_D16		49
> +#define CLK_TOP_ULPOSC1_D32		50
> +#define CLK_TOP_DMPLL			51
> +#define CLK_TOP_F_FRTC			52
> +#define CLK_TOP_F_F26M			53
> +#define CLK_TOP_AXI			54
> +#define CLK_TOP_MM			55
> +#define CLK_TOP_SCP			56
> +#define CLK_TOP_MFG			57
> +#define CLK_TOP_F_FUART			58
> +#define CLK_TOP_SPI			59
> +#define CLK_TOP_MSDC50_0		60
> +#define CLK_TOP_MSDC30_1		61
> +#define CLK_TOP_AUDIO			62
> +#define CLK_TOP_AUD_1			63
> +#define CLK_TOP_AUD_ENGEN1		64
> +#define CLK_TOP_F_FDISP_PWM		65
> +#define CLK_TOP_SSPM			66
> +#define CLK_TOP_DXCC			67
> +#define CLK_TOP_I2C			68
> +#define CLK_TOP_F_FPWM			69
> +#define CLK_TOP_F_FSENINF		70
> +#define CLK_TOP_AES_FDE			71
> +#define CLK_TOP_F_BIST2FPC		72
> +#define CLK_TOP_ARMPLL_DIVIDER_PLL0	73
> +#define CLK_TOP_ARMPLL_DIVIDER_PLL1	74
> +#define CLK_TOP_ARMPLL_DIVIDER_PLL2	75
> +#define CLK_TOP_DA_USB20_48M_DIV	76
> +#define CLK_TOP_DA_UNIV_48M_DIV		77
> +#define CLK_TOP_APLL12_DIV0		78
> +#define CLK_TOP_APLL12_DIV1		79
> +#define CLK_TOP_APLL12_DIV2		80
> +#define CLK_TOP_APLL12_DIV3		81
> +#define CLK_TOP_ARMPLL_DIVIDER_PLL0_EN	82
> +#define CLK_TOP_ARMPLL_DIVIDER_PLL1_EN	83
> +#define CLK_TOP_ARMPLL_DIVIDER_PLL2_EN	84
> +#define CLK_TOP_FMEM_OCC_DRC_EN		85
> +#define CLK_TOP_USB20_48M_EN		86
> +#define CLK_TOP_UNIVPLL_48M_EN		87
> +#define CLK_TOP_MPLL_104M_EN		88
> +#define CLK_TOP_MPLL_52M_EN		89
> +#define CLK_TOP_F_UFS_MP_SAP_CFG_EN	90
> +#define CLK_TOP_F_BIST2FPC_EN		91
> +#define CLK_TOP_MD_32K			92
> +#define CLK_TOP_MD_26M			93
> +#define CLK_TOP_MD2_32K			94
> +#define CLK_TOP_MD2_26M			95
> +#define CLK_TOP_AXI_SEL			96
> +#define CLK_TOP_MEM_SEL			97
> +#define CLK_TOP_MM_SEL			98
> +#define CLK_TOP_SCP_SEL			99
> +#define CLK_TOP_MFG_SEL			100
> +#define CLK_TOP_ATB_SEL			101
> +#define CLK_TOP_CAMTG_SEL		102
> +#define CLK_TOP_CAMTG1_SEL		103
> +#define CLK_TOP_CAMTG2_SEL		104
> +#define CLK_TOP_CAMTG3_SEL		105
> +#define CLK_TOP_UART_SEL		106
> +#define CLK_TOP_SPI_SEL			107
> +#define CLK_TOP_MSDC50_0_HCLK_SEL	108
> +#define CLK_TOP_MSDC50_0_SEL		109
> +#define CLK_TOP_MSDC30_1_SEL		110
> +#define CLK_TOP_AUDIO_SEL		111
> +#define CLK_TOP_AUD_INTBUS_SEL		112
> +#define CLK_TOP_AUD_1_SEL		113
> +#define CLK_TOP_AUD_ENGEN1_SEL		114
> +#define CLK_TOP_DISP_PWM_SEL		115
> +#define CLK_TOP_SSPM_SEL		116
> +#define CLK_TOP_DXCC_SEL		117
> +#define CLK_TOP_USB_TOP_SEL		118
> +#define CLK_TOP_SPM_SEL			119
> +#define CLK_TOP_I2C_SEL			120
> +#define CLK_TOP_PWM_SEL			121
> +#define CLK_TOP_SENINF_SEL		122
> +#define CLK_TOP_AES_FDE_SEL		123
> +#define CLK_TOP_PWRAP_ULPOSC_SEL	124
> +#define CLK_TOP_CAMTM_SEL		125
> +#define CLK_TOP_NR_CLK			126
> +
> +/* INFRACFG */
> +#define CLK_IFR_ICUSB			0
> +#define CLK_IFR_GCE			1
> +#define CLK_IFR_THERM			2
> +#define CLK_IFR_I2C_AP			3
> +#define CLK_IFR_I2C_CCU			4
> +#define CLK_IFR_I2C_SSPM		5
> +#define CLK_IFR_I2C_RSV			6
> +#define CLK_IFR_PWM_HCLK		7
> +#define CLK_IFR_PWM1			8
> +#define CLK_IFR_PWM2			9
> +#define CLK_IFR_PWM3			10
> +#define CLK_IFR_PWM4			11
> +#define CLK_IFR_PWM5			12
> +#define CLK_IFR_PWM			13
> +#define CLK_IFR_UART0			14
> +#define CLK_IFR_UART1			15
> +#define CLK_IFR_GCE_26M			16
> +#define CLK_IFR_CQ_DMA_FPC		17
> +#define CLK_IFR_BTIF			18
> +#define CLK_IFR_SPI0			19
> +#define CLK_IFR_MSDC0			20
> +#define CLK_IFR_MSDC1			21
> +#define CLK_IFR_TRNG			22
> +#define CLK_IFR_AUXADC			23
> +#define CLK_IFR_CCIF1_AP		24
> +#define CLK_IFR_CCIF1_MD		25
> +#define CLK_IFR_AUXADC_MD		26
> +#define CLK_IFR_AP_DMA			27
> +#define CLK_IFR_DEVICE_APC		28
> +#define CLK_IFR_CCIF_AP			29
> +#define CLK_IFR_AUDIO			30
> +#define CLK_IFR_CCIF_MD			31
> +#define CLK_IFR_RG_PWM_FBCLK6		32
> +#define CLK_IFR_DISP_PWM		33
> +#define CLK_IFR_CLDMA_BCLK		34
> +#define CLK_IFR_AUDIO_26M_BCLK		35
> +#define CLK_IFR_SPI1			36
> +#define CLK_IFR_I2C4			37
> +#define CLK_IFR_SPI2			38
> +#define CLK_IFR_SPI3			39
> +#define CLK_IFR_I2C5			40
> +#define CLK_IFR_I2C5_ARBITER		41
> +#define CLK_IFR_I2C5_IMM		42
> +#define CLK_IFR_I2C1_ARBITER		43
> +#define CLK_IFR_I2C1_IMM		44
> +#define CLK_IFR_I2C2_ARBITER		45
> +#define CLK_IFR_I2C2_IMM		46
> +#define CLK_IFR_SPI4			47
> +#define CLK_IFR_SPI5			48
> +#define CLK_IFR_CQ_DMA			49
> +#define CLK_IFR_FAES_FDE		50
> +#define CLK_IFR_MSDC0_SELF		51
> +#define CLK_IFR_MSDC1_SELF		52
> +#define CLK_IFR_I2C6			53
> +#define CLK_IFR_AP_MSDC0		54
> +#define CLK_IFR_MD_MSDC0		55
> +#define CLK_IFR_MSDC0_SRC		56
> +#define CLK_IFR_MSDC1_SRC		57
> +#define CLK_IFR_AES_TOP0_BCLK		58
> +#define CLK_IFR_MCU_PM_BCLK		59
> +#define CLK_IFR_CCIF2_AP		60
> +#define CLK_IFR_CCIF2_MD		61
> +#define CLK_IFR_CCIF3_AP		62
> +#define CLK_IFR_CCIF3_MD		63
> +#define CLK_IFR_NR_CLK			64
> +
> +/* AUDIO */
> +#define CLK_AUDIO_AFE			0
> +#define CLK_AUDIO_22M			1
> +#define CLK_AUDIO_APLL_TUNER		2
> +#define CLK_AUDIO_ADC			3
> +#define CLK_AUDIO_DAC			4
> +#define CLK_AUDIO_DAC_PREDIS		5
> +#define CLK_AUDIO_TML			6
> +#define CLK_AUDIO_I2S1_BCLK		7
> +#define CLK_AUDIO_I2S2_BCLK		8
> +#define CLK_AUDIO_I2S3_BCLK		9
> +#define CLK_AUDIO_I2S4_BCLK		10
> +#define CLK_AUDIO_NR_CLK		11
> +
> +/* MIPI_RX_ANA_CSI0A */
> +
> +#define CLK_MIPI0A_CSR_CSI_EN_0A	0
> +#define CLK_MIPI0A_NR_CLK		1
> +
> +/* MMSYS_CONFIG */
> +
> +#define CLK_MM_MDP_RDMA0		0
> +#define CLK_MM_MDP_CCORR0		1
> +#define CLK_MM_MDP_RSZ0			2
> +#define CLK_MM_MDP_RSZ1			3
> +#define CLK_MM_MDP_TDSHP0		4
> +#define CLK_MM_MDP_WROT0		5
> +#define CLK_MM_MDP_WDMA0		6
> +#define CLK_MM_DISP_OVL0		7
> +#define CLK_MM_DISP_OVL0_2L		8
> +#define CLK_MM_DISP_RSZ0		9
> +#define CLK_MM_DISP_RDMA0		10
> +#define CLK_MM_DISP_WDMA0		11
> +#define CLK_MM_DISP_COLOR0		12
> +#define CLK_MM_DISP_CCORR0		13
> +#define CLK_MM_DISP_AAL0		14
> +#define CLK_MM_DISP_GAMMA0		15
> +#define CLK_MM_DISP_DITHER0		16
> +#define CLK_MM_DSI0			17
> +#define CLK_MM_FAKE_ENG			18
> +#define CLK_MM_SMI_COMMON		19
> +#define CLK_MM_SMI_LARB0		20
> +#define CLK_MM_SMI_COMM0		21
> +#define CLK_MM_SMI_COMM1		22
> +#define CLK_MM_CAM_MDP			23
> +#define CLK_MM_SMI_IMG			24
> +#define CLK_MM_SMI_CAM			25
> +#define CLK_MM_IMG_DL_RELAY		26
> +#define CLK_MM_IMG_DL_ASYNC_TOP		27
> +#define CLK_MM_DIG_DSI			28
> +#define CLK_MM_F26M_HRTWT		29
> +#define CLK_MM_NR_CLK			30
> +
> +/* IMGSYS */
> +
> +#define CLK_IMG_LARB2			0
> +#define CLK_IMG_DIP			1
> +#define CLK_IMG_FDVT			2
> +#define CLK_IMG_DPE			3
> +#define CLK_IMG_RSC			4
> +#define CLK_IMG_NR_CLK			5
> +
> +/* VENCSYS */
> +
> +#define CLK_VENC_SET0_LARB		0
> +#define CLK_VENC_SET1_VENC		1
> +#define CLK_VENC_SET2_JPGENC		2
> +#define CLK_VENC_SET3_VDEC		3
> +#define CLK_VENC_NR_CLK			4
> +
> +/* CAMSYS */
> +
> +#define CLK_CAM_LARB3			0
> +#define CLK_CAM_DFP_VAD			1
> +#define CLK_CAM				2
> +#define CLK_CAMTG			3
> +#define CLK_CAM_SENINF			4
> +#define CLK_CAMSV0			5
> +#define CLK_CAMSV1			6
> +#define CLK_CAMSV2			7
> +#define CLK_CAM_CCU			8
> +#define CLK_CAM_NR_CLK			9
> +
> +#endif /* _DT_BINDINGS_CLK_MT6765_H */
> 
