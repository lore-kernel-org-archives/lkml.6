Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB9AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4931720854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8/50S7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4931720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeGVMgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 08:36:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40234 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbeGVMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 08:36:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so13394573edq.7;
        Sun, 22 Jul 2018 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5spZOMYua9sGxCp1yE9KP5VJwcI58nX2fI0A7a1bTg=;
        b=h8/50S7F86e39liMubTsvMBg7zJLwxxyEp4JZ3MjfmvIr4zvpdiFdIH/ucWWUWawRT
         UimzWdzZmwlvuF/q5EYa9qOBYWnyLJ94uUwaEcNBVrHdl0xc/zIBcYIgf8xsd7foGMk/
         dvSw1sNHRD2NQnlDmt9Vj8AJOepZciIuEszomIyyPZ0lr0YdzsbfLxtRYFNaxWT+Iw9a
         9oqZCzlcGxxRc8ruMfeccw87RxzORiVBhczjcyIrA5YiRvG1C3CMuB1Dwco8WRBoawxh
         WancogA7vZ1toI84mPrEo3+omOOvEvcgNaQCjWccx2TUU3Vq0cabjHyygS1UAYJDJ6Gn
         beWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5spZOMYua9sGxCp1yE9KP5VJwcI58nX2fI0A7a1bTg=;
        b=W2XEFSdgqR7TYWJX2Pek9ljqTdk6GS0cTVfoN6+V0/XccR9NJJm7Ab+0UF68G/OGpo
         nkvI0B9oZHShVZX/N+zre7Wwi9fESbAVmVKRmmeert8cmtxGjUiO6Vgx6Sr2n7qnvJfs
         yWNAewqbwZL8YNbe0j7H9cbkqHRT4F/p7Ic7Nl79NdU1mWE2/9XLO4hFQAxzbvA/MaXP
         BF1G1IzPVy2rEXS6Yl29EkS6d8WCxZCsyQJ7ogUhGkqb5oeeB6wTrezrJTtCffFJF7rZ
         wbxNZ3BOymJujks7uFflVWF7J62jTJ9+6nrUhGBgi9j8a1aTIVLWQFgUNxyNySLrUWXC
         53pA==
X-Gm-Message-State: AOUpUlHJQG1QjlGU/caJxsBJ6TphOqhqCIZouiiZb/N8cUVVU2fzAQqk
        MnzUjZL6wlq1a3+lStHsxd8=
X-Google-Smtp-Source: AAOMgpc29VCKKiDS6lKtsZXN2RmkeGhvdhjJU5vTioRuJLMxIEMlhiTikzprPaPlC36iJmbGy86U2w==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr9921407edo.280.1532259579817;
        Sun, 22 Jul 2018 04:39:39 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m20-v6sm3798548eds.5.2018.07.22.04.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 04:39:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Sun, 22 Jul 2018 14:39:37 +0300
Message-ID: <1555597.AMQUAZZLsZ@dimapc>
In-Reply-To: <20180719132132.16153-7-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com> <20180719132132.16153-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 19 July 2018 16:21:30 MSK Dmitry Osipenko wrote:
> Kernel should never gate the EMC clock as it causes immediate lockup, so
> removing clk-gate functionality doesn't affect anything. Turning EMC clk
> gate into divider allows to implement glitch-less EMC scaling, avoiding
> reparenting to a backup clock.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 36 ++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c
> b/drivers/clk/tegra/clk-tegra20.c index cc857d4d4a86..ebea97016d58 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -578,7 +578,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max]
> __initdata = { [tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present =
> true }, [tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
> [tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
> -	[tegra_clk_emc] = { .dt_id = TEGRA20_CLK_EMC, .present = true }, };
> 
>  static unsigned long tegra20_clk_measure_input_freq(void)
> @@ -799,6 +798,31 @@ static struct tegra_periph_init_data
> tegra_periph_nodiv_clk_list[] = {
> TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2,
> 26,  0, TEGRA20_CLK_DISP2), };
> 
> +static void __init tegra20_emc_clk_init(void)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> +			       ARRAY_SIZE(mux_pllmcp_clkm),
> +			       CLK_SET_RATE_NO_REPARENT,
> +			       clk_base + CLK_SOURCE_EMC,
> +			       30, 2, 0, &emc_lock);
> +
> +	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
> +				    &emc_lock);
> +	clks[TEGRA20_CLK_MC] = clk;
> +
> +	/*
> +	 * Note that 'emc_mux' source and 'emc' rate shouldn't be changed at
> +	 * the same time due to a HW bug, this won't happen because we're
> +	 * defining 'emc_mux' and 'emc' as distinct clocks.
> +	 */
> +	clk = clk_register_divider(NULL, "emc", "emc_mux", CLK_IS_CRITICAL,
> +				   clk_base + CLK_SOURCE_EMC, 0, 7,
> +				   0, &emc_lock);

Actually this is wrong. The divisor is 8 bits-wide and "lsb denote 0.5x", so 
this is a 7.1 divider. I'll prepare v5.



