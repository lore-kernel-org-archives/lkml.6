Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ABA24791
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix+BluW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6ABA24791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755154AbeF0AVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:21:54 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41292 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeF0AVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:21:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so124487ply.8;
        Tue, 26 Jun 2018 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wXjC77i3aGXYLBCadQGJuU70nGy278Kw2MyS6NuMmtI=;
        b=Ix+BluW6l0LfBX2pEcZr+8XWLfWJ+AKFvsXQMXMa6XceX7z6B/SdpTdxMJ829gjtOC
         bvQmhyRfoT1KStV1rCvfyAFFuFXfHqBYzQVoQzkrH/WUsvVjhTsHtEkfvdFuXh6opfIP
         gr7e32Ec+SBNZgAKnOv2iZHJU9mxRMIT7ek6mcNAtsPKCgTcjYj6KyM80KgSxgeqvS/u
         FjHMk9XgkEIkfVaHP56/AY4qetpSZo5Xy7/xAW5Ukft9y5d0V/PwZEir7Ccks6I+eVCZ
         pS86MU9C+AFVe7q4J0BOoJhuuETmU/LLGVmRtkn1KZtDgdpkMWugLy9PiCA1iHg7H9MW
         DsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXjC77i3aGXYLBCadQGJuU70nGy278Kw2MyS6NuMmtI=;
        b=PD1mLAGp0VM8fV+w9T2z1HlSniuc2jvtP+EeFgee7EQwOxZIBADnP4eJDm7WJzhYqY
         1UhgMj17ZQA/N6/Rl2fliL0GhEz+4T7MNC19HUAz8StyDa87zLHBnG+YXuuIEytT6MlU
         V4tVxr9gUds2HwOgoeNm8QQ6ynYOxmQfrmaht15OTM2Xv/TUxVTZaV0f232zmDbHu/4K
         WSwIgu3O/ryyJHG5OoIeqjJl6Shiur/kzc8ij6ITpVSCdYlHzuDAbasZsmiTHDUhZ7VH
         H/3cUB6J/PXUCKpc98FKdIvP4sV4X8GawBJW701yczL0e1Go72+jq1Do7z/Hp+RerwoH
         Z5uA==
X-Gm-Message-State: APt69E1jLHt0piEts11iB5vJG27siGuV8N//34cCFg2geIveolP8iIuj
        t8tn5jHb2bNglnJSIq/mxl8=
X-Google-Smtp-Source: ADUXVKJ/entI1UeDqJPL/uvZ1iRAdI6uqRf0C4niMODpbMsqiE95kpDJGwvZcGtO/IhLaTVqx1GTCA==
X-Received: by 2002:a17:902:7009:: with SMTP id y9-v6mr3686829plk.217.1530058910434;
        Tue, 26 Jun 2018 17:21:50 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id u67-v6sm529082pfg.63.2018.06.26.17.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 17:21:49 -0700 (PDT)
Date:   Tue, 26 Jun 2018 17:21:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Message-ID: <20180627002147.GA179416@dtor-ws>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180619175028.GA71788@dtor-ws>
 <20180620064316.GB28784@localhost.localdomain>
 <20180621102547.GA6076@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621102547.GA6076@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Thu, Jun 21, 2018 at 01:25:47PM +0300, Matti Vaittinen wrote:
