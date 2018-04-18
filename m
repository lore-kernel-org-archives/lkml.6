Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeDRCcw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 22:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753358AbeDRCcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 22:32:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C982175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Wed, 18 Apr 2018 10:32:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Abel Vesa <abel.vesa@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] clk: imx: Set CLK_SET_RATE_GATE for gate and divider
 clocks
Message-ID: <20180418023214.GN25429@dragon>
References: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
 <1523455409-7771-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523455409-7771-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 05:03:29PM +0300, Abel Vesa wrote:
> From: Shawn Guo <shawnguo@kernel.org>
> 
> Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
> client drivers usually make clk_set_rate() call, so that the call will fail
> when clock is still on instead of standing the risk of running into glitch
> issue. Rate cannot be changed when the clock is enabled due to the glitchy
> multiplexers.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> [initial patch from imx internal repo]
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> [carried over from 3.14 and also applied the flag to newer functions]
> ---
> 
> Changes since v1:
>  - changed ownership as per initial patch

IIRC, the patch was created on vendor kernel long time ago to work
around a specific glitchy multiplexer issue seen on particular SoC.
I'm not sure it's good for the upstream kernel today.

Shawn
