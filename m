Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF7C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEC92177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547103393;
	bh=ambIUa63oWMuzaBHBJr7P+giFeFZ6JMLR3X0nFetp6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0PrY6S2Tc5OlnZZn1XyHiT793URHNu2r6Gfo/3ISEzDaoaIL+YT0QhhXKTxMcRVV0
	 TDLOdsIDK7ogOozicHzwi18+EXJScd6Gmcy5Y6ZOQtnKdBkreDAkRSvb+qkoRpCEEQ
	 hB/sITgkATsSn0Df+XyP/O0fCjx8PVa6HI59pSJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfAJG4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJG4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:56:32 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA0D214DA;
        Thu, 10 Jan 2019 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547103392;
        bh=ambIUa63oWMuzaBHBJr7P+giFeFZ6JMLR3X0nFetp6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZhRZpmLyakkGj5WmxyDf8HuIvZIHJmQq3C30BCeVNfBKKMB+t+etAfgHrAPnIZZB
         uWMWY3NnzgGoNh1MD6NBnmR8Ka8dR80JUfH5dDgt6Zpjxaec7iGXqGPA7Tz7t8S7gu
         CLzfdEkSY7fXhgJrvlGB61KM34/XcyJF/OtEqUVo=
Date:   Thu, 10 Jan 2019 14:56:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx7ulp: add HSRUN mode clocks
Message-ID: <20190110065619.GB25218@dragon>
References: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
 <1544176659-32022-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544176659-32022-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 10:03:39AM +0000, Anson Huang wrote:
> i.MX7ULP can switch CPU between RUN mode and HSRUN mode
> by programming SMC1 register, different clock sources
> will be used for CPU in different modes, so SMC1 can be
> abstracted as a clock controller for CPU clock switch,
> this patch adds support for it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
