Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB3C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B8520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550504908;
	bh=Xd/iRCsn6/K7S0Mk6bCD41qjZY2c6p/jhPrQwc8FyMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OjVS1CpInOfp4hA90zQNzohba6o7wGFhM5E14elAzEi75Kb7/5+SUiUUpBXaL6QUR
	 gCvpByz5+TzAflyTx83sHvqcWeoiss5JTA6+c2xX4VwaBk1yuExsZJ9tCLdTx4SkXM
	 u885XNCL1/SxEzFKSAThfA5V1MzmXzFJ/r1v5fbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfBRPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:48:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43504 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfBRPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:48:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so28948985ota.10;
        Mon, 18 Feb 2019 07:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y6yxkg7qrm3Yj/JlHLGtkgFxQYAdQMcxpMZZhqrjvyc=;
        b=Tm9qa6YjaXYv3l53Vgx+OP4PLQkHM2SIgnOHKcO41hGv32BcRUDgWtKBzlSDg34PbR
         6NEwVkwrMxmYvXP92lXuyLcR1+JCYsfbD6MU8/LvA1uUEI4SYIakVurTGgkolyMbjSpZ
         CRbKpE+owc32+vnIf2pB7ANENl9ph50OmHfJQhLmy9Q4CwMPIW0xjksEwhyQV3x4rG3m
         C1wsWyj0zsDI2fnAWLnOPnrGs/Q2ozB7gaYpKjEF7QHT+WU9appI8eSg4b8nL9gZ0r1k
         qrhUqArmICV4Zc23vVjg/mVoxsBx2vt2iFtYQYn4JQbsfSv9t+Rk+tuViPeFQODd9XXE
         +hPw==
X-Gm-Message-State: AHQUAuYHEb8QGc9qTQKbR6erv2zVuI2riMsRl0eQr07FZPaV2hgdotNj
        plUkOj7SpXZuYSJm0Ah77w==
X-Google-Smtp-Source: AHgI3IYwDLG9UKzh+4ytyV2W6xeyPi2GNZirFS/yQlzqBnFYv4s5jdqzanKWrjRhfZY443wznRPRiQ==
X-Received: by 2002:aca:4a15:: with SMTP id x21mr14156415oia.122.1550504905275;
        Mon, 18 Feb 2019 07:48:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm5814336otl.58.2019.02.18.07.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 07:48:24 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:48:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Erin Lo <erin.lo@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
Message-ID: <20190218154823.GA2714@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
 <2b221339-3933-2a25-ab60-d4d772d2873a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b221339-3933-2a25-ab60-d4d772d2873a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:35:39AM +0100, Matthias Brugger wrote:
> 
> 
> On 15/02/2019 07:02, Erin Lo wrote:
> > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > 
> > The commit adds mt8183 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > new file mode 100644
> > index 0000000..364e673
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > @@ -0,0 +1,115 @@
> > +* Mediatek MT8183 Pin Controller
> > +
> > +The Mediatek's Pin controller is used to control SoC pins.
> > +
> > +Required properties:
> > +- compatible: value should be one of the following.
> > +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > +  binding is used, the amount of cells must be specified as 2. See the below
> > +  mentioned gpio binding representation for description of particular cells.
> > +- gpio-ranges : gpio valid number range.
> > +- reg: physicall address base for gpio base registers. There are nine
> 
> s/physicall/physical
> 
> > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > +  0x11F30000.
> > +
> > +	Eg: <&pio 6 0>
> > +	<[phandle of the gpio controller node]
> > +	[line number within the gpio controller]
> > +	[flags]>
> > +
> > +	Values for gpio specifier:
> > +	- Line number: is a value between 0 to 202.
> > +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > +            Only the following flags are supported:
> > +            0 - GPIO_ACTIVE_HIGH
> > +            1 - GPIO_ACTIVE_LOW
> > +
> > +Optional properties:
> > +- reg-names: gpio base register names. There are nine gpio base register
> > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > +- interrupt-controller: Marks the device node as an interrupt controller
> > +- #interrupt-cells: Should be two.
> > +- interrupts : The interrupt outputs from the controller.
> 
> we are missing interrupt-parent here.

No, because interrupt-parent is implied and may be in a parent node.

What's missing is how many interrupts and what are they? 

Rob
