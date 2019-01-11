Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A712084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAZi7u1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfAKVax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:30:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42478 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfAKVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:30:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so16652025wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QAqoEHzh6Ejh4bBTGXFMICGj2I4GufJbUObrFyLkr0=;
        b=UAZi7u1AadQ3wN3l2N/7z0nUXhf1d5mbG0P04mPwxbjcPRwEkyTBB7gWP7tJTz5zHg
         ODikHfepWTOfCDtH3cdUcdOH7n/vlQ6zfV62JfKPJVg0B/TOGwtxo65StcAp+uIX3tYq
         F60zXVopIVlwC+/tWtHQ9PInzPxQ4xA5hATYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QAqoEHzh6Ejh4bBTGXFMICGj2I4GufJbUObrFyLkr0=;
        b=OF7ndX3y9A456DUTuFV6LHqNey0CruBqH/K+jNhJmP1ErE3oc8ybjJdR9YhUkSWa5A
         jAJ2uAyqUncC2F2H04JaC/CQlr8eAaBSWOGFKv+KkijzeU7JomyM8H2I253Vjj9G9h3j
         9Y+uYezRanBJLrdQcwcYlt5S/WrsO8aC9iKaYz3anHpoWjiWiEOG0puRqOXovwBLBaFx
         +Y0ND6mh/MfWQfaET5xpX2SPBiPWbdngNykoYVlBjuZf11a0x1Uwgufq2SxpDjvdnsBf
         psjRkmTGRunll9VWDh73HhoXzR2m7IeHSQxKY4qELMDghhuXZ51IIR/W03DrrpYvyM8k
         EFsQ==
X-Gm-Message-State: AJcUukfZuifHqc+IlADhiVvYgx9P+T19SC4s7809ndHJNe5cAIoceTh2
        gCbg/v95rOGBGlFMYOSRygxyq5DU3qc5GzqSE1W9rg==
X-Google-Smtp-Source: ALg8bN4vT/0zLCqUBV3zENiN8ByUnk7PT+L3Dgnupy89EoKyHJ9iOfFf1AlNmh22YxscUpvX1Rwf/dD2DPf3Pzt5RzA=
X-Received: by 2002:adf:c108:: with SMTP id r8mr15663568wre.233.1547242248094;
 Fri, 11 Jan 2019 13:30:48 -0800 (PST)
MIME-Version: 1.0
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
 <1547141652-8660-3-git-send-email-john.stultz@linaro.org> <CAL_Jsq+2dYaCzLSr8n4W=ftSjgmKJaUqwQ4S7qv7ZAaR2A-5XQ@mail.gmail.com>
 <CAL_JsqJLm_tDakS10gch8K_3F+mHrzR3isw8Tm=D-R118D1sYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJLm_tDakS10gch8K_3F+mHrzR3isw8Tm=D-R118D1sYQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 11 Jan 2019 13:30:35 -0800
Message-ID: <CALAqxLVzh8ZrXQPSEsvrTXocqmF2z4hMFHH48a29VybYM=QyFg@mail.gmail.com>
Subject: Re: [PATCH 2/8 v3] Documentation: bindings: k3dma: Add binding for hisi-dma-avail-chan
To:     Rob Herring <robh+dt@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:04 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Jan 11, 2019 at 1:58 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Jan 10, 2019 at 11:34 AM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > Some dma channels can be reserved for secure mode or other
> > > hardware on the SoC, so provide a binding for a bitmask
> > > listing the available channels for the kernel to use.
> > >
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > Cc: Ryan Grachek <ryan@edited.us>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: dmaengine@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > > v3: Renamed to hisi-dma-avail-chan
> > > ---
> > >  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > index 10a2f15..38825d4 100644
> > > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > @@ -14,6 +14,9 @@ Required properties:
> > >                 have specific request line
> > >  - clocks: clock required
> > >
> > > +Optional properties:
> > > +- hisi-dma-avail-chan: Bitmask of available physical channels
> >
> > Not quite right. Should be: hisilicon,dma-avail-chan
>
> Actually, we already have the same case elsewhere with
> 'brcm,dma-channel-mask'. Maybe there are others. So make the property
> common (i.e. documented in dma.txt) and called 'dma-channel-mask'.

Ok. I'll rework it for that then.

> Whether or not the dmaengine handles this or not is irrelevant to
> whether the binding is common or not. I have no say over OS design
> decisions.

Ok. I'll keep it in the driver for now unless otherwise directed.

Thanks so much for the review!
-john
