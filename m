Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A6C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CCC2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CCC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbeKOWBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:01:20 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54570 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387548AbeKOWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:01:18 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAFBo0bs016551;
        Thu, 15 Nov 2018 05:53:37 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2nrp6njhk8-1;
        Thu, 15 Nov 2018 05:53:37 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id B4DE7611E128;
        Thu, 15 Nov 2018 05:53:36 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 15 Nov 2018
 11:53:36 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAFBrZX6011137; Thu,
 15 Nov 2018 11:53:35 GMT
Date:   Thu, 15 Nov 2018 11:53:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] pinctrl: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181115115335.GA16508@imbe.wolfsonmicro.main>
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
 <20181108101405.14062-7-ckeepax@opensource.cirrus.com>
 <CACRpkdZCUDsSZA3xAH05ZFuNP8dyHFapX7MJTVnD3A-ts1Y7yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdZCUDsSZA3xAH05ZFuNP8dyHFapX7MJTVnD3A-ts1Y7yA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811150108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:54:48AM +0100, Linus Walleij wrote:
> On Thu, Nov 8, 2018 at 11:14 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> 
> > Lochnagar is an evaluation and development board for Cirrus
> > Logic Smart CODEC and Amp devices. It allows the connection of
> > most Cirrus Logic devices on mini-cards, as well as allowing
> > connection of various application processor systems to provide a
> > full evaluation platform. This driver supports the board
> > controller chip on the Lochnagar board.
> >
> > Lochnagar provides many pins which can generally be used for an
> > audio function such as an AIF or a PDM interface, but also as
> > GPIOs.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> This v4 version looks very good to me!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Nitpicks (fix or not, my review tag stands):
> 
> >  drivers/pinctrl/cirrus/pinctrl-lochnagar.c | 1145 ++++++++++++++++++++++++++++
> >  drivers/pinctrl/cirrus/pinctrl-lochnagar.h |  112 +++
> 
> Why don't you just include that header file in the C file.
> 112 lines +/- on a 1145 line file doesn't matter.
> 
> > +       priv->gpio_chip = template_chip;
> 
> I would just skip the template and just assign struct members
> directly.
> 
> Bonus if you set ->label to something instance-unique as well.
> 

No objection to any of those need to respin for Mark's comments
on the regulators anyway, so will wrap these in and add your
reviewed by.

Thanks,
Charles
