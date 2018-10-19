Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D735FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9235C20836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n+jkcLBu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U7b/wv9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9235C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJSShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:37:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:37:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D5B46072E; Fri, 19 Oct 2018 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539945104;
        bh=tUVezTZQsvr881Rr+mkrb4w5+CNIGkTh9nL7djg78ms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n+jkcLBut+Fz5AKjTQdB2lXP6hsracpD6BKntnaEk7dOLpC5yoc0rQo0TpIuOcG64
         xayE7DnsV3mFKVIQv5+htBugJAEcje8rhHrLvSCn6Ulu1fYF8wiA87TCYGc5zezM77
         aykY0AKQgJ5pHooNm5wmzewnakld0ah6JUWQZ/0U=
Received: from [192.168.225.247] (unknown [49.32.117.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FDCD60351;
        Fri, 19 Oct 2018 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539945103;
        bh=tUVezTZQsvr881Rr+mkrb4w5+CNIGkTh9nL7djg78ms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U7b/wv9PmlCxtbw/xNmmknAO/mFCPYr54S+mz2QBdBDbRy9lPCUcK81n/pXQFQLDU
         RdlxxMDIDyoQHGbDL/edzxYGmilUoFhiHU0B4KkrSHmG0H3hewPF+uqUuOrBQ2FZgP
         jsqKPZ9px6OMyLXeL5HWuhHmgPrYq07hgv9Ye6dk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FDCD60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 1/2] clk: qcom: rcg2: Add support for display port
 clock ops
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-2-git-send-email-tdas@codeaurora.org>
 <153911799897.119890.15102407227774253910@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <02289ba9-a528-02e8-df25-892ccfd0f9bf@codeaurora.org>
Date:   Fri, 19 Oct 2018 16:01:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153911799897.119890.15102407227774253910@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 10/10/2018 2:16 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-09 06:57:46)
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index 6e3bd19..ca6142f 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/export.h>
>>   #include <linux/clk-provider.h>
>>   #include <linux/delay.h>
>> +#include <linux/rational.h>
> 
> Can you also select RATIONAL in the Kconfig language? Yes the clk
> subsystem is already selecting it, but it's nice to be explicit in the
> subdrivers.
> 

Sure, would take care of adding it in KCONFIG.

>>   #include <linux/regmap.h>
>>   #include <linux/math64.h>
>>   #include <linux/slab.h>
>> @@ -1124,3 +1125,88 @@ int qcom_cc_register_rcg_dfs(struct regmap *regmap,
>>          return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
>> +
>> +static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                       unsigned long parent_rate)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       struct freq_tbl f = { 0 };
>> +       unsigned long src_rate;
>> +       unsigned long num, den;
>> +       u32 mask = BIT(rcg->hid_width) - 1;
>> +       u32 hid_div, cfg;
>> +       int i, num_parents = clk_hw_get_num_parents(hw);
>> +
>> +       src_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
> 
> What is this doing? We shouldn't need to check the parent clk for any
> rate here when we're setting the rate.
> 

Hmmm, let me get back on this.

>> +       if (src_rate <= 0) {
>> +               pr_err("Invalid RCG parent rate\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       rational_best_approximation(src_rate, rate,
>> +                       (unsigned long)(1 << 16) - 1,
> 
> Use GENMASK?
> 
>> +                       (unsigned long)(1 << 16) - 1, &den, &num);
> 
> Same? >

Sure, would use GENMASK.

>> +
>> +       if (!num || !den) {
>> +               pr_err("Invalid MN values derived for requested rate %lu\n",
>> +                                                       rate);
>> +               return -EINVAL;
>> +       }
>> +
>> +       regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
>> +       hid_div = cfg;
>> +       cfg &= CFG_SRC_SEL_MASK;
>> +       cfg >>= CFG_SRC_SEL_SHIFT;
>> +
>> +       for (i = 0; i < num_parents; i++)
>> +               if (cfg == rcg->parent_map[i].cfg) {
>> +                       f.src = rcg->parent_map[i].src;
>> +                       break;
>> +       }
>> +
>> +       f.pre_div = hid_div;
>> +       f.pre_div >>= CFG_SRC_DIV_SHIFT;
>> +       f.pre_div &= mask;
>> +
>> +       if (num == den) {
>> +               f.m = 0;
>> +               f.n = 0;
>> +       } else {
>> +               f.m = num;
>> +               f.n = den;
>> +       }
>> +
>> +       return clk_rcg2_configure(rcg, &f);
>> +}
>> +
>> +static int clk_rcg2_dp_set_rate_and_parent(struct clk_hw *hw,
>> +               unsigned long rate, unsigned long parent_rate, u8 index)
>> +{
>> +       return clk_rcg2_dp_set_rate(hw, rate, parent_rate);
>> +}
>> +
>> +static int clk_rcg2_dp_determine_rate(struct clk_hw *hw,
>> +                               struct clk_rate_request *req)
>> +{
>> +       if (!hw)
>> +               return -EINVAL;
>> +
>> +       if (!clk_hw_get_parent(hw)) {
>> +               pr_err("Missing the parent for the DP RCG\n");
>> +               return -EINVAL;
>> +       }
> 
> Let me Harry Potter this stuff. Expelliarmus!
> 
>> +
>> +       req->best_parent_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
> 
> Presumably we should ask the parent clk for the rate that is requested
> here by calling determine rate up and see if the parent can do it. Sure,
> this clk does nothing, so we don't really need any sort of op here then
> and we can just flag the clk as CLK_SET_RATE_PARENT and let the core do
> the rest.
> 
>> +       return 0;
>> +}
>> +

Would remove this.

>> +const struct clk_ops clk_dp_ops = {
>> +       .is_enabled = clk_rcg2_is_enabled,
>> +       .get_parent = clk_rcg2_get_parent,
>> +       .set_parent = clk_rcg2_set_parent,
>> +       .recalc_rate = clk_rcg2_recalc_rate,
>> +       .set_rate = clk_rcg2_dp_set_rate,
>> +       .set_rate_and_parent = clk_rcg2_dp_set_rate_and_parent,
>> +       .determine_rate = clk_rcg2_dp_determine_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_dp_ops);

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
