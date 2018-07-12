Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19C1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+VH5KP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA5820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeGLFoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:44:11 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39579 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeGLFoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:44:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id b5-v6so12876675qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zea+/lh3Rl6WTw8D0CgS/Juv/hztSi+wAA4fC5zJC/s=;
        b=b+VH5KP+ZKXonzpYYSkNC619CcgJ3rphKfGbOp/n1K61PwAzGLmBzlfr6hR/4uIVam
         ck2pON/C9UrkroXL3ahECO8nXFvIe1sactDqtM3hXek0K+ItmJC9G6xOSCXSqSRIp1Ft
         bpK8zcS/+Oov5KyoPkZ9jlMXj/00q74cB0RRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zea+/lh3Rl6WTw8D0CgS/Juv/hztSi+wAA4fC5zJC/s=;
        b=WeH1r6v5uA7F6DpyvY7gHb7XM1lTrsC2fKH1D7vA23HzWGmcSw74o6W5Zn97PICRZy
         wyBiese/Ygs+dlQ/Tsg9Xj/6qFP6UBl0cQPaZ1qThRFCRaJIc+1txvVX5xmFjFa6ysVm
         E604R/pGYWTgGtGc8eSabYWPcTJfSeqUCIdr3+hWIuh6qVuhT8jvT5aTa4wAjT/UwsgT
         fLgIyELd1hhRf143npCwzjQtmTsIJsPwYRVYuA/TP1x3btKskqgLQ62R0rvNSfhx5kJQ
         ZmQ2k6OVn/uel39P8uO7Ml/qJkmXBgrGp3Qdik2Ncjl9TG9emDiMlrbrrkDNG2UnNYIl
         6+yA==
X-Gm-Message-State: AOUpUlGScTI2FQ9x5YH9Vg8Pd2P7wWl5DLTcTng2KFbSOCG/jXXQC8FX
        PMBqEpJFeUQKQ+B1NlVYbK058l3cBHVHwb5MudEOcQ==
X-Google-Smtp-Source: AAOMgpd6ACujGVQMp+BOvpqDwRbt8sanlMsLAI0yQMNR5OkLJNMKmAFm/AaNpeoDT8uinIF9EayMkYoHpLSuVwbWf9A=
X-Received: by 2002:a37:9187:: with SMTP id t129-v6mr598372qkd.112.1531373775930;
 Wed, 11 Jul 2018 22:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
 <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com>
 <20180711215129.GT129942@google.com> <CAD=FV=VCxpaF1t5Q-5Vv+9VH1igWoER59OMJmXZdEj3V6fOZwQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VCxpaF1t5Q-5Vv+9VH1igWoER59OMJmXZdEj3V6fOZwQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Jul 2018 11:06:04 +0530
Message-ID: <CAP245DV1sYDFHekvVmYq-4vuorO6zSQTz8gPHwfCEPzPyVKPTw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
To:     Doug Anderson <dianders@chromium.org>
Cc:     mka@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 3:30 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi Matthias,
>
> On Wed, Jul 11, 2018 at 2:51 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Wed, Jul 11, 2018 at 11:44:13AM -0700, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >> > SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> >> > sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> >> > allow more common code.
> >> >
> >> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> > ---
> >> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
> >> >  1 file changed, 16 insertions(+)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> > index cdaabeb..ba2899c 100644
> >> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> > @@ -221,6 +221,22 @@
> >> >                         #interrupt-cells = <2>;
> >> >                 };
> >> >
> >> > +               tsens0: tsens@c263000 {
> >>
> >> As per my comments in the bindings, nit that this should probably be
> >> "thermal-sensor" not "tsens", AKA:
> >>
> >> tsens0: thermal-sensor@c263000 {

Fixed.

> >> > +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> >> > +                       reg = <0xc263000 0x1ff>, /* TM */
> >> > +                             <0xc222000 0x1ff>; /* SROT */
> >> > +                       #qcom,sensors = <13>;
> >>
> >> As per my comment in the bindings and the code, I'm confused about the
> >> whole "#qcom,sensors" bit.  It's not documented and doesn't seem
> >> hooked up in the code either.
> >>
> >> ...but if people have tested this, perhaps I'm confused.  How can
> >> things work if num_sensors is 0???
> >
> > The mystery is resolved by:
> >
> > commit 6d7c70d1cd6526dc79e3d3b3faae1c40c1681168
> > Author: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Date:   Mon May 7 16:53:39 2018 -0700
> >
> >     thermal: qcom: tsens: Allow number of sensors to come from DT
> >
> >     For platforms that has multiple copies of the TSENS hardware block it's
> >     necessary to be able to specify the number of sensors per block in DeviceTree.
> >
> >     Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >     Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> >     Reviewed-by: Rob Herring <robh@kernel.org>
> >     Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> >
> >
> > I bumped into this during testing ;-)

I think this was merged in 4.17, so you didn't see it in your tree :-)

> Ah, now it makes sense to me!  Serves me right for assuming it would
> be in the same series and not checking if it was something that had
> already landed.  Thanks.  Please ignore the parts of my comments
> related to the "#qcom,sensors" property.  I guess Rob must have
> thought that the "#" in the name was fine and he's the one in charge
> not me.

Thanks for your review, Doug. I'll test this and post a v7 today. I'd
really like to get this accepted for 4.19 so I can post interrupt
support and some more cleanups.

Regards,
Amit
