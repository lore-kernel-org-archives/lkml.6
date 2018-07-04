Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBEFC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05002083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05002083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934441AbeGDIm5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:42:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39248 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933813AbeGDIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:39:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id t7-v6so3654767ljj.6;
        Wed, 04 Jul 2018 01:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2mFwD08N3LEvCNMK4uqicF8FNwPyNYaO9FooUdtGRZs=;
        b=ec+mjvEHZozLY8d9kOa2Bm1yOvol3aYSN8ZkTkbos4eSj/ha8sNC5VTfwVDyWgQGzt
         MMyTrcs+a3bNcGNfswgwsEoGQVg5MaJEeZm5M7jKYKze5aBrRKDSoY3OXyqJHcUmusr0
         X19E4D9U6Vev+qYIvb0nhMQkOFG7V5QGbHAYxFlRO65qt0thj18DkG+/PAFchGW4VUHN
         3whUp2CenCtpERMSzTMzCnsD49yh9TtIq6RSmG8s7uJP9EaU1c4tAQVimlLVj5IrYAKu
         skVdLo+O/NcD8Ole9ydn816Oh8UiMwHv51HxfAmcz+2YDOQ8BW+vyyWk5gGPtTeoVVRU
         88AQ==
X-Gm-Message-State: APt69E0Jb6N4MweUVwn4RiDU4hLscoGjaz8CWmAUA1ZC//fQ0qgZWsVG
        5j9Sacerw1yM0OItv9cx7C0=
X-Google-Smtp-Source: AAOMgpdPU+QAWxvJ6faUWOge/KrtyvmLTikpf0v89yM8MPgJrbJ2/W2lihQwKyqbpk4GYwlmMg7hew==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr812338lji.11.1530693555683;
        Wed, 04 Jul 2018 01:39:15 -0700 (PDT)
Received: from localhost.localdomain (82-203-190-178.bb.dnainternet.fi. [82.203.190.178])
        by smtp.gmail.com with ESMTPSA id l5-v6sm677451lfc.56.2018.07.04.01.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 01:39:14 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:39:11 +0300
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
Message-ID: <20180704083911.GH2118@localhost.localdomain>
References: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <18a04e42debb2a23aec855cac3bcf3d6ab6c55fd.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_533te3UuY9V9U+Z0yxTkW==3wsK22uzB4G=aWGour7Quw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_533te3UuY9V9U+Z0yxTkW==3wsK22uzB4G=aWGour7Quw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Enric, Lee and others.

Thanks again for taking the time to review the patch! I do appreciate
the effort. Especially because I find reviewing to be quite hard work.

You spotted some obvious things to change but additionally commented on
things which I would rather not change. (Namely the platdata usage and
replacing gotos with in-pklace returns). I would like to get opinion
from Lee on these before implementing the changes. So I will cook new
åatch only after I know what changes are required. Please see my view on
suggested changes below.

On Tue, Jul 03, 2018 at 11:26:00AM +0200, Enric Balletbo Serra wrote:
> One doubt regarding the probe function and few comments.

> 
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dv., 29 de juny 2018 a les 11:47:
> >
> > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > for three subsystems:
> > - clk
> > - Regulators
> > - input/power-key
> >
> > fix too long lines
> 
> I guess that this message is not intended to be here.

