Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC2ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFD121479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YuWftbhB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AIwj7pZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFD121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJJAot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:44:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJJAot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:44:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D870C60BFA; Tue,  9 Oct 2018 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539106007;
        bh=yIV8hU/6HN8K79p4PamdNMet+LwRCL4Sfns+H5y4I+c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YuWftbhB+XMLi0fhKbSWFBWnRjHVLqqtFYu5K9pnlXjz4MTvneCdcOo4+/FHqVaKL
         uMDUuKQucsGvJXOUTlU6GhzWaglTP2XViDqo8J+aADOW8ElDLbJq5TC+iXYPS01NtM
         JyEBs/eq1/mMVJZ0dYN/j52piJMJhB+Fc4SQWb9g=
Received: from [192.168.225.247] (unknown [49.32.123.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EFB3600C1;
        Tue,  9 Oct 2018 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539106006;
        bh=yIV8hU/6HN8K79p4PamdNMet+LwRCL4Sfns+H5y4I+c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AIwj7pZtbXblQtS3MfT1CfZOTRHTav6y9rx6D25WVsvtWcs2w7vfCwpSWl6FtPxwN
         Rgz2hWJ1aqLqAV69B0bN1SLGUwyeIn3WJCldto0gRYVgrD5stvYhlajo017yrVsSm3
         k9U88bVD+a6StBLs5fCPBMSXmyNqozF1OxibTLzQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EFB3600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
 <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
Date:   Tue, 9 Oct 2018 22:56:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 10/8/2018 8:14 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-04 05:02:26)
>> Add support for the lpass clock controller found on SDM845 based devices.
>> This would allow lpass peripheral loader drivers to control the clocks to
>> bring the subsystem out of reset.
>> LPASS clocks present on the global clock controller would be registered
>> with the clock framework based on the device tree flag. Also do not gate
>> these clocks if they are left unused.
> 
> Why not gate them? This statement states what the code is doing, not why
> it's doing it which is the more crucial information that should be
> described in the commit text. Also, please add a comment about it to the
> code next to the flag.
> 
> I am concerned that it doesn't make any sense though, so probably it
> shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over some
> other larger bug that needs to be fixed.
> 

It does not have any bug, it is just that to access these lpass 
registers we would need the GCC lpass registers to be enabled. I would 
update the same in the commit text.

During clock late_init these clocks should not be accessed to check the 
clock status as they would result in unclocked access. The client would 
request these clocks in the correct order and it would not have any issue.


>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> index 08d593e..6379b8b 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -3169,6 +3169,32 @@ enum {
>>          },
>>   };
>>
>> +static struct clk_branch gcc_lpass_q6_axi_clk = {
>> +       .halt_reg = 0x47000,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x47000,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_lpass_q6_axi_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch gcc_lpass_sway_clk = {
>> +       .halt_reg = 0x47008,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x47008,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_lpass_sway_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>>   static struct gdsc pcie_0_gdsc = {
>>          .gdscr = 0x6b004,
>>          .pd = {
>> @@ -3469,6 +3495,8 @@ enum {
>>          [GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
>>          [GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
>>          [GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
>> +       [GCC_LPASS_Q6_AXI_CLK] = NULL,
>> +       [GCC_LPASS_SWAY_CLK] = NULL,
>>   };
>>
>>   static const struct qcom_reset_map gcc_sdm845_resets[] = {
>> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>
>> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protected")) {
>> +               gcc_sdm845_clocks[GCC_LPASS_Q6_AXI_CLK] =
>> +                       &gcc_lpass_q6_axi_clk.clkr;
>> +               gcc_sdm845_clocks[GCC_LPASS_SWAY_CLK] =
>> +                       &gcc_lpass_sway_clk.clkr;
>> +       }
>> +
>>          return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>>   }
>>
>> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
>> new file mode 100644
>> index 0000000..f7b9b0f
>> --- /dev/null
>> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/bitops.h>
> 
> Is this needed?
> 

Would check this.

>> +/* CLK_OFF would not toggle until LPASS is not out of reset */
>> +static struct clk_branch lpass_qdsp6ss_xo_clk = {
>> +       .halt_reg = 0x38,
>> +       .halt_check = BRANCH_HALT_SKIP,
>> +       .clkr = {
>> +               .enable_reg = 0x38,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_qdsp6ss_xo_clk",
>> +                       .flags = CLK_IGNORE_UNUSED,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +/* CLK_OFF would not toggle until LPASS is not out of reset */
> 
> Move this comment next to BRANCH_HALT_SKIP please so we know what it
> relates to.
> 

Sure would take care in the next patch.

>> +static struct clk_branch lpass_qdsp6ss_sleep_clk = {
>> +       .halt_reg = 0x3c,
>> +       .halt_check = BRANCH_HALT_SKIP,
>> +       .clkr = {
>> +               .enable_reg = 0x3c,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_qdsp6ss_sleep_clk",
>> +                       .flags = CLK_IGNORE_UNUSED,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static int lpass_clocks_sdm845_probe(struct platform_device *pdev, int index,
>> +                                    const struct qcom_cc_desc *desc)
>> +{
>> +       struct regmap *regmap;
>> +       struct resource *res;
>> +       void __iomem *base;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>> +       base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
> 
> If this happens again in the future we should move this into the
> common.c file and let qcom_cc_probe_index() exist.
> 

Yes, I agree, could submit a patch to add the new function and then 
clean it up.

>> +
>> +       return qcom_cc_really_probe(pdev, desc, regmap);
>> +}
>> +
>> +/* LPASS CC clock controller */
> 
> Please remove this comment. It's useless.
> 

Would take care in the next patch.

>> +static const struct of_device_id lpass_cc_sdm845_match_table[] = {
>> +       { .compatible = "qcom,sdm845-lpasscc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
