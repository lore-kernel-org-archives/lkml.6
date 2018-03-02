Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164338AbeCBCXd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:23:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164082AbeCBCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:23:31 -0500
X-UUID: b582ded61c2848ad9c1548b64a5a0ead-20180302
Message-ID: <1519957404.14513.5.camel@mtksdaap41>
Subject: Re: [PATCH v1 3/5] dt-bindings: clock: add clocks for MT2712
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "James Liao" <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date: Fri, 2 Mar 2018 10:23:24 +0800
In-Reply-To: <20180301224555.44pvl67l5oqibbkg@rob-hp-laptop>
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
         <20180222054851.26096-5-weiyi.lu@mediatek.com>
         <20180301224555.44pvl67l5oqibbkg@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 16:45 -0600, Rob Herring wrote:
> On Thu, Feb 22, 2018 at 01:48:49PM +0800, Weiyi Lu wrote:
> > add new clocks according to ECO design change
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  include/dt-bindings/clock/mt2712-clk.h | 294 +++++++++++++++++----------------
> >  1 file changed, 151 insertions(+), 143 deletions(-)
> 
> You can't just renumber your clocks. They are an ABI. Plus, for an ECO 
> there can't have been that much change.
> 
Hi Rob,
Got it! Is it correct if I append those new added clocks at the bottom
of each own subsystem? If the answer is yes, I'll resend a new version.
> > 
> > diff --git a/include/dt-bindings/clock/mt2712-clk.h b/include/dt-bindings/clock/mt2712-clk.h
> > index 48a8e797a617..0690f24391b3 100644
> > --- a/include/dt-bindings/clock/mt2712-clk.h
> > +++ b/include/dt-bindings/clock/mt2712-clk.h
> > @@ -81,148 +81,154 @@
> >  #define CLK_TOP_F_BUS_PLL2		42
> >  #define CLK_TOP_APLL1			43
> >  #define CLK_TOP_APLL1_D2		44
> > -#define CLK_TOP_APLL1_D4		45
> > -#define CLK_TOP_APLL1_D8		46
> > -#define CLK_TOP_APLL1_D16		47
> > -#define CLK_TOP_APLL2			48
> > -#define CLK_TOP_APLL2_D2		49
> > -#define CLK_TOP_APLL2_D4		50
> > -#define CLK_TOP_APLL2_D8		51
> > -#define CLK_TOP_APLL2_D16		52
> > -#define CLK_TOP_LVDSPLL			53
> > -#define CLK_TOP_LVDSPLL_D2		54
> > -#define CLK_TOP_LVDSPLL_D4		55
> > -#define CLK_TOP_LVDSPLL_D8		56
> > -#define CLK_TOP_LVDSPLL2		57
> > -#define CLK_TOP_LVDSPLL2_D2		58
> > -#define CLK_TOP_LVDSPLL2_D4		59
> > -#define CLK_TOP_LVDSPLL2_D8		60
> > -#define CLK_TOP_ETHERPLL_125M		61
> > -#define CLK_TOP_ETHERPLL_50M		62
> > -#define CLK_TOP_CVBS			63
> > -#define CLK_TOP_CVBS_D2			64
> > -#define CLK_TOP_SYS_26M			65
> > -#define CLK_TOP_MMPLL			66
> > -#define CLK_TOP_MMPLL_D2		67
> > -#define CLK_TOP_VENCPLL			68
> > -#define CLK_TOP_VENCPLL_D2		69
> > -#define CLK_TOP_VCODECPLL		70
> > -#define CLK_TOP_VCODECPLL_D2		71
> > -#define CLK_TOP_TVDPLL			72
> > -#define CLK_TOP_TVDPLL_D2		73
> > -#define CLK_TOP_TVDPLL_D4		74
> > -#define CLK_TOP_TVDPLL_D8		75
> > -#define CLK_TOP_TVDPLL_429M		76
> > -#define CLK_TOP_TVDPLL_429M_D2		77
> > -#define CLK_TOP_TVDPLL_429M_D4		78
> > -#define CLK_TOP_MSDCPLL			79
> > -#define CLK_TOP_MSDCPLL_D2		80
> > -#define CLK_TOP_MSDCPLL_D4		81
> > -#define CLK_TOP_MSDCPLL2		82
> > -#define CLK_TOP_MSDCPLL2_D2		83
> > -#define CLK_TOP_MSDCPLL2_D4		84
> > -#define CLK_TOP_CLK26M_D2		85
> > -#define CLK_TOP_D2A_ULCLK_6P5M		86
> > -#define CLK_TOP_VPLL3_DPIX		87
> > -#define CLK_TOP_VPLL_DPIX		88
> > -#define CLK_TOP_LTEPLL_FS26M		89
> > -#define CLK_TOP_DMPLL			90
> > -#define CLK_TOP_DSI0_LNTC		91
> > -#define CLK_TOP_DSI1_LNTC		92
> > -#define CLK_TOP_LVDSTX3_CLKDIG_CTS	93
> > -#define CLK_TOP_LVDSTX_CLKDIG_CTS	94
> > -#define CLK_TOP_CLKRTC_EXT		95
> > -#define CLK_TOP_CLKRTC_INT		96
> > -#define CLK_TOP_CSI0			97
> > -#define CLK_TOP_CVBSPLL			98
> > -#define CLK_TOP_AXI_SEL			99
> > -#define CLK_TOP_MEM_SEL			100
> > -#define CLK_TOP_MM_SEL			101
> > -#define CLK_TOP_PWM_SEL			102
> > -#define CLK_TOP_VDEC_SEL		103
> > -#define CLK_TOP_VENC_SEL		104
> > -#define CLK_TOP_MFG_SEL			105
> > -#define CLK_TOP_CAMTG_SEL		106
> > -#define CLK_TOP_UART_SEL		107
> > -#define CLK_TOP_SPI_SEL			108
> > -#define CLK_TOP_USB20_SEL		109
> > -#define CLK_TOP_USB30_SEL		110
> > -#define CLK_TOP_MSDC50_0_HCLK_SEL	111
> > -#define CLK_TOP_MSDC50_0_SEL		112
> > -#define CLK_TOP_MSDC30_1_SEL		113
> > -#define CLK_TOP_MSDC30_2_SEL		114
> > -#define CLK_TOP_MSDC30_3_SEL		115
> > -#define CLK_TOP_AUDIO_SEL		116
> > -#define CLK_TOP_AUD_INTBUS_SEL		117
> > -#define CLK_TOP_PMICSPI_SEL		118
> > -#define CLK_TOP_DPILVDS1_SEL		119
> > -#define CLK_TOP_ATB_SEL			120
> > -#define CLK_TOP_NR_SEL			121
> > -#define CLK_TOP_NFI2X_SEL		122
> > -#define CLK_TOP_IRDA_SEL		123
> > -#define CLK_TOP_CCI400_SEL		124
> > -#define CLK_TOP_AUD_1_SEL		125
> > -#define CLK_TOP_AUD_2_SEL		126
> > -#define CLK_TOP_MEM_MFG_IN_AS_SEL	127
> > -#define CLK_TOP_AXI_MFG_IN_AS_SEL	128
> > -#define CLK_TOP_SCAM_SEL		129
> > -#define CLK_TOP_NFIECC_SEL		130
> > -#define CLK_TOP_PE2_MAC_P0_SEL		131
> > -#define CLK_TOP_PE2_MAC_P1_SEL		132
> > -#define CLK_TOP_DPILVDS_SEL		133
> > -#define CLK_TOP_MSDC50_3_HCLK_SEL	134
> > -#define CLK_TOP_HDCP_SEL		135
> > -#define CLK_TOP_HDCP_24M_SEL		136
> > -#define CLK_TOP_RTC_SEL			137
> > -#define CLK_TOP_SPINOR_SEL		138
> > -#define CLK_TOP_APLL_SEL		139
> > -#define CLK_TOP_APLL2_SEL		140
> > -#define CLK_TOP_A1SYS_HP_SEL		141
> > -#define CLK_TOP_A2SYS_HP_SEL		142
> > -#define CLK_TOP_ASM_L_SEL		143
> > -#define CLK_TOP_ASM_M_SEL		144
> > -#define CLK_TOP_ASM_H_SEL		145
> > -#define CLK_TOP_I2SO1_SEL		146
> > -#define CLK_TOP_I2SO2_SEL		147
> > -#define CLK_TOP_I2SO3_SEL		148
> > -#define CLK_TOP_TDMO0_SEL		149
> > -#define CLK_TOP_TDMO1_SEL		150
> > -#define CLK_TOP_I2SI1_SEL		151
> > -#define CLK_TOP_I2SI2_SEL		152
> > -#define CLK_TOP_I2SI3_SEL		153
> > -#define CLK_TOP_ETHER_125M_SEL		154
> > -#define CLK_TOP_ETHER_50M_SEL		155
> > -#define CLK_TOP_JPGDEC_SEL		156
> > -#define CLK_TOP_SPISLV_SEL		157
> > -#define CLK_TOP_ETHER_50M_RMII_SEL	158
> > -#define CLK_TOP_CAM2TG_SEL		159
> > -#define CLK_TOP_DI_SEL			160
> > -#define CLK_TOP_TVD_SEL			161
> > -#define CLK_TOP_I2C_SEL			162
> > -#define CLK_TOP_PWM_INFRA_SEL		163
> > -#define CLK_TOP_MSDC0P_AES_SEL		164
> > -#define CLK_TOP_CMSYS_SEL		165
> > -#define CLK_TOP_GCPU_SEL		166
> > -#define CLK_TOP_AUD_APLL1_SEL		167
> > -#define CLK_TOP_AUD_APLL2_SEL		168
> > -#define CLK_TOP_DA_AUDULL_VTX_6P5M_SEL	169
> > -#define CLK_TOP_APLL_DIV0		170
> > -#define CLK_TOP_APLL_DIV1		171
> > -#define CLK_TOP_APLL_DIV2		172
> > -#define CLK_TOP_APLL_DIV3		173
> > -#define CLK_TOP_APLL_DIV4		174
> > -#define CLK_TOP_APLL_DIV5		175
> > -#define CLK_TOP_APLL_DIV6		176
> > -#define CLK_TOP_APLL_DIV7		177
> > -#define CLK_TOP_APLL_DIV_PDN0		178
> > -#define CLK_TOP_APLL_DIV_PDN1		179
> > -#define CLK_TOP_APLL_DIV_PDN2		180
> > -#define CLK_TOP_APLL_DIV_PDN3		181
> > -#define CLK_TOP_APLL_DIV_PDN4		182
> > -#define CLK_TOP_APLL_DIV_PDN5		183
> > -#define CLK_TOP_APLL_DIV_PDN6		184
> > -#define CLK_TOP_APLL_DIV_PDN7		185
> > -#define CLK_TOP_NR_CLK			186
> > +#define CLK_TOP_APLL1_D3		45
> > +#define CLK_TOP_APLL1_D4		46
> > +#define CLK_TOP_APLL1_D8		47
> > +#define CLK_TOP_APLL1_D16		48
> > +#define CLK_TOP_APLL2			49
> > +#define CLK_TOP_APLL2_D2		50
> > +#define CLK_TOP_APLL2_D4		51
> > +#define CLK_TOP_APLL2_D8		52
> > +#define CLK_TOP_APLL2_D16		53
> > +#define CLK_TOP_LVDSPLL			54
> > +#define CLK_TOP_LVDSPLL_D2		55
> > +#define CLK_TOP_LVDSPLL_D4		56
> > +#define CLK_TOP_LVDSPLL_D8		57
> > +#define CLK_TOP_LVDSPLL2		58
> > +#define CLK_TOP_LVDSPLL2_D2		59
> > +#define CLK_TOP_LVDSPLL2_D4		60
> > +#define CLK_TOP_LVDSPLL2_D8		61
> > +#define CLK_TOP_ETHERPLL_125M		62
> > +#define CLK_TOP_ETHERPLL_50M		63
> > +#define CLK_TOP_CVBS			64
> > +#define CLK_TOP_CVBS_D2			65
> > +#define CLK_TOP_SYS_26M			66
> > +#define CLK_TOP_MMPLL			67
> > +#define CLK_TOP_MMPLL_D2		68
> > +#define CLK_TOP_VENCPLL			69
> > +#define CLK_TOP_VENCPLL_D2		70
> > +#define CLK_TOP_VCODECPLL		71
> > +#define CLK_TOP_VCODECPLL_D2		72
> > +#define CLK_TOP_TVDPLL			73
> > +#define CLK_TOP_TVDPLL_D2		74
> > +#define CLK_TOP_TVDPLL_D4		75
> > +#define CLK_TOP_TVDPLL_D8		76
> > +#define CLK_TOP_TVDPLL_429M		77
> > +#define CLK_TOP_TVDPLL_429M_D2		78
> > +#define CLK_TOP_TVDPLL_429M_D4		79
> > +#define CLK_TOP_MSDCPLL			80
> > +#define CLK_TOP_MSDCPLL_D2		81
> > +#define CLK_TOP_MSDCPLL_D4		82
> > +#define CLK_TOP_MSDCPLL2		83
> > +#define CLK_TOP_MSDCPLL2_D2		84
> > +#define CLK_TOP_MSDCPLL2_D4		85
> > +#define CLK_TOP_CLK26M_D2		86
> > +#define CLK_TOP_D2A_ULCLK_6P5M		87
> > +#define CLK_TOP_VPLL3_DPIX		88
> > +#define CLK_TOP_VPLL_DPIX		89
> > +#define CLK_TOP_LTEPLL_FS26M		90
> > +#define CLK_TOP_DMPLL			91
> > +#define CLK_TOP_DSI0_LNTC		92
> > +#define CLK_TOP_DSI1_LNTC		93
> > +#define CLK_TOP_LVDSTX3_CLKDIG_CTS	94
> > +#define CLK_TOP_LVDSTX_CLKDIG_CTS	95
> > +#define CLK_TOP_CLKRTC_EXT		96
> > +#define CLK_TOP_CLKRTC_INT		97
> > +#define CLK_TOP_CSI0			98
> > +#define CLK_TOP_CVBSPLL			99
> > +#define CLK_TOP_AXI_SEL			100
> > +#define CLK_TOP_MEM_SEL			101
> > +#define CLK_TOP_MM_SEL			102
> > +#define CLK_TOP_PWM_SEL			103
> > +#define CLK_TOP_VDEC_SEL		104
> > +#define CLK_TOP_VENC_SEL		105
> > +#define CLK_TOP_MFG_SEL			106
> > +#define CLK_TOP_CAMTG_SEL		107
> > +#define CLK_TOP_UART_SEL		108
> > +#define CLK_TOP_SPI_SEL			109
> > +#define CLK_TOP_USB20_SEL		110
> > +#define CLK_TOP_USB30_SEL		111
> > +#define CLK_TOP_MSDC50_0_HCLK_SEL	112
> > +#define CLK_TOP_MSDC50_0_SEL		113
> > +#define CLK_TOP_MSDC30_1_SEL		114
> > +#define CLK_TOP_MSDC30_2_SEL		115
> > +#define CLK_TOP_MSDC30_3_SEL		116
> > +#define CLK_TOP_AUDIO_SEL		117
> > +#define CLK_TOP_AUD_INTBUS_SEL		118
> > +#define CLK_TOP_PMICSPI_SEL		119
> > +#define CLK_TOP_DPILVDS1_SEL		120
> > +#define CLK_TOP_ATB_SEL			121
> > +#define CLK_TOP_NR_SEL			122
> > +#define CLK_TOP_NFI2X_SEL		123
> > +#define CLK_TOP_IRDA_SEL		124
> > +#define CLK_TOP_CCI400_SEL		125
> > +#define CLK_TOP_AUD_1_SEL		126
> > +#define CLK_TOP_AUD_2_SEL		127
> > +#define CLK_TOP_MEM_MFG_IN_AS_SEL	128
> > +#define CLK_TOP_AXI_MFG_IN_AS_SEL	129
> > +#define CLK_TOP_SCAM_SEL		130
> > +#define CLK_TOP_NFIECC_SEL		131
> > +#define CLK_TOP_PE2_MAC_P0_SEL		132
> > +#define CLK_TOP_PE2_MAC_P1_SEL		133
> > +#define CLK_TOP_DPILVDS_SEL		134
> > +#define CLK_TOP_MSDC50_3_HCLK_SEL	135
> > +#define CLK_TOP_HDCP_SEL		136
> > +#define CLK_TOP_HDCP_24M_SEL		137
> > +#define CLK_TOP_RTC_SEL			138
> > +#define CLK_TOP_SPINOR_SEL		139
> > +#define CLK_TOP_APLL_SEL		140
> > +#define CLK_TOP_APLL2_SEL		141
> > +#define CLK_TOP_A1SYS_HP_SEL		142
> > +#define CLK_TOP_A2SYS_HP_SEL		143
> > +#define CLK_TOP_ASM_L_SEL		144
> > +#define CLK_TOP_ASM_M_SEL		145
> > +#define CLK_TOP_ASM_H_SEL		146
> > +#define CLK_TOP_I2SO1_SEL		147
> > +#define CLK_TOP_I2SO2_SEL		148
> > +#define CLK_TOP_I2SO3_SEL		149
> > +#define CLK_TOP_TDMO0_SEL		150
> > +#define CLK_TOP_TDMO1_SEL		151
> > +#define CLK_TOP_I2SI1_SEL		152
> > +#define CLK_TOP_I2SI2_SEL		153
> > +#define CLK_TOP_I2SI3_SEL		154
> > +#define CLK_TOP_ETHER_125M_SEL		155
> > +#define CLK_TOP_ETHER_50M_SEL		156
> > +#define CLK_TOP_JPGDEC_SEL		157
> > +#define CLK_TOP_SPISLV_SEL		158
> > +#define CLK_TOP_ETHER_50M_RMII_SEL	159
> > +#define CLK_TOP_CAM2TG_SEL		160
> > +#define CLK_TOP_DI_SEL			161
> > +#define CLK_TOP_TVD_SEL			162
> > +#define CLK_TOP_I2C_SEL			163
> > +#define CLK_TOP_PWM_INFRA_SEL		164
> > +#define CLK_TOP_MSDC0P_AES_SEL		165
> > +#define CLK_TOP_CMSYS_SEL		166
> > +#define CLK_TOP_GCPU_SEL		167
> > +#define CLK_TOP_AUD_APLL1_SEL		168
> > +#define CLK_TOP_AUD_APLL2_SEL		169
> > +#define CLK_TOP_APLL1_REF_SEL		170
> > +#define CLK_TOP_APLL2_REF_SEL		171
> > +#define CLK_TOP_DA_AUDULL_VTX_6P5M_SEL	172
> > +#define CLK_TOP_APLL_DIV0		173
> > +#define CLK_TOP_APLL_DIV1		174
> > +#define CLK_TOP_APLL_DIV2		175
> > +#define CLK_TOP_APLL_DIV3		176
> > +#define CLK_TOP_APLL_DIV4		177
> > +#define CLK_TOP_APLL_DIV5		178
> > +#define CLK_TOP_APLL_DIV6		179
> > +#define CLK_TOP_APLL_DIV7		180
> > +#define CLK_TOP_APLL_DIV_PDN0		181
> > +#define CLK_TOP_APLL_DIV_PDN1		182
> > +#define CLK_TOP_APLL_DIV_PDN2		183
> > +#define CLK_TOP_APLL_DIV_PDN3		184
> > +#define CLK_TOP_APLL_DIV_PDN4		185
> > +#define CLK_TOP_APLL_DIV_PDN5		186
> > +#define CLK_TOP_APLL_DIV_PDN6		187
> > +#define CLK_TOP_APLL_DIV_PDN7		188
> > +#define CLK_TOP_NFI2X_EN		189
> > +#define CLK_TOP_NFIECC_EN		190
> > +#define CLK_TOP_NFI1X_CK_EN		191
> > +#define CLK_TOP_NR_CLK			192
> >  
> >  /* INFRACFG */
> >  
> > @@ -281,7 +287,9 @@
> >  #define CLK_PERI_MSDC30_3_EN		41
> >  #define CLK_PERI_MSDC50_0_HCLK_EN	42
> >  #define CLK_PERI_MSDC50_3_HCLK_EN	43
> > -#define CLK_PERI_NR_CLK			44
> > +#define CLK_PERI_MSDC30_0_QTR_EN	44
> > +#define CLK_PERI_MSDC30_3_QTR_EN	45
> > +#define CLK_PERI_NR_CLK			46
> >  
> >  /* MCUCFG */
> >  
> > -- 
> > 2.12.5
> > 
