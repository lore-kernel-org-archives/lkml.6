Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EBBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7FA20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7FA20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH3Vu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:50:27 -0400
Received: from baldur.buserror.net ([165.227.176.147]:45750 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3Vu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:50:26 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fvQxv-0000m3-Qb; Thu, 30 Aug 2018 12:42:44 -0500
Message-ID: <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>
Date:   Thu, 30 Aug 2018 12:42:41 -0500
In-Reply-To: <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
         <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
         <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
         <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
         <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: vabhav.sharma@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com, yogeshnarayan.gaur@nxp.com, andy.tang@nxp.com, udit.kumar@nxp.com, linux@armlinux.org.uk, V.Sethi@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 12:39 -0500, Scott Wood wrote:
> On Thu, 2018-08-30 at 07:36 +0000, Vabhav Sharma wrote:
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Scott Wood
> > > Sent: Wednesday, August 29, 2018 5:49 AM
> > > To: Vabhav Sharma <vabhav.sharma@nxp.com>; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org;
> > > mark.rutland@arm.com; linuxppc-dev@lists.ozlabs.org; linux-arm-
> > > kernel@lists.infradead.org; mturquette@baylibre.com; sboyd@kernel.org;
> > > rjw@rjwysocki.net; viresh.kumar@linaro.org; linux-clk@vger.kernel.org;
> > > linux-pm@vger.kernel.org; linux-kernel-owner@vger.kernel.org;
> > > catalin.marinas@arm.com; will.deacon@arm.com;
> > > gregkh@linuxfoundation.org; arnd@arndb.de;
> > > kstewart@linuxfoundation.org; yamada.masahiro@socionext.com
> > > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Andy Tang
> > > <andy.tang@nxp.com>; Udit Kumar <udit.kumar@nxp.com>;
> > > linux@armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>
> > > Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
> > > lx2160a
> > > 
> > > On Mon, 2018-08-20 at 12:17 +0530, Vabhav Sharma wrote:
> > > > From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > > 
> > > > Add clockgen support for lx2160a.
> > > > Added entry for compat 'fsl,lx2160a-clockgen'.
> > > > As LX2160A is 16 core, so modified value for NUM_CMUX
> > > > 
> > > > Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> > > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > > ---
> > > >  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
> > > >  drivers/cpufreq/qoriq-cpufreq.c |  1 +
> > > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c index
> > > > 3a1812f..fc6e308 100644
> > > > --- a/drivers/clk/clk-qoriq.c
> > > > +++ b/drivers/clk/clk-qoriq.c
> > > > @@ -60,7 +60,7 @@ struct clockgen_muxinfo {  };
> > > > 
> > > >  #define NUM_HWACCEL	5
> > > > -#define NUM_CMUX	8
> > > > +#define NUM_CMUX	16
> > > > 
> > > >  struct clockgen;
> > > > 
> > > > @@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[]
> > > > =
> > > > {
> > > >  		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
> > > >  	},
> > > >  	{
> > > > +		.compat = "fsl,lx2160a-clockgen",
> > > > +		.cmux_groups = {
> > > > +			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
> > > > +		},
> > > > +		.cmux_to_group = {
> > > > +			0, 0, 0, 0, 1, 1, 1, 1, -1
> > > > +		},
> > > > +		.pll_mask = 0x37,
> > > > +		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
> > > > +	},
> > > 
> > > Why are you increasing NUM_CMUX beyond 8 for a chip that only has 8
> > > entries in cmux_to_group?
> > 
> > Configuration is 16 cores,8 cluster with 2 cores in each cluster
> 
> So?  This is about cmuxes, not cores.  You're increasing the array without
> ever using the new size.

Oh, and you also broke p4080 which has 8 cmuxes but no -1 terminator, because
the array was of length 8.  Probably the array should be changed to NUM_CMUX+1
so every array can be -1 terminated.

-Scott

