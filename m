Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A171C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D813520854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="driKJC+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D813520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJEFNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbeJEFNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:13:24 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 460A12087D;
        Thu,  4 Oct 2018 22:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538691475;
        bh=M3fDbY+dkvViEJ/iRS7qgZLLnL9rCUrstnX07jZGGh8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=driKJC+OEK9tYg/mkmsxWkAlyzTBJjqcEVQp9yr5qUTGKDCJ2GwUrvohzgiIPQUBi
         gxCSqY7fcEZ3oJRsPgkC9nPCJQKGw3oPtPpw5Y+wQtbCV9mqEGR6P1uvAPkcEEDvir
         Yw9DgfHAF5GL+iP6iA/6PtlbXYz6tOhfvfIXOMgI=
Received: by mail-qt1-f181.google.com with SMTP id q40-v6so11828865qte.0;
        Thu, 04 Oct 2018 15:17:55 -0700 (PDT)
X-Gm-Message-State: ABuFfohuS3zaQFW9EvMwZHxfi4a9VI/St3nJ4rve7lLtpkbUI0lN/dnN
        swdqI/uOWd81vgJNi3VISC6r1OAvVsfKIfmI7g==
X-Google-Smtp-Source: ACcGV61e3aDPploo1XJUK66abN0JjQednCl/E9rdiz56A7+eMDc8BSU8djyAbT7km/MXNmhOE3YPrw/8Nj0FhYtT7k4=
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr7218205qte.164.1538691474447;
 Thu, 04 Oct 2018 15:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180627045234.27403-1-rnayak@codeaurora.org> <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop> <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org> <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
 <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org> <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
 <20181004083637.xlz26rpn4qtsvdk7@vireshk-i7> <CAL_JsqKSiT15sn_jXy0FRp_YG5XbkREUeHf-98A61iN-TKxWpQ@mail.gmail.com>
 <20181004191725.GA7926@centauri.lan>
In-Reply-To: <20181004191725.GA7926@centauri.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Oct 2018 17:17:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOf6y1ZwcYk_LcL=-XShW2ME=aPTgho2fEQSDmHqE0eQ@mail.gmail.com>
Message-ID: <CAL_JsqJOf6y1ZwcYk_LcL=-XShW2ME=aPTgho2fEQSDmHqE0eQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 2:17 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> On Thu, Oct 04, 2018 at 10:18:22AM -0500, Rob Herring wrote:
> > On Thu, Oct 4, 2018 at 3:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 25-09-18, 14:43, Rob Herring wrote:
> > > > On Tue, Sep 25, 2018 at 5:25 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > []...
> > > > > >>>>> +   rpmhpd_opp_table: opp-table {
> > > > > >>>>> +           compatible = "operating-points-v2-qcom-level";
> > > > > >>>>> +
> > > > > >>>>> +           rpmhpd_opp_ret: opp1 {
> > > > > >>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> > > > > >>>>> +           };
> > > > > >>>>
> > > > > >>>> I don't see the point in using the OPP binding here when you aren't
> > > > > >>>> using *any* of the properties from it.
> > > > > >>>
> > > > > >>> Yeah, that's the case for now. But there are cases (as Stephen
> > > > > >>> mentioned earlier [1]) where the voltage values (and maybe other
> > > > > >>> values like current, etc) would be known and filled in DT. And that's
> > > > > >>> why we all agreed to use OPP tables for PM domains as well, as these
> > > > > >>> are really "operating performance points" of these PM domains.
> > > > > >>
> > > > > >> Rob, are you fine with these bindings then?
> > > > > >
> > > > > > Okay, my only thought is whether we should just use 'reg' here, or do
> > > > > > we need 'level' for anything else and should make it common?
> > > > >
> > > > > I am not quite sure I understood what you are suggesting here :(
> > > >
> > > > You could use the  'reg' property instead of 'qcom,level'. Any reason
> > > > not to do that?
> > >
> > > They can use any property which uniquely identifies the OPP nodes in
> > > the table. Though I never thought we can use 'reg' property in such a
> > > way. I always thought it must be related to registers somehow :)
> >
> > That's almost certainly where the name originates from back in the
> > 90s. I view 'reg' as how you identify or address a device. This can be
> > channels of something like an ADC.
> >
> > It's perhaps a stretch for OPP nodes as they aren't really a device,
> > but if the levels are part of the h/w then perhaps reg is a good
> > match.
> >
>
> FWIW, I actually have a use case on qcom SoCs.
>
> I'm working on reviving an old patch series from Stephen Boyd:
> https://lkml.org/lkml/2015/9/18/833
>
>
> Rajendra's Documentation/devicetree/bindings/opp/qcom-opp.txt currently has:
>
> Required properties:
> - qcom,level: On Qualcomm platforms an OPP node can describe a positive value
> representing a corner/level that's communicated with a remote microprocessor
> (usually called the RPM) which then translates it into a certain voltage on
> a voltage rail
>
>
> I'm planning on extending it with something like:
>
> Optional properties:
> -qcom,fuse-level: On Qualcomm platforms, not all corners/levels are real
> corners/levels, i.e., not all corners/levels have a unique eFuse associated.
> Usually more than one corner/level uses the same eFuse corner/level.

Is that because there's additional parameters not covered as part of a corner?

> So for each OPP I would have:
>
> opp1 {
>         qcom,level = <foo>;
>         qcom,fuse-level = <bar>;
> }
>
>
> Not sure if this changes your opinion about using reg,
> but I thought that it was worth mentioning.

'reg' is probably not the right fit then.

Does any of this fuse-level apply to platforms using this binding? If
so, then it should be incorporated here. I don't want incomplete
bindings that get one property added at a time.

Rob
