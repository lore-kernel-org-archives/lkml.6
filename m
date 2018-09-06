Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EDFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E71320861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4pksL9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E71320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIFN7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:59:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46270 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeIFN7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:59:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so11391931qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmCte+4fgUFOjCLbLVehYz54TysgyiRsjGxk0i6p7AE=;
        b=a4pksL9JyCDop+zQjB23kQdb5h0wLPh1HYEYRB5telC1KNqQ5HVGdzkDpUDro1KfSC
         MRv59M0V4EUqlSx6SUOeMzmg0QPuzU04LqSI7fKVnNDF3DoDsASL2N8ppIu7+KR2SeUi
         +iKZVTv7RWNOJPjrN8D2eLc8e8aEdaVLT+jKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmCte+4fgUFOjCLbLVehYz54TysgyiRsjGxk0i6p7AE=;
        b=ZmlXeDCblEATGd9gOHzIkbkhTbVY3RZZB6iVdt3kRsU1as3J114FLQZqXsMaXKVpMg
         YYtFTKdOHPFvLhc2fBE7rLCC6sRy+rPaJf4hb1Z3OsMcok0GwZRTvnDKsjqcfxwwTPa0
         TO2TMPzQa57Bhge7+nk/w2bhqjMfEJ1QfZG5gg3C/L7awT+3DTn4UvoUui537aiQlaXl
         kPFD58ANAlWT5MjwPQKzB3XN7BRC8tz2mE6N0HTVQVtPo4tGZ4vexPPJPZsjsgnyIz5+
         C2+EsH2ewVIJJ9GUi7qh5/3qbOrIiATT2O7w88EELsSWmdmDOBlfqz+0QmInrnTHP7bH
         g0Tg==
X-Gm-Message-State: APzg51DFd+YMcmkQEl446DFxgT+ISNXHxRGp1SnI+079NnIrQLQZjxbk
        9hCuHv3aj1okWUWNjyO/h2oEsdDe/63/248XtrEP5w==
X-Google-Smtp-Source: ANB0VdYRPFeMtRo9xmu5N2TdraLocuTBFVxdwOTAUuQuwwR3LHlo5yXL27kJPs0cvKt7NgejmMGkz182oeusTCvvWmQ=
X-Received: by 2002:ac8:6790:: with SMTP id b16-v6mr1328293qtp.66.1536225867577;
 Thu, 06 Sep 2018 02:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <882739b10bd0a3b655baef9b7ee1958680aa0b04.1535462942.git.amit.kucheria@linaro.org>
 <20180903200255.GL3456@tuxbook-pro>
In-Reply-To: <20180903200255.GL3456@tuxbook-pro>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 6 Sep 2018 14:54:16 +0530
Message-ID: <CAP245DX=oiDgi=_ig08yto-RaYQi9FPrKzYK073+=WsBTi83pw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 1:29 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:
>
> > We've earlier added support to split the register address space into TM
> > and SROT regions.
> >
> > Split up the regmap address space into two for the remaining platforms
> > that have a similar register layout and make corresponding changes to
> > the get_temp_common() function used by these platforms.
> >
> > Since tsens-common.c/init_common() currently only registers one address
> > space, the order is important (TM before SROT).  This is OK since the
> > code doesn't really use the SROT functionality yet.
> >
>
> Having a single patch touching both code and dts will cause merge issues
> as this patch travel upstream. Even more arm-soc expects arm and arm64
> dts changes to come in different pull requests.


> Please split it so that the three pieces can be picked up by respective
> maintainer.

Will do.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm/boot/dts/qcom-msm8974.dtsi   | 5 +++--
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
> >  drivers/thermal/qcom/tsens-common.c   | 5 +++--
> >  3 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > index d9019a49b292..56dbbf788d15 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > @@ -427,9 +427,10 @@
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
> >                       #thermal-sensor-cells = <1>;
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index 7b32b8990d62..6a277fce3333 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -761,9 +761,10 @@
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
> >                       #thermal-sensor-cells = <1>;
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 6207d8d92351..478739543bbc 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -21,7 +21,7 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > -#define S0_ST_ADDR           0x1030
> > +#define STATUS_OFFSET                0x30
> >  #define SN_ADDR_OFFSET               0x4
> >  #define SN_ST_TEMP_MASK              0x3ff
> >  #define CAL_DEGC_PT1         30
> > @@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
> >       unsigned int status_reg;
> >       int last_temp = 0, ret;
> >
> > -     status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> > +     status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
>
> Wasn't this change part of the previous set that introduced the
> tm_offset? If not how did we handle the fact that tmdev->map is already
> indented 0x1000 bytes?

It was a similar change 5b1283984fa3 ("thermal: tsens: Add support to
split up register address space into two") for the get_temp_8996()
function.

This patch converts over the remaining users.

> Both changes looks good, but I'm worries about the order of things.

We're OK.
