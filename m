Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DAF20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DAF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK3WFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:05:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:5471 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbeK3WFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:05:06 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id CA0F313F8CF;
        Fri, 30 Nov 2018 11:55:49 +0100 (CET)
Subject: Re: [PATCH 2/3] clk: qcom: gcc-msm8998: Disable halt check of UFS
 clocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-3-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <273c0544-bf33-fe66-ac42-ad17ea3038d1@free.fr>
Date:   Fri, 30 Nov 2018 11:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130065259.26497-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 07:52, Bjorn Andersson wrote:

> Drop the halt check of the UFS symbol clocks, in accordance with other
> platforms. This makes clk_disable_unused() happy and makes it possible
> to turn the clocks on again without an error.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gcc-msm8998.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index d89f8e7c2a59..3d232d266d72 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2403,7 +2403,7 @@ static struct clk_branch gcc_ufs_phy_aux_clk = {
>  
>  static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
>  	.halt_reg = 0x75014,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x75014,
>  		.enable_mask = BIT(0),
> @@ -2416,7 +2416,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
>  
>  static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
>  	.halt_reg = 0x7605c,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x7605c,
>  		.enable_mask = BIT(0),
> @@ -2429,7 +2429,7 @@ static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
>  
>  static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
>  	.halt_reg = 0x75010,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x75010,
>  		.enable_mask = BIT(0),

FWIW, before applying your patch, the kernel printed the following
warnings at boot:

[    1.820756] gcc_ufs_rx_symbol_1_clk status stuck at 'on'
[    1.992977] gcc_ufs_rx_symbol_0_clk status stuck at 'on'
[    2.165113] gcc_gpu_bimc_gfx_clk status stuck at 'on'

https://lore.kernel.org/linux-clk/f4271471-b60a-f056-b453-1cfa593a0fc4@free.fr/

(NB: gcc_ufs_tx_symbol_0_clk not mentioned)

Your patch makes the two ufs_rx warnings go away.

Regards.
