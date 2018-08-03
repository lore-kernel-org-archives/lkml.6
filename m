Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D338121759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FRIsYpN2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dqfeAr+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D338121759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeHCOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:15:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeHCOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:15:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45422602B7; Fri,  3 Aug 2018 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298776;
        bh=fJnXav+vAq1geqokStin2eIbWr/vfDAtZGRgB2SYVuc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FRIsYpN27C0VqTWPysT1rUEa1gk6nRrsD1wTtoPqih5mkSkUBQ/LcbwrboCGWkFds
         6tyCviBaNRBTo5ijCzRFpsiK1oj7r8RWRNu/GFupzKodIPTjXyaWYBqvncTI1/rK1x
         FwqjX/zlbADAi/Jcq46dOcmBMCE4uijEIwfYYAto=
Received: from [192.168.225.247] (unknown [49.32.113.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5388602D7;
        Fri,  3 Aug 2018 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298775;
        bh=fJnXav+vAq1geqokStin2eIbWr/vfDAtZGRgB2SYVuc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dqfeAr+45A4yShxKehn43+hAHBdlrancAgpTN9QbiyHbNznBZvNK/uCO8TgDHtuDg
         MUBi5amOLdvNr/M9FgB8pKh/sPGJc/Yb6z6OmJB7C4rr5MsHahLhoTuajek7yMMWzl
         lY9AI2t9Rr8D3fGzesVMr8koIP+E8h7vEsa2niyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5388602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 2/2] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org
References: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
 <1530773721-14668-3-git-send-email-tdas@codeaurora.org>
 <153092037708.143105.10977459810239534218@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <6ef09f88-b497-79ec-cdac-b6440abe017d@codeaurora.org>
Date:   Fri, 3 Aug 2018 17:49:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153092037708.143105.10977459810239534218@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2018 5:09 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-04 23:55:21)
>> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
>> new file mode 100644
>> index 0000000..5285b26
>> --- /dev/null
>> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
>> @@ -0,0 +1,243 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,lpass-sdm845.h>
>> +
>> +#include "clk-regmap.h"
>> +#include "clk-branch.h"
>> +#include "common.h"
>> +
>> +static struct clk_branch gcc_lpass_q6_axi_clk = {
>> +       .halt_reg = 0x0,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x0,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_lpass_q6_axi_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch gcc_lpass_sway_clk = {
>> +       .halt_reg = 0x8,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x8,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_lpass_sway_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +

Moved the above clocks to GCC driver.

>> +static struct clk_branch lpass_audio_wrapper_aon_clk = {
>> +       .halt_reg = 0x098,
>> +       .halt_check = BRANCH_VOTED,
>> +       .clkr = {
>> +               .enable_reg = 0x098,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_audio_wrapper_aon_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch lpass_q6ss_ahbm_aon_clk = {
>> +       .halt_reg = 0x12000,
>> +       .halt_check = BRANCH_VOTED,
> 
> I'll take your word for it.
> 
>> +       .clkr = {
>> +               .enable_reg = 0x12000,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_q6ss_ahbm_aon_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch lpass_q6ss_ahbs_aon_clk = {
>> +       .halt_reg = 0x1f000,
>> +       .halt_check = BRANCH_VOTED,
>> +       .clkr = {
>> +               .enable_reg = 0x1f000,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_q6ss_ahbs_aon_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch lpass_qdsp6ss_xo_clk = {
>> +       .halt_reg = 0x18,
>> +       .halt_check = BRANCH_HALT_SKIP,
> 
> Why? Hint, add a comment.
> 

Added a comment in the next patch.

>> +       .clkr = {
>> +               .enable_reg = 0x18,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_qdsp6ss_xo_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch lpass_qdsp6ss_sleep_clk = {
>> +       .halt_reg = 0x1c,
>> +       .halt_check = BRANCH_HALT_SKIP,
> 
> Why? Hint, add a comment.

Added a comment in the next patch.

> 
>> +       .clkr = {
>> +               .enable_reg = 0x1c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_qdsp6ss_sleep_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch lpass_qdsp6ss_core_clk = {
>> +       .halt_reg = 0x0,
>> +       .halt_check = BRANCH_HALT_SKIP,
> 
> Again.
> 

Added a comment in the next patch.

>> +       .clkr = {
>> +               .enable_reg = 0x0,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_qdsp6ss_core_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct regmap_config lpass_regmap_config = {
>> +       .reg_bits       = 32,
>> +       .reg_stride     = 4,
>> +       .val_bits       = 32,
>> +       .fast_io        = true,
>> +};
>> +
>> +static struct clk_regmap *lpass_gcc_sdm845_clocks[] = {
>> +       [GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
>> +       [GCC_LPASS_SWAY_CLK] = &gcc_lpass_sway_clk.clkr,
>> +};
>> +
>> +static const struct qcom_cc_desc lpass_gcc_sdm845_desc = {
>> +       .config = &lpass_regmap_config,
>> +       .clks = lpass_gcc_sdm845_clocks,
>> +       .num_clks = ARRAY_SIZE(lpass_gcc_sdm845_clocks),
>> +};
>> +
>> +static struct clk_regmap *lpass_cc_sdm845_clocks[] = {
>> +       [LPASS_AUDIO_WRAPPER_AON_CLK] = &lpass_audio_wrapper_aon_clk.clkr,
>> +       [LPASS_Q6SS_AHBM_AON_CLK] = &lpass_q6ss_ahbm_aon_clk.clkr,
>> +       [LPASS_Q6SS_AHBS_AON_CLK] = &lpass_q6ss_ahbs_aon_clk.clkr,
> 
> So it's kinda sad that these lists have holes in them and we just waste
> space forever the more we add. How about using the same linear array,
> but indexing into the array with different offsets based on the start of
> the numberspace for those clks? It would mean that adding new clks
> wouldn't work, so add all the clks now instead of later.
> 

There are no more clocks from these CCs which would be required to be 
controlled. These are only required for the Low Pass Audio subsystem to 
be brought out of reset.

> Otherwise, maybe we need to add support for qcom_cc_desc having two
> cells and then indicating which first cell to map into? So the binding
> would look like:
> 
> 	<&lpasscc 0 GCC_LPASS_Q6_AXI_CLK>
> 
> 	<&lpasscc 1 LPASS_Q6SS_AHBM_AON_CLK>
> 
> and our lookup function would need to be different for the multi-cell
> thing, but otherwise works and avoids the hole and adding numbers later
> problem.
> 
>> +};
>> +
>> +static const struct qcom_cc_desc lpass_cc_sdm845_desc = {
>> +       .config = &lpass_regmap_config,
>> +       .clks = lpass_cc_sdm845_clocks,
>> +       .num_clks = ARRAY_SIZE(lpass_cc_sdm845_clocks),
>> +};
>> +
>> +static struct clk_regmap *lpass_qdsp6ss_sdm845_clocks[] = {
>> +       [LPASS_QDSP6SS_XO_CLK] = &lpass_qdsp6ss_xo_clk.clkr,
>> +       [LPASS_QDSP6SS_SLEEP_CLK] = &lpass_qdsp6ss_sleep_clk.clkr,
>> +       [LPASS_QDSP6SS_CORE_CLK] = &lpass_qdsp6ss_core_clk.clkr,
>> +};
>> +
>> +static const struct qcom_cc_desc lpass_qdsp6ss_sdm845_desc = {
>> +       .config = &lpass_regmap_config,
>> +       .clks = lpass_qdsp6ss_sdm845_clocks,
>> +       .num_clks = ARRAY_SIZE(lpass_qdsp6ss_sdm845_clocks),
>> +};
>> +
>> +static int lpass_clocks_sdm845_probe(struct platform_device *pdev, int index,
>> +                                    const struct qcom_cc_desc *desc)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct regmap *regmap;
>> +       struct resource res;
>> +       void __iomem *base;
>> +
>> +       if (of_address_to_resource(np, index, &res))
> 
> Just use platform device APIs instead please.
> 

I have moved to use the platform device APIs.

>> +               return -ENOMEM;
>> +
>> +       base = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
> 
> And devm_ioremap_resource().

Use the above API to map.

> 
>> +       if (IS_ERR(base))
>> +               return -ENOMEM;
>> +
>> +       regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       return qcom_cc_really_probe(pdev, desc, regmap);
>> +}
>> +
>> +/* LPASS CC clock controller */
>> +static const struct of_device_id lpass_cc_sdm845_match_table[] = {
>> +       { .compatible = "qcom,sdm845-lpasscc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
>> +
>> +static int lpass_cc_sdm845_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_cc_desc *desc;
>> +       struct device_node *np;
>> +       int ret, index;
>> +
>> +       np = pdev->dev.of_node;
>> +
>> +       lpass_regmap_config.name = "lpass_gcc";
>> +       desc = &lpass_gcc_sdm845_desc;
>> +       index = of_property_match_string(np, "reg-names", "lpass_gcc");
>> +
>> +       ret = lpass_clocks_sdm845_probe(pdev, index, desc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       lpass_regmap_config.name = "lpass_cc";
>> +       desc = &lpass_cc_sdm845_desc;
>> +       index = of_property_match_string(np, "reg-names", "lpass_cc");
>> +
>> +       ret = lpass_clocks_sdm845_probe(pdev, index, desc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       lpass_regmap_config.name = "lpass_qdsp6ss";
>> +       desc = &lpass_qdsp6ss_sdm845_desc;
>> +       index = of_property_match_string(np, "reg-names", "lpass_qdsp6ss");
> 
> We shouldn't need to do this. Just index them by number and specify that
> the order has to be exactly that order. reg-names is supposed to be
> optional.
> 

Have fixed the index in the next patch.

>> +
>> +       ret = lpass_clocks_sdm845_probe(pdev, index, desc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
> 
> Just 'return lpass_clocks_sdm845_probe()'.
> 

removed the check for ret.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
