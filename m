Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F16C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41212075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pjm73jZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41212075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIESOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:14:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56956 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIESOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:14:11 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50520119E;
        Wed,  5 Sep 2018 15:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536155031;
        bh=1+HW2Ah/nUzN8cetHoypCV+9IoMjne40W5BG24Rt+QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjm73jZOvnseqE4niCxZ3RfNyHTOxzTp0zUF30JpcGAZSncTfxuDMagy2cJdg6jiX
         LFr0XJeLCdre+mb/0rlBazSrTEDv61kbPG/LrZGJDcGbo/XV9mImZhALfO2U8Tgwux
         Ry5QwkbpEeqjWutzpp6Fo4T9Uv4PZXvk4Bp0pUYQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 03/10] phy: Add MIPI D-PHY configuration options
Date:   Wed, 05 Sep 2018 16:43:57 +0300
Message-ID: <11216244.YyI1EIWKhC@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <5b784b096d5507e45c641880af31b07763b4fce2.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <5b784b096d5507e45c641880af31b07763b4fce2.1536138624.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you for the patch.

On Wednesday, 5 September 2018 12:16:34 EEST Maxime Ripard wrote:
> Now that we have some infrastructure for it, allow the MIPI D-PHY phy's to
> be configured through the generic functions through a custom structure
> added to the generic union.
> 
> The parameters added here are the one defined in the MIPI D-PHY spec, plus

s/one/ones/

> some parameters that were used by a number of PHY drivers currently found
> in the linux kernel.

It would be useful to document which parameters are from the spec and which 
are not.

