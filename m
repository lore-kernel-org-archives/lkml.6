Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeEGM40 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:56:26 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59272 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEGM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:56:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 14:56:19 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jacky Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
In-Reply-To: <20180502073807.GE3443@dragon>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon>
Message-ID: <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_ZERO(0.00)[0];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         TO_DN_SOME(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

On 02.05.2018 09:38, Shawn Guo wrote:
> Hi Jacky,
> 
> Do you see this problem on i.MX6 ULL?  What's your take on Stefan's fix?

Any comment to this?

It is 4.17.0-rc4 is out and i.MX 6ULL is still broken :-(

--
Stefan

> 
> Shawn
> 
> On Wed, Apr 18, 2018 at 02:49:08PM +0200, Stefan Agner wrote:
>> On i.MX6 ULL using PLL3 seems to cause a freeze when setting
>> the parent to IMX6UL_CLK_PLL3_USB_OTG. This only seems to appear
>> since commit 6f9575e55632 ("clk: imx: Add CLK_IS_CRITICAL flag
>> for busy divider and busy mux"), probably because the clock is
>> now forced to be on.
>>
>> Fixes: 6f9575e55632("clk: imx: Add CLK_IS_CRITICAL flag for busy divider and busy mux")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> This addresses a regression ssen on v4.17-rc1 where the kernel
>> boots during clock initialization, see also:
>> https://patchwork.kernel.org/patch/10295927/
>>
>>  drivers/clk/imx/clk-imx6ul.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
>> index 114ecbb94ec5..12320118f8de 100644
>> --- a/drivers/clk/imx/clk-imx6ul.c
>> +++ b/drivers/clk/imx/clk-imx6ul.c
>> @@ -464,7 +464,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>>  	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
>>
>>  	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
>> -	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_PLL3_USB_OTG]);
>> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_OSC]);
>>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_CLK2]);
>>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE], clks[IMX6UL_CLK_PLL2_BUS]);
>>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_PRE]);
>> --
>> 2.17.0
>>
