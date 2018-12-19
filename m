Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946D021850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeLSKSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:18:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56373 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeLSKSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:18:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB999207D9; Wed, 19 Dec 2018 11:17:59 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9841720510;
        Wed, 19 Dec 2018 11:17:49 +0100 (CET)
Date:   Wed, 19 Dec 2018 11:17:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Message-ID: <20181219101749.GK19816@piout.net>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
 <20181219085429.GJ19816@piout.net>
 <DB3PR0402MB39167296BD1302130B537FD7F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB42119CF2FB98AEDE02DC0FB980BE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42119CF2FB98AEDE02DC0FB980BE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 09:48:25+0000, Aisheng Dong wrote:
> [...]
> > >
> > > I applied it on my test branch and this makes sparc64-allyesconfig
> > > fail
> > > with:
> > >
> > >    drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_read_time':
> > >    rtc-imx-sc.c:(.text+0x34): undefined reference to `imx_scu_call_rpc'
> > >    drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_probe':
> > >    rtc-imx-sc.c:(.text+0x90): undefined reference to `imx_scu_get_handle'
> > 
> > Maybe there are some changes on basic support of imx scu driver, I will resend
> > a patch set later, thanks.
> > 
> 
> This driver should depend on IMX_SCU which seems not got compiled.
> 

Yes, this seems to be the straightforward solution.

> Regards
> Dong Aisheng
> 
> > Anson.
> > 
> > >
> > >
> > >
> > > --
> > > Alexandre Belloni, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fboo
> > > tl
> > in.com&amp;data=02%7C01%7Canson.huang%40nxp.com%7C72b147643a3f
> > >
> > 44c258c208d6658f9cce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > %7C636808064818797711&amp;sdata=%2Bl5jGXX6wBYbOg5Zalg4CyxyZKj
> > Ue
> > > uzRSQEKO9TJnRI%3D&amp;reserved=0

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
