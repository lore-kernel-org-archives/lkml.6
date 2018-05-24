Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968581AbeEXSGf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:06:35 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:64523 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968546AbeEXSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:06:31 -0400
X-AuditID: c0a8fbf4-fcfff70000000f28-36-5b06fba026b3
From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To: Mark Brown <broonie@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: RE: [PATCH 8/9] regulator: bd71837: BD71837 PMIC regulator driver
Thread-Topic: [PATCH 8/9] regulator: bd71837: BD71837 PMIC regulator driver
Thread-Index: AQHT82mISKOyi8FfiUKQkM/afomaOaQ/JCHb
Date: Thu, 24 May 2018 17:51:27 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4016C06B60@WILL-MAIL002.REu.RohmEu.com>
References: <20180524060036.GI4249@localhost.localdomain>,<20180524141427.GU4828@sirena.org.uk>
In-Reply-To: <20180524141427.GU4828@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.216.252.121]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5sOL3Jt0Fv9miDRbfYreY+vAJm8X8I+dY
        Le5/Pcpo8e1KB5PFx557rBaXd81hs1h6/SKTxZylJ1gsLp5ytWjde4Td4t+1jSwO3B5r5q1h
        9Hh/o5XdY+esu+wem1Z1snncubaHzePzJrkAtihum6TEkrLgzPQ8fbsE7owFMywKjslUNNye
        w9TAeEi0i5GTQ0LARGLl7BfMXYxcHEIC1xgltjy9zgrhnGCU6G5+ytjFyMHBJmAj0XWTHaRB
        REBZ4ur3vSwgNcwCv1gktmy4BZYQFvCS2PzyLjNEkbfE/8PTWCBsI4krj+6wgdgsAqoS16/f
        ZAWxeQWCJPoa34L1CgnES9x9MIUJxOYEqm88sRushlFAVqKz4R1YnFlAXOLWk/lMEFcLSCzZ
        c54ZwhaVePn4HyuErSyx5tRONoh6HYkFuz9B2doSyxa+ZobYKyhxcuYTlgmMorOQjJ2FpGUW
        kpZZSFoWMLKsYpTITczMSU8sSTXUK0ot1SvKz8gFUsn5uZsYIdH6ZQfj/0OehxgFOBiVeHjb
        vrBFC7EmlhVX5h5ilORgUhLlZXgFFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC2/0LKMebklhZ
        lVqUD5OS5mBREueNOv8rSkgAZHN2ampBahFMVoaDQ0mC9whIo2BRanpqRVpmTglCmomDE2Q4
        l5RIcWpeSmpRYmlJRjwoWcQXA9MFSIoHaC/zb5C9xQWJuUBRiNZTjJJS4rxvfgIlBEASGaV5
        cGNfMYoDfSfM2wWylQeYruG6XgENZAIaeHE5M8jAkkSElFQD494/su3v/vIGTS2US7QRvf/o
        E2txbgfXPOv5u2bXPrDvOVRy1LaRpWzt5jvCht9zQo+Ja3/bWqehar3RZ0XbzJ+mRRtO/3i9
        6trbc+ynuwzK51aoGQglfHllquw6MUFOJpPhTGRPvHrsL9f/q19+u9s+8ULyjSbh4J2FWaK9
        1wqtKqwyHOrmK7EUZyQaajEXFScCACNOnAyUAwAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mark Brown [broonie@kernel.org]
> Sent: Thursday, May 24, 2018 5:14 PM
>
> On Thu, May 24, 2018 at 09:00:36AM +0300, Matti Vaittinen wrote:
>
> > @@ -0,0 +1,683 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2018 ROHM Semiconductors */
> > +/*
> > + * bd71837-regulator.c ROHM BD71837MWV regulator driver
> > + */
> > +#include <linux/kernel.h>
>
> Make the entire comment block a C++ comment so it looks more intentional

I will change this to C++ - but the verison of checkpatch.pl I used did complain
if I used C++ style comments in C-files or if I used C-style comments in header.
I guess the sscript should be fixed unless it is already done.

> and add a blank line before the headers for legibility.
Will do.

> > +static int bd71837_regulator_set_regmap(struct regulator_dev *rdev, int set)
> > +{
> > +     int ret = -EINVAL;
> > +     struct bd71837_pmic *pmic = rdev->reg_data;
> > +
> > +     if (pmic) {
> > +             mutex_lock(&pmic->mtx);
> > +             if (!set)
> > +                     ret = regulator_disable_regmap(rdev);
> > +             else
> > +                     ret = regulator_enable_regmap(rdev);
> > +             mutex_unlock(&pmic->mtx);
> > +     }
>
> This looks very weird - why might we not have a parent PMIC,
I'll remove the check. I've just adopted habit of adding NULL checks
for pointers "jsut in case".

> what is the lock doing and what is this wrapper function intended to do?
This was the other spot which I was unsure how to handle. Datasheet for
the chip says that if voltage is to be changed, the regulator must be
disabled. Thus my voltage changing function checks if regulator is enabled
and disables it for duration of voltage change (if it was enabled). This lock
is used to protect the voltage change so that no one enables the regulator
during voltage change. I don't know what would have been correct way of
doing this, or if disabling regulator for voltage change is Ok - but this was
the only way I could think of. I am again grateful for any tips.

> Similar
> issues apply to the voltage functions, if there's any need for this it
> needs to be better documented but it really doesn't look like a good
> idea.
If the solution with lock and wrapper (to prevent race during state check
and voltage change) is Ok, then I will add comment which explains this,

> > +     err =
> > +         regmap_update_bits(pmic->mfd->regmap, BD71837_REG_REGLOCK,
> > +                            (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
> > +     if (err) {
> > +             dev_err(&pmic->pdev->dev, "Failed to unlock PMIC (%d)\n", err);
> > +             goto err;
> > +     } else
> > +             dev_dbg(&pmic->pdev->dev, "%s: Unlocked lock register 0x%x\n",
> > +                     __func__, BD71837_REG_REGLOCK);
>
> There's loads of coding style problems with this code, please refer to
> the coding style - indentation is weird and if there's { } on one side
> of an else it should be on both.

Will fix it.

> > +             rdev = regulator_register(desc, &config);
> > +             if (IS_ERR(rdev)) {
>
> devm_regulator_regster()

Makes sense. Thanks


Best Regards
    Matti Vaittinen
