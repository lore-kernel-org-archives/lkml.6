Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24ACC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E89423C02
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+22Fx3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E89423C02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeGFRPh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933714AbeGFRPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:15:35 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E049F22545;
        Fri,  6 Jul 2018 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530897335;
        bh=DdNetV5Uh849CboyIM0HRCpFfqM6qbZTI4b8cTkSoEk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=f+22Fx3L5udm/5M2WgkluCwW/eVzDRp78P2Qvba2yOPGwx9VZ4MjKIUQsD3jqR9Hf
         7mU74/R6GwrDZUelIq6IByWLGdOonQ5rhofkdqXZbwqe4zlc3+MKCT+Jb4noRqUChj
         d0ICIRExTqncpZ+m99t4qOBT35zIhauaQ5kOCLkA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180701021947.GA4348@dragon>
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
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <20180628005217.GC22683@dragon>
 <153029757874.143105.17774476792947607999@swboyd.mtv.corp.google.com>
 <20180701021947.GA4348@dragon>
Message-ID: <153089733418.143105.7025289108790540252@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Date:   Fri, 06 Jul 2018 10:15:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-06-30 19:19:49)
> On Fri, Jun 29, 2018 at 11:39:38AM -0700, Stephen Boyd wrote:
> > Quoting Shawn Guo (2018-06-27 17:52:18)
> > > On Mon, Jun 25, 2018 at 03:14:39AM +0000, Anson Huang wrote:
> > > > Gentle Ping...
> > > =

> > > I cannot apply this dts patch until the clock patch is landed on
> > > mainline, because it has a dependency on new clock ID IMX6UL_CLK_GPIO1
> > > created by clock patch.
> > > =

> > =

> > Does it matter if that clk ID changes across branches? Or is everything
> > good if it just exists as some number?
> =

> We use macro IMX6UL_CLK_GPIO1 instead of hard-coded number in DTS.  So
> it doesn't matter if IMX6UL_CLK_GPIO1 changes.
> =

> > The patch adding the define
> > conflicts with another patch to fix the numbering scheme to be
> > incremental instead of changing IMX6UL and IMX6ULL which is annoying.
> > I'll probably make a topic branch just for the fix and merge it into
> > clk-fixes and this branch so you can pick it up from there if you like.
> =

> It will be good if you can have a topic branch.  Otherwise, we are also
> fine to wait till the clock patches lands on mainline.
> =


Ok. The topic branch is out there as clk-imx-gpio-gates
