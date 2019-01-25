Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4CDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4FC2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RpooUbQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAYIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:06:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40296 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfAYIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:06:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so7064028oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4HtE7SG2hHHWO8uyOjgsf0mYFV+CmPFhe2+Q86umSc=;
        b=RpooUbQuDCB4rDky7gduAAXgEMtNnHMSy5piA/tRmQtCLL6RiH9AweSowpDDrGS68/
         53srGJ9SSalDZ6ushi8ASk8bIyVPj13WWph6RZq7+L+h5XRcyp+X8TMywNpIZmfLXOHB
         NZuZurnemaPPGE8slxPzBRt1ZxF1wvRz9t5UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4HtE7SG2hHHWO8uyOjgsf0mYFV+CmPFhe2+Q86umSc=;
        b=P0FyyqrgOto2FWc3skEAcPqMAqbNuogZdUxnmY21MpY1COzJR0u0j0sUV/WQHmNVyM
         6VKyMww+XjCjN1YudgPAYXcpreQGB1qxXTe2nDAjFDFpkqQGo2CYT7DdjjyhUCjvPZd9
         VCm67T1gJ8Ok7jCV+xhALtK0/upuH+pOSEK2KHEjBWQG4Zuphd37QyumuINlo8vatxvV
         rTx6ZhHQPERIrUHfC6gULlh0qhcZypbWdDOOjzJ8SkUKZL8w9ZiOk5aYRZmv5XJVb7FR
         fOCSDiArzrpSnkVfUI8Pa0ICPxtDzRigt2FtWhyg5LGk0PXeO+3Her0O1enlLzlN5lQY
         dl+Q==
X-Gm-Message-State: AJcUuke0F608QilUX7YwYZ0F1lErBx27KDTi5DB1FVK7rNd73JSqWTFV
        K1p44pxFX2PJc/w3PANXoGBl1A4VK++p3w==
X-Google-Smtp-Source: ALg8bN63fJ5Hk3HHobMywu/U8ptxsPenh4jDnUoopLTTP6ed7dChNW1sv99T+KDML13eI9FX3sfd/g==
X-Received: by 2002:a05:6808:1c7:: with SMTP id x7mr651549oic.264.1548402410082;
        Thu, 24 Jan 2019 23:46:50 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id m26sm930331otl.32.2019.01.24.23.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 23:46:49 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id n8so7723400otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:46:48 -0800 (PST)
X-Received: by 2002:a9d:7059:: with SMTP id x25mr7244259otj.35.1548402408511;
 Thu, 24 Jan 2019 23:46:48 -0800 (PST)
MIME-Version: 1.0
References: <1545292023-5489-1-git-send-email-mgottam@codeaurora.org> <0ee6676f-f169-1ea1-506e-16e4097d1c04@linaro.org>
In-Reply-To: <0ee6676f-f169-1ea1-506e-16e4097d1c04@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 25 Jan 2019 16:46:36 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
Message-ID: <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: sdm845: add video nodes
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Malathi Gottam <mgottam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 8:58 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Malathi,
>
> On 12/20/18 9:47 AM, Malathi Gottam wrote:
> > This adds video nodes to sdm845 based on the examples
> > in the bindings.
> >
> > Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
>
> Looks good to me:
>
> Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index b72bdb0..ccd2b10 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -87,6 +87,11 @@
> >                       reg = <0 0x86200000 0 0x2d00000>;
> >                       no-map;
> >               };
> > +
> > +             venus_region: memory@95800000 {
> > +                     reg = <0x0 0x95800000 0x0 0x500000>;
> > +                     no-map;
> > +             };
> >       };
> >
> >       cpus {
> > @@ -1403,5 +1408,35 @@
> >                               status = "disabled";
> >                       };
> >               };
> > +
> > +             video-codec@aa00000 {
> > +                     compatible = "qcom,sdm845-venus";
> > +                     reg = <0x0aa00000 0xff000>;
> > +                     interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> > +                     power-domains = <&videocc VENUS_GDSC>;
> > +                     clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> > +                              <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> > +                              <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> > +                     clock-names = "core", "iface", "bus";
> > +                     iommus = <&apps_smmu 0x10a0 0x8>,
> > +                              <&apps_smmu 0x10b0 0x0>;
> > +                     memory-region = <&venus_region>;
> > +
> > +                     video-core0 {
> > +                             compatible = "venus-decoder";
> > +                             clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> > +                                      <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> > +                             clock-names = "core", "bus";
> > +                             power-domains = <&videocc VCODEC0_GDSC>;
> > +                     };
> > +
> > +                     video-core1 {
> > +                             compatible = "venus-encoder";
> > +                             clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> > +                                      <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> > +                             clock-names = "core", "bus";
> > +                             power-domains = <&videocc VCODEC1_GDSC>;
> > +                     };
> > +             };

This patch lacks the video-firmware node, it should at the very least
be added before this gets merged.
