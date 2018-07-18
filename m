Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617672075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617672075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeGRHq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:46:29 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40429 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeGRHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:46:29 -0400
Received: by mail-ua0-f193.google.com with SMTP id p22-v6so2292820uao.7;
        Wed, 18 Jul 2018 00:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXfBVwFV9aSbZ23i9yBp0XjN1/fAHHnAXoLSg9V3DVI=;
        b=WCkWd4bgdxPNCIghOwjH9z2kY1lrV+MqTonysiHfPXimNS/N1q8+ycZV2UxtQpVBvh
         k857P8YblLDqNIc5ou2S5nbAgI0cl5VDstzVvD1ub3DZVB4pxwBV0S7DL5gZTaQZqYr7
         Jw9iqHycXI1r+09mVyCQDIzbJnEUes+b7RTMdPDX7fyH/pQFkh3dPYkqkMam/tJsv2qi
         oxB3V28AuWh2EwMoO95IyfDSlz9cDjFR6cj+QL53luDAKww6K5cqNQoqQxho4bb1NbR3
         kSoTxPbjEl+oeI60Lpy7SB5uCsVQfYeAJGPmGRbLi0fT6o9Xv8JyBiPSU07v4m/Q7Fs4
         N1Kg==
X-Gm-Message-State: AOUpUlErtQJtmHEvhN45124ZDYrCwryzuTEYA6/8kq/y/2FJLatEjhmT
        OrU7NS+KQ7lfSJ0ik5CPV45ymj3MEQ3gXr+yNYg=
X-Google-Smtp-Source: AAOMgpefJs9PX3PY11lUkQYvHvOL1Vk03NG2hfIx9AyKM3NDuC/DQTScGx4M/U1yPHwNcC49+4NYEWgKYcZOMMKfroQ=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr3309480uap.33.1531897804746;
 Wed, 18 Jul 2018 00:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1454992186.git.viresh.kumar@linaro.org> <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
 <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com> <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
In-Reply-To: <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 09:09:53 +0200
Message-ID: <CAMuHMdU=FNhWh_oroBZb8NkUr_fsvUvYxBHH6=KErqU9_Xi4ZQ@mail.gmail.com>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linaro-kernel <linaro-kernel@lists.linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Wed, Jul 18, 2018 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-07-18, 09:46, Geert Uytterhoeven wrote:
> > CC device-tree folks
> >
> > Replying to an old email, because that's the most accurate reference I
> > could find.
> >
> > On Tue, Feb 9, 2016 at 6:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > OPP core can handle the regulators by itself, and but it needs to know
> > > the name of the regulator to fetch. Add support for that.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > > index 4c9f8a828f6f..2af75f8088bb 100644
> > > --- a/drivers/cpufreq/cpufreq-dt.c
> > > +++ b/drivers/cpufreq/cpufreq-dt.c
> >
> > > @@ -119,6 +120,30 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
> > >         return ret;
> > >  }
> > >
> > > +/*
> > > + * An earlier version of opp-v1 bindings used to name the regulator
> > > + * "cpu0-supply", we still need to handle that for backwards compatibility.
> > > + */
> > > +static const char *find_supply_name(struct device *dev, struct device_node *np)
> > > +{
> > > +       struct property *pp;
> > > +       int cpu = dev->id;
> > > +
> > > +       /* Try "cpu0" for older DTs */
> > > +       if (!cpu) {
> > > +               pp = of_find_property(np, "cpu0-supply", NULL);
> > > +               if (pp)
> > > +                       return "cpu0";
> > > +       }
> > > +
> > > +       pp = of_find_property(np, "cpu-supply", NULL);
> > > +       if (pp)
> > > +               return "cpu";
> >
> > Despite the existence of lots of users of these properties, I couldn't find
> > both the "earlier version" and the "current version" of the opp-v1 bindings
> > documenting the "cpu0-supply" and "cpu-supply" properties?
>
> They are part of the device nodes and don't fall under the
> jurisdiction of OPP tables and so aren't defined there. We rely on the
> "<name>-supply" property from the regulator bindings for the devices.
>
> > Even for opp-v2, they are not documented in
> > Documentation/devicetree/bindings/opp/opp.txt, but cpu-supply is used in
> > the examples?
>
> Same reasoning here as well.

Right, they are part of the cpu nodes, not of the operating-points properties
(which are part of the cpu nodes) or the opp_table nodes (for v2).

> > Can you please document these properties?
>
> I don't think we need to, do we ?

IMHO they should be documented somewhere, with a link to
Documentation/devicetree/bindings/regulator/regulator.txt.
How else can a DTS writer know he/she needs them?
Without cpu-supply (and clock!) properties, cpufreq can't work.

Candidates:
  - Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
    This has operating points without clocks nor cpu-supply, but with
    clock-latency (for which clock? ;-)
  - Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
    Again, operating points without clocks nor cpu-supply, but with
    clock-latency.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
