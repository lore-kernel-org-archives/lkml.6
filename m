Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD69C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE786208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKybfI01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE786208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbeFQHZC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeFQHZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:25:01 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CB42086A;
        Sun, 17 Jun 2018 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529220300;
        bh=2GAUzsB4ObTxP/nRcI9riIPZFUwudGROzOyQu5veV60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKybfI01z+LWAonohPwPn8HPlIjG+hS1OtI/eZe+meqko3cCDqRSqfmhWi0LE6SGh
         iTxluJLktxBt6gzuS/R9FWGwcIf5dlC8VHWsxi/qoNOtazlFbiTQ3NlaRJWeWm5jbZ
         i0BIClBfnyy/ZXrbrtXgQ1QZ5LQrNW+JuepG2pao=
Date:   Sun, 17 Jun 2018 15:24:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Colin Didier <colin.dider@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Colin Didier <colin.didier@devialet.com>,
        =?iso-8859-1?Q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH 2/5] ARM: clk-imx6q: add EPIT clock support
Message-ID: <20180617072408.GP16091@dragon>
References: <20180528173412.10000-1-peron.clem@gmail.com>
 <20180528173412.10000-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528173412.10000-3-peron.clem@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 07:34:09PM +0200, Clément Péron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add EPIT clock support to the i.MX6Q clocking infrastructure.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>

This is a clock patch and should be prefixed with 'clk: imx6q: ...'
rather than 'ARM: ...'  Otherwise,

Acked-by: Shawn Guo <shawnguo@kernel.org>

> ---
>  drivers/clk/imx/clk-imx6q.c               | 2 ++
>  include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index 8d518ad5dc13..b9ea7037e193 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -753,6 +753,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	else
>  		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
>  	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
> +	clk[IMX6QDL_CLK_EPIT1]        = imx_clk_gate2("epit1",         "ipg",               base + 0x6c, 12);
> +	clk[IMX6QDL_CLK_EPIT2]        = imx_clk_gate2("epit2",         "ipg",               base + 0x6c, 14);
>  	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
>  	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
>  	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
> diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
> index da59fd9cdb5e..7ad171b8f3bf 100644
> --- a/include/dt-bindings/clock/imx6qdl-clock.h
> +++ b/include/dt-bindings/clock/imx6qdl-clock.h
> @@ -271,6 +271,8 @@
>  #define IMX6QDL_CLK_PRE_AXI			258
>  #define IMX6QDL_CLK_MLB_SEL			259
>  #define IMX6QDL_CLK_MLB_PODF			260
> -#define IMX6QDL_CLK_END				261
> +#define IMX6QDL_CLK_EPIT1			261
> +#define IMX6QDL_CLK_EPIT2			262
> +#define IMX6QDL_CLK_END				263
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
> -- 
> 2.17.0
> 