> On Wed, Jun 20, 2018 at 09:43:16AM +0300, Matti Vaittinen wrote:
> > On Tue, Jun 19, 2018 at 10:50:28AM -0700, Dmitry Torokhov wrote:
> > > Hi Matti,
> > > 
> > > On Tue, Jun 19, 2018 at 01:57:09PM +0300, Matti Vaittinen wrote:
> > > > ROHM BD71837 PMIC power button driver providing power-key press
> > > > information to user-space.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > ---
> > > >  drivers/input/misc/Kconfig          | 10 +++++
> > > >  drivers/input/misc/Makefile         |  1 +
> > > >  drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 101 insertions(+)
> > > >  create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
> > > > 
> > > > +	platform_set_drvdata(pdev, pk);
> > > > +	err = regmap_update_bits(pk->mfd->regmap,
> > > > +				 BD71837_REG_PWRONCONFIG0,
> > > > +				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
> > > > +				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
> > > 
> > > This seems to be the only custom bit of set up in the driver, the rest I
> > > think can easily be handled by gpio-keys.c in interrupt-only mode. Maybe
> > > we could move this into MFD piece and drop this driver?
> 
> I did following in MFD driver - is this what you suggested:
> +static struct gpio_keys_button btns[] = {
> +       {
> +               .code = KEY_POWER,
> +               .gpio = -1,
> +               .type = EV_KEY,
> +       },
> +};
> +
> +static struct gpio_keys_platform_data bd718xx_powerkey_data = {
> +       .buttons = &btns[0],
> +       .nbuttons = ARRAY_SIZE(btns),
> +       .name = "bd718xx-pwrkey",
> +};
> +
> +/* bd71837 multi function cells */
> +
> +static struct mfd_cell bd71837_mfd_cells[] = {
> +       {
> +               .name = "bd71837-clk",
> +       }, {
> +               .name = "gpio-keys",
> +               .platform_data = &bd718xx_powerkey_data,
> +               .pdata_size = sizeof(bd718xx_powerkey_data),
> +       }, {

Yes, something like this should work. It will not expose the internal
kernel structure (the fact that we are using gpio-keys dirver) to handle
power button of this PMIC, which Rob would appreciate. And we can change
it later if you want to create a fancier driver.

> 
> //snip
> 
> +static int bd71837_i2c_probe(struct i2c_client *i2c,
> +                           const struct i2c_device_id *id)
> +{
> 
> // snip
> 
> +       ret = regmap_add_irq_chip(bd71837->regmap, bd71837->chip_irq,
> +               IRQF_ONESHOT, 0,
> +               &bd71837_irq_chip, &bd71837->irq_data);
> +       if (ret < 0) {
> +               dev_err(bd71837->dev, "Failed to add irq_chip %d\n", ret);
> +               goto err_out;
> +       }
> +       /* I think this should be done conditionally and only when pwrkey is used
> +        * What would be the correct way to decide if we want to touch rhw button
> +        * press detection times?
> +        */
> +       ret = regmap_update_bits(bd71837->regmap,
> +                                BD71837_REG_PWRONCONFIG0,
> +                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
> +                                BD718XX_PWRBTN_SHORT_PRESS_10MS);
> +       if (ret < 0) {
> +               dev_err(bd71837->dev, "Failed to configure button short press timeout %d\n", ret);
> +               goto err_out;
> +       }
> +       /* According to BD71847 datasheet the HW default for long press detection
> +        * is 10ms. So letch change it to 10 sec so we can actually get the short
> +        * push and allow gracefull shut down
> +        */
> +       ret = regmap_update_bits(bd71837->regmap,
> +                                BD71837_REG_PWRONCONFIG1,
> +                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
> +                                BD718XX_PWRBTN_LONG_PRESS_10S);
> +       if (ret < 0) {
> +               dev_err(bd71837->dev, "Failed to configure button long press timeout %d\n", ret);
> +               goto err_out;
> +       }
> +       btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
> +                                         BD71837_INT_PWRBTN_S);
> +
> +       if (btns[0].irq < 0) {
> +               ret = btns[0].irq;
> +               goto err_out;
> +       }
> +
> +       ret = mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
> +                             bd71837_mfd_cells, ARRAY_SIZE(bd71837_mfd_cells),
> +                             NULL, 0,
> +                             regmap_irq_get_domain(bd71837->irq_data));
> 
> If looks is Ok I will send new patch with this approach at next week -
> unless I get lost during the traditional midsummer festival here in
> Finland.
> 
> > Finally, there may be cases when power button is not attached to PMIC
> > or is needing different configuration for 'short push'. This is why I
> > would prefer having own Kconfig option for this power-key driver. I am
> > not sure if it is easily doable if we use gpio_keys?
> 
> What would be the preferred mechanism for skipping the button push duration
> configurations (time it takes for PMIC to detect short or long push)? Or
> setting the durations to values user(s) would prefer? To me this sounds again
> something we could configure from DT. Would adding propereties
> rohm,short-press-ms and rohm,long-press-ms sound reasonable? I will send
> the first version with no option to skip/specify the configuration
> (fixed 10ms for short press, 10 sec for long press) but I would like to add
> support for specifying the duration as next step.

This sounds OK to be but you'd need to get Rob's buy in here. The
properties should probably be in a sub-node of the PMIC device node.

Thanks.

-- 
Dmitry
