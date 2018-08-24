Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF804C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920C321581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920C321581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeHXLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:32:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51181 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeHXLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:32:08 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ft6zE-0007S9-Cd; Fri, 24 Aug 2018 09:58:28 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ft6zD-0006vl-ID; Fri, 24 Aug 2018 09:58:27 +0200
Date:   Fri, 24 Aug 2018 09:58:27 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
        linux-imx@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Message-ID: <20180824075827.l54jghjbetulzntg@pengutronix.de>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
 <1534945703-4730-6-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534945703-4730-6-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:44:09 up 72 days, 16:53, 67 users,  load average: 0.02, 0.06,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:48:23PM +0300, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Add driver for the Clock Control Module found on i.MX8MQ.
> 
> This is largely based on the downstream driver from Anson Huang and
> Bai Ping at NXP, with only some small adaptions to mainline from me.

It's time to rephrase the commit message. With the new composite clock
the adaptions are no longer that small.

> +
> +static int const clks_init_on[] __initconst = {
> +	IMX8MQ_CLK_DRAM_CORE, IMX8MQ_CLK_AHB_CG,
> +	IMX8MQ_CLK_NOC, IMX8MQ_CLK_NOC_APB,
> +	IMX8MQ_CLK_USB_BUS, IMX8MQ_CLK_NAND_USDHC_BUS,
> +	IMX8MQ_CLK_MAIN_AXI, IMX8MQ_CLK_A53_CG,
> +	IMX8MQ_CLK_AUDIO_AHB_DIV, IMX8MQ_CLK_TMU_ROOT,
> +	IMX8MQ_CLK_DRAM_APB,
> +};

This is unused and you seem to have converted all these clocks to add
the CLK_IS_CRITICAL flag.

Are all these really needed? some clocks like IMX8MQ_CLK_AUDIO_AHB_DIV,
IMX8MQ_CLK_USB_BUS and IMX8MQ_CLK_NAND_USDHC_BUS look suspicious.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
