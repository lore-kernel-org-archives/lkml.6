Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44271C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E485E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7QVzLSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E485E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389833AbeIUSOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:14:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37212 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:14:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id b12-v6so3966579lfa.4;
        Fri, 21 Sep 2018 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3qGfciWu46thVqSAVXvCZRQ7+eTfkRBHzcGN3HpBSk=;
        b=r7QVzLSO/ECHudrgLOPdKb760GkMGKK6XZNK2U9CEEDovh3E7tTF17Tcc2zJHlqSw1
         HDmSZruTt4X/+SE5ygyohn0YCM/Opxvi3vm7JSsfKMlIyXas3nKjwueU1hSLMX389XYe
         7dOwKjcClvrbPPPnKoMiBfAab18NGCve1ppPYQGXhK5kXmQBBuehjdk07dT5Yd5pZv2t
         qdoZM+B9lud0rERF73SjlhLPApWvqbu+ASPIFBFKl0E1tQ5apGSKmO5M0NaXfYv0wf0H
         V++X+RX243qU5Gl49VuEV9lgdo4pSotolxMUBHzF1bBkBDszFEj4Xvu4bIxSxVSUvUfm
         eePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3qGfciWu46thVqSAVXvCZRQ7+eTfkRBHzcGN3HpBSk=;
        b=ld6mu8cp+kG/me+VUQMU2swWek4VpLJNB0P4n3u3R1gXjYUooYRKgCkWc/brYwWeJ5
         bSpS4Kp8fKrzHKH0EA0+qHjRmdCmT3PM0Iwhs/MUVZc6QGAMtYlJwszdYd/dD/mm2Lqn
         P90ZhL8+KgZIMChZCFpaupS9eWwoDtm/d3Md48TFjGVNjjNiXjNZN6aprLtyW2gBA2/G
         7m0143dDqe9DmaEVFlcHp/hlIckSnak7V67JwoW2NWtwqswn+ZtiIObImAgeiBcTOgHl
         9obsJiAmq4PgycDJVMhEoZI46v3VKQSitzetv7yCJLVXQIJQPvQGzTblPl8sG1TNij2t
         Gvkw==
X-Gm-Message-State: APzg51CmncVB0lGvQADKbyHIiUg1IHGIaH/r8VWC6xs7hzI7hWmeqLSJ
        5PlRaA1FUf3/PV3BlwmB0Vq5/COSnUSCJY7Uvob7ZT/7
X-Google-Smtp-Source: ANB0Vdanh5FoeAsOVRIAwlItWfxNELPO4XGD698moSf9FTUCLtHTou4gyW81fziO+8e+RfWw4/k3I4hQFb1CfzP9Imw=
X-Received: by 2002:a19:c396:: with SMTP id t144-v6mr16292362lff.7.1537532765241;
 Fri, 21 Sep 2018 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180921113329.tha5tfrsvdf7dtws@inc028000032.lancs.ac.uk> <CAJKOXPdDFm=7wNLt5Nzf-y8TS4u6gmo51Y70bFv_pKdFK42VDQ@mail.gmail.com>
In-Reply-To: <CAJKOXPdDFm=7wNLt5Nzf-y8TS4u6gmo51Y70bFv_pKdFK42VDQ@mail.gmail.com>
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
Date:   Fri, 21 Sep 2018 13:25:54 +0100
Message-ID: <CACfOrNdkG=MTy=+TF1x8y++goDAyfnjfReno6=vwpRMy4r-dWA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: ordering wrong order tmu_cpu on
 Odroid-XU3/4 thermal-zones definition
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 at 12:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, 21 Sep 2018 at 13:33, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> >
> > This patch is to open a discussion about wrong order of tmu_cpu.
> >
> > It seems that tmu_cpu1 correspond to cpu3, and tmu_cpu3 match cpu1.
> > Note, cpu{0|3} in dtsi correspond to cpu{3|7} in linux and are the big
> > cores.
>
> Hi,
>
> I do not understand this sentence. In DTSI, the CPU0-3 are the A7,
> little cores. Defined by exynos5422-cpus.dtsi. What did you mean here?

Leave it, you clarify that is just indices.

> > By dependencis from exynos5422-odroidxu3-common.dtsi to
> > exynos5800.dtsi -> exynos5420.dtsi, I guess definitions of tmu_cpuX are
> > incorrect. However, changing the address, reg interrupts or clocks
> > would breack other boards depending on it. As I can't test other boards,
> > I've just overload the reference in the thermal-zones node.
>
> There are 8 CPUs (4 little and 4 big) but only 4 thermal zones for
> CPUs. The mapping of names of CPU nodes and TMU nodes in DTS is not
> direct. These are just indices ...

Maybe we could rename these nodes to support the real name while running?
But it's just a detail I guess.

>
> although more important is to map
> the cooling devices to proper TMU. This should be mentioned in DTS as
> this the real problem here.

The cooling devices mapping is correct, it's the reporting in
/sys/devices/virtual/thermal/thermal_zone$i/temp that are wrong.
Currently, there is no bad effect for cooling, as the attached cooling device
adapts the FAN and both frequencies of little and big cluster. Frequencies
of little cores and big cores are shared inside a cluster.
This patch is for coherency only.

>
> >
> > To reproduce the problem, I provide two scripts:
> > == script_stress:
> >
> > for i in 0 10 20 40 80; do
> >     echo $i
> >     taskset $i stress -t 10 -c 1
> > done;
> >
> > == script_read_temp:
> >
> > while true; do
> >     for i in 0 1 2 3 4; do
> >         echo $i
> >         cat /sys/devices/virtual/thermal/thermal_zone$i/temp
> >     done;
> >     sleep 1
> >     clear
> > done;
> >
> > Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > index 96e281c0a118..4512ffad2785 100644
> > --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > @@ -135,7 +135,8 @@
> >                         };
> >                 };
> >                 cpu1_thermal: cpu1-thermal {
> > -                       thermal-sensors = <&tmu_cpu1 0>;
> > +                       // thermal-sensors = <&tmu_cpu1 0>;
>
> Do not leave commented lines, there are not needed.
>
> Also your email does not match signed-off-by. You must have something
> wrong with either git setup or mailer (git commit --si will use the
> same address for From and SoB so I guess the mailer...).

Ok, my bad.

> Best regards,
> Krzysztof
