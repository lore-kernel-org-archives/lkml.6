Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965836AbeE2SfZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754646AbeE2SfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:35:20 -0400
Date: Tue, 29 May 2018 20:34:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        stable@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3] rtc: sun6i: Fix bit_idx value for clk_register_gate
Message-ID: <20180529183459.GB10359@kroah.com>
References: <20180529173913.12386-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529173913.12386-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:09:13PM +0530, Jagan Teki wrote:
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
> (sha1: 17ecd246414b3a0fe0cb248c86977a8bda465b7b)
> 
> Fixes: 17ecd246414b ("rtc: sun6i: Add support for the external oscillator
> gate")
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
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

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
