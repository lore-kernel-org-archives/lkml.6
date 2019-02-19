Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D935C20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550589733;
	bh=nWrp3hRt+m/nWI1jpFziRhc1dk8W/7e+eu+0/lLsSuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iVWjBwTsXwpWaLc/vthfPHW9fbqf2joKpiTg0L/3AT5KcX+pd/5bRF6rdUmsGYJfW
	 5poDM3rN0M4bwBvwE2mH8e6uVqn7yzfFVXqbqfOuCJ/qry3NvxeIn/4a5d7M//VQux
	 eTzCOJS8/pBwBoklrG+g6wt0PV/GvYoSZuhdCtS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfBSPWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:22:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSPWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:22:11 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8951821773;
        Tue, 19 Feb 2019 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550589729;
        bh=nWrp3hRt+m/nWI1jpFziRhc1dk8W/7e+eu+0/lLsSuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fH2222xkFAwQphhNO87XJwKnDMy6hs/hiOYFc7un/JyK0Dng3BcSyJWLXskIl/1j/
         Y/RRpjwvzhecmFG/3r+jJvbxHYegf8MR8ev73KRu6AQLwinJ94EFXkr/9nshp4E9va
         u3t1+1esuPBWmd+wxQla7hyAkaNoKxz+h3yA/fyk=
Received: by mail-qt1-f177.google.com with SMTP id d18so13455437qtg.12;
        Tue, 19 Feb 2019 07:22:09 -0800 (PST)
X-Gm-Message-State: AHQUAub+Dj/pZ2q/uMGABxsCX28kO/H/Qlsv7tDVpp33EEpIgW8RVnEE
        bnoYLtmz5nZvJYPqSdYIJWVAAEmnddJcoo7Tdg==
X-Google-Smtp-Source: AHgI3IZ8hSkfBrnjFm51aMPEPzA4H/4KOCD8rtwWi0pAdp5c6cvDqtwNDEyLJmh2A82Vjgpo1ZygklPp5RoOslsWz3Q=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr22638752qta.76.1550589728749;
 Tue, 19 Feb 2019 07:22:08 -0800 (PST)
MIME-Version: 1.0
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com> <20190218163211.GB2714@bogus>
 <1550544357.4739.32.camel@mhfsdcap03>
In-Reply-To: <1550544357.4739.32.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Feb 2019 09:21:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgp615eJZnSu6aogzLwubnBKdxdU8+19hj=hS1aOWefA@mail.gmail.com>
Message-ID: <CAL_JsqKgp615eJZnSu6aogzLwubnBKdxdU8+19hj=hS1aOWefA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Erin Lo <erin.lo@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 8:46 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> On Mon, 2019-02-18 at 10:32 -0600, Rob Herring wrote:
> > On Fri, Feb 15, 2019 at 02:02:35PM +0800, Erin Lo wrote:
> > > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > >
> > > The commit adds mt8183 compatible node in binding document.
> > >
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > new file mode 100644
> > > index 0000000..364e673
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > @@ -0,0 +1,115 @@
> > > +* Mediatek MT8183 Pin Controller
> > > +
> > > +The Mediatek's Pin controller is used to control SoC pins.
> > > +
> > > +Required properties:
> > > +- compatible: value should be one of the following.
> > > +   "mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > > +- gpio-controller : Marks the device node as a gpio controller.
> > > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > > +  binding is used, the amount of cells must be specified as 2. See the below
> > > +  mentioned gpio binding representation for description of particular cells.
> > > +- gpio-ranges : gpio valid number range.
> > > +- reg: physicall address base for gpio base registers. There are nine
> > > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > > +  0x11F30000.
> >
> > You don't need to list out each address, just what each address is. (Or
> > just '9 GPIO base addresses'.)
>
> ==>ok, we will change it.
> >
> > > +
> > > +   Eg: <&pio 6 0>
> >
> > How is this an example of reg? Seems something is missing.
> >
> > > +   <[phandle of the gpio controller node]
> > > +   [line number within the gpio controller]
> > > +   [flags]>
> > > +
> > > +   Values for gpio specifier:
> > > +   - Line number: is a value between 0 to 202.
> > > +   - Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > > +            Only the following flags are supported:
> > > +            0 - GPIO_ACTIVE_HIGH
> > > +            1 - GPIO_ACTIVE_LOW
> > > +
> > > +Optional properties:
> > > +- reg-names: gpio base register names. There are nine gpio base register
> > > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > > +- interrupt-controller: Marks the device node as an interrupt controller
> > > +- #interrupt-cells: Should be two.
> > > +- interrupts : The interrupt outputs from the controller.
> >
> > outputs? More than 1? If so, need to say what they are and the order.
> >
> ==> there is only use one interrupt in mt8183. we will change
> "interrupts" to "interrupt" in v8.

No, 'interrupts' is always plural. The problem is 'outputs'.

Rob
