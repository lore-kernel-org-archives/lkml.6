Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA03C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FFA20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZCNC4k5w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T2nzPXhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FFA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLAF3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:29:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeLAF3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:29:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29F5060B13; Fri, 30 Nov 2018 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543601963;
        bh=smBoCsiIiy8PAWOULwRH82fVryuhvNoMF/mFvis5m8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZCNC4k5wnimL4cS92fwO0bpRTMrD6TFNGg6k9nLvvWqPjMkIxDvQbvLm9iu2QjpK1
         nxdGmQlfIvBwOwIqk+3reGKcY7KgYPX7ixxJdXiiUVw/Ai7Qt7YSwRFSkkCyrtMrGg
         Pk9LcH8pfaEsmwVdgjRsQoApkpn4DA2XwVPSXAYg=
Received: from [192.168.225.247] (unknown [49.33.181.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25FC76021A;
        Fri, 30 Nov 2018 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543601962;
        bh=smBoCsiIiy8PAWOULwRH82fVryuhvNoMF/mFvis5m8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T2nzPXhyWwMAzygX0DBZoY2NNwalR1MwjBZo8Y4hh6lcBkDZ6Up+w1XstHcDkb17s
         wxEv2MxnUMw2OYHU6Z6XsOTs7iVtfbSoiwEb219CzPq+cRXEPhjOwAyVvX1jSXsWZH
         eh8KTJCbi95+sSRE5CjhZa58XdpyScR1CS4uGfoI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25FC76021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v10 3/3] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
 <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
 <154343944180.88331.8662440760190505722@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <700cd5de-d826-4315-d879-d2ae7ed08262@codeaurora.org>
Date:   Fri, 30 Nov 2018 23:49:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154343944180.88331.8662440760190505722@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 11/29/2018 2:40 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-21 23:53:41)
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> index f133b7f..ba8ff99 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -3153,6 +3153,34 @@ enum {
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
>> +                       .flags = CLK_IS_CRITICAL,
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
>> +                       .flags = CLK_IS_CRITICAL,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>>   static struct gdsc pcie_0_gdsc = {
>>          .gdscr = 0x6b004,
>>          .pd = {
>> @@ -3453,6 +3481,8 @@ enum {
>>          [GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
>>          [GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
>>          [GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
>> +       [GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
>> +       [GCC_LPASS_SWAY_CLK] = &gcc_lpass_sway_clk.clkr,
> 
> I have one single idea to avoid the integration nightmare with dts
> needing another update for this on platforms where these can't be
> touched. It's not perfect, but we can throw these clks and usage of the
> clks behind an #ifdef CONFIG_SDM_LPASSCC_845 and then let the dts parts
> match up with the clk driver parts in linux-next. After everything is
> merged together, someone can turn on the knobs for LPASS clk controller
> and make sure they have the right dts bits to mark them as protected.
> 

Sure, would keep it under the ifdefer and would clean it up later.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
