Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F863C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF6B21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+8cuXXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF6B21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeGCPKb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:10:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38111 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932668AbeGCPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:10:26 -0400
Received: by mail-qt0-f193.google.com with SMTP id c5-v6so1850119qth.5;
        Tue, 03 Jul 2018 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tGk/mZu09sqr/67HHT67xwYdctHUsnNqCulLfU1iU8=;
        b=V+8cuXXv0wwK0WeWtg+3RKOUjxWC5hDtvJHDmulu3LF3kqrJ9wBcCb/4n6YRgihaWA
         +Yp3o9BqroF3iK0p2Idn4gQkuR6kEPzj/LvqXCaXjJBH9NO8tG1DFhdCg3tBJ0T6NHv0
         GM7jNZSdM2sfmF7xMGFftapBjglRTGJdXQtBFoOz50F2RgXaUzv2EwUDWQWaiG0cYmhr
         2XmYV+x+VojBnJIz5gc7zYsUM/RWNQjfRGk2wVqYPkNYSAgRndzTVBznzWGzOrlrGQpO
         whgwRaYd/CNOA9KSBDp/I1Jo79/kSU+FVCCLf5e8pIgWfZKtrqbhxBKCaPyT+bIEfLXG
         mq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tGk/mZu09sqr/67HHT67xwYdctHUsnNqCulLfU1iU8=;
        b=CQJ5CkklLzik61+8Q9L0mEkH2OxvApoh8NwRUSiVjvY+8epqPa2SyNLuuFasSW3p7p
         QOb6f/gc+yUdj/3FD9pvO57EpxdTiJDAa1lm2AhmdLw1S7BGf+sMqmCSZVli+vrL/J3d
         jjoXaACADw8e4Sc9MjOmVwcBDIHOmsmVs75xIouWlhMPTFLz0DzxiWDVDlRmIgBRnQMF
         6Yil0/jnvmRrEHqBUFLjR91AOXVDQdpGypmW4dh76L6rvEYTYgy/D6niawtfQcFT93gi
         u/Cg9I/jFMMpXfDvH7FTfpiOOpn83ZLfP7wxtrEhW++/Plr8NbaI5h0zLwjSPUibe6En
         edXA==
X-Gm-Message-State: APt69E1Vsn6mNZRD+MCvsVMerhxJLAqG9+e0sKgm/UOdemw3Jd8TGVI0
        Pr7NM57s7d3dsUYZ4TwoNmiIWRYwTH4=
X-Google-Smtp-Source: AAOMgpcKajhfV3DOaPWsPlDNNnOsJQbFLZP00+s7joqqEfG/Xw4sVpc6Uj5UrtDyvGGRIro4/oNglw==
X-Received: by 2002:aed:3ee8:: with SMTP id o37-v6mr15330021qtf.150.1530630624644;
        Tue, 03 Jul 2018 08:10:24 -0700 (PDT)
Received: from [192.168.44.96] (5.sub-174-226-19.myvzw.com. [174.226.19.5])
        by smtp.gmail.com with ESMTPSA id q15-v6sm900822qtl.39.2018.07.03.08.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 08:10:23 -0700 (PDT)
Subject: Re: [PATCH 1/3] clk: tegra: refactor 7.1 div calculation
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1530617721-5767-1-git-send-email-avienamo@nvidia.com>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <46bc7178-f8a4-cc4e-ebe3-507671ffb735@gmail.com>
Date:   Tue, 3 Jul 2018 11:10:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530617721-5767-1-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

Just a heads up.
During compilation with your patches, I get the following warning:

In file included from ./arch/arm/include/asm/div64.h:127:0,
                  from ./include/linux/kernel.h:174,
                  from drivers/clk/tegra/div71.c:17:
drivers/clk/tegra/div71.c: In function ‘div71_get’:
./include/asm-generic/div64.h:222:28: warning: comparison of distinct 
pointer types lacks a cast
   (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                             ^
drivers/clk/tegra/div71.c:40:2: note: in expansion of macro ‘do_div’
   do_div(divider_ux1, rate);
   ^~~~~~

Very Respectfully,
Peter Geis


On 07/03/2018 07:35 AM, Aapo Vienamo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Move this to a separate file so it can be used to calculate the sdmmc
> clock dividers.
> 
> Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/clk/tegra/Makefile      |  1 +
>   drivers/clk/tegra/clk-divider.c | 30 ++++--------------------
>   drivers/clk/tegra/clk.h         |  3 +++
>   drivers/clk/tegra/div71.c       | 51 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 60 insertions(+), 25 deletions(-)
>   create mode 100644 drivers/clk/tegra/div71.c
> 
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index b716923..6d4f563 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -24,3 +24,4 @@ obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
>   obj-y					+= cvb.o
>   obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
>   obj-$(CONFIG_CLK_TEGRA_BPMP)		+= clk-bpmp.o
> +obj-y					+= div71.o
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index 16e0aee..ad87858 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -32,35 +32,15 @@
>   static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
>   		   unsigned long parent_rate)
>   {
> -	u64 divider_ux1 = parent_rate;
> -	u8 flags = divider->flags;
> -	int mul;
> -
> -	if (!rate)
> -		return 0;
> -
> -	mul = get_mul(divider);
> -
> -	if (!(flags & TEGRA_DIVIDER_INT))
> -		divider_ux1 *= mul;
> -
> -	if (flags & TEGRA_DIVIDER_ROUND_UP)
> -		divider_ux1 += rate - 1;
> -
> -	do_div(divider_ux1, rate);
> -
> -	if (flags & TEGRA_DIVIDER_INT)
> -		divider_ux1 *= mul;
> +	int div;
>   
> -	divider_ux1 -= mul;
> +	div = div71_get(rate, parent_rate, divider->width, divider->frac_width,
> +			divider->flags);
>   
> -	if ((s64)divider_ux1 < 0)
> +	if (div < 0)
>   		return 0;
>   
> -	if (divider_ux1 > get_max_div(divider))
> -		return get_max_div(divider);
> -
> -	return divider_ux1;
> +	return div;
>   }
>   
>   static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index e1f8846..f14e136 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -811,6 +811,9 @@ extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
>   int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll);
>   u16 tegra_pll_get_fixed_mdiv(struct clk_hw *hw, unsigned long input_rate);
>   int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
> +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> +	      u8 frac_width, u8 flags);
> +
>   
>   /* Combined read fence with delay */
>   #define fence_udelay(delay, reg)	\
> diff --git a/drivers/clk/tegra/div71.c b/drivers/clk/tegra/div71.c
> new file mode 100644
> index 0000000..27b3846
> --- /dev/null
> +++ b/drivers/clk/tegra/div71.c
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include "clk.h"
> +
> +#define div_mask(w) ((1 << (w)) - 1)
> +
> +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> +	      u8 frac_width, u8 flags)
> +{
> +	s64 divider_ux1 = parent_rate;
> +	int mul;
> +
> +	if (!rate)
> +		return 0;
> +
> +	mul = 1 << frac_width;
> +
> +	if (!(flags & TEGRA_DIVIDER_INT))
> +		divider_ux1 *= mul;
> +
> +	if (flags & TEGRA_DIVIDER_ROUND_UP)
> +		divider_ux1 += rate - 1;
> +
> +	do_div(divider_ux1, rate);
> +
> +	if (flags & TEGRA_DIVIDER_INT)
> +		divider_ux1 *= mul;
> +
> +	divider_ux1 -= mul;
> +
> +	if (divider_ux1 > div_mask(width))
> +		return div_mask(width);
> +
> +	return divider_ux1;
> +}
> 
