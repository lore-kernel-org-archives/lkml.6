Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7081C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7022419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZHiGOp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKOJ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOJ0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:26:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533442175B;
        Wed, 14 Nov 2018 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542237678;
        bh=EfdzHbBl9CB+iIL9Uckj7soO3uTegmMavQ1UX8zqiIA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=AZHiGOp/3nFmtBZop1VlB6XN3q5bVtT/f6pDYXStdAA9p00NTxyjJHAGapCd9S0+i
         T3NM/KdlKuwNn2HGsEQq6NOTnCBvEM64vfKj75fSq3TB9cm/7PYSMzOBd8cOOOPw6J
         LqA/nLA3v5fQcac/nUU3l2qiqXXt7ynuMSH/do+k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181113142533.GA4557@dragon>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
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
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
 <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
 <20181108122938.mnhu3ttnlztfeyot@fsr-ub1664-175>
 <154170172752.88331.2213352243956732809@swboyd.mtv.corp.google.com>
 <AM0PR04MB42118C6960C39387051B57F280C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181113142533.GA4557@dragon>
Message-ID: <154223767765.88331.8896059926353279805@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Date:   Wed, 14 Nov 2018 15:21:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-11-13 06:25:36)
> On Sat, Nov 10, 2018 at 04:05:44PM +0000, A.s. Dong wrote:
> > Hi Stephen,
> > =

> > [...]
> > > > I already sent the 12th version of this current patch series and I
> > > > would really like to get this in ASAP so that the booting up of imx=
8mq will
> > > not be delayed.
> > > >
> > > =

> > > Ok. Well we're in rc1 right now, and so we're not merging new drivers=
 into
> > > mainline. I can merge the clk driver into clk-next, but you'll have t=
o wait for the
> > > stabilization period to end (approximately 6 or 7 weeks) before this =
can get
> > > into the next kernel version. It will be in linux-next much sooner of=
 course.
> > =

> > That would be great if you can help that.
> > We're now working with SUSE to enable i.MX8 support.
> > Their criteria is only backporting patches which must be at least in ma=
intainer's
> > next tree already. So either picked up by you or Shawn would help a lot=
 on it.
> > =

> > BTW, one simple question is that because MX8MQ DTS patches depends on
> > this clock driver series. How would you suggest this series to go throu=
gh
> > your tree or Shawn's tree?
> =

> Once Stephen has a topic branch for the patches, I can pull it into my
> tree to resolve the DT dependency.
> =


Sounds like a plan. Expect something next week.

