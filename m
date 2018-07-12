Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B85C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00D921471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Th22sS+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00D921471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeGLGEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:04:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42415 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeGLGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:04:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so14664371qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADhLezP4YUM0VGOUcDvLECpa2gua6Ymylh810Kzc9iA=;
        b=Th22sS+O5NzREVeIa8qQXTRkUEt1xu+WV6QQ1zTcsyhajrzfa7Q9FMtIsR0f4FdCya
         vACfT3x8WomeLyXHkCGElEFZlAguiX1lHV9Nv5rWI5RfW6gvlKad2U3izer8VtPMBcJJ
         SYX1RvSwVw5jfQeWZFtAAzqJIh+AJDAU2M47s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADhLezP4YUM0VGOUcDvLECpa2gua6Ymylh810Kzc9iA=;
        b=jARossAv9t4iCKMrRL6uqmz1Xoi6Ot6OrmWw31tcIDp5/V7ehpjlpMfT/KFN2msHOd
         NDlUpdBZ4riKP/uNXP1XnaTKybBnp/GzQZMBx6EUGHAAm90HplbeliN9NYLwBa0+v8+P
         J70UFytLZZPYMeBrxcAe93hqxXQf6E3BfF0Z0N7hATkJwco7ctFs+iLniq4LXmqfcLvK
         o4KDOOidMu5WMoM7MqxVrbft8FWJCXC/H1UkQpcSU7qUvCSkW/fnO+0v1jrM1kA/BhoH
         /vqm07cMoTRc4dLcqjRuycTbrEGMs2t9JmIV1vFMYpYFuM2CpZ+qzyoh1yhvG7402Cke
         da7w==
X-Gm-Message-State: AOUpUlFVCF8I4LAdHqfQ1mA9VVsC2hC1yzfvVQst6hmFTGnYw+L6kr3c
        GAXcKe3ZQn4A7MI61WU29eO+ZMrERwHcvXwd1NWnvQ==
X-Google-Smtp-Source: AAOMgpfIQ6ooXY9FCLhBUC9ACDRDsqr1rqf+xeQf8iUwSm+L97CY/9t+pT7uBKMKjlCUh7ehXmr9HE+jWgSAFIph42M=
X-Received: by 2002:aed:244c:: with SMTP id s12-v6mr708465qtc.74.1531374997810;
 Wed, 11 Jul 2018 22:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
 <CAD=FV=W-snhM9L9Ez-ypAJwn2NhNJ1X=s5wDvu-gbQvmLZY9Qg@mail.gmail.com>
In-Reply-To: <CAD=FV=W-snhM9L9Ez-ypAJwn2NhNJ1X=s5wDvu-gbQvmLZY9Qg@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Jul 2018 11:26:25 +0530
Message-ID: <CAP245DVpOPhuCZ4OJ0t=izquND2mUrQ8ekkU8M+sMeyUJ_fjYw@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:12 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > We want to create common code for v2 of the TSENS IP block that is used in
> > a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> > most of the common functionality start with a common get_temp() function.
> >
> > It is also necessary to split out the memory regions for the TM and SROT
> > register banks because their offsets are not constant across SoC families.
>
> nit that bindings should be earlier in the patch series than the code
> implementing the bindings.

Will reorder.

>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > index 06195e8..8f963b1 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > @@ -1,10 +1,16 @@
> >  * QCOM SoC Temperature Sensor (TSENS)
> >
> >  Required properties:
> > -- compatible :
> > - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> > - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> > - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> > +- compatible:
> > +  Must be one of the following:
> > +    - "qcom,msm8916-tsens" (MSM8916)
> > +    - "qcom,msm8974-tsens" (MSM8974)
> > +    - "qcom,msm8996-tsens" (MSM8996)
> > +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
> > +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
> > +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC with
> > +  version 2 of the TSENS IP. MSM8996 is the only exception beacause the generic
> > +  property did not exist when support was added.
> >
> >  - reg: Address range of the thermal registers
>
> You need to document that for old SoCs where TM / SROT were 0x1000
> apart (SROT first) that one "reg" field was OK.  ...and that for new
> SoCs you specify two reg ranges: the first for TM and the second for
> SROT.

OK.

> >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> > @@ -12,7 +18,7 @@ Required properties:
> >  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
> >  nvmem cells
> >
> > -Example:
> > +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
> >  tsens: thermal-sensor@900000 {
> >                 compatible = "qcom,msm8916-tsens";
> >                 reg = <0x4a8000 0x2000>;
> > @@ -20,3 +26,12 @@ tsens: thermal-sensor@900000 {
> >                 nvmem-cell-names = "caldata", "calsel";
> >                 #thermal-sensor-cells = <1>;
> >         };
> > +
> > +Example 2 (for any platform containing v2 of the TSENS IP):
> > +tsens0: tsens@c222000 {
>
> A) Use a generic name for the node, not a specific one.  Thus the node
> should be "thermal-sensor", not "tsens".
>
> B) This unit address needs to match the _first_ reg address listed.
> Give your reg below, this should be @c263000
>
> Thus your node name should be:
>
> tsens0: thermal-sensor@c263000 {

Fixed

> > +               compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +               reg = <0xc263000 0x1ff>, /* TM */
> > +                       <0xc222000 0x1ff>; /* SROT */
> > +               #qcom,sensors = <13>;
>
> The "#qcom,sensors" property seems wrong in a few ways:
>
> A) I wouldn't have expected it to start with a "#".  I only expect to
> see that on things specifying sizes / lengths.  Rob can feel free to
> override me, though.
>
> B) It's not documented above.  Just putting something in an example
> doesn't document it--it needs to be listed in the "Optional
> properties".
