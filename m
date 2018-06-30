Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA8BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99724FCA
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkSHZ5cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99724FCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937000AbeF3MoS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 08:44:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36375 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936446AbeF3MoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 08:44:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id m19-v6so1610650pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wa767PseyMPn2KUIWa5tBXnpCkzL5vpgnL5LITTbrPc=;
        b=BkSHZ5cnp4dWxVjfLzgUm7gAFLcvC0htGbePYtmUl/cWeS9KNzHfAnp7sxbfJF8aXi
         D4C/nPcLoUOU37W4BRidCutxR/hm6c7bRtCoKw1LyRqNLmJIPmDKgEqUJPytABOID4qr
         alVVCGXgESd0+PvTWjS55Ejs52piHeuA35Uek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wa767PseyMPn2KUIWa5tBXnpCkzL5vpgnL5LITTbrPc=;
        b=gaCvjk4LSUcSIaCIs7U5BojAOrmGsa7eOIlZ8lw98AUB7FRZxzvX3qydow0obJ457T
         Z/pFe9uLjLy36+MkUUSCRBRwHDNx4UJ5IWtVMcDFfhjBbN4ICQZqe/A12tbXk8I/mr8E
         39AM6XSN4JwrJ7aowvmWwGZqcY5HMQFwy0gqRfDjd4gUPp+CIpd1i9Ecof43qgdN/0Mz
         zUO/BdTxZUG1MSaRky4E0LvOVxsQS5nEfEuDMl9OdIHc88RfqxK7t2I0GE4v0JrjrxXU
         NzZWhOmX/OKhOcrZSGye51UUGzdm5aYxeD9vvxU3xlp+3r/+rFFuBrk3isvQFIeq85dc
         9axg==
X-Gm-Message-State: APt69E3aElWIwXnE7z/duJotSdvMNOkIKCgTco0gjHlLydMZoMUPkkfc
        CnzUhBOh2aYIUHMZfm5MWolT
X-Google-Smtp-Source: AAOMgpf/ov4KZMjuMwOH5DIPi6wp1QauEmx7Puvc3hPxNDfLKPcs76R72L0m8/yrqN8CYDXMI5xArw==
X-Received: by 2002:a62:d24a:: with SMTP id c71-v6mr10171251pfg.242.1530362653689;
        Sat, 30 Jun 2018 05:44:13 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id m15-v6sm25146643pff.108.2018.06.30.05.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 05:44:13 -0700 (PDT)
Date:   Sat, 30 Jun 2018 18:14:00 +0530
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
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
Message-ID: <20180630124400.GB16775@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
 <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Jun 30, 2018 at 03:14:37PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add Actions Semi OWL family S900 I2C driver.
> 
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> 
> > +#include <linux/io.h>
> 
> Perhaps keep in order?
> 

Fixed in next revision.

> > +#define OWL_I2C_DEFAULT_SPEED  100000
> > +#define OWL_I2C_MAX_SPEED      400000
> 
> ..._SPEED -> ..._SPEED_HZ ?
> 
> DEFAULT -> DEF ?
>

Okay.

> > +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> > +{
> > +       unsigned int val, timeout = 0;
> > +
> > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> > +                               OWL_I2C_CTL_EN, false);
> 
> > +       mdelay(1);
> 
> 1 ms keeping CPU busy for nothing. Perhaps usleep_range() / msleep()?
> Is it called in atomic context?
> 

I have removed reset function from the interrupt handler and gave the
justification to my reply to Peter's review.

> > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> > +                               OWL_I2C_CTL_EN, true);
> > +
> > +       /* Reset FIFO */
> > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> > +                               OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> > +                               true);
> > +
> > +       /* Wait 50ms for FIFO reset complete */
> > +       do {
> > +               val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> > +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> > +                       break;
> 
> > +               mdelay(1);
> 
> Ditto.
> 

Same as above.

> > +       } while (timeout++ < OWL_I2C_MAX_RETRIES);
> 
> OK, I see you call it from IRQ context. 50ms for IRQ handler is
> inappropriate. (1ms either, but at least not so drastically).
> 

Same as above.

> > +}
> 
> > +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> > +{
> 
> > +       stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> > +       if (stat & OWL_I2C_STAT_BEB) {
> > +               dev_dbg(&i2c_dev->adap.dev, "bus error");
> 
> > +               owl_i2c_reset(i2c_dev);
> 
> This is questionable to be here (looking at so loong delays in it).
> 

Same as above.

> > +               goto stop;
> > +       }
> 
> > +       return IRQ_HANDLED;
> > +}
> 
> > +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> > +                               int num)
> > +{
> 
> > +       int ret = 0, idx;
> 
> Redundant assignment.
> 

No. Actually the return path will be fixed in next iteration. Please
see my reply to Peter's review for explanation.

> > +       ret = owl_i2c_hw_init(i2c_dev);
> > +       if (ret)
> > +               return ret;
> 
> > +}
> 
> > +static const struct i2c_algorithm owl_i2c_algorithm = {
> > +       .master_xfer    = owl_i2c_master_xfer,
> 
> > +       .functionality  = owl_i2c_func
> 
> Slightly better to keep comma at the end
> 

Okay.

> > +};
> > +
> > +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> > +       .flags          = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> > +       .max_read_len   = 240,
> > +       .max_write_len  = 240,
> > +       .max_comb_1st_msg_len = 6,
> > +       .max_comb_2nd_msg_len = 240
> 
> Ditto.
> 

Okay.

Thanks,
Mani

> > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko
