Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7679C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28232085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28232085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJJM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:58:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36325 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:58:25 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1gA7Bs-0001qN-7C; Wed, 10 Oct 2018 07:37:48 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1gA7Bo-0007uF-RM; Wed, 10 Oct 2018 07:37:44 +0200
Date:   Wed, 10 Oct 2018 07:37:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abelvesa@linux.com" <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 4/5] clk: imx: add imx composite clock
Message-ID: <20181010053744.5pxrlcdxmmyisu62@pengutronix.de>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
 <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
 <5c0cc4de8403fca17431a9382f7e34e8003f497b.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0cc4de8403fca17431a9382f7e34e8003f497b.camel@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:37:28 up 119 days, 14:46, 77 users,  load average: 0.09, 0.10,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 10:56:14PM +0000, Leonard Crestez wrote:
> On Tue, 2018-10-09 at 08:37 +0000, Abel Vesa wrote:
> > +struct clk *imx_clk_composite_8m_flags(const char *name,
> > +					const char **parent_names,
> > +					int num_parents, void __iomem *reg,
> > +					unsigned long flags);
> > +
> > +#define __imx_clk_composite_8m(name, parent_names, reg, flags) \
> > +	imx_clk_composite_8m_flags(name, parent_names, \
> > +		ARRAY_SIZE(parent_names), reg, \
> > +		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> > +
> > +#define imx_clk_composite_8m(name, parent_names, reg) \
> > +	__imx_clk_composite_8m(name, parent_names, reg, 0)
> > +
> > +#define imx_clk_composite_8m_critical(name, parent_names, reg) \
> > +	__imx_clk_composite_8m(name, parent_names, reg, CLK_IS_CRITICAL)
> 
> Does anyone else think that the "8m" would be prettier next to imx
> rather than as a suffix? Using imx8m_clk_composite* and
> imx7ulp_clk_composite* makes more sense to me.

+1

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
