Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F582ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A68F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FCfUEFuq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R4X6r5qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A68F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeGPGCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:02:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeGPGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:02:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD826607B9; Mon, 16 Jul 2018 05:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531719426;
        bh=ui64SlTA3mNDs2yGpdGMcJpses8g3/8SvrU/NbyBv2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FCfUEFuqrZlenuT1sPZVtVM8vMaAVPkoLfKxqXuGfn333xJ3j7j97NlUZq/2HjlZc
         rS2qaljCMkm+Q1XQcuNsp2AMK3BHe1uKikPH29vGJvghNeZ4G4Fn1mWJ6rztF2w9oO
         dWs/fy6JmtmQLT2TOJe0nO70cxbXth1wQwMVKVeY=
Received: from [10.79.169.10] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C54F607DC;
        Mon, 16 Jul 2018 05:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531719425;
        bh=ui64SlTA3mNDs2yGpdGMcJpses8g3/8SvrU/NbyBv2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R4X6r5qTZd/cgHgrNmMBSYLx2s3AMAJQ0n3sFK4xexNBBeRrASa1QubkoCI3xdEUX
         PeHPADC+SoGRmDOdC6TTv2muFgr3E8yU+y3S3KoWPR6Zn4Nqab6CEA3wVMFxZol5Vz
         vyXzBsfzNDxYQvWaP7i0gseEKiMcOb4THZIXFhkM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C54F607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 1/2] clk: qcom: Add support for RCG to register for DFS
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
 <1530186451-24648-2-git-send-email-tdas@codeaurora.org>
 <153111984699.143105.18327452281843047622@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <8fda4c13-3930-3cbb-30bf-66cd4a5418ca@codeaurora.org>
Date:   Mon, 16 Jul 2018 11:06:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153111984699.143105.18327452281843047622@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for your review comments.

On 7/9/2018 12:34 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-06-28 04:47:30)
>> Dynamic Frequency switch is a feature of clock controller by which request
>> from peripherals allows automatic switching frequency of input clock.
>> There are various performance levels associated to a root clock generator.
>> Register the root clock generators(RCG) to switch to use the dfs clock ops
>> in the cases where DFS is enabled.
>> The DFS clock ops would at runtime read the clock perf level registers to
>> identify the frequencies supported and update the frequency table
>> accordingly.
> 
> But nobody is really using the frequency table except for
> clk_round_rate()? Can you add some comments into the commit text and the
> code indicating how it works in hardware? I think the way it works is by
> having DFS enabled in the clock controller, and then another register in
> the QUP register space controls the index that the clk configures itself
> for. But I'm not clear on if the RCG registers are updated when DFS
> frequency is set, or if anything is visible from the clk controller
> hardware besides being in DFS mode and the frequency plan.
> 
>>
Sure, added few more details in the next series.

>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index 52208d4..25b0560 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -929,3 +938,208 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
>>          .set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
>>   };
>>   EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
>> +
>> +/* Common APIs to be used for DFS based RCGR */
>> +static int clk_rcg2_calculate_m_and_n(struct clk_hw *hw, u32 *mode,
>> +               unsigned long *prate, int level, struct freq_tbl *f)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       struct clk_hw *phw;
> 
> Just 'p' for parent is good.
> 

Taken care in the next patch.

>> +       u32 val, mask, cfg, m_off, n_off, offset;
>> +       int i, ret, num_parents;
>> +
>> +       offset = SE_PERF_DFSR(level);
>> +       ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cfg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mask = BIT(rcg->hid_width) - 1;
>> +       f->pre_div = cfg & mask ? (cfg & mask) : 1;
>> +
>> +       *mode = cfg & CFG_MODE_MASK;
>> +       *mode >>= CFG_MODE_SHIFT;
>> +
>> +       cfg &= CFG_SRC_SEL_MASK;
>> +       cfg >>= CFG_SRC_SEL_SHIFT;
>> +
>> +       num_parents = clk_hw_get_num_parents(hw);
>> +       for (i = 0; i < num_parents; i++) {
>> +               if (cfg == rcg->parent_map[i].cfg) {
>> +                       f->src = rcg->parent_map[i].src;
>> +                       phw = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
>> +                       *prate = clk_hw_get_rate(phw);
>> +               }
>> +       }
>> +
>> +       if (!*mode)
>> +               return 0;
>> +
>> +       /* Calculate M & N values */
>> +       m_off = SE_PERF_M_DFSR(level);
>> +       n_off = SE_PERF_N_DFSR(level);
>> +
>> +       mask = BIT(rcg->mnd_width) - 1;
>> +       ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_off, &val);
> 
> Why weird space before regmap_read?
> 

