Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ED5C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2622721841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547232844;
	bh=PVk3DuHfBjCFsN+5uMovneaSZ8G8cZGkyCo70c40AR0=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=gtyBkC7IaOdJuS42NNS5LZqwwyLDu/qLUm0Lz1AnX43+7M6zdxgiJKXqsQHOS+/bA
	 FsJMtdvKjEBcnTeX+w/+x18M8z/gKZ+/38YMrhypk4//y5HQszOGQN/sdcEPkze25z
	 gvro8GqUnb5n7E5r5MdaKdNBEjz/wAg54W6R1iSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbfAKSyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbfAKSyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:54:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9902133F;
        Fri, 11 Jan 2019 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547232841;
        bh=PVk3DuHfBjCFsN+5uMovneaSZ8G8cZGkyCo70c40AR0=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=vf6hf7PQ7/r6P7HP5G5EYrwCh7CPo30CY6poSgarXMpd6yg2TrErPTlfoZfVW8iPP
         i/5UJCE2opSfV3+iXHNrj5yt/RGmeAYllJ/8L/cZrCgiKomq9YtfJO1LLsETkQVKOA
         X4wOcOL2SGgMg30TWXTsqxtFJiRrVtD9of8SA6hg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
User-Agent: alot/0.8
In-Reply-To: <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com>
References: <20190110221903.3990-4-robh@kernel.org> <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com> <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>
To:     Rob Herring <robh@kernel.org>
Message-ID: <154723284041.169631.6622751321828044091@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 10:54:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-01-11 10:27:48)
> On Fri, Jan 11, 2019 at 11:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Rob Herring (2019-01-10 14:19:01)
> > > Convert the fixed-clock binding to DT schema format using json-schema.
> > >
> >
> > Any pointer to the full schema?
>=20
> https://github.com/robherring/yaml-bindings/blob/master/schemas/
>=20
> And the clock schema in particular:
> https://github.com/robherring/yaml-bindings/blob/master/schemas/clock.yaml

Awesome. Thanks for the pointers! Is the clock schema posted to the list
somewhere?

>=20
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > [...]
> > > diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml=
 b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > > new file mode 100644
> > > index 000000000000..8b5628463b90
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Binding for simple fixed-rate clock sources.
> >
> > Why does title have a full stop?
>=20
> Because it was there in the original. My script to extract just takes
> the first line of alphanumeric text.

Ok. I think it would be good to treat them like commit subjects that
don't have the full stop either, so if the script is able to drop the
full stop it would be great.

>=20
> > > +
> > > +maintainers:
> > > +  - Michael Turquette <mturquette@baylibre.com>
> > > +  - Stephen Boyd <sboyd@kernel.org>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: fixed-clock
> > > +
> > > +  "#clock-cells":
> > > +    const: 0
> > > +
> > > +  clock-frequency: true
> >
> > Why doesn't this need the $ref: /schemas/types.yaml#/... thing?
>=20
> You might want to read bindings/example-schema.yaml which tries to
> explain some of this.
>=20
> Standard properties are already defined in the core schemas. So we
> only have to say "we use this property" and any binding specific
> constraints. In this case, there aren't any other constraints. It is
> also needed to be listed here to mark it required and to satisfy
> 'additionalProperties: false'.

Hmm ok. I suppose I'll have to hold that information in my mind when
reviewing bindings. Is there any tooling or some script that I can run
on json-schema bindings to verify they're correct? Or to find something
redundant like this where a standard property is redefined? Grep would
work for the redundant problem I suppose.

>=20
> > > +  clock-accuracy:
> > > +    description: accuracy of clock in ppb (parts per billion).
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  clock-output-names:
> > > +    maxItems: 1
> >
> > Is there a schema for strings?
>=20
> Yes. The core already covers that '*-names' properties are a list of
> strings. So no need to do that again here and we just need to define
> how many strings are valid.

Alright. Thanks for the explanations.

>=20
> > > +
> > > +required:
> > > +  - compatible
> > > +  - "#clock-cells"
> > > +  - clock-frequency
> > > +
> > > +additionalProperties: false
> >
> > Does this always have to be specified even if it's false?
>=20
> Yes, the default defined as true by the json-schema spec. In some
> cases we don't want to specify it.
>=20
> > > +
> > > +examples:
> > > +  - |
> > > +    clock {
> > > +      compatible =3D "fixed-clock";
> > > +      #clock-cells =3D <0>;
> > > +      clock-frequency =3D <1000000000>;
> > > +      clock-accuracy =3D <100>;
> > > +    };
> > > +...
> > >
> >
> > Is the triple dot part of the schema?
>=20
> Yes. Well, it is part of YAML. It's optional really as are the 2 lines
> at the start. It's just good hygiene.
>=20

Sounds good.

