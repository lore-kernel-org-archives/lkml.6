Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8E220858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCnhnp4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8E220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJHWJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHWJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:09:49 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B1C20878;
        Mon,  8 Oct 2018 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539010660;
        bh=1BE0fw0J6LIRJq+p2GmA36rsVMGIZ+lKvwe/cLY4HQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bCnhnp4eEYFxEFqoMCY9JW1YwDB+SeXXDDy93WH/q+eQDWTjLvq/gvYJ6N6n07q88
         qLIOnplc7iJ159v2Rokq0QuUIGqWQyKPalB+hBV78PfFQjIzsJSOWWVO5hXRTttpUk
         tYhiwrZwB4Crt04GY7BpI1IclcAD3ZKwyZqR8o5c=
Received: by mail-qt1-f177.google.com with SMTP id b4-v6so13174613qtc.7;
        Mon, 08 Oct 2018 07:57:40 -0700 (PDT)
X-Gm-Message-State: ABuFfohtIH7TizgdpuP+k4v0cZr8xEyjneGdjBJqemuVvMi3XW/BnnyW
        rw3DSxrLpglDAK2tDSYooR5KO3FaessO7J56Hw==
X-Google-Smtp-Source: ACcGV63kRvahAnuLfjlkXq4x2Du56g/dNSuTSlLH2jYw0qKttpn+PMNma6684mZPs0FhUPbEiIJvByBxewfeerCkQ5Y=
X-Received: by 2002:a0c:bc03:: with SMTP id j3-v6mr19885313qvg.77.1539010659716;
 Mon, 08 Oct 2018 07:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-30-robh@kernel.org>
 <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
In-Reply-To: <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Oct 2018 09:57:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
Message-ID: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!
>
> Note that this will need a rebase, as more SoCs/boards have been added
> in -next.
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> > @@ -0,0 +1,205 @@
> > +# SPDX-License-Identifier: None
>
> The old file didn't have an SPDX header, so it was GPL-2.0, implicitly?

Right. I meant to update this with something. I'd prefer it be dual
licensed as these aren't just kernel files, but I don't really want to
try to gather permissions from all the copyright holders. And who is
the copyright holder when it is implicit? Everyone listed by git
blame?

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/arm/shmobile.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
>
> Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
> Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
>
> You had it right in the CC list, though...

I generated it here from git log rather get_maintainers.pl because
get_maintainers.pl just lists me for a bunch of them.

> > +      - description: RZ/G1M (R8A77430)
> > +        items:
> > +          - enum:
> > +              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
> > +              - iwave,g20d
> > +          - const: iwave,g20m
> > +          - const: renesas,r8a7743
> > +
> > +      - items:
> > +          - enum:
> > +              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
> > +              - iwave,g20m
> > +          - const: renesas,r8a7743
> > +
> > +      - description: RZ/G1N (R8A77440)
> > +        items:
> > +          - enum:
> > +              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)
>
> This board belongs under the RZ/G1M section above
> (see also the 7743 in the part number).

Indeed. Not sure how I screwed that one up.

> > +          - const: renesas,r8a7744
>
> > +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> > +        items:
> > +          - const: shimafuji,kingfisher
> > +          - enum:
> > +              - renesas,h3ulcb
> > +              - renesas,m3ulcb
> > +          - enum:
> > +              - renesas,r8a7795
> > +              - renesas,r8a7796
>
> This looks a bit funny: all other entries have the "const" last, and
> use it for the
> SoC number. May be correct, though.
> To clarify, this is an extension board that can fit both the [HM]3ULCB
> boards (actually also the new M3NULCB, I think).

This being Kingfisher?

I wrote this based on dts files in the tree. There's 2 combinations that I see:

"shimafuji,kingfisher", "renesas,h3ulcb", "renesas,r8a7795"
"shimafuji,kingfisher", "renesas,m3ulcb", "renesas,r8a7796"

The schema allows 4 combinations (1 * 2 * 2). I have no idea if the
other combinations are possible. If not, then we could rewrite this as
2 entries with 3 const values each.

Rob