removed.

>> +       if (ret) {
>> +               pr_err("Failed to read M offset register\n");
>> +               return ret;
>> +       }
>> +       val &= mask;
>> +       f->m  = val;
>> +
>> +       ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_off, &val);
>> +       if (ret) {
>> +               pr_err("Failed to read N offset register\n");
>> +               return ret;
>> +       }
>> +       /* val ~(N-M) */
>> +       val = ~val;
>> +       val &= mask;
>> +       val += f->m;
>> +       f->n = val;
>> +
>> +       return 0;
>> +}
>> +
>> +static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
>> +{
>> +       struct freq_tbl *dfs_freq_tbl;
>> +       int i, j, ret = 0;
>> +       unsigned long calc_freq, prate = 0;
>> +       u32 mode = 0;
>> +
>> +       dfs_freq_tbl = kcalloc(MAX_PERF_LEVEL, sizeof(struct freq_tbl),
> 
> sizeof(*dfs_freq_tbl) or just call it freq_tbl. We know it's dfs
> already.
> 

Fixed in the next patch.

>> +                               GFP_KERNEL);
>> +       if (!dfs_freq_tbl)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < MAX_PERF_LEVEL; i++) {
>> +               ret = clk_rcg2_calculate_m_and_n(&rcg->clkr.hw, &mode, &prate,
>> +                                                i, &dfs_freq_tbl[i]);
> 
> Why can't this function return the frequency? Or 0 if it failed for some
> reason?
> 

Sure, have taken care in the next patch.

>> +               if (ret) {
>> +                       kfree(dfs_freq_tbl);
>> +                       return ret;
>> +               }
>> +
>> +               calc_freq = calc_rate(prate, dfs_freq_tbl[i].m,
>> +                                       dfs_freq_tbl[i].n, mode,
>> +                                       dfs_freq_tbl[i].pre_div);
> 
> Because this is not so good looking.
> 
>> +               /* Check for duplicate frequencies to end table */
>> +               for (j = 0; j  < i; j++) {
> 
> Duplicate space after j here should be cleaned up.
> 
>> +                       if (dfs_freq_tbl[j].freq == calc_freq)
> 
> Is it sometimes a duplicate frequency that came earlier in the table?
> Why isn't this just a check for the same frequency in succession while
> going through the table? Or even a frequency that's lower than the
> previous one?
> 

I was trimming the table based on the last frequencies, say we have 
multiple 19.2MHz calculated at the end, so I was trimming the table, but 
I don't think it is really required. So I have removed this logic.
>> +                               goto done;
>> +               }
>> +
>> +               dfs_freq_tbl[i].freq = calc_freq;
>> +       }
>> +done:
>> +       rcg->freq_tbl = dfs_freq_tbl;
>> +
>> +       return 0;
>> +}
>> +
>> +static int clk_rcg2_dfs_determine_rate(struct clk_hw *hw,
>> +                                  struct clk_rate_request *req)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       int ret;
>> +
>> +       if (rcg->freq_tbl == NULL) {
> 
> if (!rcg->freq_tbl) is preferred style.
> 
>> +               ret = clk_rcg2_dfs_populate_freq_table(rcg);
>> +               if (ret) {
>> +                       pr_err("Failed to update DFS tables\n");
> 
> Also print the clk name? Who knows which one this happens for otherwise.
> 

Taken care in the next patch.

>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       return clk_rcg2_shared_ops.determine_rate(hw, req);
>> +}
>> +
>> +static int clk_rcg2_dfs_set_rate(struct clk_hw *hw, unsigned long rate,
> 
> We can't set the rate?
>

No, if it is DFS mode, SW would not be allowed to update the RCG.
I have removed the set_rate in the next series.

>> +                                   unsigned long prate)
>> +{
>> +       return 0;
>> +}
>> +
>> +static unsigned long
>> +clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> 
> Huh? How will we know what frequency the clk is running at? We can't?
> 
> Why are these even implemented then? Just implement determine_rate() op
> so that clk_round_rate() can be called in a loop to figure out the
> frequency plan index? Or if the registers are actually updated when QUP
> asks for an index, then recalc_rate() should be implemented and the
> nocache flag should be added to the clk so we know to recalculate each
> time clk_get_rate() is called.
> 

No, we can't read any registers to know the frequency at which the clock
is running. I have removed this too in the next series.
>> +{
>> +       return 0;
>> +}
>> +
>> +const struct clk_ops clk_rcg2_dfs_ops = {
> 
> static?
>
Done.

>> +       .is_enabled = clk_rcg2_is_enabled,
>> +       .get_parent = clk_rcg2_get_parent,
>> +       .recalc_rate = clk_rcg2_dfs_recalc_rate,
>> +       .determine_rate = clk_rcg2_dfs_determine_rate,
>> +       .set_rate = clk_rcg2_dfs_set_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_rcg2_dfs_ops);
>> +
>> +static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct device *dev)
>> +{
>> +       struct regmap *regmap;
>> +       struct clk_init_data *init;
>> +       struct clk_rate_request req = { };
>> +       u32 val;
>> +       int ret;
>> +
>> +       regmap = dev_get_regmap(dev, NULL);
>> +       if (!regmap)
>> +               return -EINVAL;
>> +
>> +       init = kzalloc(sizeof(struct clk_init_data), GFP_KERNEL);
> 
> Use sizeof(*init) so type doesn't matter.
> 
Done.

>> +       if (!init)
>> +               return -ENOMEM;
>> +
>> +       init->name = rcg->clkr.hw.init->name;
>> +       init->ops = &clk_rcg2_shared_ops;
> 
> These should already be done statically.
> 
>> +       init->flags = rcg->clkr.hw.init->flags;
>> +       init->parent_names = rcg->clkr.hw.init->parent_names;
>> +       init->num_parents = rcg->clkr.hw.init->num_parents;
>> +       rcg->clkr.hw.init = init;
> 
> In fact, the whole init structure should just be whatever is there
> already.
>
I would override it now, only if DFS ops is required.

>> +
>> +       ret = regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
>> +                         &val);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to read DFS enable register\n");
> 
> For which clk? And do we even care? The regmap_read most likely never
> fails.
> 
Removed the print.

