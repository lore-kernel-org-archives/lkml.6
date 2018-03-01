Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965302AbeCAAOf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965144AbeCAAOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:14:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B7721748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 1 Mar 2018 08:14:08 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, fabio.estevam@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH] clk: imx: imx7d: correct video pll clock tree
Message-ID: <20180301001407.GM3217@dragon>
References: <1514999361-2723-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514999361-2723-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2018 at 01:09:21AM +0800, Anson Huang wrote:
> There is a test divider and post divider in video PLL,
> test divider is placed before post divider, all clocks
> that can select parent from video PLL should be from
> post divider, NOT from pll_video_main, below are
> clock tree dump before and after this patch:
> 
> Before:
> pll_video_main
>    pll_video_main_bypass
>       pll_video_main_clk
>          lcdif_pixel_src
>             lcdif_pixel_cg
>                lcdif_pixel_pre_div
>                   lcdif_pixel_post_div
>                      lcdif_pixel_root_clk
> After:
> pll_video_main
>    pll_video_main_bypass
>       pll_video_main_clk
>          pll_video_test_div
>             pll_video_post_div
>                lcdif_pixel_src
>                   lcdif_pixel_cg
>                      lcdif_pixel_pre_div
>                         lcdif_pixel_post_div
>                            lcdif_pixel_root_clk
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
