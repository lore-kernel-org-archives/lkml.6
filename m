Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755574AbeCHJnM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:43:12 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36037 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755180AbeCHJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:43:10 -0500
X-Google-Smtp-Source: AG47ELtBzSUtz8fw6m6z0edEiIQeUgu3OyLoVf+o/qI5ACilpFCugkpsg1Zb+j4M2ogAmkyO1C6vQQ==
Message-ID: <1520502187.4264.5.camel@baylibre.com>
Subject: Re: [PATCH] clk: fix phase reported being zero
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 10:43:07 +0100
In-Reply-To: <20180215101958.22676-1-jbrunet@baylibre.com>
References: <20180215101958.22676-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 11:19 +0100, Jerome Brunet wrote:
> While introducing clk_core_set_phase_nolock, assigning core->phase was
> mistakenly removed. Fixing this now
> 
> Fixes: 9e4d04adeb1a ("clk: add clk_core_set_phase_nolock function")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Please drop this patch if favor of 

https://lkml.kernel.org/r/1520491781-132529-1-git-send-email-shawn.lin@rock-chip
s.com

Thanks
Jerome

> ---
>  drivers/clk/clk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9d56be6ead39..b33d362239e7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2314,6 +2314,9 @@ static int clk_core_set_phase_nolock(struct clk_core *core, int degrees)
>  	if (core->ops->set_phase)
>  		ret = core->ops->set_phase(core->hw, degrees);
>  
> +	if (!ret)
> +		core->phase = degrees;
> +
>  	trace_clk_set_phase_complete(core, degrees);
>  
>  	return ret;
