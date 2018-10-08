Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F06C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE2620652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccOTgV7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE2620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJHU6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbeJHU6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:58:21 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D3020890;
        Mon,  8 Oct 2018 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539006392;
        bh=jR8K6sL3dQKFGacRFfiHHdgXPEuNZEpxTMsH2Nu/8+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ccOTgV7TYbiBJWCJGtXh7k/DwfG9InEyBToMMUv8wZTdVk6eClMoftFOtsYS6mZ28
         /BlMhbhJ/5Kns2zvMKzqKzR2r2JSBfdyy0Bnrx9byavOmbZKgyNweLZs23wVaKXNEq
         1JL1czqe19m6pivUAw/1FWSr7X5M8cYbiALG/aLM=
Received: by mail-qt1-f170.google.com with SMTP id u34-v6so20960297qth.3;
        Mon, 08 Oct 2018 06:46:32 -0700 (PDT)
X-Gm-Message-State: ABuFfogT9EyFOUQT4ftN1SkcY42T0EmFS6Paigv44pbhRoBxKz4TWCkW
        uLsGjQUg8RGRHLQ7vVdnQHCRQVzE+lzbpqjCjA==
X-Google-Smtp-Source: ACcGV62+VTBfdUctckeb/p7WMzKEpe08RdMWyNeUphT8alz+CO97UOPUR9vt5xO/NYVQUAPQMkPziVLS+YHbetHJmtI=
X-Received: by 2002:a0c:d4e5:: with SMTP id y34mr4743931qvh.106.1539006391296;
 Mon, 08 Oct 2018 06:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-29-robh@kernel.org>
 <1857752.ZLvpeyYpZr@phil>
In-Reply-To: <1857752.ZLvpeyYpZr@phil>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Oct 2018 08:46:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+79kn8BtL_saZOMGRqJ0kJq14HCekhVPfbFSquBdRAqA@mail.gmail.com>
Message-ID: <CAL_Jsq+79kn8BtL_saZOMGRqJ0kJq14HCekhVPfbFSquBdRAqA@mail.gmail.com>
Subject: Re: [PATCH 28/36] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To:     "heiko@sntech.de" <heiko@sntech.de>
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 4:45 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Rob,
>
> either I'm misunderstanding that, or something did go a bit wrong during
> the conversion, as pointed out below:
>
> Am Freitag, 5. Oktober 2018, 18:58:40 CEST schrieb Rob Herring:
> > Convert Rockchip SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/rockchip.txt      | 220 ----------------
> >  .../devicetree/bindings/arm/rockchip.yaml     | 242 ++++++++++++++++++
> >  2 files changed, 242 insertions(+), 220 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml
> >
>
>
>
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amarula,vyasa-rk3288
> > +              - asus,rk3288-tinker
> > +              - radxa,rock2-square
> > +              - chipspark,popmetal-rk3288
> > +              - netxeon,r89
> > +              - firefly,firefly-rk3288
> > +              - firefly,firefly-rk3288-beta
> > +              - firefly,firefly-rk3288-reload
> > +              - mqmaker,miqi
> > +              - rockchip,rk3288-fennec
> > +          - const: rockchip,rk3288
>
> These are very much distinct boards, so shouldn't they also get
> individual entries including their existing description like the phytec
> or google boards below?

It is grouped by SoC compatible and # of compatible strings. So this
one is all the cases that have 2 compatible strings. It is simply
saying the 1st compatible string must be one of the enums and the 2nd
compatible string must be "rockchip,rk3288".

>
> Similarly why is it an enum for those, while the Google boards get a
> const for each compatible string?

Because each Google board is a fixed list of strings.

> Most non-google boards below also lost their description and where lumped
> together into combined entries. Was that intentional?

If the description was just repeating the compatible string with
spaces and capitalization, then yes it was intentional. If your
description matches what you have for 'model', then I'd prefer to see
model added as a property schema.

Rob
