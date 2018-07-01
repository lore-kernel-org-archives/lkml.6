Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFDC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064B24FDC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIdap94Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F064B24FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeGAImB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:42:01 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43094 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeGAIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:41:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id v13-v6so168532pgr.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDK3E3yAEoIJApbawD9/XQYMaXzSADsoh28cx/Mtlzg=;
        b=XIdap94Qh/IeSa4eRJphwN7BismlUHPNBM9zUvaQu3toUVzKk7oVpzd4NPcrT0VTiK
         s9jhXGfrFOniW5rUFMPe5IM3WjM4svM6EL1utGj5+K1hubIQ/kAgPQJ5Z/is2oz29e95
         X0sr4+RPZ1/ACYeQMjPvUzXHaHGqS0admN9VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDK3E3yAEoIJApbawD9/XQYMaXzSADsoh28cx/Mtlzg=;
        b=rkGf6XqFSGeXRGGdMPxEWQbcN+dQl1eh6YQupQ9p956KogeGZGQlvK0MtUncZqEfaM
         VrSIPGSIsWeLw6evHCSrH+E2USFF8s3RQa72KG4Suj0udz0TRrsDOaeq6IaRx+1ri9K4
         eGu4IU7MnQEs0TwjQvOqqC2UfWqFNetqIwispA0im2E7A6vh9NfltajhaKmJbdJIyPYG
         vL1mDvi7yW3n/mfRarw5B4n4IGCulJoFQ2M9I1jpDR+zTJZCvqJEORJszMZcCMAvGiwS
         Ywv5sn0nO0kKVHdmhGOKehrUZM96tteYc2b+o4kGqi0758ylPcd2+ecuHsvNTLGezZdr
         uqWw==
X-Gm-Message-State: APt69E2CcBttoKiBPjN0lwYe9ho+LhEdMy7/0+cJrs5r7eLXCJNssyl5
        o9N/LD7Lazve+T9vzZK+whKF
X-Google-Smtp-Source: AAOMgpc5a97N4ZEb27BXiZ32eylmzgGR5b/YVbUqLJbHFTTqujBjML2FWu+V9gw77bHkBujROfD6ww==
X-Received: by 2002:a62:e117:: with SMTP id q23-v6mr21151626pfh.75.1530434514777;
        Sun, 01 Jul 2018 01:41:54 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73c0:9e12:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id b1-v6sm1706999pfc.97.2018.07.01.01.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 01:41:54 -0700 (PDT)
Date:   Sun, 1 Jul 2018 14:11:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Message-ID: <20180701084140.GC28390@Mani-XPS-13-9360>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
 <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
 <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
 <20180701081333.GB28390@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701081333.GB28390@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 01:43:33PM +0530, Manivannan Sadhasivam wrote:
> Hi Andy,
> 
> On Sun, Jul 01, 2018 at 12:11:00AM +0300, Andy Shevchenko wrote:
> > On Sat, Jun 30, 2018 at 4:33 PM, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > Add Actions Semiconductor Owl family S900 I2C driver.
> > 
> > Thanks for an update. Few left comments and it would LGTM.
> > 
> 
> Thanks :)
> 
> > > +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> > > +{
> > 
> > > +       mdelay(1);
> > 
> > But now, since it's not used in atomic context, we may switch to
> > usleep_range() / msleep() instead.
> > 
> 
> okay, will use msleep()
>

Just realised, I have to use spinlock for the entire owl_i2c_master_xfer
function, so can't use sleep* for delay.

> > > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> > > +                               OWL_I2C_CTL_EN, true);
> > > +
> > 
> > > +       /* Wait 50ms for FIFO reset complete */
> > > +       do {
> > 
> > > +               mdelay(1);
> > 
> > Especially in this case it's very important.
> > 
> 
> Okay.

Same here, but I'm not sure about the latency. What is your suggestion?

Thanks,
Mani

> 
> > > +       } while (timeout++ < OWL_I2C_MAX_RETRIES);
> > 
> > > +}
> > 
> > > +       val = (i2c_dev->clk_rate + i2c_dev->bus_freq * 16 - 1) /
> > > +                               (i2c_dev->bus_freq * 16);
> > 
> > This is effectively DIV_ROUND_UP(->clk_rate, ->bus_freq * 16).
> > 
> 
> Ack.
> 
> > > +       /*
> > > +        * By default, 0 will be returned if interrupt occurred but no
> > > +        * read or write happened. Else if msg_ptr equals to message length,
> > > +        * message count will be returned.
> > > +        */
> > 
> > > +       if (i2c_dev->msg_ptr == msg->len)
> > > +               ret = num;
> > 
> > I dunno if
> > 
> > ret = ->msg_ptr == len ? num : 0;
> > 
> > would be slightly more explicit (yes, I aware about ret == 0).
> > 
> > Up to you to choose.
> > 
> 
> As per Peter's comment, returning 0 will get changed to an error value.
> Will use this pattern once we settle with a proper error value.
> 
> > > +       /* We support only frequencies of 100k and 400k for now */
> > > +       if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> > > +                       i2c_dev->bus_freq > OWL_I2C_MAX_SPEED_HZ) {
> > 
> > I think it should be != in the second case as well.
> > 
> 
> yeah, agree. We don't support any other frequencies now.
> 
> Thanks,
> Mani
> 
> > > +               dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> > > +               return -EINVAL;
> > > +       }
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
