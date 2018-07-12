Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B38C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1312E2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep+kwdDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1312E2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeGLO1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732321AbeGLO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:27:30 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAD521486
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531405063;
        bh=u9R34N3LulDGQif8PzupIa/tB3+m5C8Fd8auMz6q/HI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ep+kwdDf19boMfF4vVxtse/d4SV70VdnV9DxFJZxJvlOq4/v5Lq2dVdIf6FJ5yEr/
         sqI9xX1X8ttDjiilqt5yOURQPEASX67C3BkHvZ7wi95vVkI5gE2PggCpSVsTzDus+m
         CH1nldGltHrNHhjrKpj86T7TxEr3tL5XMbw3LIqY=
Received: by mail-wr1-f49.google.com with SMTP id b15-v6so21920647wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:17:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlFrXy/R3UiNoAd17pTv4/MQIHh/yqgsFxPLBA7c6dGaOhLADfFO
        ndNH9K3aTwPiLvPvVY/RzjuZ5w7qn38Muf/kPttq0A==
X-Google-Smtp-Source: AAOMgpfZO81CwDM5YClWZGk8DJiMU5XfVPM9vnYL+cpysiIiie3ape1TN5r1IF/5Om15ALmdat0ANc91J5TzrG24yBQ=
X-Received: by 2002:adf:9465:: with SMTP id 92-v6mr2095340wrq.283.1531405061253;
 Thu, 12 Jul 2018 07:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180710163658.6175-1-yixun.lan@amlogic.com> <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop> <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
In-Reply-To: <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Jul 2018 08:17:29 -0600
X-Gmail-Original-Message-ID: <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
Message-ID: <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock controller
To:     yixun.lan@amlogic.com
Cc:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, carlo@caione.org,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, miquel.raynal@bootlin.com,
        boris.brezillon@bootlin.com, martin.blumenstingl@googlemail.com,
        liang.yang@amlogic.com, qiufang.dai@amlogic.com,
        jian.hu@amlogic.com, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 8:47 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> Hi Rob
>
> see my comments
>
> On 07/12/18 03:43, Rob Herring wrote:
> > On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
> >> Document the MMC sub clock controller driver, the potential consumer
> >> of this driver is MMC or NAND.
> >
> > So you all have decided to properly model this now?
> >
> Yes, ;-)
>
> >>
> >> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> >> ---
> >>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >> new file mode 100644
> >> index 000000000000..ff6b4bf3ecf9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >> @@ -0,0 +1,31 @@
> >> +* Amlogic MMC Sub Clock Controller Driver
> >> +
> >> +The Amlogic MMC clock controller generates and supplies clock to support
> >> +MMC and NAND controller
> >> +
> >> +Required Properties:
> >> +
> >> +- compatible: should be:
> >> +            "amlogic,meson-gx-mmc-clkc"
> >> +            "amlogic,meson-axg-mmc-clkc"
> >> +
> >> +- #clock-cells: should be 1.
> >> +- clocks: phandles to clocks corresponding to the clock-names property
> >> +- clock-names: list of parent clock names
> >> +    - "clkin0", "clkin1"
> >> +
> >> +Parent node should have the following properties :
> >> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"
> >
> > You don't need "simple-mfd" and probably not syscon either. The order is
> > wrong too. Most specific first.
> >
> Ok, I will drop "simple-mfd"..
>
> but the syscon is a must, since this mmc clock model access registers
> via the regmap interface

A syscon compatible should not be the only way to get a regmap.
Removing lines 56/57 of drivers/mfd/syscon.c should be sufficient.

Why do you need a regmap in the first place? What else needs to access
this register directly? Don't you need a patch removing the clock code
from within the emmc driver? It's not even using regmap, so using
regmap here doesn't help.

Rob
