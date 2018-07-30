Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46156FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1D620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1D620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeG3IZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:25:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44583 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeG3IZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:25:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so7335351lfb.11;
        Sun, 29 Jul 2018 23:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fRIrObFNcE0XyMpBVRVtMmxusYuzrOmbeqdDJiatK6Y=;
        b=lRzGIXbEgK/px61Oij4MrfTqafxovx2QPfioQVTISZ+d9PiObFlwFMduy5osWtgkE5
         lij0YnnUeQ3tDVk0aCoxtensZDG+6AC2GH8Qh6XMRH3tJFb+s39DOS68VtDkbTttEQ0L
         j4N4tOGFY7y2DDwcizicY7fl51mQdzvJLGZAiqzHOCuPzV530R5WB3w4xQ6ge3RcbHlX
         xY0CwrW5i1z+mynytKQzbflmM++SF+MrCgx3KZ5rIWtTD+EURFkG82MTrvHwfSE7VnpE
         9TYbmuAK69xQpl50/Mv04XSmwW3kSgrrWP+DN18qhq9we1jz62cVXxZ8leyR1IWNAfMM
         Hycg==
X-Gm-Message-State: AOUpUlG9Q+lzmU1NNw4R08/mc5sVbdqI1Ru/biRxyoWx9sWbeyB2tG57
        hr945hb+jTpk3+7MlurD8Is=
X-Google-Smtp-Source: AAOMgpedUL8Vx4Wdozl7O+0/bX9ltzh9i/i2zpazwcb+SbOx3cbhdvHe3eZIlqIqflYC9fr7B0T/4w==
X-Received: by 2002:a19:17c2:: with SMTP id 63-v6mr9040162lfx.112.1532933532538;
        Sun, 29 Jul 2018 23:52:12 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q19-v6sm1962059lji.14.2018.07.29.23.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 23:52:11 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:52:00 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v10 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180730065200.GA8862@localhost.localdomain>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <e737bb13d17b75ea5e55f59005ef3181d428e704.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <20180712130013.GJ4641@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712130013.GJ4641@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee & All others,

I'm physically back from my vacations so I can once again reach the
keyboard. So it's time to try address these issues =)

On Thu, Jul 12, 2018 at 02:00:13PM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> 
> > +	ret = regmap_read(bd71837->regmap, BD71837_REG_REV, &val);
> > +	if (ret) {
> > +		dev_err(&i2c->dev, "Read BD71837_REG_DEVICE failed\n");
> > +		return ret;
> > +	}
> 
> You never do anything with the value here.
> 
> Please either utilise it, read something useful or remove it.

Right. I'll add check that the chip revision is known and supported by
driver. Later I'll also use this value to distinguish between BD71837
and BD71847.

> > +struct bd71837_pmic;
> > +struct bd71837_clk;
> > +
> > +struct bd71837 {
> > +	struct device *dev;
> > +	struct i2c_client *i2c_client;
> 
> Are these both being used?
> 
> If you save one, you tend not to need the other.
> 

That's what I would call experience. I indeed only use the dev pointer
in subdevices - and what's even more ugly is that I use
dev_get_drvdata(pdev->dev.parent) - in regulator while I use
i2c_set_clientdata(i2c, bd71837); in MFD. This works because
i2c_set_clientdata actually calls dev_set_drvdata - buit that's not
pretty.

I think it would be more appropriate to drop the i2c_client because
subdevices need not to know the chip is connected via i2c. I'll do that
and also replace the call to i2c_set_clientdata with direct use of
dev_set_drvdata. Thanks!

> > +	struct regmap *regmap;
> > +	unsigned long int id;
> > +
> > +	int chip_irq;
> > +	struct regmap_irq_chip_data *irq_data;
> > +
> > +	struct bd71837_pmic *pmic;
> > +	struct bd71837_clk *clk;
> > +};
> > +
> > +#endif /* __LINUX_MFD_BD71837_H__ */
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
