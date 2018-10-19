Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67702ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2253E20836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ikHdpRIF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pNnZIFJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2253E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJSSjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:39:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49912 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeJSSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:39:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F50A60316; Fri, 19 Oct 2018 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539945261;
        bh=+4DunBQtDui6Lhs61OL2zalUAYAUoNDF+1OTGzEFxiE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ikHdpRIFeuRUFTFBsWF+bFF1sPn6TllO/xYb5fvsQYHxIXfMpe0Ddi9NdDCcfU+yA
         3QgsHSGbGd0IesEAi3ZvPHFHvAgJN8eph/7yoFKhdCHoNMmAPxGCy+2ZQ4pOT7Oy9x
         WR6/Z+s6a+PhMuFP0FElav/7i12wcT6gYeO/gqFU=
Received: from [192.168.225.247] (unknown [49.32.117.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B266960316;
        Fri, 19 Oct 2018 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539945260;
        bh=+4DunBQtDui6Lhs61OL2zalUAYAUoNDF+1OTGzEFxiE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pNnZIFJVnWrBuJVSHz16qs1TM7kfYlL9RHdIsKcV+HQQ44nHOFSpvGu3OborkNhMM
         9ZaE07MA9iMjZwGoZbdz7eC10/KiCOpQcCxsCSc+M0YNRrejrLtLmOASdW1iBQaP2r
         MUHoGXL3wWurCrOMK3tJOqFj535vnm53LsL7nvRg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B266960316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port
 clocks
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
Date:   Fri, 19 Oct 2018 16:04:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 10/10/2018 2:04 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-09 06:57:47)
>> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
>> index 0cc4909..6d3136a 100644
>> --- a/drivers/clk/qcom/dispcc-sdm845.c
>> +++ b/drivers/clk/qcom/dispcc-sdm845.c
>> @@ -128,6 +144,100 @@ enum {
>>          },
>>   };
>>
>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_aux_clk_src[] = {
>> +       F(19200000, P_BI_TCXO, 1, 0, 0),
>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
>> +       .cmd_rcgr = 0x219c,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_2,
>> +       .freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "disp_cc_mdss_dp_aux_clk_src",
>> +               .parent_names = disp_cc_parent_names_2,
>> +               .num_parents = 2,
>> +               .flags = CLK_SET_RATE_PARENT,
>> +               .ops = &clk_rcg2_ops,
>> +       },
>> +};
>> +
>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_crypto_clk_src[] = {
>> +       F(108000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
>> +       F(180000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
>> +       F(360000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
>> +       .cmd_rcgr = 0x2154,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_1,
>> +       .freq_tbl = ftbl_disp_cc_mdss_dp_crypto_clk_src,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "disp_cc_mdss_dp_crypto_clk_src",
>> +               .parent_names = disp_cc_parent_names_1,
>> +               .num_parents = 4,
>> +               .flags = CLK_GET_RATE_NOCACHE,
> 
> Why?
> 
>> +               .ops = &clk_rcg2_ops,
>> +       },
>> +};
>> +
>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] = {
>> +       F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> +       F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> +       F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> 
> Are these in kHz? They really look like it and that's bad. Why do we
> need them at all? Just to make sure the display driver picks these exact
> frequencies? It seems like we could just pass whatever number comes in
> up to the parent and see what it can do.
> 

Let me check back the reason we had to make this change.

>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
>> +       .cmd_rcgr = 0x2138,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_1,
>> +       .freq_tbl = ftbl_disp_cc_mdss_dp_link_clk_src,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "disp_cc_mdss_dp_link_clk_src",
>> +               .parent_names = disp_cc_parent_names_1,
>> +               .num_parents = 4,
>> +               .flags = CLK_SET_RATE_PARENT,
>> +               .ops = &clk_rcg2_ops,
>> +       },
>> +};
>> +
>> +static struct clk_rcg2 disp_cc_mdss_dp_pixel1_clk_src = {
>> +       .cmd_rcgr = 0x2184,
>> +       .mnd_width = 16,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_1,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "disp_cc_mdss_dp_pixel1_clk_src",
>> +               .parent_names = disp_cc_parent_names_1,
>> +               .num_parents = 4,
>> +               .flags = CLK_SET_RATE_PARENT,
>> +               .ops = &clk_dp_ops,
>> +       },
>> +};
>> +
>> +static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
>> +       .cmd_rcgr = 0x216c,
>> +       .mnd_width = 16,
>> +       .hid_width = 5,
>> +       .parent_map = disp_cc_parent_map_1,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "disp_cc_mdss_dp_pixel_clk_src",
>> +               .parent_names = disp_cc_parent_names_1,
>> +               .num_parents = 4,
>> +               .flags = CLK_SET_RATE_PARENT,
>> +               .ops = &clk_dp_ops,
>> +       },
>> +};
>> +
>>   static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] = {
>>          F(19200000, P_BI_TCXO, 1, 0, 0),
>>          { }
>> @@ -391,6 +501,115 @@ enum {
>>          },
>>   };
>>
>> +static struct clk_branch disp_cc_mdss_dp_aux_clk = {
>> +       .halt_reg = 0x2054,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x2054,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "disp_cc_mdss_dp_aux_clk",
>> +                       .parent_names = (const char *[]){
>> +                               "disp_cc_mdss_dp_aux_clk_src",
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch disp_cc_mdss_dp_crypto_clk = {
>> +       .halt_reg = 0x2048,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x2048,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "disp_cc_mdss_dp_crypto_clk",
>> +                       .parent_names = (const char *[]){
>> +                               "disp_cc_mdss_dp_crypto_clk_src",
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch disp_cc_mdss_dp_link_clk = {
>> +       .halt_reg = 0x2040,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x2040,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "disp_cc_mdss_dp_link_clk",
>> +                       .parent_names = (const char *[]){
>> +                               "disp_cc_mdss_dp_link_clk_src",
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +/* reset state of disp_cc_mdss_dp_link_div_clk_src divider is 0x3 (div 4) */
> 
> Not sure what this comment is for. But it's interesting nonetheless.
> 
>> +static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
>> +       .halt_reg = 0x2044,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x2044,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "disp_cc_mdss_dp_link_intf_clk",
>> +                       .parent_names = (const char *[]){
>> +                               "disp_cc_mdss_dp_link_clk_src",
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_GET_RATE_NOCACHE,
> 
> Why?
> 

It was a requirement, but let me get back on this too.

>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
