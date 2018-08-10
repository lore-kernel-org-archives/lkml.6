Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C12BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A376223DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQxm1zbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A376223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeHJHTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 03:19:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46660 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeHJHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 03:19:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so9019256qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 21:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OzhIxVdXSNF2GLduVefPFaAe0chQj0CXHcsUpdCbfY=;
        b=SQxm1zbZehNvXkhErY4pPMQztRM6wpFYHQbAF9d2DVu5sSvgVn/fjWxkEZjGt31crA
         Qez0OcPaVOp2wc62INJOycp6qmbcZ8N79Kb7+V40OjhzStGm4j4kLi981yU/RMhE2lgs
         utg2DorbatzsQDmouffLvqPRMvI8F0WU8u/TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OzhIxVdXSNF2GLduVefPFaAe0chQj0CXHcsUpdCbfY=;
        b=mJMrHtcmepSd/PeRnu99jzMaltoL0jGTv83l72bhmZDa8sQg8ByRFOjL/efng1aKl/
         NdFcfeW1ZxVBAYGinjx1adHvrXJJEs29SoljmD3eHpl/OLbQCdnF9OCXyY67ogtNNZMR
         32QWiMIW8nbgbLjx+i0YO1dmWxZQKg71MzBLX+VrGsMWhKMl+jAr1mk+zcui0S4IDEDn
         wnCv1cmZ7wcJhTb3Si4UaNdKyFgarF7U7D72HJW0oaki//Y4vz2VDAd9bWVxI7VeytVr
         ARbN2iEYiZ/r6rKH4bLHWpHrowQ3RJAoIxtYc4HCwCU2sztMkvJrUGTmyYX9R7MTx7Jm
         m6kQ==
X-Gm-Message-State: AOUpUlGXMmmDIrDxoPBJH/AP5tksO1I9Zh6k3UoWPCHaYSYODFXt/mhU
        7ui987BhDxkNtgfUBT+aGN2epTBVeJR8pZ6ORu+KJg==
X-Google-Smtp-Source: AA+uWPwJgnkBTfyPZtBHI9bNqIhtEPNaBkjL187bXbSd2D4QRW+5XxG9UGMTZ9jtqmUuq/2MVrI8u4B2F6vMO+5KMYc=
X-Received: by 2002:a0c:d1c5:: with SMTP id k5-v6mr4440932qvh.14.1533876650703;
 Thu, 09 Aug 2018 21:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
 <20180809191059.GI160295@google.com>
In-Reply-To: <20180809191059.GI160295@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 10 Aug 2018 10:20:38 +0530
Message-ID: <CAP245DUtn=dzfaNPTmYdHZBRDzmKJ9q4EZw-n9-zgeoeBPGr2g@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
To:     mka@chromium.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
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

On Fri, Aug 10, 2018 at 12:41 AM Matthias Kaehlcke <mka@chromium.org> wrote:
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
>
> nit: adding the number of sensors isn't directly related and probably
> should be in a separate patch. Not important enough to re-spin just
> for this though ;-)

Hi Matthias,

Sometimes the urge to avoid frivolous patches takes over too strongly. :-)

I'll split it out in a respin. Thanks for the quick review of the series.

Regards,
Amit

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
>
> ditto
>
> >                       #thermal-sensor-cells = <1>;
> >               };
> >
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
> >       ret = regmap_read(tmdev->map, status_reg, &code);
> > +
> >       if (ret)
> >               return ret;
> >       last_temp = code & SN_ST_TEMP_MASK;
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
