Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B57C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D8820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547248214;
	bh=iHNUtKS2TIPaD92DTomGQECc0mDYx7XKzQFscfDWh9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wnhyTHRSXD1cdnArQfpPFiHXSKBypnDlLgFA5PU5G+XUOaqeba5buYa1oHR/dZ/co
	 wj9YR0jBqRq85pyunuVADmlYs5/cTcWNOTeKk/0uER7W+5TuaxJ/ywtFIzUoGUgdME
	 JJidlQ+AtFKQ+gnf+nWasGS+RjoiunQt1J376JGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfAKXKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfAKXKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:10:12 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510EF2184A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547248211;
        bh=iHNUtKS2TIPaD92DTomGQECc0mDYx7XKzQFscfDWh9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZKxd/PLhcCW7aAamB7Rzqzextwc2I4+9dAM96lAWC27C8CapsfZy5FZgbyicBhcWM
         4yi+qAclbgCypOsVM+rMQtbLEuDcEdhumcWB1vwZ1GeSLrohVy2socX9BxbeTTv8EG
         vLLBYabMW+x+kBsJPveroKPNFNgL9+kM4pgF5o+Y=
Received: by mail-wr1-f46.google.com with SMTP id j2so16939563wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:10:11 -0800 (PST)
X-Gm-Message-State: AJcUukfhLzNyjFUjOCxMKbqg+q5AWV5Il2RADMtHZs1Xku+TsvMlBd0R
        fiHcxAilyaiDwnNmKCL6ZSttAGfUWhypxWw2CnqQAg==
X-Google-Smtp-Source: ALg8bN4xV0nv3eqK+XYdRsuxKHBiX0mrHFfqSqiCA9/0DQVvMU7wFJDgdTq7IKb4gZo+T4QptMksrsJyE3LOgk704fY=
X-Received: by 2002:adf:e983:: with SMTP id h3mr14647451wrm.232.1547248209680;
 Fri, 11 Jan 2019 15:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20190110221903.3990-4-robh@kernel.org> <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com>
 <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com>
 <154723284041.169631.6622751321828044091@swboyd.mtv.corp.google.com>
 <CAL_JsqJFyC3AXwbd8PoJS1wZ5BSokAPcFi=4FF2DQ6yFi0XwCw@mail.gmail.com> <154724656826.169631.7419387360923471292@swboyd.mtv.corp.google.com>
In-Reply-To: <154724656826.169631.7419387360923471292@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Jan 2019 17:09:58 -0600
X-Gmail-Original-Message-ID: <CABGGiswYYpm-7T9e6F_Mp6FdU-JFDC8xV_JR1E6cgiz32A0u_Q@mail.gmail.com>
Message-ID: <CABGGiswYYpm-7T9e6F_Mp6FdU-JFDC8xV_JR1E6cgiz32A0u_Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 4:42 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2019-01-11 12:49:04)
> > On Fri, Jan 11, 2019 at 12:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Rob Herring (2019-01-11 10:27:48)
> > > > On Fri, Jan 11, 2019 at 11:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > Any pointer to the full schema?
> > > >
> > > > https://github.com/robherring/yaml-bindings/blob/master/schemas/
> > > >
> > > > And the clock schema in particular:
> > > > https://github.com/robherring/yaml-bindings/blob/master/schemas/clock.yaml
> > >
> > > Awesome. Thanks for the pointers! Is the clock schema posted to the list
> > > somewhere?
> >
> > No. Happy to post things, but I'm struggling to find anyone that cares.
>
> Ok. I can review that document too if you post it to the list.
>
> >
> > > > > Why does title have a full stop?
> > > >
> > > > Because it was there in the original. My script to extract just takes
> > > > the first line of alphanumeric text.
> > >
> > > Ok. I think it would be good to treat them like commit subjects that
> > > don't have the full stop either, so if the script is able to drop the
> > > full stop it would be great.
> >
> > I can just write a meta-schema to enforce that. :)
>
> Sounds good.
>
> >
> > Yes, the meta-schema enforces this at least to the extent there is a
> > meta-schema defined for a standard property. Even if not something for
> > a specific property, we limit things to a subset of json-schema
> > keywords. Also, you also can't define something contradicting a core
> > schema (e.g. { reg: { type: string } }), but that wouldn't be found
> > until you check actual DTs.
> >
> > The meta-schema check is run with:
> > make dt_binding_check
> >
> > This is all documented in Documentation/devicetree/writing-schema.md.
> >
>
> Ok I'll read that document now. Would be cool if the build robots (and
> myself) can somehow run the dt_binding_check on a single YAML file so we
> can quickly validate the binding. Maybe even make C=2 or C=1 do that?
>
> If the robots can then complain if the single file fails to build it
> will save us tons of time. I just tried to run it but it seems to only
> care about running on all the YAML files.

make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/file/to/test

It will check only the schema specified and check all the DT files
against only that schema (plus any referenced schema if you use a
top-level 'allOf'. See the GIC schema patch[2] for an example of
that).

I'm running the schema check for patches in the DT patchwork instance.
For example, here's this patch[1]. So as long as it has my R-by, then
it should be good. I'm not yet running the schema check on DT files
because generally there are warnings and I don't intend to fix them
for everyone. But maybe I should anyways so we at least have the data.

Rob

[1] https://patchwork.ozlabs.org/patch/1023240/
[2] https://patchwork.ozlabs.org/patch/1023243/
