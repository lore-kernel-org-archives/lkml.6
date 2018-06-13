Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CD37AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BAE208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CjOh1xGC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QQGW97nX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BAE208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbeFMJTM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:19:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934563AbeFMJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:19:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CCCB4600D0; Wed, 13 Jun 2018 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528881547;
        bh=h48vvuLQJ6w68CAT8XPweNEBAsGYCMWd1LFKu8b53u4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CjOh1xGCpCiIpzAC4U0Li2n/N0XDLZR1S86GxH1xhrTz74q1Czbq+aHm5Iin/j5O0
         8I4LMbinoFB32Xar2UEN4eXEGjLEVfaRv607afATLZ4ShKUUtYrZFxozCXigLCX3QK
         /ExvT6PsjmUmuWSc/eCoY4OemAtVxM7L5CPo3scw=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D1ED6022C;
        Wed, 13 Jun 2018 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528881545;
        bh=h48vvuLQJ6w68CAT8XPweNEBAsGYCMWd1LFKu8b53u4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QQGW97nXIywHBBFmsNPZJC6hdFuhUclQn3Ylw2OGvgJV8pC0RazLig8EmqjJlYxRn
         32vqJuyJs/nFVxiMn+h0XRs7hGoRZfMps751L3fzo+Jdmh4PTMkbAum6tRqDxxaO31
         snD8qq6BacoCrtE6P25rYEoapP0UGHIA3EeDGVOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D1ED6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] clk: qcom: Add display clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
 <1528098985-3676-3-git-send-email-tdas@codeaurora.org>
 <152879014163.16708.9093599796057889104@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a397c3f9-1e4e-b6db-299b-0ecfd1726226@codeaurora.org>
Date:   Wed, 13 Jun 2018 14:48:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152879014163.16708.9093599796057889104@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for review.

On 6/12/2018 1:25 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-06-04 00:56:25)
>> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
>> new file mode 100644
>> index 0000000..317ab33
>> --- /dev/null
>> +++ b/drivers/clk/qcom/dispcc-sdm845.c
>> @@ -0,0 +1,679 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-pll.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
> 
> Used?
>
Unused ones I would clean up.

>> +#include "common.h"
>> +#include "gdsc.h"
>> +#include "reset.h"
>> +
>> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> 
> We really need to move this into the header file.
> 
> $ git grep '#define F(' -- drivers/clk/qcom/ | wc -l
> 13
> 
Sure, will move this in a header and submit the patch.

>> +
> [...]
>> +static const char * const disp_cc_parent_names_4[] = {
>> +       "bi_tcxo",
>> +       "dsi0_phy_pll_out_dsiclk",
>> +       "dsi1_phy_pll_out_dsiclk",
>> +       "core_bi_pll_test_se",
>> +};
>> +
>> +static const struct alpha_pll_config disp_cc_pll0_config = {
>> +       .l = 0x2c,
>> +       .alpha = 0xcaaa,
>> +};
> 
> Any reason this can't be put on the stack in the probe function?
> 
I would move it.
>> +
>> +static struct clk_alpha_pll disp_cc_pll0 = {
>> +       .offset = 0x0,
>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
>> +       .clkr = {
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "disp_cc_pll0",
>> +                       .parent_names = (const char *[]){ "bi_tcxo" },
>> +                       .num_parents = 1,
>> +                       .ops = &clk_alpha_pll_fabia_ops,
>> +               },
>> +       },
>> +};
> [...]
>> +
>> +static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
>> +       .cmd_rcgr = 0x2058,
>> +       .mnd_width = 8,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_4,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "disp_cc_mdss_pclk0_clk_src",
>> +               .parent_names = disp_cc_parent_names_4,
>> +               .num_parents = 4,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> 
> Why is the nocache flag needed? Applies to all clks in this file.
> 

This flag is required for all RCGs whose PLLs are controlled outside the 
clock controller. The display code would require the recalculated rate 
always.

>> +               .ops = &clk_pixel_ops,
>> +       },
>> +};
>> +
>> +static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
>> +       .cmd_rcgr = 0x2070,
>> +       .mnd_width = 8,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_4,
>> +       .clkr.hw.init = &(struct clk_init_data){
> [...]
>> +
>> +static const struct regmap_config disp_cc_sdm845_regmap_config = {
>> +       .reg_bits       = 32,
>> +       .reg_stride     = 4,
>> +       .val_bits       = 32,
>> +       .max_register   = 0x10000,
> 
> This seems arbitrarily large. List the actual end?
> 
The actual end is larger than this :( , I have listed the range till the 
register offset are used here.

>> +       .fast_io        = true,
>> +};
>> +
>> +static const struct qcom_cc_desc disp_cc_sdm845_desc = {
>> +       .config = &disp_cc_sdm845_regmap_config,
>> +       .clks = disp_cc_sdm845_clocks,
>> +       .num_clks = ARRAY_SIZE(disp_cc_sdm845_clocks),
>> +       .resets = disp_cc_sdm845_resets,
>> +       .num_resets = ARRAY_SIZE(disp_cc_sdm845_resets),
>> +       .gdscs = disp_cc_sdm845_gdscs,
>> +       .num_gdscs = ARRAY_SIZE(disp_cc_sdm845_gdscs),
>> +};
>> +
>> +static const struct of_device_id disp_cc_sdm845_match_table[] = {
>> +       { .compatible = "qcom,sdm845-dispcc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, disp_cc_sdm845_match_table);
>> +
>> +static int disp_cc_sdm845_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = qcom_cc_map(pdev, &disp_cc_sdm845_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_fabia_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
>> +
>> +       /* Enable clock gating for DSI and MDP clocks */
> 
> Hardware clock gating? What does this mean.
> 
These are used for deciding whether to enable HW based Clock gating or 
not. Setting these bit will enable HW based Clock gating.

>> +       regmap_update_bits(regmap, 0x8000, 0x7f0, 0x7f0);
>> +
>> +       return qcom_cc_really_probe(pdev, &disp_cc_sdm845_desc, regmap);
>> +}

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