Right. That's a leftover from squash commit. Good catch!
> 
> > +static int bd71837_i2c_probe(struct i2c_client *i2c,
> > +                           const struct i2c_device_id *id)
> > +{
> > +       struct bd71837 *bd71837;
> > +       struct bd71837_board *board_info;
> > +       int ret = -EINVAL;
> > +
> > +       board_info = dev_get_platdata(&i2c->dev);
> 
> Sorry in advance if I am missing something, but isn't this always NULL?
At the moment, yes. But the idea is that one using this PMIC could
relatively easily get rid of the "depends on OF" if the PMIC is controlled
for example using X86 family chips. So platdata is a mechanism that
could be used to bring in for example the irq information - or perhaps
the chip type when I add support to BD71847. I can remove the platdata
for now if it really bothers - but if it does not, then I would like to
keep it in.
> 
> > +
> > +       if (!board_info) {
> 
> then this check is not required

Yes. But as I said, I would like to keep this so that platdata could be
used for giving the HW information to driver on certain architectures,
But as I said - if this is a problem it can be removed. Please let me
know if platdata usage is a "show stopper" here.
> 
> > +               board_info = devm_kzalloc(&i2c->dev, sizeof(*board_info),
> > +                                         GFP_KERNEL);
> > +               if (!board_info) {
> > +                       ret = -ENOMEM;
> > +                       goto err_out;
> 
> Now that you use devm calls and you don't need to unwind things I
> think is better to use plain returns. So,
> 
> return -ENOMEM;

I have never really understood why use of gotos in error handling is
discouraged. Personally I would always choose single point of exit from
a function when it is simple enough to achieve (like in this case). I've
written and fixed way too many functions which leak resources or
accidentally keep a lock when exiting from error branches. But I know
many colleagues like you who prefer not to have gotos but  in place returns
instead. So I guess I'll leave the final call on this to the one who is
maintainer for this code. And it is true there is no things to unwind
now - which does not mean that next updater won't add such. But as I
said, I know plenty of people share your view - and even though I rather
maintain code with only one exit the final call is on subsystem maintainer
here.
> 
> > +               } else if (i2c->irq) {
> 
> IMO this else is confusing, also maybe you want to warn about the
> missing interrupt.

Right. The else is completely unnecessary as we have goto in previous
if. Nicely spotted-

> 
> if (!i2c->irq) {
>     dev_err(&i2c->dev, "No IRQ configured!);
>     return -EINVAL;
> }
> 
> > +                       board_info->gpio_intr = i2c->irq;
> 
> Is board_info really necessary?
> 

As explained before the idea of board info is to be able to provide the
HW description without device-tree. It could be used for example to provide
the regulator information to sub device(s). I have not tested/used this
mechanism as my development setup relies on DT - but I like to keep this
as an option for those who need to work on archs which do not have DT
support.

> > +               } else {
> > +                       ret = -ENOENT;
> > +                       goto err_out;
> > +               }
> 
> and remove the else
> 
> > +       }
> > +
> > +       if (!board_info)
> > +               goto err_out;
> > +
> 
> This is redundant.

Right. We have alloc check abowe and goto error there.
 
> > +       bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
> > +       if (bd71837 == NULL)
> 
> if (!bd71837)
> 

Right.

> > +               return -ENOMEM;
> > +
> > +       i2c_set_clientdata(i2c, bd71837);
> > +       bd71837->dev = &i2c->dev;
> > +       bd71837->i2c_client = i2c;
> > +       bd71837->chip_irq = board_info->gpio_intr;
> 
> bd71837->chip_irq = i2c->irq;
> 

Maybe not if we want to keep the platdata support, right?

> > +
> > +       bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
> > +       if (IS_ERR(bd71837->regmap)) {
> > +               ret = PTR_ERR(bd71837->regmap);
> > +               dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
> > +               goto err_out;
> 
>     dev_err(bd71837->dev, "regmap initialization failed: %d\n", ret);
>     return PTR_ERR(bd71837->regmap);
> 

This goes back to the discussion on whether to prefer single point of
exit or not.

> > +       }
> > +
> > +       ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
> > +       if (ret < 0) {
> > +               dev_err(bd71837->dev,
> > +                       "%s(): Read BD71837_REG_DEVICE failed!\n", __func__);
> 
> __func__ part is redundant.
> 

Indeed. Thanks.

> > +               goto err_out;
> return ret;

Rest of the comments can be fixed if we choose to add multpile exit
points. But as I said, I would prefer having only one so let's wait for
another opinion, Ok?

Best Regards,
	Matti Vaittinen

