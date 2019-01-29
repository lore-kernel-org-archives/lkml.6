Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10482147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRFxF78/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfA2Wq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:46:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfA2Wq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:46:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so15916164lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfw8h2TEUUd48ds29/wo0hGuEF0n8MjNAPrKWo6x+Qo=;
        b=kRFxF78/Uj4zS4IRLpEutk/5VBZUGTbQyWNj3WZw7CHQvFMuakbeZyRr2sw6PIgd48
         dKyXGNmpswtXfKxXAy8QLw8AAvUR+B1bGq5vNK3yaky4FAn1tY0u5kTYd+qMgAi977xn
         Ps0JsthfYb0IUDPpiGiy2dgtNQhCXtmj+uwQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfw8h2TEUUd48ds29/wo0hGuEF0n8MjNAPrKWo6x+Qo=;
        b=rd64EShcDNMSGypkiXx3HMu2+g9PyoAiHlodB2IYLpgOZOpoxAmIkrrwOLfpbGDZsN
         DwBLBsjSQDRWiUYi9C21l1DK7/YR1OptzmZcCHpDNBuYoevKfh1Yzn8NycoZvhUVoL4/
         b2DK1Y5tigbODjjvy8H1Jm7qM8i3+EDrYO0bdPnvs8DrYWxQKJ3ONYMxOYFwRBVP1+Is
         QC61d4tze9MBcEBMPImEMkI/0rsQuKnjBNsLJZHDEnrab/mR42S+vrIw/53kAK8+x98X
         DvxAf4NBNyD50zcxA3QFan5hdKWHTsogxg4U2l9/ga/khqxhTfSjeA5gEhVEtMkL9QRb
         +QrA==
X-Gm-Message-State: AJcUukfY7dnzxAJbP5J9oZnk/cdgPO0Buv6SE+D+5LJe1p6SxLoeq7mk
        EDBl59CFXab0FCPxyVBFY+IfEQ==
X-Google-Smtp-Source: ALg8bN4Ttcc8s43KZ+YK2cTGPqMUfodX30cZPt0SSRhRw8OxZkTpOBAyHzCSoVSWDuKBgSQYgCaO5g==
X-Received: by 2002:a19:c014:: with SMTP id q20mr23259355lff.16.1548802015497;
        Tue, 29 Jan 2019 14:46:55 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id h3sm3663785lfj.25.2019.01.29.14.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:46:54 -0800 (PST)
Date:   Tue, 29 Jan 2019 23:46:52 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        broonie@kernel.org
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Message-ID: <20190129224652.GB11349@centauri.lan>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
 <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Mark Brown on CC.

On Tue, Jan 29, 2019 at 10:58:47PM +0100, Jorge Ramirez wrote:
> On 1/26/19 00:29, Bjorn Andersson wrote:
> > PMS405 S5 was upstreamed without a voltage and PMS405 L3 is outside the
> > acceptable range, causing PCIe to fail. Fix these.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> > index 579ddaf4f5fa..072061aa1b79 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> > @@ -72,8 +72,8 @@
> >  		};
> >  
> >  		vreg_s5_1p35: s5 {
> > -			regulator-min-microvolt = <>;
> > -			regulator-max-microvolt = <>;
> > +			regulator-min-microvolt = <1352000>;
> > +			regulator-max-microvolt = <1352000>;
> >  		};
> >  
> >  		vreg_l1_1p3: l1 {
> > @@ -87,7 +87,7 @@
> >  		};
> >  
> >  		vreg_l3_1p05: l3 {
> > -			regulator-min-microvolt = <976000>;
> > +			regulator-min-microvolt = <1050000>;
> 
> 
> the linear range for this regulator is
>  - REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
> 
> meaning that 1050000 is actually not a valid selectable value (ie, after
> applying the above constrains 1056000 would be selected instead)
> 
> In order for a driver to be able to successfully request min = 1050000,
> regulator-min-microvolt should be set to 1048000 (and 1056000 would be
> applied)
> 
> the question is, should this property contain only hardware achievable
> values? or should drivers only request hardware achievable values? the
> way the constrains are implemented it has to be one of the two (I think
> the former would be more intuitive - ie if the dts
> regulator-min-microvolt is a valid value)
> 
> >  			regulator-max-microvolt = <1160000>;
> >  		};
> >  
> > 
> 
