Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A215AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E0F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E0F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeJ3Wxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:53:35 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46970 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727576AbeJ3Wxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:53:35 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9UDweXu009668;
        Tue, 30 Oct 2018 08:59:51 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ncne2uhue-1;
        Tue, 30 Oct 2018 08:59:51 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id B6767611E121;
        Tue, 30 Oct 2018 08:59:50 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 30 Oct 2018
 13:59:50 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9UDxmq2016368; Tue,
 30 Oct 2018 13:59:49 GMT
Date:   Tue, 30 Oct 2018 13:59:48 +0000
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
Subject: Re: [PATCH v3 5/5] pinctrl: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181030135948.GJ16508@imbe.wolfsonmicro.main>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
 <20181019095003.26046-5-ckeepax@opensource.cirrus.com>
 <CACRpkdbYtphSk+9E5Wzz4kZvQiT=RANDg_hYqRac7pb0M02oAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdbYtphSk+9E5Wzz4kZvQiT=RANDg_hYqRac7pb0M02oAA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810300122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:04:20PM +0100, Linus Walleij wrote:
> On Fri, Oct 19, 2018 at 11:50 AM Charles Keepax
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
> > ---
> > +static void lochnagar_gpio_set(struct gpio_chip *chip,
> > +                              unsigned int offset, int value)
> > +{
> > +       struct lochnagar_pin_priv *priv = gpiochip_get_data(chip);
> > +       struct lochnagar *lochnagar = priv->lochnagar;
> > +       const struct lochnagar_pin *pin = priv->pins[offset].drv_data;
> > +       int ret;
> > +
> > +       value = !!value;
> 
> value = value ? BIT(pin->shift) : 0;
> 

I think this will end up more complex because...

> > +       dev_dbg(priv->dev, "Set GPIO %s to %s\n",
> > +               pin->name, value ? "high" : "low");
> > +
> > +       switch (pin->type) {
> > +       case LN_PTYPE_MUX:
> > +               value |= LN2_OP_GPIO;

I want the value to be in the lowest bit for this path.

> > +
> > +               ret = lochnagar_pin_set_mux(priv, pin, value);
> > +               break;
> > +       case LN_PTYPE_GPIO:
> > +               if (pin->invert)
> > +                       value = !value;

And then I need to invert the value here.

> > +
> > +               ret = regmap_update_bits(lochnagar->regmap, pin->reg,
> > +                                        0x1 << pin->shift,
> 
> BIT(pin->shift)
> 
> > +                                        value << pin->shift);
> 
> Just value provided you used the construction above
> to construct it.
> 

All the other comments look good will fixup for the next spin.

Thanks,
Charles
