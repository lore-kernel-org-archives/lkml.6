Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF59C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70113208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yu5Atbxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70113208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeH0Qlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:41:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35799 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeH0Qlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:41:39 -0400
Received: by mail-qt0-f196.google.com with SMTP id f19-v6so16374792qtf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vt0lCmDD4fOHIiOx7V5XT3J5HOs3K8vnUEMG4+YHnXk=;
        b=Yu5Atbxp6/2VkJ0R3/K6pVmiOvpucvmZVyIH1JtenTiSqLQ/4z/4/apsCwc/FP3fz1
         xG0qPwvAt2CxEsS787uTx6Qa9wgzUh6bL4MHKrYYxAJG6OAx+Pd1Z0V/yIeYbhT4LY4d
         FPNUHDYRPm+EkIRfsnx/4BAS+cEjNlMRkSaOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vt0lCmDD4fOHIiOx7V5XT3J5HOs3K8vnUEMG4+YHnXk=;
        b=hS3iKFjiVBVzdr0gJU7ANcqGQ9eeg0wpf0JK81HnL5VKyPCSlxxtRxjJrSeHwPRfRL
         3rdX7++OvvQEiq+b6YrXKLl0J058iKHVn81IXnsKwfzUBi5eD9u3q3fY8BLJQuh7viKl
         fsU8/CLOflWvVvoUSHWL+ztnG2khjb9rmfSI8eA2akhR7DO/vQAh/LB6yFdbhoQ+U4QR
         ri53H9oY+JZ+ECyHY7V1u34/0xxEKreIb0wKnhglCFonICEfVGEgMUbdzk+VMS7o9+X8
         wTuj+2h9mTJDk4VO4Q+ovaDqLFjL0EI9/HOLIUSGGaRxNn4Ol6rB27gTD2B5CMaMXda5
         VCKg==
X-Gm-Message-State: APzg51BtGPo6imk/Fm1qmgKBGwR+YynwP+pcc+9KQi47cDX7DTFMXjI4
        mnqgwW5iL3ZhotQVMsV50ZnnksDi5YGgTc5aV4Fn+A==
X-Google-Smtp-Source: ANB0Vdbnz641aFm8/frVmSOSQi1rmXHdRXdbTGehJ+e3Oh6hvwsHotbhWgOI3tPAvHG1DDk/2WW7h699T9bwKN0rpew=
X-Received: by 2002:ac8:2f24:: with SMTP id j33-v6mr13459043qta.93.1535374506114;
 Mon, 27 Aug 2018 05:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
 <20180824232747.GE25163@localhost.localdomain>
In-Reply-To: <20180824232747.GE25163@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 27 Aug 2018 18:24:55 +0530
Message-ID: <CAP245DWcQ1DQCoMv_92wJweySUDaH60+ySwGeQHR9hL1PpD0uw@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 4:58 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, Aug 09, 2018 at 06:02:33PM +0530, Amit Kucheria wrote:
> > We've earlier added support to split the register address space into TM
> > and SROT regions.
> >
> > Split up the regmap address space into two for the remaining platforms that
> > have a similar register layout and make corresponding changes to the
> > get_temp_common() function used by these platforms.
> >
> > Since tsens-common.c/init_common() currently only registers one address
> > space, the order is important (TM before SROT).  This is OK since the code
> > doesn't really use the SROT functionality yet.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-msm8974.dtsi   | 6 ++++--
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
> >  drivers/thermal/qcom/tsens-common.c   | 5 +++--
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > index d9019a49b292..3c4b81c29798 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > @@ -427,11 +427,13 @@
> >                       };
> >               };
> >
> > -             tsens: thermal-sensor@fc4a8000 {
> > +             tsens: thermal-sensor@fc4a9000 {
> >                       compatible = "qcom,msm8974-tsens";
> > -                     reg = <0xfc4a8000 0x2000>;
> > +                     reg = <0xfc4a9000 0x1000>, /* TM */
> > +                           <0xfc4a8000 0x1000>; /* SROT */
> >                       nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> >                       nvmem-cell-names = "calib", "calib_backup";
> > +                     #qcom,sensors = <11>;
> >                       #thermal-sensor-cells = <1>;
> >               };
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index cc1040eacdf5..abf84df5a7bc 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -774,11 +774,13 @@
> >                       };
> >               };
> >
> > -             tsens: thermal-sensor@4a8000 {
> > +             tsens: thermal-sensor@4a9000 {
> >                       compatible = "qcom,msm8916-tsens";
> > -                     reg = <0x4a8000 0x2000>;
> > +                     reg = <0x4a9000 0x1000>, /* TM */
> > +                           <0x4a8000 0x1000>; /* SROT */
> >                       nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> >                       nvmem-cell-names = "calib", "calib_sel";
> > +                     #qcom,sensors = <5>;
> >                       #thermal-sensor-cells = <1>;
>
> Looking closer to this, I fail to remember the reasoning why
> #qcom,sensors property was needed.

It is necessary for platforms that have multiple TSENS blocks. This
then allows us to specify the number of connected sensors per block.
See commit 6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of
sensors to come from DT") for details.

As requested by Matthias, I'm moving this bit to its own patch in v2.

Regards,
Amit
