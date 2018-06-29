Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A137C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC626D3C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EC626D3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965369AbeF2Iiu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:38:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36385 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965322AbeF2Iis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:38:48 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fYovP-0000r9-Nd; Fri, 29 Jun 2018 10:38:39 +0200
Message-ID: <1530261518.22468.62.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6: correct anatop regulators range
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 29 Jun 2018 10:38:38 +0200
In-Reply-To: <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
         <1530260109.22468.60.camel@pengutronix.de>
         <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
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

Am Freitag, den 29.06.2018, 08:27 +0000 schrieb Anson Huang:
> Hi, Lucas
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Friday, June 29, 2018 4:15 PM
> > > > > > To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
> > > > s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> > > > > > > > <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > > > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > > > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] ARM: dts: imx6: correct anatop regulators range
> > 
> > Am Freitag, den 29.06.2018, 15:54 +0800 schrieb Anson Huang:
> > > Correct some i.MX6 SoCs anatop regulators range according to reference
> > > manual.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > NACK.
> > 
> > This is wrong. While the regulator supports this range, the SoC doesn't. The
> > current settings are derived from the allowed operating ranges of the SoC (at
> > least for the MX6QDL), which is in accordance with how regulator constraints
> > in DT are meant to be used.
> 
>  
> Understand that normally these regulators' voltage are NOT adjusted, we just use
> the default value, let's just call the operating range of the SoC "SoC range",
> my intention is to make all i.MX6's anatop regulator settings aligned since they are in same series, 
> I saw some i.MX6 SoCs use same SoC range as anatop ldo range, but some are
> NOT, like imx6qdl/imx6sx/imx6sl use different SoC range than anatop ldo range,
> but imx6ul/ull/sll use same regulator range as anatop ldo, and regulator 1p1/2p5/3p0
> also have different settings, some are use SoC range and some are just same as anatop
> ldo range....this looks really confused.
> 
> So, do you think we can adjust the imx6ul/ull/sll's regulator range to be SoC range rather than
> anatop ldo range? And how to define the SoC range? Like the 1p1 ldo range, how do
> we know which range is fine? As I saw it is 1v ~ 1.2v on imx6qdl, but 0.8v ~ 1.375v on imx6sl?

If you want to align those voltages to something then it's definitely
the SoC range you want to use. This is how the constraints are
specified in the DT binding, as being the allowed voltage range that
won't damage any of the attached consumers.

Please align the constraints to the operating ranges, as specified in
the datasheet. For example an excerpt from the i.MX6SL datasheet:

"4.3.2.1 Regulators for Analog Modules
  LDO_1P1
   [...] Typical Programming Operating Range is 1.0 V to 1.2 V with the
nominal default setting as 1.1 V"

So the range for 1p1 LDO on i.MX6SL should be 1.0V to 1.2V, which is
the same as i.MX6QDL.

Regards,
Lucas
