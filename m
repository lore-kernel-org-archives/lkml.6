Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C8C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0235F2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTF7l5Ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0235F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJHOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeJHOvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:51:14 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3FD20645;
        Mon,  8 Oct 2018 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538984452;
        bh=9G2Wac3g3fZwGPGo6JirZ0jZGuqGW5bxWgvX1S5Anes=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TTF7l5Nio33ZGmdpB3h/7Qox3/s8IHUbe3ow/anCTyzLZDBW0nhiWEulQLXKsqI38
         L/QrsmmUw97cRkykqFMfHx3EIhNFQ6axyNrHYSR6nE68qrsUyA8FToMMSppURb44N5
         J6utXh+kNZeM88RiPddUd/7o0ETy8hq2t31BjcV8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Message-ID: <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Date:   Mon, 08 Oct 2018 00:40:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-09-03 00:20:53)
> > > On 08/31/2018 03:29 AM, Stephen Boyd wrote:
> > > > Quoting Peng Fan (2018-08-12 18:15:41)
> > > >> Hi Anson,
> > > >>
> > > >>>>> -----Original Message-----
> > > >>>>> From: Anson Huang
> > > >>>>> Sent: 2018=E5=B9=B48=E6=9C=888=E6=97=A5 12:39
> > > >>>>> To: shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > >>>>> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > >>>>> mturquette@baylibre.com; sboyd@kernel.org;
> > > >>>>> linux-arm-kernel@lists.infradead.org;
> > > >>>>> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org
> > > >>>>> Cc: dl-linux-imx <linux-imx@nxp.com>
> > > >>>>> Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
> > > >>>>>
> > > >>>>> Clock framework will enable those clocks registered with
> > > >>>>> CLK_IS_CRITICAL flag, so no need to have clks_init_on array
> > > >>>>> during clock
> > > >>>> initialization now.
> > > >>>>
> > > >>>> Will it be more flexible to parse dts saying "critical-clocks =
=3D <xxx>"
> > > >>>> or "init-on-arrary=3D<xxx>"
> > > >>>> and enable those clocks?
> > > >>>
> > > >>> Parsing the clocks arrays from dtb is another way of enabling
> > > >>> critical clocks, but for current i.MX6/7 platforms, we implement
> > > >>> it in same way as most of other SoCs, currently I did NOT see any
> > > >>> necessity of putting them in dtb, just adding flag during clock
> > > >>> registering is more simple, if there is any special requirement
> > > >>> for different clocks set to be enabled, then we can add support t=
o enable
> > the method of parsing critical-clocks from dtb. Just my two cents.
> > > >>
> > > >> Thinking about OP-TEE want to use one device, but it's clocks are
> > > >> registered by Linux, because there is no module in Linux side use
> > > >> it, it will shutdown the clock, which cause OP-TEE could not acces=
s the
> > device.
> > > >>
> > > >> Then people have to modify clk code to add CLK_IS_CRITICAL flag to
> > > >> make sure the clocks are not shutdown by Linux.
> > > >>
> > > >> However adding a new property in clk node and let driver code parse
> > > >> the dts, there is no need to modify clk driver code when OP-TEE ne=
eds
> > another device clock.
> > > >>
> > > >
> > > > If OP-TEE needs linux to keep things on then why can't the OP-TEE
> > > > driver in Linux probe, acquire clocks, and keep the clks enabled fo=
rever?
> > >
> > > Sounds reasonable, but how could this be done without introducing
> > > platform-specific stuff in the OP-TEE driver?
> > >
> > =

> > Why is that a goal?
>  =

> I do NOT think we should consider such case in this patch series, whateve=
r OP-TEE needs for its own
> feature, it should do necessary operations either in its driver or somewh=
ere else by adding new patch.
> =


Why can't we add clks to the op-tee node in DT's /firmware container?
Then any clks in there can be turned on forever and left enabled by the
linux driver?

