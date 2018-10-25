Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DCDECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C94920838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C94920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeJYQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:58:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49620 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbeJYQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:58:16 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9P8O7me001354;
        Thu, 25 Oct 2018 03:26:23 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n80speb3k-1;
        Thu, 25 Oct 2018 03:26:22 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id A3F53611CE60;
        Thu, 25 Oct 2018 03:29:19 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 25 Oct 2018
 09:26:22 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9P8QLIF012015; Thu,
 25 Oct 2018 09:26:21 +0100
Date:   Thu, 25 Oct 2018 09:26:21 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181025082621.GD16508@imbe.wolfsonmicro.main>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181025074459.GF4939@dell>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810250078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
> On Mon, 08 Oct 2018, Charles Keepax wrote:
> > From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > +static const struct reg_default lochnagar1_reg_defaults[] = {
> > +	{ LOCHNAGAR1_CDC_AIF1_SEL,    0x00 },
> > +	{ LOCHNAGAR1_CDC_AIF2_SEL,    0x00 },
...
> > +	{ LOCHNAGAR1_LED1,            0x00 },
> > +	{ LOCHNAGAR1_LED2,            0x00 },
> > +	{ LOCHNAGAR1_I2C_CTRL,        0x01 },
> > +};
> 
> Why do you need to specify each register value?
> 

The way regmap operates it needs to know the starting value of
each register. It will use this to initialise the cache and to
determine if writes need to actually update the hardware on
cache_syncs after devices have been powered back up.

> > +static const struct reg_sequence lochnagar1_patch[] = {
> > +	{ 0x40, 0x0083 },
> > +	{ 0x46, 0x0001 },
> > +	{ 0x47, 0x0018 },
> > +	{ 0x50, 0x0000 },
> > +};
> 
> I'm really not a fan of these so call 'patches'.
> 
> Can't you set the registers up proper way?
> 

I will see if we could move any out of here or define any of the
registers but as we have discussed before it is not always possible.

> > +static bool lochnagar2_readable_register(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case LOCHNAGAR_SOFTWARE_RESET:
> > +	case LOCHNAGAR_FIRMWARE_ID1:
> > +	case LOCHNAGAR_FIRMWARE_ID2:
...
> > +	case LOCHNAGAR2_MICVDD_CTRL2:
> > +	case LOCHNAGAR2_VDDCORE_CDC_CTRL1:
> > +	case LOCHNAGAR2_VDDCORE_CDC_CTRL2:
> > +	case LOCHNAGAR2_SOUNDCARD_AIF_CTRL:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static bool lochnagar2_volatile_register(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case LOCHNAGAR2_GPIO_CHANNEL1:
> > +	case LOCHNAGAR2_GPIO_CHANNEL2:
> > +	case LOCHNAGAR2_GPIO_CHANNEL3:
...
> > +	case LOCHNAGAR2_GPIO_CHANNEL13:
> > +	case LOCHNAGAR2_GPIO_CHANNEL14:
> > +	case LOCHNAGAR2_GPIO_CHANNEL15:
> > +	case LOCHNAGAR2_GPIO_CHANNEL16:
> > +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 
> This is getting silly now.  Can't you use ranges?
> 

I can if you feel strongly about it? But it does make the drivers
much more error prone and significantly more annoying to work
with. I find it is really common to be checking that a register
is handled correctly through the regmap callbacks and it is nice
to just be able to grep for that. Obviously this won't work for
all devices/regmaps as well since many will not have consecutive
addresses on registers, for example having multi-byte registers
that are byte addressed.

How far would you like me to take this as well? Is it just the
numeric registers you want ranges for ie.

LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR_GPIO_CHANNEL16

Or is it all consecutive registers even if they are unrelated
(exmaple is probably not accurate as I haven't checked the
addresses):

LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR2_ANALOGURE_PATH_CTRL1

I don't mind the first at all but the second is getting really
horrible in my opinion.

> > +static const struct reg_default lochnagar2_reg_defaults[] = {
> > +	{ LOCHNAGAR2_CDC_AIF1_CTRL,         0x0000 },
> > +	{ LOCHNAGAR2_CDC_AIF2_CTRL,         0x0000 },
> > +	{ LOCHNAGAR2_CDC_AIF3_CTRL,         0x0000 },
> > +	{ LOCHNAGAR2_DSP_AIF1_CTRL,         0x0000 },
...
> > +	{ LOCHNAGAR2_MINICARD_RESETS,       0x0000 },
> > +	{ LOCHNAGAR2_ANALOGUE_PATH_CTRL2,   0x0000 },
> > +	{ LOCHNAGAR2_COMMS_CTRL4,           0x0001 },
> > +	{ LOCHNAGAR2_SPDIF_CTRL,            0x0008 },
> > +	{ LOCHNAGAR2_POWER_CTRL,            0x0001 },
> > +	{ LOCHNAGAR2_SOUNDCARD_AIF_CTRL,    0x0000 },
> > +};
> 
> OMG!  Vile, vile vile!
> 

I really feel this isn't the driver you are objecting to as such
but the way regmap operates and also we seem to always have the same
discussions around regmap every time we push a driver. Is there
any way me, you and Mark could hash this out and find out a way to
handle regmaps that is acceptable to you? I don't suppose you are
in Edinburgh at the moment for ELCE?

> > +	/* Wait for Lochnagar to boot */
> > +	ret = lochnagar_wait_for_boot(lochnagar->regmap, &val);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to read device ID: %d\n", ret);
> 
> Eh?
> 
> So you read the LOCHNAGAR_SOFTWARE_RESET register and out pops the
> device/revision IDs?  That's just random!

I shall let the hardware guys know you don't approve of their
life choices :-) and add some comments to the code.

> > +	ret = devm_of_platform_populate(dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to populate child nodes: %d\n", ret);
> > +		return ret;
> > +	}
> 
> Please do not mix OF and MFD device registration strategies.
> 
> Pick one and register all devices through your chosen method.
> 

Hmmm we use this to do things like register some fixed regulators
and clocks that don't need any control but do need to be associated
with the device. I could do that through the MFD although it is in
direct conflict with the feedback on the clock patches I received
to move the fixed clocks into devicetree rather than registering
them manually (see v2 of the patch chain).

I will have a look see if I can find any ideas that will make
everyone happy but we might need to discuss with Mark and the
clock guys.

> > +	.probe_new = lochnagar_i2c_probe,
> 
> Hasn't this been replaced yet?
> 

I will check, the patchset has been around internally for a while
so it is possible this is no longer needed.

> > +#ifndef CIRRUS_LOCHNAGAR_H
> > +#define CIRRUS_LOCHNAGAR_H
> > +
> > +#include "lochnagar1_regs.h"
> > +#include "lochnagar2_regs.h"
> 
> Why are you including these here?
> 

It is just a convenience so the drivers only need to include
lochnagar.h rather than including all three headers manually.

> > diff --git a/include/linux/mfd/lochnagar1_regs.h b/include/linux/mfd/lochnagar1_regs.h
> > diff --git a/include/linux/mfd/lochnagar2_regs.h b/include/linux/mfd/lochnagar2_regs.h
> 
> So Lochnagar 1 and 2 are completely different devices?
> 
> What do they do?
> 

Completely different devices is a bit strong, they are different
versions of the same system. They have quite different register
maps but provide very similar functionality.

All the other comments I will get fixed up for the next spin of
the patches.

Thanks,
Charles
