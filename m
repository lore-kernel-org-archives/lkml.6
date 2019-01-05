Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ADC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA78218EA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="irY4Jhc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfAEEjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:39:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42675 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEEjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:39:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so38217637wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IanwLBDuNTJ73hS90AYH70FOKxkadZ/s9U3FcBmlLVU=;
        b=irY4Jhc2JjqbLSk81YgW61B59uwrPl+OsuL5BU1KtegnL0/p+Q5IPxnooyQUqPh+QD
         6b6Q3WDf3J9Fg/vf5uLNGMawgFuGZhi1GtdmcfUoXBicV3KDFz2Z5ORVzS3tKHJyhunL
         3BkKB4dywcWFDnxP3jIlcrdfIGq7EeUm/+2I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IanwLBDuNTJ73hS90AYH70FOKxkadZ/s9U3FcBmlLVU=;
        b=e2mY2Vf316wgb7Q8jDTT1yLTphn7BiSyDuuAUw44X3dTSM86UVmJ1KTnE/8LzQmkJW
         YGJANkXIhZk3kBctszChX1XSy2o4TJyY8FRLtr44Kt7w2Xxu67JT6T4pUPvTrp+w0a3j
         oddXI64/vtQFKK1owaJpWgcomy5iBLG53KBziMEfE8kHzvMsnO8hcangDFsW4BgvO0dk
         cUXRBbYAoX+mzbBYuUngmMfiUqOrtwa4Vk3RsAsFt9M2BtAS8UOkySjKmwG5V0yzVYmy
         gaV1ojgeCnDPK3r3sV7WdcRk6awmzC+ydhfzol8T6qgbW2LUtY73YWFLEcKPBy7hT8sC
         0GnQ==
X-Gm-Message-State: AJcUuke3Swq4+iVBNba9VUD4ld0D0F3il8FEYNIhlgAumLMnASJvgKYR
        NbB1AOSYGsxxGwNmbRUpf75VWOsFQrO0HWu6fYajkQ==
X-Google-Smtp-Source: ALg8bN77AVuQKt/oWEeUiZlA64TvLRh2XRM71Lm5OBy5GKnTryBguwIQLbxny2zObB98lr4bNsPVP8Lw/pRtH74xE8k=
X-Received: by 2002:adf:9521:: with SMTP id 30mr43296351wrs.192.1546663186386;
 Fri, 04 Jan 2019 20:39:46 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-3-git-send-email-john.stultz@linaro.org> <20190105040030.GF2477@Mani-XPS-13-9360>
In-Reply-To: <20190105040030.GF2477@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 20:39:34 -0800
Message-ID: <CALAqxLUZ=6_tELtZPEjYwV+BNNBcZj4Z=dq9UyrRXuPhs_uGUw@mail.gmail.com>
Subject: Re: [PATCH 2/8 v2] Documentation: bindings: k3dma: Add binding for dma-avail-chan
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 8:00 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi John,
>
> On Fri, Jan 04, 2019 at 12:56:22PM -0800, John Stultz wrote:
> > Some dma channels can be reserved for secure mode or other
> > hardware on the SoC, so provide a binding for a bitmask
> > listing the available channels for the kernel to use.
> >
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Tanglei Han <hantanglei@huawei.com>
> > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > Cc: Ryan Grachek <ryan@edited.us>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > index 10a2f15..1c466c1 100644
> > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > @@ -14,6 +14,9 @@ Required properties:
> >               have specific request line
> >  - clocks: clock required
> >
> > +Optional properties:
> > +- dma-avail-chan: Bitmask of available physical channels
> > +
>
> This property looks too generic. Since this is specific to HiSi SoCs,
> this could be "hisi-dma-avail-chan"?

I'm fine to change it, but I'm not sure I fully understand the
rational. Can you help me understand?
Are device node-binding names supposed to have global scope? I assumed
the node property names are basically scoped to the entry?
Further, having some dma channels be reserved doesn't seem to be too
unique a concept, so I'm not sure what we gain long term by prefixing
it?

thanks
-john
