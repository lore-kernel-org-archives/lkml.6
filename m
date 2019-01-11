Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB91C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11582133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547239760;
	bh=GE6MFGkevP3oHwgQFacU37gcdTIyXhguSNBrg4fNM9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mYfUXMEVbNwBpMSUr5rl0elk9KCvWp+RkwbQ64ba/Ls/NCaZ3RUzM/BIdyrrqVH7X
	 QewIFaUfL45QoEBShXuHZ4Q65DvCpR9g7FiPfCdperVgw2YfGjp4wEvjcXJWMo2RtJ
	 +Pa35A4GlDLXfwKNdDeo+vxxmhLRUpE0Oc46+CB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfAKUtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfAKUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:49:19 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8342133F;
        Fri, 11 Jan 2019 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547239757;
        bh=GE6MFGkevP3oHwgQFacU37gcdTIyXhguSNBrg4fNM9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YNQPPe0KElil6Rl5HKa96cu+U5inmCyOe2FmAdsqX+ePklgTC3J18eb59ltmmlGaD
         q/KLtV/zqBSgjs+qdWg1+ChCU6MoKVG52T2R1qoOzgcBYHPusuyjbNYvQ+ymXWed//
         kglksjaj9bqTW5VUdxlR3/aXgWkK8F0O45sf1jMU=
Received: by mail-qt1-f181.google.com with SMTP id y20so20298968qtm.13;
        Fri, 11 Jan 2019 12:49:17 -0800 (PST)
X-Gm-Message-State: AJcUukdeQUxzkMgLnC+B9UtM5MThUngUOCmTPedmhkfezCOTJqSjMyJw
        P/UygiV89b498qwJTHW7gDXAgqGKSD6LHL7Jzw==
X-Google-Smtp-Source: ALg8bN7eE/X9BYzSc7z8RQeVuiEMPWzapOJpzqt8NFwUPXsUOg1r4gkdhm6+51D0E9cR53Jb88e1f5hQCQO4TLP791I=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr15620049qvk.106.1547239756893;
 Fri, 11 Jan 2019 12:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20190110221903.3990-4-robh@kernel.org> <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com>
 <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com> <154723284041.169631.6622751321828044091@swboyd.mtv.corp.google.com>
In-Reply-To: <154723284041.169631.6622751321828044091@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Jan 2019 14:49:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFyC3AXwbd8PoJS1wZ5BSokAPcFi=4FF2DQ6yFi0XwCw@mail.gmail.com>
Message-ID: <CAL_JsqJFyC3AXwbd8PoJS1wZ5BSokAPcFi=4FF2DQ6yFi0XwCw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2019-01-11 10:27:48)
> > On Fri, Jan 11, 2019 at 11:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Rob Herring (2019-01-10 14:19:01)
> > > > Convert the fixed-clock binding to DT schema format using json-schema.
> > > >
> > >
> > > Any pointer to the full schema?
> >
> > https://github.com/robherring/yaml-bindings/blob/master/schemas/
> >
> > And the clock schema in particular:
> > https://github.com/robherring/yaml-bindings/blob/master/schemas/clock.yaml
>
> Awesome. Thanks for the pointers! Is the clock schema posted to the list
> somewhere?

No. Happy to post things, but I'm struggling to find anyone that cares.

> > > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > Cc: linux-clk@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > [...]
> > > > diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > > > new file mode 100644
> > > > index 000000000000..8b5628463b90
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > > > @@ -0,0 +1,44 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Binding for simple fixed-rate clock sources.
> > >
> > > Why does title have a full stop?
> >
> > Because it was there in the original. My script to extract just takes
> > the first line of alphanumeric text.
>
> Ok. I think it would be good to treat them like commit subjects that
> don't have the full stop either, so if the script is able to drop the
> full stop it would be great.

I can just write a meta-schema to enforce that. :)

> > > > +
> > > > +maintainers:
> > > > +  - Michael Turquette <mturquette@baylibre.com>
> > > > +  - Stephen Boyd <sboyd@kernel.org>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: fixed-clock
> > > > +
> > > > +  "#clock-cells":
> > > > +    const: 0
> > > > +
> > > > +  clock-frequency: true
> > >
> > > Why doesn't this need the $ref: /schemas/types.yaml#/... thing?
> >
> > You might want to read bindings/example-schema.yaml which tries to
> > explain some of this.
> >
> > Standard properties are already defined in the core schemas. So we
> > only have to say "we use this property" and any binding specific
> > constraints. In this case, there aren't any other constraints. It is
> > also needed to be listed here to mark it required and to satisfy
> > 'additionalProperties: false'.
>
> Hmm ok. I suppose I'll have to hold that information in my mind when
> reviewing bindings. Is there any tooling or some script that I can run
> on json-schema bindings to verify they're correct? Or to find something
> redundant like this where a standard property is redefined? Grep would
> work for the redundant problem I suppose.

Yes, the meta-schema enforces this at least to the extent there is a
meta-schema defined for a standard property. Even if not something for
a specific property, we limit things to a subset of json-schema
keywords. Also, you also can't define something contradicting a core
schema (e.g. { reg: { type: string } }), but that wouldn't be found
until you check actual DTs.

The meta-schema check is run with:
make dt_binding_check

This is all documented in Documentation/devicetree/writing-schema.md.

Rob
