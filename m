Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4743AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228FF21872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547231283;
	bh=E5hwJ8WmRW653bLaAmz7zYyCrUUqBfwWB0EapN4nckM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bRMjdsQAZ5ocx35ORoUFD/UEeDK/n5JwEd0cCPM4lmMb2RZkHWg3IHRq4wtSJQ909
	 jgvWpFexJEBQ1ujngLyEuA2P3RoMLrrV4cheuUjLAxCut7Y4ilRhhcbatSrd5e2XBh
	 c+9+RQ8unxKvzA+8tywD0GLMZGXYyWa1bbHgd33A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfAKS2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbfAKS2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:28:02 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6182133F;
        Fri, 11 Jan 2019 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547231281;
        bh=E5hwJ8WmRW653bLaAmz7zYyCrUUqBfwWB0EapN4nckM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=njSU0dIfy6NaI8Bc7dARFDl1SADjp6tNHEn0YFE4a3OhRTjs1Ckw9gLknbVMBfAwV
         HHt1HhjQp+5DKC5XqjfOxvhqsSil4Pc1H3Ai6gMnXZI3lBqWBOCjoubA1Epnb7Fmsf
         2B+jjKrXEIcSQqZmcTo59MWXdW5474m9N5fYIjtE=
Received: by mail-qt1-f169.google.com with SMTP id d19so19850354qtq.9;
        Fri, 11 Jan 2019 10:28:01 -0800 (PST)
X-Gm-Message-State: AJcUukf0BJ+bCnlcd/7MCrkYSSSiljFSU4osO7XsuuDeUjjaTfU0mQPf
        kfB6p52xl6txArJaVIICvBpYZ/n3vBO4dfOgtg==
X-Google-Smtp-Source: ALg8bN4wKSCf8mqtshJYUfpv4uWRG/RJbyPI2ReQ1boSa2Gbm7OcIn8a/mgIF8dkN/bzFXorbfztDbLwLE9SowOM8Jw=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr14263941qta.38.1547231280309;
 Fri, 11 Jan 2019 10:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110221903.3990-4-robh@kernel.org> <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com>
In-Reply-To: <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Jan 2019 12:27:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com>
Message-ID: <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com>
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

On Fri, Jan 11, 2019 at 11:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2019-01-10 14:19:01)
> > Convert the fixed-clock binding to DT schema format using json-schema.
> >
>
> Any pointer to the full schema?

https://github.com/robherring/yaml-bindings/blob/master/schemas/

And the clock schema in particular:
https://github.com/robherring/yaml-bindings/blob/master/schemas/clock.yaml

> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> [...]
> > diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > new file mode 100644
> > index 000000000000..8b5628463b90
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binding for simple fixed-rate clock sources.
>
> Why does title have a full stop?

Because it was there in the original. My script to extract just takes
the first line of alphanumeric text.

> > +
> > +maintainers:
> > +  - Michael Turquette <mturquette@baylibre.com>
> > +  - Stephen Boyd <sboyd@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    const: fixed-clock
> > +
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  clock-frequency: true
>
> Why doesn't this need the $ref: /schemas/types.yaml#/... thing?

You might want to read bindings/example-schema.yaml which tries to
explain some of this.

Standard properties are already defined in the core schemas. So we
only have to say "we use this property" and any binding specific
constraints. In this case, there aren't any other constraints. It is
also needed to be listed here to mark it required and to satisfy
'additionalProperties: false'.

> > +  clock-accuracy:
> > +    description: accuracy of clock in ppb (parts per billion).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  clock-output-names:
> > +    maxItems: 1
>
> Is there a schema for strings?

Yes. The core already covers that '*-names' properties are a list of
strings. So no need to do that again here and we just need to define
how many strings are valid.

> > +
> > +required:
> > +  - compatible
> > +  - "#clock-cells"
> > +  - clock-frequency
> > +
> > +additionalProperties: false
>
> Does this always have to be specified even if it's false?

Yes, the default defined as true by the json-schema spec. In some
cases we don't want to specify it.

> > +
> > +examples:
> > +  - |
> > +    clock {
> > +      compatible = "fixed-clock";
> > +      #clock-cells = <0>;
> > +      clock-frequency = <1000000000>;
> > +      clock-accuracy = <100>;
> > +    };
> > +...
> >
>
> Is the triple dot part of the schema?

Yes. Well, it is part of YAML. It's optional really as are the 2 lines
at the start. It's just good hygiene.

Rob
