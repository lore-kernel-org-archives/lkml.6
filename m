Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17440C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223620858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKUVvJUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D223620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJHUmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbeJHUmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:42:36 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8870E20878;
        Mon,  8 Oct 2018 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539005450;
        bh=Ga+54931F5Dp4fhweeArGpOswihb1FQDHPktxIyMDQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mKUVvJUBBFZR49VETkxPZZxXQdhScq8rGh0FpGtCuKA0qTE6nvkvXJnGphNjFZMsm
         eh7qJzkO/6TNKWR3GjUdyOP9a07h2FsobxEH/MY2KeYgFrui3cOXJQjEzSBc7ZnAl4
         9KAntnk6sRpyNaZQpZoxdWO+ZwFWDe++hVUW4L3A=
Received: by mail-qk1-f179.google.com with SMTP id y8-v6so12018467qka.11;
        Mon, 08 Oct 2018 06:30:50 -0700 (PDT)
X-Gm-Message-State: ABuFfojiHA/aue6CtLVNcmiRHhPA0UliZlnSSW41Mo5xDnAptPyGFMMX
        /2e7fdYhZkiR5KqSyGbxq4pErb9d8+nx4sP6Vg==
X-Google-Smtp-Source: ACcGV60+gkqFHl0OW0BTcEJKlX6KgPXre9Ljbe7MrYkNZBn9Qwdt2cOD0NuVi5gPt2omgV+8IjCm4zQ81/Vg0VIQYAY=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr18763505qks.147.1539005449747;
 Mon, 08 Oct 2018 06:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-23-robh@kernel.org>
 <20181008070142.GM3587@dragon>
In-Reply-To: <20181008070142.GM3587@dragon>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Oct 2018 08:30:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJu0AGH7VizWJJVB2UnFhWKwMVTm-EznOfhDVabgQUA_g@mail.gmail.com>
Message-ID: <CAL_JsqJu0AGH7VizWJJVB2UnFhWKwMVTm-EznOfhDVabgQUA_g@mail.gmail.com>
Subject: Re: [PATCH 22/36] dt-bindings: arm: Convert FSL board/soc bindings to json-schema
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 2:02 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Oct 05, 2018 at 11:58:34AM -0500, Rob Herring wrote:
> > Convert Freescale SoC bindings to DT schema format using json-schema.

> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: i.MX23 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx23-evk
> > +              - olimex,imx23-olinuxino
> > +          - const: fsl,imx23
> > +
> > +      - description: i.MX25 Product Development Kit
> > +        items:
> > +          - enum:
> > +              - fsl,imx25-pdk
> > +          - const: fsl,imx25
> > +
> > +      - description: i.MX27 Product Development Kit
> > +        items:
> > +          - enum:
> > +              - fsl,imx27-pdk
> > +          - const: fsl,imx27
> > +
> > +      - description: i.MX28 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx28-evk
> > +              - i2se,duckbill
> > +              - i2se,duckbill-2
> > +              - technologic,imx28-ts4600
> > +          - const: fsl,imx28
> > +      - items:
>
> The schema is new to me.  This line looks unusual to me, so you may want
> to double check.

It's fine. There's just no description schema on this one as it's a
continuation of the previous one (logically, but not from a schema
perspective). Perhaps add "i.MX28 I2SE Duckbill 2 based boards".

> > +          - enum:
> > +              - i2se,duckbill-2-485
> > +              - i2se,duckbill-2-enocean
> > +              - i2se,duckbill-2-spi
> > +          - const: i2se,duckbill-2
> > +          - const: fsl,imx28
> > +
> > +      - description: i.MX51 Babbage Board
