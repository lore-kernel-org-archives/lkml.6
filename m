Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9BC2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGadupLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9BC2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLDPEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLDPEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:04:14 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30B52146D;
        Tue,  4 Dec 2018 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543935853;
        bh=HdctKzxhIzA5Gileog4jo6YzMyxJEoW+jk67LM2xECg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nGadupLmjDAD1bmPQF+j/5LsIOKP+nY5Lg/CDyZmVCPMSWHZNgAwi9UAqKMantj+O
         E1RPWZBeoWACU6pYURhoUVJWZzhvQNfOWPX3DxUp5pLGS4tUmNFEVSPDPGeLGvNYGK
         PvkQE9wphjMKQRbicBAYHj9MkjFfcwd/CDs1jJTE=
Received: by mail-qt1-f179.google.com with SMTP id d19so18320772qtq.9;
        Tue, 04 Dec 2018 07:04:12 -0800 (PST)
X-Gm-Message-State: AA+aEWYnOPGeJyhbDy/JuI9DHpML49Y57zki5gBSQpgzQyPBMxcayFie
        hDl37ytfSTX2q6IjmEtomfQ2xGM4Tzi5bAPEFQ==
X-Google-Smtp-Source: AFSGD/UxX00JUXYe4WhcTim/duD5eAOZOjhVmC85JiZHnQ/r6zyx7o/gmpM9vKLumEZGa4Jml4vbfXF/3p7lKwQWe4A=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr20764932qvl.77.1543935851783;
 Tue, 04 Dec 2018 07:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-25-robh@kernel.org>
 <3170130.k0DT9deCHj@phil>
In-Reply-To: <3170130.k0DT9deCHj@phil>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 09:04:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
Message-ID: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
Subject: Re: [PATCH v2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To:     "heiko@sntech.de" <heiko@sntech.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 8:16 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 3. Dezember 2018, 22:32:13 CET schrieb Rob Herring:
> > Convert Rockchip SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > new file mode 100644
> > index 000000000000..3d30ec9adcd3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -0,0 +1,251 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/rockchip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip platforms device tree bindings
> > +
> > +maintainers:
> > +  - Beniamino Galvani <b.galvani@gmail.com>
>
> # scripts/get_maintainer.pl -f Documentation/devicetree/bindings/arm/rockchip.txt
>
> doesn't list Beniamino at all and he hasn't been active on Rockchip stuff
> for a number of years, so I'm not really sure where this mention as
> maintainer comes from.

git history. get_maintainers.pl had too many cases where I ended up as
the maintainer.

I'll drop him.

> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amarula,vyasa-rk3288
> > +              - asus,rk3288-tinker
> > +              - asus,rk3288-tinker-s
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
> [...]
>
> > +      - items:
> > +          - enum:
> > +              - firefly,firefly-rk3399
> > +              - firefly,roc-rk3399-pc
> > +              - pine64,rockpro64
> > +              - rockchip,rk3399-evb
> > +              - rockchip,rk3399-sapphire
> > +              - rockchip,rk3399-sapphire-excavator
> > +              - tsd,rk3399-q7-haikou
> > +              - vamrs,ficus
> > +              - vamrs,rock960 # 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> > +          - const: rockchip,rk3399
>
>
> as said before, loosing the description of the boards that get thrown
> into one listing really decreases the usability a lot.

Sorry, I thought I addressed these previous comments.

> Best example is maybe the rk3399 rock960, where the consumer-edition
> board is actually named "ficus" and the description actually brings the
> connection to the product-name.
>
> So here it may increase the machine-readability but definitly descreases
> the human readability of the file itself.
>
> I guess just using the format that all the Google-boards got for all boards
> would just be easiest, so for example the rock960 also would just become:
>
>       - description: 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
>         items:
>           - const: vamrs,ficus
>           - const: rockchip,rk3399
>
>       - description: 96boards RK3399 Ficus (ROCK960 Consumer Edition)
>         items:
>           - const: vamrs,rock960
>           - const: rockchip,rk3399

Sure, you can do this if you like. I prefer the other way as it is a
one line change to add a board. The SoC maintainers can pick whatever
they like. You could split into a file per SoC too if you wanted.

> Looking at other socs, this is likely similar there. Like on Mediatek
> all the MT67xx eval boards loose the mapping to the
> socs marketing name "Helio Foobar" when the description is gone,
> which could've been helpful for people reading the binding.

Generally when we had just 'hello,foobar' with 'Hello Foobar' I
dropped the comment as I didn't think it added much.

Rob
