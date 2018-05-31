Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeEaJZ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:25:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43981 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754135AbeEaJZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:25:54 -0400
Date: Thu, 31 May 2018 11:25:42 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] rtc: sun6i: Fix bit_idx value for clk_register_gate
Message-ID: <20180531092542.GA2727@piout.net>
References: <20180530182744.27611-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530182744.27611-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2018 23:57:44+0530, Jagan Teki wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> clk-gate core will take bit_idx through clk_register_gate
> and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
> is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
> which is wrong and eventually external gate clock is not enabling.
> 
> This patch fixed by passing bit index and the original change
> introduced from below commit.
> "rtc: sun6i: Add support for the external oscillator gate"
> (sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Fixes: 17ecd246414b ("rtc: sun6i: Add support for the external oscillator gate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4:
> - Cc to stable tree
> Changes for v3:
> - add fixes tag
> - Cced stable ML
> Changes for v2:
> - add suffix _OFFSET with macro name to distinguish b/w
>   register actual values vs offset.
> 
>  drivers/rtc/rtc-sun6i.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
