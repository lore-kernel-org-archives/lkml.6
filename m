Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE8BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D68C218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kncOjfiN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m5UG2fOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbeLULTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:19:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbeLULTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:19:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9586560909; Fri, 21 Dec 2018 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545391183;
        bh=EoRquBr4Hj2je3Da64uLThh3DoJ/cG7aKPuvTCCA/KQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kncOjfiNBgQz7n39Z8c9gAzngtx1pi/3vudJ1p9KewXkW8+iDXthf1QC148dRpsW0
         a9mTrQWX2hZ2AaLCqpDNdmJdNx9em163TWv5ZXJmbcG8qFKFWduHEx9qykLzkSsWOF
         mAk34WPJMRGOUDnt6IQG6Q/WS6WtvX9tAR/V3wJA=
Received: from [192.168.225.247] (unknown [49.32.154.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20E5360208;
        Fri, 21 Dec 2018 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545391182;
        bh=EoRquBr4Hj2je3Da64uLThh3DoJ/cG7aKPuvTCCA/KQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m5UG2fOjzR2K5QntPkAGuknOl7Ye0fV8uYoaCvcivDenci76IdrMHgkIMVH8a8rql
         +cS5ot6V4/sxbfauUOe/dni8FIFvA4kM9/vcPj9SxPp/MlaLbhdf7QfHsKqv+6l78g
         moA6sE1BYXC+fOne/mnJImufSIM5RogxK1fvrSmo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E5360208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
Date:   Fri, 21 Dec 2018 16:49:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> specifications.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>   drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index 64da032..833436a 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
>   	},
>   };
>   
> +static const struct pll_vco gpll0_ao_out_vco[] = {
> +	{ 800000000, 800000000, 0 },
> +};
> +
>   static struct clk_alpha_pll gpll0_ao_out_main = {
>   	.offset = 0x21000,
>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>   	.flags = SUPPORTS_FSM_MODE,
> +	.vco_table = gpll0_ao_out_vco,
> +	.num_vco = ARRAY_SIZE(gpll0_ao_out_vco),

Could you please help as to why this is required? This is a fixed PLL 
and we do not require a VCO table for it.

>   	.clkr = {
>   		.enable_reg = 0x45000,
>   		.enable_mask = BIT(0),
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