> The current set of parameters should cover all the potential users.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  include/linux/phy/phy-mipi-dphy.h | 241 +++++++++++++++++++++++++++++++-
>  include/linux/phy/phy.h           |   6 +-
>  2 files changed, 247 insertions(+)
>  create mode 100644 include/linux/phy/phy-mipi-dphy.h
> 
> diff --git a/include/linux/phy/phy-mipi-dphy.h
> b/include/linux/phy/phy-mipi-dphy.h new file mode 100644
> index 000000000000..792724145290
> --- /dev/null
> +++ b/include/linux/phy/phy-mipi-dphy.h
> @@ -0,0 +1,241 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Cadence Design Systems Inc.
> + */
> +
> +#ifndef __PHY_MIPI_DPHY_H_
> +#define __PHY_MIPI_DPHY_H_
> +
> +#include <video/videomode.h>
> +
> +/**
> + * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
> + *
> + * This structure is used to represent the configuration state of a
> + * MIPI D-PHY phy.

Shouldn't we split the RX and TX parameters in two structures ?

> + */
> +struct phy_configure_opts_mipi_dphy {
> +	/**
> +	 * @clk_miss:
> +	 *
> +	 * Timeout, in nanoseconds, for receiver to detect absence of
> +	 * Clock transitions and disable the Clock Lane HS-RX.
> +	 */
> +	unsigned int		clk_miss;
> +
> +	/**
> +	 * @clk_post:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter continues to
> +	 * send HS clock after the last associated Data Lane has
> +	 * transitioned to LP Mode. Interval is defined as the period
> +	 * from the end of @hs_trail to the beginning of @clk_trail.
> +	 */
> +	unsigned int		clk_post;
> +
> +	/**
> +	 * @clk_pre:
> +	 *
> +	 * Time, in nanoseconds, that the HS clock shall be driven by
> +	 * the transmitter prior to any associated Data Lane beginning
> +	 * the transition from LP to HS mode.
> +	 */
> +	unsigned int		clk_pre;
> +
> +	/**
> +	 * @clk_prepare:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the Clock
> +	 * Lane LP-00 Line state immediately before the HS-0 Line
> +	 * state starting the HS transmission.
> +	 */
> +	unsigned int		clk_prepare;
> +
> +	/**
> +	 * @clk_settle:
> +	 *
> +	 * Time interval, in nanoseconds, during which the HS receiver
> +	 * should ignore any Clock Lane HS transitions, starting from
> +	 * the beginning of @clk_prepare.
> +	 */
> +	unsigned int		clk_settle;
> +
> +	/**
> +	 * @clk_term_en:
> +	 *
> +	 * Time, in nanoseconds, for the Clock Lane receiver to enable
> +	 * the HS line termination.
> +	 */
> +	unsigned int		clk_term_en;
> +
> +	/**
> +	 * @clk_trail:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the HS-0
> +	 * state after the last payload clock bit of a HS transmission
> +	 * burst.
> +	 */
> +	unsigned int		clk_trail;
> +
> +	/**
> +	 * @clk_zero:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the HS-0
> +	 * state prior to starting the Clock.
> +	 */
> +	unsigned int		clk_zero;
> +
> +	/**
> +	 * @d_term_en:
> +	 *
> +	 * Time, in nanoseconds, for the Data Lane receiver to enable
> +	 * the HS line termination.
> +	 */
> +	unsigned int		d_term_en;
> +
> +	/**
> +	 * @eot:
> +	 *
> +	 * Transmitted time interval, in nanoseconds, from the start
> +	 * of @hs_trail or @clk_trail, to the start of the LP- 11
> +	 * state following a HS burst.
> +	 */
> +	unsigned int		eot;
> +
> +	/**
> +	 * @hs_exit:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives LP-11
> +	 * following a HS burst.
> +	 */
> +	unsigned int		hs_exit;
> +
> +	/**
> +	 * @hs_prepare:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the Data
> +	 * Lane LP-00 Line state immediately before the HS-0 Line
> +	 * state starting the HS transmission
> +	 */
> +	unsigned int		hs_prepare;
> +
> +	/**
> +	 * @hs_settle:
> +	 *
> +	 * Time interval, in nanoseconds, during which the HS receiver
> +	 * shall ignore any Data Lane HS transitions, starting from
> +	 * the beginning of @hs_prepare.
> +	 */
> +	unsigned int		hs_settle;
> +
> +	/**
> +	 * @hs_skip:
> +	 *
> +	 * Time interval, in nanoseconds, during which the HS-RX
> +	 * should ignore any transitions on the Data Lane, following a
> +	 * HS burst. The end point of the interval is defined as the
> +	 * beginning of the LP-11 state following the HS burst.
> +	 */
> +	unsigned int		hs_skip;
> +
> +	/**
> +	 * @hs_trail:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the
> +	 * flipped differential state after last payload data bit of a
> +	 * HS transmission burst
> +	 */
> +	unsigned int		hs_trail;
> +
> +	/**
> +	 * @hs_zero:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the HS-0
> +	 * state prior to transmitting the Sync sequence.
> +	 */
> +	unsigned int		hs_zero;
> +
> +	/**
> +	 * @lpx:
> +	 *
> +	 * Transmitted length, in nanoseconds, of any Low-Power state
> +	 * period.
> +	 */
> +	unsigned int		lpx;
> +
> +	/**
> +	 * @ta_get:
> +	 *
> +	 * Time, in nanoseconds, that the new transmitter drives the
> +	 * Bridge state (LP-00) after accepting control during a Link
> +	 * Turnaround.
> +	 */
> +	unsigned int		ta_get;
> +
> +	/**
> +	 * @ta_go:
> +	 *
> +	 * Time, in nanoseconds, that the transmitter drives the
> +	 * Bridge state (LP-00) before releasing control during a Link
> +	 * Turnaround.
> +	 */
> +	unsigned int		ta_go;
> +
> +	/**
> +	 * @ta_sure:
> +	 *
> +	 * Time, in nanoseconds, that the new transmitter waits after
> +	 * the LP-10 state before transmitting the Bridge state
> +	 * (LP-00) during a Link Turnaround.
> +	 */
> +	unsigned int		ta_sure;
> +
> +	/**
> +	 * @wakeup:
> +	 *
> +	 * Time, in nanoseconds, that a transmitter drives a Mark-1
> +	 * state prior to a Stop state in order to initiate an exit
> +	 * from ULPS.
> +	 */
> +	unsigned int		wakeup;
> +
> +	/**
> +	 * @hs_clk_rate:
> +	 *
> +	 * Clock rate, in Hertz, of the high-speed clock.
> +	 */
> +	unsigned long		hs_clk_rate;
> +
> +	/**
> +	 * @lp_clk_rate:
> +	 *
> +	 * Clock rate, in Hertz, of the low-power clock.
> +	 */
> +	unsigned long		lp_clk_rate;
> +
> +	/**
> +	 * @lanes:
> +	 *
> +	 * Number of lanes used for the transmissions.
> +	 */
> +	unsigned char		lanes;
> +
> +	/**
> +	 * @modes:
> +	 *
> +	 * transmission operation mode flags
> +	 */
> +	u32			modes;

Where are those flags defined ?

> +	/**
> +	 * @timings:
> +	 *
> +	 * Video timings associated with the transmission.

That's a pretty vague description...

> +	 */
> +	struct videomode	timings;
> +};
> +
> +/* TODO: Add other modes (burst, commands, etc) */
> +#define MIPI_DPHY_MODE_VIDEO_SYNC_PULSE		BIT(0)
> +
> +#endif /* __PHY_MIPI_DPHY_H_ */
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 3cc315dcfcd0..2b7a72f98428 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -20,6 +20,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> 
> +#include <linux/phy/phy-mipi-dphy.h>

You can move this within the existing list of #include's.

> +
>  struct phy;
> 
>  enum phy_mode {
> @@ -45,8 +47,12 @@ enum phy_mode {
> 
>  /**
>   * union phy_configure_opts - Opaque generic phy configuration
> + *
> + * @mipi_dphy:	Configuration set applicable for phys supporting
> + *		the MIPI_DPHY phy mode.
>   */
>  union phy_configure_opts {
> +	struct phy_configure_opts_mipi_dphy	mipi_dphy;
>  };
> 
>  /**

-- 
Regards,

Laurent Pinchart



