Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1CC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3940522565
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3940522565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeGDJxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:53:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42111 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbeGDJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:53:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so3900917lff.9;
        Wed, 04 Jul 2018 02:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gXIjNJIMo2JAWf3HX3qmKlFVneREu1e0fI4fkzuH7xg=;
        b=NffBiUdGpzs09j82ehg9KskuhLpIHO9hhuuh4cP5E06hlXUnEMYi7wrwIWn7GDh9hy
         QOSc9axmp8sdD9LyYoHpBwO0rMcYrJHnkwHPbDnkls96suiU4oPcY+eyyCxf3uQshHCj
         tRoisYJu+lveTFWqEUN+xKYcOMyCazJn4Guhm1nnXfh2oVs4YhosjK7l2Ea7wL9JPfzi
         Fapk2NDgSIEllOFhBSYKOj0geN84phGw4R4rpxZG1hwihU0WhRIWXcXzsDZENUMCPGwN
         mo3jaw1pkNOXEn8GeawPmTIFx0zObjbnKMPJeiBPH8MjbVuFF8J+NsAnSIUG0WMmiYU9
         Ayaw==
X-Gm-Message-State: APt69E1kQMONyfVvhvi89697mGzWtx4MOwbKwU9knMmRyKYAgx0kDyQI
        NyUtjyucvnEUNs/zX4wHSYg=
X-Google-Smtp-Source: AAOMgpfHKtMvWLYOxGwFSFoU3Cl5IBUijMj9fC2ZvXL4DYvvMxSYYt37MtES44qqqASc6s2P3Kvhlg==
X-Received: by 2002:a19:63dc:: with SMTP id v89-v6mr1122475lfi.23.1530697981845;
        Wed, 04 Jul 2018 02:53:01 -0700 (PDT)
Received: from localhost.localdomain (82-203-185-45.bb.dnainternet.fi. [82.203.185.45])
        by smtp.gmail.com with ESMTPSA id p20-v6sm526952lji.37.2018.07.04.02.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:53:01 -0700 (PDT)
Date:   Wed, 4 Jul 2018 12:52:57 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v8 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180704095257.GJ2118@localhost.localdomain>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <18a04e42debb2a23aec855cac3bcf3d6ab6c55fd.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_533te3UuY9V9U+Z0yxTkW==3wsK22uzB4G=aWGour7Quw@mail.gmail.com>
 <20180704083911.GH2118@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704083911.GH2118@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:39:11AM +0300, Matti Vaittinen wrote:
> On Tue, Jul 03, 2018 at 11:26:00AM +0200, Enric Balletbo Serra wrote:
> > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > dia dv., 29 de juny 2018 a les 11:47:
> > 
> > Now that you use devm calls and you don't need to unwind things I
> > think is better to use plain returns. So,
> > 
> > return -ENOMEM;
> 
> I have never really understood why use of gotos in error handling is
> discouraged. Personally I would always choose single point of exit from
> a function when it is simple enough to achieve (like in this case). I've
> written and fixed way too many functions which leak resources or
> accidentally keep a lock when exiting from error branches. But I know
> many colleagues like you who prefer not to have gotos but  in place returns
> instead. So I guess I'll leave the final call on this to the one who is
> maintainer for this code. And it is true there is no things to unwind
> now - which does not mean that next updater won't add such. But as I
> said, I know plenty of people share your view - and even though I rather
> maintain code with only one exit the final call is on subsystem maintainer
> here.

Actually, If it was completely my call the probe would look something
like this:

+static int bd71837_i2c_probe(struct i2c_client *i2c,
+                           const struct i2c_device_id *id)
+{
+       struct bd71837 *bd71837;
+       struct bd71837_board *board_info;
+       int gpio_intr = 0;
+
+       const char *errstr = "No IRQ configured";
+       int ret = -EINVAL;
+
+       bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
+
+       if (bd71837 == NULL)
+               return -ENOMEM;
+
+       board_info = dev_get_platdata(&i2c->dev);
+
+       if (!board_info)
+               gpio_intr = i2c->irq;
+       else
+               gpio_intr = board_info->gpio_intr;
+
+       if (!gpio_intr)
+               goto err_out;
+
+       i2c_set_clientdata(i2c, bd71837);
+       bd71837->dev = &i2c->dev;
+       bd71837->i2c_client = i2c;
+       bd71837->chip_irq = gpio_intr;
+
+       errstr = "regmap initialization failed";
+
+       bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
+       ret = PTR_ERR(bd71837->regmap);
+       if (IS_ERR(bd71837->regmap))
+               goto err_out;
+
+       errstr = "Read BD71837_REG_DEVICE failed";
+       ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
+       if (ret < 0)
+               goto err_out;
+
+       errstr = "Failed to add irq_chip";
+       ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
+                                      bd71837->chip_irq, IRQF_ONESHOT, 0,
+                                      &bd71837_irq_chip, &bd71837->irq_data);
+       if (ret < 0)
+               goto err_out;
+
+       errstr = "Failed to configure button short press timeout";
+       ret = regmap_update_bits(bd71837->regmap,
+                                BD71837_REG_PWRONCONFIG0,
+                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
+                                BD718XX_PWRBTN_SHORT_PRESS_10MS);
+       if (ret < 0)
+               goto err_out;
+
+       /* According to BD71847 datasheet the HW default for long press
+        * detection is 10ms. So lets change it to 10 sec so we can actually
+        * get the short push and allow gracefull shut down
+        */
+       ret = regmap_update_bits(bd71837->regmap,
+                                BD71837_REG_PWRONCONFIG1,
+                                BD718XX_PWRBTN_PRESS_DURATION_MASK,
+                                BD718XX_PWRBTN_LONG_PRESS_10S);
+
+       errstr = "Failed to configure button long press timeout";
+       if (ret < 0)
+               goto err_out;
+
+       btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
+                                         BD71837_INT_PWRBTN_S);
+
+       errstr = "Failed to get the IRQ";
+       ret = btns[0].irq;
+       if (btns[0].irq < 0)
+               goto err_out;
+
+       errstr = "Failed to create subdevices";
+       ret = devm_mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
+                                  bd71837_mfd_cells,
+                                  ARRAY_SIZE(bd71837_mfd_cells), NULL, 0,
+                                  regmap_irq_get_domain(bd71837->irq_data));
+       if (ret) {
+err_out:
+               if (errstr)
+                       dev_err(&i2c->dev, "%s (%d)\n", errstr, ret);
+       }
+
+       return ret;
+}

What do you think of this? To my eye it is nice. It keeps single point of
exit and introduces only simple if-statements without the need of curly
brackets. And finally the error prints string works as a comment too.
I've seen bunch of constructs like this on the networking side but I
have no idea if this is frowned on this subsystem =) Oh, and probe abowe
is just to illustrate the idea, I did not even try compiling it yet.

Best Regards
    Matti Vaittinen
