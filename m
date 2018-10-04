Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660C22082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEjywRi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C22082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJDWMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeJDWMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:12:20 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A42020877;
        Thu,  4 Oct 2018 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538666315;
        bh=ClNXtFf5uL9odpA5AthxKQO+zYY14Q9Bkhn1hBpbFGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KEjywRi+5gfg0Eyy8UDQV3u7gM1Isa6a0FxdVqMic8S5kc4TkwRKIswPeLO49oKjG
         rcvVNhjjSBo/MhYTHoZgPeaeOmj9ot70skPMo/S+CIcaaJvYlRK3d6NcFhI3tU8eCL
         LQKInfcaSmF8MoF8MOaBlqEkWkNVjt4gvHbeuz7Y=
Received: by mail-qt1-f182.google.com with SMTP id u34-v6so10277782qth.3;
        Thu, 04 Oct 2018 08:18:35 -0700 (PDT)
X-Gm-Message-State: ABuFfogzNttZ3pjuqS07RxjIHz44RxIHdjHtpqfqLzUKQZY8r1pEHZKs
        y69VOuQsK2X+3RnoxRYAuwBZVzVMPht0X7B+oQ==
X-Google-Smtp-Source: ACcGV63qHE0zPuvozJ5SQi8pLk1L2zrYf7sW7Llp/LLcvnpETYyskjjNwyPmv53/jfj0qsKBqseEHrr/xBKGyXptsyw=
X-Received: by 2002:a0c:b5d3:: with SMTP id o19-v6mr5858374qvf.218.1538666314607;
 Thu, 04 Oct 2018 08:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180627045234.27403-1-rnayak@codeaurora.org> <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop> <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org> <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
 <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org> <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
 <20181004083637.xlz26rpn4qtsvdk7@vireshk-i7>
In-Reply-To: <20181004083637.xlz26rpn4qtsvdk7@vireshk-i7>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Oct 2018 10:18:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSiT15sn_jXy0FRp_YG5XbkREUeHf-98A61iN-TKxWpQ@mail.gmail.com>
Message-ID: <CAL_JsqKSiT15sn_jXy0FRp_YG5XbkREUeHf-98A61iN-TKxWpQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
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

On Thu, Oct 4, 2018 at 3:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-09-18, 14:43, Rob Herring wrote:
> > On Tue, Sep 25, 2018 at 5:25 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > []...
> > > >>>>> +   rpmhpd_opp_table: opp-table {
> > > >>>>> +           compatible = "operating-points-v2-qcom-level";
> > > >>>>> +
> > > >>>>> +           rpmhpd_opp_ret: opp1 {
> > > >>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> > > >>>>> +           };
> > > >>>>
> > > >>>> I don't see the point in using the OPP binding here when you aren't
> > > >>>> using *any* of the properties from it.
> > > >>>
> > > >>> Yeah, that's the case for now. But there are cases (as Stephen
> > > >>> mentioned earlier [1]) where the voltage values (and maybe other
> > > >>> values like current, etc) would be known and filled in DT. And that's
> > > >>> why we all agreed to use OPP tables for PM domains as well, as these
> > > >>> are really "operating performance points" of these PM domains.
> > > >>
> > > >> Rob, are you fine with these bindings then?
> > > >
> > > > Okay, my only thought is whether we should just use 'reg' here, or do
> > > > we need 'level' for anything else and should make it common?
> > >
> > > I am not quite sure I understood what you are suggesting here :(
> >
> > You could use the  'reg' property instead of 'qcom,level'. Any reason
> > not to do that?
>
> They can use any property which uniquely identifies the OPP nodes in
> the table. Though I never thought we can use 'reg' property in such a
> way. I always thought it must be related to registers somehow :)

That's almost certainly where the name originates from back in the
90s. I view 'reg' as how you identify or address a device. This can be
channels of something like an ADC.

It's perhaps a stretch for OPP nodes as they aren't really a device,
but if the levels are part of the h/w then perhaps reg is a good
match.

Rob
