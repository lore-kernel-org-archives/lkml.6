Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4840DC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1848A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1848A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeKTUlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:41:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43827 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKTUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:41:02 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gP31K-00031Z-2Q; Tue, 20 Nov 2018 11:12:38 +0100
Message-ID: <1542708756.2508.11.camel@pengutronix.de>
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Tue, 20 Nov 2018 11:12:36 +0100
In-Reply-To: <93eff9f1-922f-f5c1-9a88-debacdd68168@linaro.org>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
         <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
         <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <e4cf8bad-9a4f-32e5-2f0e-be44257b5fe2@linaro.org>
         <DB3PR0402MB391604AB207C160F09D3595EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
         <93eff9f1-922f-f5c1-9a88-debacdd68168@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 20.11.2018, 10:29 +0100 schrieb Daniel Lezcano:
> On 20/11/2018 09:58, Anson Huang wrote:
> > Hi, Daniel
> > 
> > Best Regards!
> > Anson Huang
> > 
> > > -----Original Message-----
> > > From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
> > > Sent: 2018年11月20日 16:54
> > > To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
> > > edubezval@gmail.com; linux-pm@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Cc: dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
> > > 
> > > On 20/11/2018 09:47, Anson Huang wrote:
> > > > Hi, Daniel
> > > > 
> > > > Best Regards!
> > > > Anson Huang
> > > > 
> > > > > -----Original Message-----
> > > > > From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
> > > > > Sent: 2018年11月20日 16:45
> > > > > To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
> > > > > edubezval@gmail.com; linux-pm@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org
> > > > > Cc: dl-linux-imx <linux-imx@nxp.com>
> > > > > Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-
> > > > > freq
> > > > > 
> > > > > On 24/10/2018 08:39, Anson Huang wrote:
> > > > > > The thermal driver is a standalone driver for monitoring
> > > > > > SoC
> > > > > > temperature by enabling thermal sensor, so it can be
> > > > > > enabled even
> > > > > > when CONFIG_CPU_FREQ is NOT set. So remove the dependency
> > > > > > with
> > > > > 
> > > > > CPU_THERMAL.
> > > > > > 
> > > > > > Add CONFIG_CPU_FREQ check for cpu-freq related operation in
> > > > > > thermal
> > > > > > driver to make thermal driver probe successfully when
> > > > > > CONFIG_CPU_FREQ is NOT set.
> > > > > > 
> > > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > > ---
> > > > > 
> > > > > Why not simply kill this legacy code ?
> > > > 
> > > > Because killing legacy code will have old dtb compatible issue,
> > > > old
> > > > dtb will NOT have cpufreq cooling function.
> > > 
> > > Yeah, I imagine that is the reason why you want to keep the
> > > legacy code but do
> > > you really care about old DTB based boards? Are they still
> > > updated with newer
> > > *upstream vanilla* kernels?
> > 
> > I am NOT sure if there is someone care about it, but I did receive
> > many comments
> > about old dtb compatible when I sent out other patches, so is it a
> > solid requirement
> > of old dtb compatible when doing upstream, or each sub-system or
> > maintainer has
> > different requirement about it? Actually I am happy to just remove
> > the legacy
> > code, because it makes the code more clean and easy reading. Who
> > can make the
> > decision?
> 
> Yes, making sure to not break the compatibility makes the patch
> submission easier. However, sometime it makes sense to put in
> question
> if keeping old (and hackish) code really matters.
> 
> Old boards are rarely updated with newer kernels and when that
> happens,
> usually the DT is updated also.
> 
> IMO, this decision is in the hands of the platform maintainers. I
> suggest to send a patch removing the legacy code Cc'ing all of them.

On i.MX we usually try to keep DT compatibility as much as possible.
There are cases where keeping the compatibility is just too much of a
burden on maintenance, but IMHO this is not the case for the piece of
code in question here.

Regards,
Lucas

