Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D4C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1D6252F3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wGMHB0lA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1D6252F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeGACUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeGACT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:19:58 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B907252F2;
        Sun,  1 Jul 2018 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530411598;
        bh=zMgr9mW4rZGl4cJlvu+Or2dQu7SXD+rommvbB9bj+ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGMHB0lAbDhNQct8DAeEklQFS+A2Ggczf1MQzMDPCpZA2K3utBtg2l1TSum/VnbVd
         0YEbUZoSUwJ0Hrdtju70UTK4ew3knblXRIJAhhxdIe2k8vJhRxulZ0/tYoVbmrxHrP
         ju/ogWYB2+vrP54NI5cYopAo3CtC0gKBkjHlzuGs=
Date:   Sun, 1 Jul 2018 10:19:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Message-ID: <20180701021947.GA4348@dragon>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <20180628005217.GC22683@dragon>
 <153029757874.143105.17774476792947607999@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153029757874.143105.17774476792947607999@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:39:38AM -0700, Stephen Boyd wrote:
> Quoting Shawn Guo (2018-06-27 17:52:18)
> > On Mon, Jun 25, 2018 at 03:14:39AM +0000, Anson Huang wrote:
> > > Gentle Ping...
> > 
> > I cannot apply this dts patch until the clock patch is landed on
> > mainline, because it has a dependency on new clock ID IMX6UL_CLK_GPIO1
> > created by clock patch.
> > 
> 
> Does it matter if that clk ID changes across branches? Or is everything
> good if it just exists as some number?

We use macro IMX6UL_CLK_GPIO1 instead of hard-coded number in DTS.  So
it doesn't matter if IMX6UL_CLK_GPIO1 changes.

> The patch adding the define
> conflicts with another patch to fix the numbering scheme to be
> incremental instead of changing IMX6UL and IMX6ULL which is annoying.
> I'll probably make a topic branch just for the fix and merge it into
> clk-fixes and this branch so you can pick it up from there if you like.

It will be good if you can have a topic branch.  Otherwise, we are also
fine to wait till the clock patches lands on mainline.

Shawn
