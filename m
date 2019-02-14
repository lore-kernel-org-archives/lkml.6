Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0FB222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502440AbfBNPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:55:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502425AbfBNPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:55:15 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1guJLw-0004qF-9D; Thu, 14 Feb 2019 16:55:08 +0100
Message-ID: <1550159708.2546.45.camel@pengutronix.de>
Subject: Re: [RFC 0/5] Add cpufreq-dt support i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date:   Thu, 14 Feb 2019 16:55:08 +0100
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 13.02.2019, 19:05 +0000 schrieb Abel Vesa:
> I'm sending this as a patchseries (RFC) just to show all the changes
> needed for this to work. I'll resend separately once I get some
> feedback
> on the entire thing.
> 
> One thing that is missing compared to the earlier work
> (here: https://patchwork.kernel.org/patch/10807821/ )
> is the speed grading. That can be done as a separate change 
> once I figure out how to do it with cpufreq-dt.
> 
> Unfortumately, there is a need to update the dt-bindings
> once again in order to add missing ARM clock from patches 1 and 2.

Which isn't much of a problem as it's a backward compatible change. A
new kernel with cpufreq support will not find the clock when started
with an old DT and thus not expose cpufreq support. I.e. it's working
with exactly the same functionality level as a kernel matching the old
DT.

Regards,
Lucas

> Abel Vesa (5):
>   clk: imx: imx8mq: Fix the rate propagation for arm pll
>   dt-bindings: imx8mq-clock: Add the missing ARM clock
>   clk: imx8mq: Add the missing ARM clock
>   arm64: dts: imx8mq: Add the clocks and the latencies for the A53
> cores
>   arm64: dts: imx8mq: Add the opp table and the cpu-supply nodes
> 
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 31
> ++++++++++++++++++++++++++++
>  drivers/clk/imx/clk-imx8mq.c                 |  8 ++++++-
>  include/dt-bindings/clock/imx8mq-clock.h     |  4 +++-
>  4 files changed, 58 insertions(+), 2 deletions(-)
> 
