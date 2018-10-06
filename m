Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33543C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C823020645
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A+RCvhD8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M16sHt4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C823020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJGAxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:53:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJGAxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:53:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79FC06031A; Sat,  6 Oct 2018 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538848173;
        bh=Usc5zJvnBi7LVdCRSU2DsRFv76QwjOrq1u4Hq6IAeKY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A+RCvhD8KWTq01UH2x0lmvn8Tz6SfP+YkDZASslE/m80ALcJPu47HL5Jn5qGPgmPF
         7UlJWaCfBymGoeTIdBV+389hdIzNes8oG0/RKrRxsBzYqTEKlicMWWjj/RIvLJqPzR
         j73ql3EHQ4aT028xOENLvTdSmLzAXM/VsODcoR1c=
Received: from [192.168.225.247] (unknown [49.32.125.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34594600E6;
        Sat,  6 Oct 2018 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538848172;
        bh=Usc5zJvnBi7LVdCRSU2DsRFv76QwjOrq1u4Hq6IAeKY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M16sHt4TcQaPkwbZhxzJnpUP3kkyFw7g+JVt+lzraHuyhtTDGGZ9X2t23+Rx+nz2Z
         BLn+0KBPYWaVwocrO/9QeoFvFkzwvxoQPVOTkgtv5VJbWax2sQ+O3fU2/w4OkY1uQJ
         9GDuPeVlN8Tt8HBM4VZdJ7+FUNrRzft6Wz3Iu8Bc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34594600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver
 for QCS404
To:     Vinod <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
References: <20180921185936.9590-1-vkoul@kernel.org>
 <20180921185936.9590-2-vkoul@kernel.org>
 <153841434099.119890.3912925112860077471@swboyd.mtv.corp.google.com>
 <20181003062103.GN19792@vkoul-mobl>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <6986bbb2-eb89-7758-7fac-d8ac79da55ec@codeaurora.org>
Date:   Sat, 6 Oct 2018 23:19:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003062103.GN19792@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinod,

On 10/3/2018 11:51 AM, Vinod wrote:
> Hi Stephen,
> 
> Thanks for the comments,
> 
> On 01-10-18, 10:19, Stephen Boyd wrote:
>> Quoting Vinod Koul (2018-09-21 11:59:36)
>>> From: Shefali Jain <shefjain@codeaurora.org>
>>>
>>> Add the clocks supported in global clock controller which clock the
>>> peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
>>> to the clock framework for the clients to be able to request for them.
>>>
>>> Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>> Co-developed-by: Taniya Das <tdas@codeaurora.org>
>>> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
>>> [rebase and tidyup for upstream]
>>
>> Who did the tidying?
> 
> both of us :)
> 
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> ---
>>>   - reg : shall contain base register location and length
>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>> index 064768699fe7..529d84cc7503 100644
>>> --- a/drivers/clk/qcom/Kconfig
>>> +++ b/drivers/clk/qcom/Kconfig
>>> @@ -235,6 +235,14 @@ config MSM_GCC_8998
>>>            Say Y if you want to use peripheral devices such as UART, SPI,
>>>            i2c, USB, UFS, SD/eMMC, PCIe, etc.
>>>   
>>> +config QCS_GCC_404
>>> +       tristate "QCS404 Global Clock Controller"
>>> +       depends on COMMON_CLK_QCOM
>>> +       help
>>> +        Support for the global clock controller on QCS404 devices.
>>> +        Say Y if you want to use peripheral devices such as UART, SPI, I2C,
>>> +        USB, SD/eMMC, PCIe, etc.
>>
>> It seems to include multimedia display clks and ethernet? Maybe include
>> those too.
> 
> Sure will add
> 
>>> +#include <linux/kernel.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/clk.h>
>>
>> Please don't include this.
> 
> OK will check if this is required, any reason for not including this?
> 
>>> +/* 930MHz configuration */
>>> +static const struct alpha_pll_config gpll3_config = {
>>> +       .l = 48,
>>> +       .alpha = 0x0,
>>> +       .alpha_en_mask = BIT(24),
>>> +       .post_div_mask = 0xf << 8,
>>> +       .post_div_val = 0x1 << 8,
>>> +       .vco_mask = 0x3 << 20,
>>> +       .main_output_mask = 0x1,
>>> +       .config_ctl_val = 0x4001055b,
>>> +};
>>> +
>>> +static struct pll_vco gpll3_vco[] = {
>>
>> const?
> 
> sure
> 
>>> +static struct clk_branch gcc_pwm1_xo512_clk = {
>>> +       .halt_reg = 0x49004,
>>> +       .halt_check = BRANCH_HALT,
>>> +       .clkr = {
>>> +               .enable_reg = 0x49004,
>>> +               .enable_mask = BIT(0),
>>> +               .hw.init = &(struct clk_init_data){
>>> +                       .name = "gcc_pwm1_xo512_clk",
>>> +                       .ops = &clk_branch2_ops,
>>
>> Do these pwm clks have a parent clk of the XO?
> 
> Yes they do
> 

We do not need to specify the parent here.

>>> +       [GCC_USB_HS_PHY_CFG_AHB_CLK] = &gcc_usb_hs_phy_cfg_ahb_clk.clkr,
>>> +       [GCC_USB_HS_SYSTEM_CLK] = &gcc_usb_hs_system_clk.clkr,
>>> +       [GFX3D_CLK_SRC] = &gfx3d_clk_src.clkr,
>>> +       [GP1_CLK_SRC] = &gp1_clk_src.clkr,
>>
>> Why are some of these missing GCC_ prefix?
> 
> will add..
> 

These clocks in HW plans do not have GCC prefixed, so it better to leave 
them as they are represented in the HW.

>>> +static int gcc_qcs404_probe(struct platform_device *pdev)
>>> +{
>>> +       struct regmap *regmap;
>>> +       int ret;
>>> +
>>> +       ret = qcom_cc_register_board_clk(&pdev->dev,
>>> +                                        "xo_board", "cxo", 19200000);
>>
>> You shouldn't need to do this. This function is for transitioning DT
>> that doesn't have the board clk in DT to something the driver wants to
>> use, in this case "cxo". So you can either register a fixed factor 1/1
>> clk to do the translation between board and cxo names, or use xo_board
>> as the parent of things that can take crystal.
> 
> Okay will modify this. If I go about using xo_board as parent, I would
> need to register that right? FWIW I see the same thing done in gcc-msm8916
> 

As Stephen suggested it should be defined in DT till we use the 
clk-smd-rpm.c.

>>
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       regmap = qcom_cc_map(pdev, &gcc_qcs404_desc);
>>> +       if (IS_ERR(regmap))
>>> +               return PTR_ERR(regmap);
>>> +
>>> +       clk_alpha_pll_configure(&gpll3_out_main, regmap, &gpll3_config);
>>> +       clk_set_rate(apss_ahb_clk_src.clkr.hw.clk, 19200000);
>>
>> use assigned clock rates from DT please.
> 
> ok
> 
>>> +       clk_prepare_enable(apss_ahb_clk_src.clkr.hw.clk);
>>> +       clk_prepare_enable(gpll0_ao_out_main.clkr.hw.clk);
>>
>> And these should be marked as critical clocks.
> 
> Okay and how do we go about doing that?
> 
>>> +#define GCC_USB2A_PHY_SLEEP_CLK                                89
>>> +#define GCC_USB30_MASTER_CLK                           90
>>> +#define GCC_USB30_MOCK_UTMI_CLK                                91
>>> +#define gcc_usb30_sleep_clk                            92
>>> +#define gcc_usb3_phy_aux_clk                           93
>>> +#define gcc_usb3_phy_pipe_clk                          94
>>> +#define gcc_usb_hs_phy_cfg_ahb_clk                     95
>>> +#define gcc_usb_hs_system_clk                          96
>>> +#define gfx3d_clk_src                                  97
>>> +#define gp1_clk_src                                    98
>>> +#define gp2_clk_src                                    99
>>> +#define gp3_clk_src                                    100
>>> +#define gpll0_out_main                                 101
>>> +#define gpll1_out_main                                 102
>>> +#define gpll3_out_main                                 103
>>> +#define gpll4_out_main                                 104
>>> +#define hdmi_app_clk_src                               105
>>> +#define hdmi_pclk_clk_src                              106
>>> +#define mdp_clk_src                                    107
>>> +#define pcie_0_aux_clk_src                             108
>>> +#define pcie_0_pipe_clk_src                            109
>>> +#define pclk0_clk_src                                  110
>>> +#define pdm2_clk_src                                   111
>>> +#define sdcc1_apps_clk_src                             112
>>> +#define sdcc1_ice_core_clk_src                         113
>>> +#define sdcc2_apps_clk_src                             114
>>> +#define usb20_mock_utmi_clk_src                                115
>>> +#define usb30_master_clk_src                           116
>>> +#define usb30_mock_utmi_clk_src                                117
>>> +#define usb3_phy_aux_clk_src                           118
>>> +#define usb_hs_system_clk_src                          119
>>> +#define gpll0_ao_clk_src                               120
>>> +#define wcnss_m_clk                                    121
>>> +#define gcc_usb_hs_inactivity_timers_clk               122
>>
>> Please capitalize all these macros.
> 
> Will do
> 
>>> +#define GCC_GENI_IR_BCR                                        0
>>> +#define GCC_USB_HS_BCR                                 1
>>> +#define GCC_USB2_HS_PHY_ONLY_BCR                       2
>>> +#define GCC_QUSB2_PHY_BCR                              3
>>> +#define GCC_USB_HS_PHY_CFG_AHB_BCR                     4
>>> +#define GCC_USB2A_PHY_BCR                              5
>>> +#define GCC_USB3_PHY_BCR                               6
>>> +#define GCC_USB_30_BCR                                 7
>>> +#define GCC_USB3PHY_PHY_BCR                            8
>>> +#define GCC_PCIE_0_BCR                                 9
>>> +#define GCC_PCIE_0_PHY_BCR                             10
>>> +#define GCC_PCIE_0_LINK_DOWN_BCR                       11
>>> +#define GCC_PCIEPHY_0_PHY_BCR                          12
>>> +#define GCC_EMAC_BCR                                   13
>>
>> No GDSCs? Ok.
> 
> Downstream doesn't seem to have one, will recheck specs.
>

Downstream uses different way to handle GDSC, there are 2 GDSCs which 
have to be added 1 for MDSS and 1 OXILI_GX.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