>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!(val & SE_CMD_DFS_EN))
>> +               return 0;
>> +
>> +       init->ops = &clk_rcg2_dfs_ops;
>> +       rcg->clkr.hw.init = init;
> 
> The clks were already registered. I don't know how this works.
> 
Yes, it worked and it updated the ops.

>> +       rcg->freq_tbl = NULL;
>> +
>> +       /*
>> +        * In case the clocks are registered earlier than determine the dfs
>> +        * rates.
>> +        */
>> +       if (__clk_lookup(rcg->clkr.hw.init->name))
>> +               return clk_rcg2_dfs_determine_rate(&rcg->clkr.hw, &req);
> 
> Remove this. Do the DFS enabled probing before registering the clks.
> 
Removed.
>> +
>> +       return 0;
>> +}
>> +
>> +int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
> 
> Please don't pass the device. Pass the regmap.
> 
>> +                           struct clk_rcg2 **rcgs, int num_clks)
>> +{
>> +       int i, ret = 0;
>> +
>> +       for (i = 0; i < num_clks; i++) {
>> +               ret = clk_rcg2_enable_dfs(rcgs[i], &pdev->dev);
>> +               if (ret) {
>> +                       const char *name = rcgs[i]->clkr.hw.init->name;
>> +
>> +                       dev_err(&pdev->dev,
>> +                               "%s DFS frequencies update failed\n", name);
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
> 
>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>> index 39ce64c..958d27c 100644
>> --- a/drivers/clk/qcom/common.c
>> +++ b/drivers/clk/qcom/common.c
>> @@ -1,15 +1,5 @@
>> -/*
>> - * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
>> - *
>> - * This software is licensed under the terms of the GNU General Public
>> - * License version 2, as published by the Free Software Foundation, and
>> - * may be copied, distributed, and modified under those terms.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved. */
>>
>>   #include <linux/export.h>
>>   #include <linux/module.h>
>> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
>> index 00196ee..52d2dce 100644
>> --- a/drivers/clk/qcom/common.h
>> +++ b/drivers/clk/qcom/common.h
>> @@ -1,15 +1,6 @@
>> -/*
>> - * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>> - *
>> - * This software is licensed under the terms of the GNU General Public
>> - * License version 2, as published by the Free Software Foundation, and
>> - * may be copied, distributed, and modified under those terms.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - */
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2014, 2018, The Linux Foundation. All rights reserved. */
>> +
> 
> Can you split these last two file hunks into another patch to update
> common for SPDX? I can apply that without anything else.
> 

Removed these patches.

>>   #ifndef __QCOM_CLK_COMMON_H__
>>   #define __QCOM_CLK_COMMON_H__
>>
>> @@ -68,5 +59,4 @@ extern int qcom_cc_really_probe(struct platform_device *pdev,
>>                                  struct regmap *regmap);
>>   extern int qcom_cc_probe(struct platform_device *pdev,
>>                           const struct qcom_cc_desc *desc);
>> -
> 
> No.
> 
>>   #endif
>> --

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
