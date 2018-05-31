Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeEaIDi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:03:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41396 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753740AbeEaIDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:03:33 -0400
Date: Thu, 31 May 2018 10:03:31 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] rtc: sun6i: Fix bit_idx value for clk_register_gate
Message-ID: <20180531080331.5onjtjmxfolzbtc2@flea.home>
References: <20180530182744.27611-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180530182744.27611-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:57:44PM +0530, Jagan Teki wrote:
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

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
