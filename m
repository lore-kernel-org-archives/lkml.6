Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D958C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFE021570
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KnmY5lVT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CFgAcMxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFE021570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeHUO4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:56:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeHUO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:56:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F4E060D74; Tue, 21 Aug 2018 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534851392;
        bh=lYw5RVxzh/3+JaezK0xcdPpY4PFRHIfRVHY0NvN87CQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=KnmY5lVTjraFQoz3AiMcgs6kXqXosppfc4gR/Wczzsynq6eVFBvhRzKYLFgII6Uqm
         /xg710FdH2v8J4f+NAqlQOiB/AwuWUonSzbNTYykVqJa4t78Mt7Hn+z4JkL4k0KQbV
         eXFvRN/PdIJzwLj4rpRRSNMnLX/2+kj2Dl8YWNSs=
Received: from [192.168.225.247] (unknown [49.33.199.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52C936037C;
        Tue, 21 Aug 2018 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534851389;
        bh=lYw5RVxzh/3+JaezK0xcdPpY4PFRHIfRVHY0NvN87CQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=CFgAcMxGgJZ0dfvXeymahzRgfQlG1l3rR/3wguiCsglNxxdFU2xOonwh2ofOW41M2
         HeCw3rk1VA+yUODmymxCPPOc+nwxi9EXK2Xa/bQhhQdfM1QgL2YiE3SF3e14+wJgos
         XL7YKG6YWLqmxpWfnFkgY0ruvvMFCxJPtE+UtC6s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52C936037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 0/2] clk: qcom: Add support for RCG to register for DFS
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533952436-17221-1-git-send-email-tdas@codeaurora.org>
 <153455835372.28926.7641705907931269497@swboyd.mtv.corp.google.com>
 <693d9cf4-4a6f-feb5-0c3f-ded842bbdf0a@codeaurora.org>
Message-ID: <2db97037-b5f1-9234-862c-fa483b8aeb62@codeaurora.org>
Date:   Tue, 21 Aug 2018 17:06:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <693d9cf4-4a6f-feb5-0c3f-ded842bbdf0a@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the changes, I have tested the changes and would require the 
change mentioned below for this to work.

On 8/18/2018 11:31 PM, Taniya Das wrote:
> Hello Stephen,
> 
> I will test these changes and get back.
> 
> On 8/18/2018 7:42 AM, Stephen Boyd wrote:
>> Quoting Taniya Das (2018-08-10 18:53:54)
>>>   [v4]
>>>    * Add recalc_clk_ops to calculate the clock frequency reading the 
>>> current
>>>      perf state, also add CLK_GET_RATE_NOCACHE flag.
>>>    * Cleanup 'goto' during mode check in 'clk_rcg2_calculate_freq'.
>>>    * cleanup return from function 'com_cc_register_rcg_dfs'.
>>
>> I want to squash this in. I have only compile tested it. Let me know
>> what you think.
>>
>> ----8<---
>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>> index e6300e05d5df..e5eca8a1abe4 100644
>> --- a/drivers/clk/qcom/clk-rcg.h
>> +++ b/drivers/clk/qcom/clk-rcg.h
>> @@ -163,6 +163,15 @@ extern const struct clk_ops clk_pixel_ops;
>>   extern const struct clk_ops clk_gfx3d_ops;
>>   extern const struct clk_ops clk_rcg2_shared_ops;
>> +struct clk_rcg_dfs_data {
>> +    struct clk_rcg2 *rcg;
>> +    struct clk_init_data *init;
>> +};
>> +
>> +#define DEFINE_RCG_DFS(r) \
>> +    { .rcg = &r##_src, .init = &r##_init }
>> +
>>   extern int qcom_cc_register_rcg_dfs(struct regmap *regmap,
>> -                 struct clk_rcg2 **rcgs, int num_clks);
>> +                    const struct clk_rcg_dfs_data *rcgs,
>> +                    size_t len);
>>   #endif
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index 55a5b58cbb15..bbe2a1916296 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -1051,48 +1051,24 @@ static unsigned long
>>   clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>>   {
>>       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> -    u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask, level;
>> -    int num_parents, i;
>> -    unsigned long prate;
>> -
>> -    regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
>> -                SE_CMD_DFSR_OFFSET, &cfg);
>> -    level = (GENMASK(4, 1) & cfg) >> 1;
>> -
>> -    regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
>> -                SE_PERF_DFSR(level), &cfg);
>> -    if (rcg->mnd_width) {
>> -        mask = BIT(rcg->mnd_width) - 1;
>> -        regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
>> -                SE_PERF_M_DFSR(level), &m);
>> -        m &= mask;
>> -        regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
>> -                SE_PERF_N_DFSR(level), &n);
>> -        n =  ~n;
>> -        n &= mask;
>> -        n += m;
>> -        mode = cfg & CFG_MODE_MASK;
>> -        mode >>= CFG_MODE_SHIFT;
>> -    }
>> +    int ret;
>> +    u32 level;
>> -    mask = BIT(rcg->hid_width) - 1;
>> -    hid_div = cfg >> CFG_SRC_DIV_SHIFT;
>> -    hid_div &= mask;
>> -    cfg &= CFG_SRC_SEL_MASK;
>> -    cfg >>= CFG_SRC_SEL_SHIFT;
>> +    regmap_read(rcg->clkr.regmap,
>> +            rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET, &level);
>> +    level &= GENMASK(4, 1);
>> +    level >>= 1;
>> -    num_parents = clk_hw_get_num_parents(hw);
>> -    for (i = 0; i < num_parents; i++) {
>> -        if (cfg == rcg->parent_map[i].cfg) {
>> -            prate = clk_hw_get_rate(
>> -                clk_hw_get_parent_by_index(&rcg->clkr.hw, i));
>> -            if (parent_rate != prate)
>> -                parent_rate = prate;
>> +    if (!rcg->freq_tbl) {
>> +        ret = clk_rcg2_dfs_populate_freq_table(rcg);

This function would retrieve the parent_rate and if the parent_rate is 
not ready then it would fail to boot up.

So we have to make sure the parents are registered before these RCGs. 
That also was one reason for me to not populate the frequency table at 
recalc.

We would need this patch to make this work.

  /* GCC clock registers */
-#define GCC_AGGRE_NOC_PCIE_TBU_CLK                             0
-#define GCC_AGGRE_UFS_CARD_AXI_CLK                             1
-#define GCC_AGGRE_UFS_PHY_AXI_CLK                              2
-#define GCC_AGGRE_USB3_PRIM_AXI_CLK                            3
+#define GPLL0                                                  0
+#define GPLL0_OUT_EVEN                                         1
+#define GPLL0_OUT_MAIN                                         2
+#define GPLL4                                                  3
  #define GCC_AGGRE_USB3_SEC_AXI_CLK                             4
  #define GCC_BOOT_ROM_AHB_CLK                                   5
  #define GCC_CAMERA_AHB_CLK                                     6
@@ -172,9 +172,9 @@
  #define GCC_VIDEO_AHB_CLK                                      162
  #define GCC_VIDEO_AXI_CLK                                      163
  #define GCC_VIDEO_XO_CLK                                       164
-#define GPLL0                                                  165
-#define GPLL0_OUT_EVEN                                         166
-#define GPLL0_OUT_MAIN                                         167
+#define GCC_AGGRE_NOC_PCIE_TBU_CLK                             165
+#define GCC_AGGRE_UFS_CARD_AXI_CLK                             166
+#define GCC_AGGRE_UFS_PHY_AXI_CLK                              167
  #define GCC_GPU_IREF_CLK                                       168
  #define GCC_SDCC1_AHB_CLK                                      169
  #define GCC_SDCC1_APPS_CLK                                     170
@@ -191,7 +191,7 @@
  #define GCC_VS_CTRL_CLK                                        181
  #define GCC_VS_CTRL_CLK_SRC                                    182
  #define GCC_VSENSOR_CLK_SRC                                    183
-#define GPLL4                                                  184
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK                            184


>> +        if (ret) {
>> +            pr_err("Failed to update DFS tables for %s\n",
>> +                    clk_hw_get_name(hw));
>> +            return ret;
>>           }
>>       }
>> -
>> -    return calc_rate(parent_rate, m, n, mode, hid_div);
>> +    return rcg->freq_tbl[level].freq;
>>   }
>>   static const struct clk_ops clk_rcg2_dfs_ops = {
>> @@ -1102,9 +1078,11 @@ static const struct clk_ops clk_rcg2_dfs_ops = {
>>       .recalc_rate = clk_rcg2_dfs_recalc_rate,
>>   };
>> -static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct regmap 
>> *regmap)
>> +static int clk_rcg2_enable_dfs(const struct clk_rcg_dfs_data *data,
>> +                   struct regmap *regmap)
>>   {
>> -    struct clk_init_data *init;
>> +    struct clk_rcg2 *rcg = data->rcg;
>> +    struct clk_init_data *init = data->init;
>>       u32 val;
>>       int ret;
>> @@ -1116,18 +1094,13 @@ static int clk_rcg2_enable_dfs(struct clk_rcg2 
>> *rcg, struct regmap *regmap)
>>       if (!(val & SE_CMD_DFS_EN))
>>           return 0;
>> -    init = kzalloc(sizeof(*init), GFP_KERNEL);
>> -    if (!init)
>> -        return -ENOMEM;
>> -
>> -    init->name = rcg->clkr.hw.init->name;
>> -    init->flags = rcg->clkr.hw.init->flags;
>> -    init->parent_names = rcg->clkr.hw.init->parent_names;
>> -    init->num_parents = rcg->clkr.hw.init->num_parents;
>> -    init->flags = CLK_GET_RATE_NOCACHE;
>> +    /*
>> +     * Rate changes with consumer writing a register in
>> +     * their own I/O region
>> +     */
>> +    init->flags |= CLK_GET_RATE_NOCACHE;
>>       init->ops = &clk_rcg2_dfs_ops;
>> -    rcg->clkr.hw.init = init;
>>       rcg->freq_tbl = NULL;
>>       pr_debug("DFS registered for clk %s\n", init->name);
>> @@ -1136,14 +1109,14 @@ static int clk_rcg2_enable_dfs(struct clk_rcg2 
>> *rcg, struct regmap *regmap)
>>   }
>>   int qcom_cc_register_rcg_dfs(struct regmap *regmap,
>> -                struct clk_rcg2 **rcgs, int num_clks)
>> +                 const struct clk_rcg_dfs_data *rcgs, size_t len)
>>   {
>>       int i, ret;
>> -    for (i = 0; i < num_clks; i++) {
>> -        ret = clk_rcg2_enable_dfs(rcgs[i], regmap);
>> +    for (i = 0; i < len; i++) {
>> +        ret = clk_rcg2_enable_dfs(&rcgs[i], regmap);
>>           if (ret) {
>> -            const char *name = rcgs[i]->clkr.hw.init->name;
>> +            const char *name = rcgs[i].init->name;
>>               pr_err("DFS register failed for clk %s\n", name);
>>               return ret;
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c 
>> b/drivers/clk/qcom/gcc-sdm845.c
>> index fef6732bd7d8..42ab01d33b52 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -396,18 +396,27 @@ static const struct freq_tbl 
>> ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>>       { }
>>   };
>> +static struct clk_init_data gcc_qupv3_wrap0_s0_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s0_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>> +};
>> +
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
>>       .cmd_rcgr = 0x17034,
>>       .mnd_width = 16,
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s0_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s1_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s1_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
>> @@ -416,12 +425,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s1_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s1_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s2_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s2_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
>> @@ -430,12 +441,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s2_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s2_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s3_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s3_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
>> @@ -444,12 +457,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s3_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s3_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s4_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s4_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
>> @@ -458,12 +473,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s4_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s4_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s5_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s5_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
>> @@ -472,12 +489,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s5_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s5_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s6_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s6_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
>> @@ -486,12 +505,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s6_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s6_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s6_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap0_s7_clk_init = {
>> +    .name = "gcc_qupv3_wrap0_s7_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
>> @@ -500,12 +521,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap0_s7_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap0_s7_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap0_s7_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s0_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s0_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
>> @@ -514,12 +537,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s0_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s0_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s1_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s1_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
>> @@ -528,12 +553,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s1_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s1_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s2_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s2_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
>> @@ -542,12 +569,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s2_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s2_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s3_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s3_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
>> @@ -556,12 +585,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s3_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s3_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s4_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s4_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
>> @@ -570,12 +601,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s4_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s4_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s5_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s5_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
>> @@ -584,12 +617,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s5_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s5_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s6_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s6_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
>> @@ -598,12 +633,14 @@ static struct clk_rcg2 
>> gcc_qupv3_wrap1_s6_clk_src = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s6_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s6_clk_init,
>> +};
>> +
>> +static struct clk_init_data gcc_qupv3_wrap1_s7_clk_init = {
>> +    .name = "gcc_qupv3_wrap1_s7_clk_src",
>> +    .parent_names = gcc_parent_names_0,
>> +    .num_parents = 4,
>> +    .ops = &clk_rcg2_shared_ops,
>>   };
>>   static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
>> @@ -612,12 +649,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src 
>> = {
>>       .hid_width = 5,
>>       .parent_map = gcc_parent_map_0,
>>       .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -    .clkr.hw.init = &(struct clk_init_data){
>> -        .name = "gcc_qupv3_wrap1_s7_clk_src",
>> -        .parent_names = gcc_parent_names_0,
>> -        .num_parents = 4,
>> -        .ops = &clk_rcg2_shared_ops,
>> -    },
>> +    .clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_init,
>>   };
>>   static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>> @@ -3458,23 +3490,23 @@ static const struct of_device_id 
>> gcc_sdm845_match_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
>> -static struct clk_rcg2 *gcc_dfs_clocks[] = {
>> -    &gcc_qupv3_wrap0_s0_clk_src,
>> -    &gcc_qupv3_wrap0_s1_clk_src,
>> -    &gcc_qupv3_wrap0_s2_clk_src,
>> -    &gcc_qupv3_wrap0_s3_clk_src,
>> -    &gcc_qupv3_wrap0_s4_clk_src,
>> -    &gcc_qupv3_wrap0_s5_clk_src,
>> -    &gcc_qupv3_wrap0_s6_clk_src,
>> -    &gcc_qupv3_wrap0_s7_clk_src,
>> -    &gcc_qupv3_wrap1_s0_clk_src,
>> -    &gcc_qupv3_wrap1_s1_clk_src,
>> -    &gcc_qupv3_wrap1_s2_clk_src,
>> -    &gcc_qupv3_wrap1_s3_clk_src,
>> -    &gcc_qupv3_wrap1_s4_clk_src,
>> -    &gcc_qupv3_wrap1_s5_clk_src,
>> -    &gcc_qupv3_wrap1_s6_clk_src,
>> -    &gcc_qupv3_wrap1_s7_clk_src,
>> +static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s0_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s1_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s2_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s3_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s4_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s5_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s6_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap0_s7_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s0_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s1_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s2_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s3_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s4_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s5_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s6_clk),
>> +    DEFINE_RCG_DFS(gcc_qupv3_wrap1_s7_clk),
>>   };
>>   static int gcc_sdm845_probe(struct platform_device *pdev)
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
