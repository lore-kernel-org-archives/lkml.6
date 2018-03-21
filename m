Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeCUUEn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:04:43 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:40072 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbeCUUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:04:38 -0400
X-Google-Smtp-Source: AG47ELuW/HxJsZ35NoDmPlnxnFw9wbDSADqGcGd+wazlVYn7iDgS5NQmI3w0ZEI03EKV3EJDi+Tfkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1521655629.23017.84.camel@linux.intel.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <1521655629.23017.84.camel@linux.intel.com>
Message-ID: <152166267662.91116.8188392814465278915@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be requested
Date: Wed, 21 Mar 2018 13:04:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2LK51WZ030153

Quoting Andy Shevchenko (2018-03-21 11:07:09)
> On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> > +static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned
> > offset)
> > +{
> > +     struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> > +     struct gpio_chip *chip = &pctrl->chip;
> > +
> > +     if (gpiochip_line_is_valid(chip, offset))
> > +             return 0;
> > +
> > +     return -EINVAL;
> 
> Perhaps traditional pattern
> 
> if (!...)
>  return -EINVAL;
> 
> return 0;
> 

Or ternary?

  return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;

> 
> > +}
> 
> >       seq_printf(s, " %dmA", msm_regval_to_drive(drive));
> > -     seq_printf(s, " %s", pulls[pull]);
> > +     seq_printf(s, " %s\n", pulls[pull]);
> 
> I had commented this once, but you ignored by some reason.
> 
> I would rather just move 
>  seq_puts(s, "\n");
> here.
> 
> The rationale behind, besides making diff more neat, is to reduce
> possible burden in the future if someone would like to squeeze more data
> in between.

Sure.

> 
> > +             tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
> 
> sizeof(*tmp) ?
> 

Ok.
