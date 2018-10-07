Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBAAC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA47B2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnntvaDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA47B2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeJHC2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJHC2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:28:43 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718A62089D;
        Sun,  7 Oct 2018 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538940025;
        bh=q2hcIl/I/0R/umsZvda+xirHhaeeNaaYy23YsfrIp4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JnntvaDAKqilcGFoZOpH7KOXZkO9HjLbDBl0LUe3pSWtCy9/4vYXwonRR5RX9dY1Q
         x0+KsmxsgE68hA4sDEE2qN/w6pEOXWlYJpns7ttRTwD/hSmXjAmjiv/G0aZuhBltm2
         377gm0KpYa9RkGKP18UhEKkFmTTsZtWwfMWuVk14=
Received: by mail-qk1-f182.google.com with SMTP id q5-v6so10908383qki.6;
        Sun, 07 Oct 2018 12:20:25 -0700 (PDT)
X-Gm-Message-State: ABuFfohkrlL5QW7TbUgneUSmlbMweUhVCe3TG1VKjjmnSBzbTG+tR1XM
        QNghS5/inJllJArEfvxfXz1hh23f+i3V1UFUig==
X-Google-Smtp-Source: ACcGV60lULwId0mAy0K8YBBSY6e95iEYKGelAvajvChfaaS5QmOHR1NAoRR2vPj3sqNFM1u17vv0bPL+tvTF2rvOwro=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr16008551qkb.326.1538940024583;
 Sun, 07 Oct 2018 12:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-28-robh@kernel.org>
 <41eb7b19-dd26-16e2-bd80-b8b7d6f52f94@suse.de>
In-Reply-To: <41eb7b19-dd26-16e2-bd80-b8b7d6f52f94@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 7 Oct 2018 14:20:12 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+D7Hh6Ry+21Dvpp5YvPLjoLCur8x7r8xKpLUVv6ZoQ4Q@mail.gmail.com>
Message-ID: <CAL_Jsq+D7Hh6Ry+21Dvpp5YvPLjoLCur8x7r8xKpLUVv6ZoQ4Q@mail.gmail.com>
Subject: Re: [PATCH 27/36] dt-bindings: arm: Convert Realtek board/soc
 bindings to json-schema
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 5:54 AM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Am 05.10.18 um 18:58 schrieb Rob Herring:
> > Convert Realtek SoC bindings to DT schema format using json-schema.
>
> YAML (2x)

?

> > Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/realtek.txt       | 22 ----------------
> >  .../devicetree/bindings/arm/realtek.yaml      | 25 +++++++++++++++++++
> >  2 files changed, 25 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Docume=
ntation/devicetree/bindings/arm/realtek.txt
> > deleted file mode 100644
> > index 95839e19ae92..000000000000
> > --- a/Documentation/devicetree/bindings/arm/realtek.txt
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -Realtek platforms device tree bindings
> > ---------------------------------------
> > -
> > -
> > -RTD1295 SoC
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Required root node properties:
> > -
> > - - compatible :  must contain "realtek,rtd1295"
> > -
> > -
> > -Root node property compatible must contain, depending on board:
> > -
> > - - MeLE V9: "mele,v9"
> > - - ProBox2 AVA: "probox2,ava"
> > - - Zidoo X9S: "zidoo,x9s"
> > -
> > -
> > -Example:
> > -
> > -    compatible =3D "zidoo,x9s", "realtek,rtd1295";
> > diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Docum=
entation/devicetree/bindings/arm/realtek.yaml
> > new file mode 100644
> > index 000000000000..9e3bb3249c77
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/realtek.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: None
>
> What is the expected license for such bindings?

Good question. I'd meant to figure something out for this placeholder.
The default would be GPL-2 inheriting from the old doc. My preference
would be to dual license these with BSD as they're not just kernel
files, but I don't really want to track down copyright holders (also
not explicitly declared) to do that.

> You did not add such a line for actions.yaml.
>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/arm/realtek.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Realtek platforms device tree bindings
> > +
> > +maintainers:
> > +  - Andreas F=C3=A4rber <afaerber@suse.de>
> > +
> > +description: |+
>
> "|+"?

The '|'  means a literal block. The '+' is a block chomping indicator:

http://yaml.org/spec/1.2/spec.html#id2794534

This was all converted using my doc2yaml script and ruamel.yaml
decided it needed the '+'. I'm not sure exactly why. It may be based
on how many trailing newlines the text had.

> > +  RTD1295 SoC

In this case, this isn't really useful and we should just remove
description unless you want to add something.

> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mele,v9
> > +          - probox2,ava
> > +          - zidoo,x9s
> > +      - const: realtek,rtd1295
> > +...
>
> That does not look like a full "PATCH" yet? It also confuses me whether
> or when leading dashes are necessary - for Actions Semi "items" had one.

'...' is the end of YAML document marker.

'-' means a list item (a YAML/JSON list, not to be confused with
'items' the json-schema keyword). Actions uses 'oneOf' (which is a
list of schemas) because there are multiple SoCs.

And also 'items' itself can be a list or dict, but we restrict it to
lists for the DT meta-schema.

> I have preparations on my GitHub staging tree for three more SoCs, so we
> should prepare the structure to ease adding SoCs and avoid re-indenting
> patches - adding SoCs was much easier in the original flat text format.
> Please also consider for other vendors.

Good point.

One option is always use 'oneOf' even if just 1 item. The problem is
that the use of oneOf/allOf/anyOf makes the error reporting pretty
vague.

Another option is to make each SoC a separate schema which could be
either separate docs or multiple yaml docs within a file. The downside
is just repeating all the top-level properties.

>
> Same comment as for Actions: We're losing a human description of the
> enum values.

I kept those as comments when there was meaningful information. I did
not feel that "MeLE V9" as a description of "mele,v9" added any value.
If you want to add 'model' schema that would be better than having
just comments, but I'm not going to find all the values of model which
aren't documented.

Rob
