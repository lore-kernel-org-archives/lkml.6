Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F738C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA32146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ybPTvHHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABA32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK3I55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeK3I55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:57:57 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2827521019;
        Thu, 29 Nov 2018 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543528265;
        bh=qsEDmw2EjV+cE5P+2S+AvdpnpQQ6ZLjFtSihyjsKzH0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ybPTvHHzhYjdgC87Gsd1XNAfhsit/SQMs/+yR+mS/l0FEjLBb0zJAxZ+5wNqzUf//
         PhpDwaKd8tl3c/SbK+EMqEn7sSHsRidjnitBSdj+f3ezt9rUkLGuyLqgpdFI/qXpsF
         JFw4SKEPR02Q3NgtooD9csR6YxZP0eKUvrkHhqlM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
 <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154352826457.88331.16669625591730377740@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v13 0/5] Add i.MX8MQ clock driver
Date:   Thu, 29 Nov 2018 13:51:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng DONG (2018-11-28 23:46:41)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> [...]
> > >
> > > Changes since v12:
> > >  * replaced the division in clk_pll_recalc_rate in clk-frac
> > >    with do_div as suggested by Stephen
> > >
> > > Abel Vesa (2):
> > >   clk: imx: Add imx composite clock
> > >   clk: imx: Add clock driver for i.MX8MQ CCM
> > >
> > > Lucas Stach (3):
> > >   dt-bindings: add binding for i.MX8MQ CCM
> > >   clk: imx: add fractional PLL output clock
> > >   clk: imx: Add SCCG PLL type
> > >
> > =

> > I had to apply this set of fixes to silence sparse and smatch warnings =
about
> > things that are not right. Please take a look over things and see if it=
's sane.
> > =

> =

> The change looks good to me and tested ok.
> I did not see this patch series in your tree.
> Do you want us to apply your changes and re-send for easy pick up?
> =


I applied this version and my fixes. I'll just mark v14 as superseded.
Thanks for testing!

