Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B97CC0044B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245BA21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dK2inTUB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dK2inTUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245BA21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeKKL7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:59:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeKKL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:59:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 86ED16032C; Sun, 11 Nov 2018 02:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541902357;
        bh=ScJh1Bzt8HJtqg1fnx7Dsp+0kE8Rq8drSe8ehyywDu8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dK2inTUBQSB051OhVTS1VYdwVJQ9XGq2sziOVyV2Eh2vZjn82G+2Uhc7H4ZLHNnh5
         bVu1PB/g6nZpFNpYHFJ6CerPeYq5juDvm2cOWMO2dgA594iXm8rlFO11jUkT/7m3mw
         p+Ga8v+ikUb9fFmFd7f9unVt9oZB8dnpRv9AIOAw=
Received: from [10.79.174.32] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6944601D7;
        Sun, 11 Nov 2018 02:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541902357;
        bh=ScJh1Bzt8HJtqg1fnx7Dsp+0kE8Rq8drSe8ehyywDu8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dK2inTUBQSB051OhVTS1VYdwVJQ9XGq2sziOVyV2Eh2vZjn82G+2Uhc7H4ZLHNnh5
         bVu1PB/g6nZpFNpYHFJ6CerPeYq5juDvm2cOWMO2dgA594iXm8rlFO11jUkT/7m3mw
         p+Ga8v+ikUb9fFmFd7f9unVt9oZB8dnpRv9AIOAw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6944601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH] clk: qcom: gcc: Fix board clock node name
To:     Vinod Koul <vkoul@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181109095054.13924-1-vkoul@kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <c3bf03cd-ef87-a005-8536-d8739f53f2a5@codeaurora.org>
Date:   Sun, 11 Nov 2018 07:42:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181109095054.13924-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinod,

On 11/9/2018 3:20 PM, Vinod Koul wrote:
> Device tree node name are not supposed to have "_" in them so fix the
> node name use of xo_board to xo-board
> 
> Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Steve: RobH pointed this on DTS patches, would be great if you can pick this
> as a fix
> 
>   drivers/clk/qcom/gcc-qcs404.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index e4ca6a45f313..ef1b267cb058 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -265,7 +265,7 @@ static struct clk_fixed_factor cxo = {
>   	.div = 1,
>   	.hw.init = &(struct clk_init_data){
>   		.name = "cxo",
> -		.parent_names = (const char *[]){ "xo_board" },
> +		.parent_names = (const char *[]){ "xo-board" },
>   		.num_parents = 1,
>   		.ops = &clk_fixed_factor_ops,
>   	},
> 

This fixed clock needs to be removed, once the RPM<->SMD clocks are 
added. Why not have this clock part of the device Tree?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
