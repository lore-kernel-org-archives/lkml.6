Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE7DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BEA2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ex3VoY2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BEA2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeGRQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:28:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39959 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbeGRQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:28:45 -0400
Received: by mail-pf0-f196.google.com with SMTP id e13-v6so2400398pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MI7D64/uxpc0ZvBqziwFaaddyp0sVIV++b20+qIL0dY=;
        b=ex3VoY2GfC2Q2r7ZFUWCLaLghzu3vrOqHhrUkcOgtojGO0HMrgBlfyFOlD23X8Wy+v
         urt/lXqrLev+9PHOvUw6yO4C7ltjUHTUUa9gtYLFWki6NYNWgPjUc2Hpv1P09zjgHMF6
         jfg5Wcv1O7uqT3SSF+vO/aQM218IlbZ5R01z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MI7D64/uxpc0ZvBqziwFaaddyp0sVIV++b20+qIL0dY=;
        b=SlTieB0Tv8+gyPXEhU0euZc0zaICzohbS1ifCI9cRZTq3tKeAL0xSq4891rUjhiEhc
         o0NYZeiybXlU/RQAblpGZq0jAKbttK3+qg8oAxzj1H3uj9p00Kv6sAx3FrHzor1yhfAj
         FJ51yht0YBk2CVrxbAtVqs5cCukWeXWwhn53YppQ+uRg+iL4YWdv8J4pi+Q9SjSuLpeK
         wYEks/8iE+NKn41QW7dEQqH/aNkql+Mm/y7xN9Ngstk2BzVuldpNlPXyzSTtNOA3WIG/
         oQbEXGlorYKwfEJCwdpVRv0jJwyAEg/V6wF7L7P/E5QMyF7wEI+FpB6AHLnByvKjEjfX
         +gXQ==
X-Gm-Message-State: AOUpUlHq8iVywue9yLIzMXGyLvUtAE7yFFDG0fkB3ECF6lUBPcIljuEE
        CbXA3s8a1mlS41/oCO2tSUgX
X-Google-Smtp-Source: AAOMgpeXVuX9CsGiPuu53iP4SgDEoL6ZhI1MniP3fZGM8MZ1yyQRq8GBBh+WP1mT5b0kas0phT3XOA==
X-Received: by 2002:a62:a018:: with SMTP id r24-v6mr5755498pfe.144.1531929014199;
        Wed, 18 Jul 2018 08:50:14 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628d:5c0b:c41c:3ac6:8e56:5127])
        by smtp.gmail.com with ESMTPSA id u11-v6sm10661684pfd.117.2018.07.18.08.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 08:50:13 -0700 (PDT)
Date:   Wed, 18 Jul 2018 21:20:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, andy.shevchenko@gmail.com, peda@axentia.se
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        afaerber@suse.de
Subject: Re: [PATCH v4 0/6] Add Actions Semiconductor Owl S900 I2C support
Message-ID: <20180718155000.GA3061@Mani-XPS-13-9360>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
 <20180711024502.GA4739@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711024502.GA4739@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:15:02AM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jul 01, 2018 at 10:52:59PM +0530, Manivannan Sadhasivam wrote:
> > This patchset adds I2C controller support for Actions Semiconductor S900 SoC.
> > This driver has been structured in a way such that there will be only
> > one controller driver for the whole Owl family series (S500, S700 and
> > S900 SoCs).
> > 
> > There are 6 I2C controllers with separate memory mapped register space.
> > The I2C controller can handle atmost two messages concatenated by a
> > repeated start via its internal address feature. Hence the driver
> > uses this feature for messages of length greater than 1. In those cases,
> > the first message of the combined message should be a `write` with maximum
> > message length 6 and the second message's maximum length should be 240 bytes.
> > 
> > As far as the bus speed is concerned, this driver only supports
> > Standard (100KHz) and High speed (400KHz) for now.
> > 
> > The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> > With the mux option available only for I2C0.
> > 
> > For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
> > are exposed on the Low speed expansion connector are enabled.
> > 
> > This series depends on the pinctrl patch [1] is still not merged by the
> > platform maintainer Andreas but it has been reviewed by the pinctrl maintainer
> > Linus Walleij. For the reference, I have queued up all reviewed dts patches
> > in my tree [2] from which Andreas is picking them for 4.19.
> > 
> > For this series, since the dts patches will go through the ARM SoC tree,
> > Andreas will pick it up once it is reviewed.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://patchwork.kernel.org/patch/10322937/
> > [2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next
> > 
> 
> Hi Andy, Peter,
> 
> Just a gentle ping on this v4!
> 
> Thanks,
> Mani
>

Hi,

Any update on this patchset?

Thanks,
Mani

> > Changes in v4:
> > 
> > As per Andy and Peter review:
> > 
> > * Used spinlock for accessing most of the register access (only parts
> >   involved sleep/long-busy-wait has been excluded)
> > * Removed returning 0 and added -ENXIO if the msg_ptr not equals to
> >   message length
> > * Added DIV_ROUND_UP for setting clock frequency
> > * Changed one non-atomic mdelay instance to usleep_range
> > * Moved pinctrl definition patch before dts patch
> > * Fixed the driver to support only 100KHz and 400KHz frequencies
> > 
> > Changes in v3:
> > 
> > As per Peter, Andy and Andreas review:
> > 
> > * Removed owl_i2c_reset function from interrupt handler since it
> >   involves the use of delays.
> > * Fixed the return path in owl_i2c_master_xfer and added a note
> > * Changed "base" parameter to "reg" in owl_i2c_update_reg for better
> >   understandability
> > * Ordered the includes in alphabetical order
> > * Small changes to defines and added comma at the end of struct members
> > * Removed rendundant 0 assignment in owl_i2c_master_xfer
> > * Changed all OWL naming convention to Owl and also changed Actions Semi
> >   naming to Actions Semiconductor
> > 
> > Changes in v2:
> > 
> > As per Andy's review:
> > * Modified infinite loops to fixed number of retries
> > * Used i2c_8bit_addr_from_msg for constructing the slave address
> > * Removed unnecessary parenthesis around defines
> > * Modified certain dev_warn to dev_dbg
> > * Modified the error handling to more generic pattern
> > 
> > * Fixed the return value in owl_i2c_master_xfer
> > * Added MAINTAINERS patch for I2C driver and its binding
> > 
> > Manivannan Sadhasivam (6):
> >   dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C
> >     controller
> >   arm64: dts: actions: Add pinctrl definition for S900 I2C controller
> >   arm64: dts: actions: Add Actions Semiconductor S900 I2C controller
> >     nodes
> >   arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
> >   i2c: Add Actions Semiconductor Owl family S900 I2C driver
> >   MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
> > 
> >  .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
> >  MAINTAINERS                                   |   2 +
> >  .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 +
> >  .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
> >  arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
> >  drivers/i2c/busses/Kconfig                    |   7 +
> >  drivers/i2c/busses/Makefile                   |   1 +
> >  drivers/i2c/busses/i2c-owl.c                  | 504 ++++++++++++++++++
> >  8 files changed, 641 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
> >  create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
> >  create mode 100644 drivers/i2c/busses/i2c-owl.c
> > 
> > -- 
> > 2.17.1
> > 
