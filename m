Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186820842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2nkBXq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfB0JOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:14:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39681 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0JOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:14:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id r123so3535971lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk4EKe9AIkIIro09r2ePS2oLZlyKIyOHXigO+NBlOxI=;
        b=t2nkBXq+osPSndiSgDYG3qQDx1l84OBffTirPYu1k+xMcCeWo21wvcaeRiosYtmJM4
         CfVF2uhhvxjIBTyrVscaXjNsw7Yi0/SmmLeNKC+dMtgHp1HMviwvgEIDON0+8+1xMQ+x
         ykqK/srY7OTQDzgqR9ug1DYfUIbGi0nVEiUgIqD8QQyd2VRL/aADCxt+m08GhQztmbG+
         Z47ZUTog6YUszA+2r/3UzV1IgytcGEMdHmzuZe7MGDTTK+XSxOBkoixUtWWpJIgpvB49
         l8Cq6omiatjZ0vyjiPToE5FEFG51NATu9QZ+CWOTuS+G235Tln727a0CENSYvxftvNCM
         LN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk4EKe9AIkIIro09r2ePS2oLZlyKIyOHXigO+NBlOxI=;
        b=YBCgoNfX5ozX4cRwEquCN7UXGwnVouG/SsLdI81++M2yPmF1WYWhEBW0mJAqLM+o4a
         jf9NZc5iHCSMnnPyKQjjHVTxUnT0dpywmG37qPX8mEePYRnUzMhTfVPHqP9WRTC2uEA8
         pLATPUyfhZlaaQSqrtrF09zzy7Gvl6ShqbBboPhPCUqHLQ9qjyDg9TMlEauxNzYXRtOv
         8OzXLi9SbMKHfizRXY38kBbMGh08etEw1AJWggh+GSQE1UyhiwbH6PsHpFnddPRQQo9f
         Sg6nlTnVGVBBXBB+sUcZRiChnisC9edHbVVV5+cEoCBZI5DV6pHFidPCrTw0XuzBeC4X
         GIfg==
X-Gm-Message-State: AHQUAuYwBi3JRxrZo76qs4bOYdqm6l4exDSxUQp40bIVyhOJXrq+Z0ak
        vBmTsPX75XmibwBLwRK+nzs0OskRaiBIFTW4XYH/Xg==
X-Google-Smtp-Source: AHgI3IYHim4BAFOlRTAN14cU/OzA+viXcRgVfiKNDXLetbDN8ibsKl4nMY4fUSsF2l/zq38VuVmc3wbGaugwI4nGOCQ=
X-Received: by 2002:a19:505a:: with SMTP id z26mr217714lfj.96.1551258860400;
 Wed, 27 Feb 2019 01:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20190226070525.22453-1-bjorn.andersson@linaro.org>
 <20190227070022.31975-1-bjorn.andersson@linaro.org> <31974548-f786-125f-c897-4b8a4d615559@free.fr>
In-Reply-To: <31974548-f786-125f-c897-4b8a4d615559@free.fr>
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Wed, 27 Feb 2019 10:14:09 +0100
Message-ID: <CAP71Wjw1K0Le=vOWKP7OWCSvAOxVs10epzKYKXGeVpVPdBuk=w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add GEN2 PCIe controller and PHY
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:06 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 27/02/2019 08:00, Bjorn Andersson wrote:
>
> > SDM845 sports two PCIe controller/phy pairs; one GEN2 and one GEN3. Add
> > the nodes for the GEN2 pair.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v1:
> > - "reg" is spelled without a 't'
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 103 +++++++++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 5308f1671824..35887fedfd0e 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1024,6 +1024,109 @@
> >                       };
> >               };
> >
> > +             pcie0: pci@1c00000 {
> > +                     compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
>
> $ git grep "qcom,pcie-sdm845\|qcom,sdm845-qmp-pcie-phy" drivers/
> /* Nada */
>
> Are you planning on landing more patches later?
> In particular, the PHY init sequence...

Have you seen
https://lore.kernel.org/lkml/20190226070125.22318-1-bjorn.andersson@linaro.org/
?
