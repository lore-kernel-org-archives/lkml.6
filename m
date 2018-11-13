Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF39C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14868223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ1wYQ9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14868223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbeKNAYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbeKNAYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:24:11 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED4C20825;
        Tue, 13 Nov 2018 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542119148;
        bh=F5mp5j6wqL80xc5c0v34/X9a+qopIPqGcEPnYsRJid4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJ1wYQ9wkOoc5FbDmivM1LD3Usr8TvQYQz0McTNpUaTZVbayVHQFQ7+htKKC0TWkS
         5Nw+vn8MqEUhPxbnDqjR339d+TZw0LmfK3cnGLI7VHFqLtFindgltf6+vGMCVGTgw9
         frMK+sOBT2sTHhFoS01K6pKEa6Pjyd8MYTYSv/II=
Date:   Tue, 13 Nov 2018 22:25:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Message-ID: <20181113142533.GA4557@dragon>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
 <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
 <20181108122938.mnhu3ttnlztfeyot@fsr-ub1664-175>
 <154170172752.88331.2213352243956732809@swboyd.mtv.corp.google.com>
 <AM0PR04MB42118C6960C39387051B57F280C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42118C6960C39387051B57F280C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 04:05:44PM +0000, A.s. Dong wrote:
> Hi Stephen,
> 
> [...]
> > > I already sent the 12th version of this current patch series and I
> > > would really like to get this in ASAP so that the booting up of imx8mq will
> > not be delayed.
> > >
> > 
> > Ok. Well we're in rc1 right now, and so we're not merging new drivers into
> > mainline. I can merge the clk driver into clk-next, but you'll have to wait for the
> > stabilization period to end (approximately 6 or 7 weeks) before this can get
> > into the next kernel version. It will be in linux-next much sooner of course.
> 
> That would be great if you can help that.
> We're now working with SUSE to enable i.MX8 support.
> Their criteria is only backporting patches which must be at least in maintainer's
> next tree already. So either picked up by you or Shawn would help a lot on it.
> 
> BTW, one simple question is that because MX8MQ DTS patches depends on
> this clock driver series. How would you suggest this series to go through
> your tree or Shawn's tree?

Once Stephen has a topic branch for the patches, I can pull it into my
tree to resolve the DT dependency.

Shawn
