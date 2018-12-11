Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A597CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3DD2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544515386;
	bh=27qKANtVyfxGEReXEC/rQ61r+efcmhaDdmDRwkL0jS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2i6vWHwsoeWM8l7uykUDtLgBxwMdT9JAYzkGmEYcxW+k1FGD9BrMlZulb05lfcKcn
	 1U6J/Pmhs68997fu3U8IKNr1sEI/xZJucydh+kQH1tJpQeIZ4O5ttQqyWeC01UlZxU
	 VHVEka7op5WeVeenEG3FVNLT2NFwMBIsBcvIsQWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3DD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKIDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLKIDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:03:04 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931602081B;
        Tue, 11 Dec 2018 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544515384;
        bh=27qKANtVyfxGEReXEC/rQ61r+efcmhaDdmDRwkL0jS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jucL7OdGvNUFtwk2AR6s4lOan8LP23jXKWbLuBLIKooszl8d9UY1DVRno1F9T5Dm2
         KNeYhKXqSsAISUi7b+DoUV3z81X81v1j8L1c9a8Bzc2V+j/iV838v2eRnCa36RIO3r
         dybtzjt8cIDwhJhf/wiBnj8skIZEo7mmWzk3eRYg=
Date:   Tue, 11 Dec 2018 16:02:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>
Subject: Re: [PATCH v13 0/5] Add i.MX8MQ clock driver
Message-ID: <20181211080208.GY3987@dragon>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
 <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154352826457.88331.16669625591730377740@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154352826457.88331.16669625591730377740@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:51:04PM -0800, Stephen Boyd wrote:
> Quoting Aisheng DONG (2018-11-28 23:46:41)
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > [...]
> > > >
> > > > Changes since v12:
> > > >  * replaced the division in clk_pll_recalc_rate in clk-frac
> > > >    with do_div as suggested by Stephen
> > > >
> > > > Abel Vesa (2):
> > > >   clk: imx: Add imx composite clock
> > > >   clk: imx: Add clock driver for i.MX8MQ CCM
> > > >
> > > > Lucas Stach (3):
> > > >   dt-bindings: add binding for i.MX8MQ CCM
> > > >   clk: imx: add fractional PLL output clock
> > > >   clk: imx: Add SCCG PLL type
> > > >
> > > 
> > > I had to apply this set of fixes to silence sparse and smatch warnings about
> > > things that are not right. Please take a look over things and see if it's sane.
> > > 
> > 
> > The change looks good to me and tested ok.
> > I did not see this patch series in your tree.
> > Do you want us to apply your changes and re-send for easy pick up?
> > 
> 
> I applied this version and my fixes. I'll just mark v14 as superseded.
> Thanks for testing!

Hi Stephen,

For the same reason as clk-imx7ulp, please keep branch clk-imx8mq
stable.  Thanks.

Shawn
