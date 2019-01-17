Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32024C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002B820652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw3/Rx/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfAQRoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:44:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37728 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfAQRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:44:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so1971841wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOLNUkxDa/on7JB1hVWhTK1qzUZUfphUpw71lYVwtSM=;
        b=Pw3/Rx/ORbXo+P13kagjCExD61TI/vBxJlbTGSXHAK0Fi5uvqz4yqwo63xta0fPGMD
         S9jPP9uIXbTiMHCVbTJj4V4rPRr/LWrrJ5IbCLGAlOcivomBMy5owihv9o6KqepE7PgQ
         MWFoT8MtE9dtNGScy/4m/AhpPwT13fT+gcMhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOLNUkxDa/on7JB1hVWhTK1qzUZUfphUpw71lYVwtSM=;
        b=qJA5XfHPGuoaaEeKnJfU5JMxaHdn3uVFI3rm8TW05AkhN3uFEbUjDXOnvbClhZm7tJ
         iCV5yYGnCLzQamuEnfO9VLvgqVnsWAwxfTM7SqINml6rG0M0IeFggdlltK0Q+e5oA/i/
         2atRN0YhEfBNdH0Gi6UoxQ6Bk/TbNZyyayZ5XuMruK6fXTQjOd7fwKbWBphNqGU/9sJm
         me20q41NU2ktNMtOYWVRnldqyG7jizNgVbZh1KDnNSjVaYeLpUyjGD8qROf7ulpm1KaB
         WUAIQQF3QJwFKhyePxWHNWt4CsOvbLr4dW0trOCACXXTtbSyHxtKq2MSGvRS5ujdpZZ0
         ryxw==
X-Gm-Message-State: AJcUukctHKUB1Xc6foT2xOFOzcagPgfMTbALV9ntGbVrOHVw2Nmqjxyq
        Ra2x2Rv9mjbZEdUUCh0ys6cbJBx2MTqePBsC3Ezlxi07nlc=
X-Google-Smtp-Source: ALg8bN6oyQNUcrn2JKOFiN4VF9V+zUL6C7NT2K0kNLp+Xhzw8FsXmWyK66lGBlO0a+dS6qJJ1NPxlGm/quCJta3FKRQ=
X-Received: by 2002:a1c:de57:: with SMTP id v84mr12549965wmg.55.1547747045632;
 Thu, 17 Jan 2019 09:44:05 -0800 (PST)
MIME-Version: 1.0
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-3-git-send-email-john.stultz@linaro.org> <20190117170829.GJ5283@Mani-XPS-13-9360>
In-Reply-To: <20190117170829.GJ5283@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 17 Jan 2019 09:43:52 -0800
Message-ID: <CALAqxLXc4dE=65MYR5M_jA-uKeGjsN0CL+JjDYbZUTyi+mKUTA@mail.gmail.com>
Subject: Re: [PATCH 2/8 v4] Documentation: bindings: dma: Add binding for dma-channel-mask
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jan 16, 2019 at 09:10:23AM -0800, John Stultz wrote:
> > Some dma channels can be reserved for secure mode or other
> > hardware on the SoC, so provide a binding for a bitmask
> > listing the available channels for the kernel to use.
> >
> > This follows the pre-existing bcm,dma-channel-mask binding.
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
> > v3: Renamed to hisi-dma-avail-chan
> > v4: Reworked to generic dma-channel-mask
> > ---
> >  Documentation/devicetree/bindings/dma/dma.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> > index 6312fb0..eeb4e4d 100644
> > --- a/Documentation/devicetree/bindings/dma/dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/dma.txt
> > @@ -16,6 +16,9 @@ Optional properties:
> >  - dma-channels:      Number of DMA channels supported by the controller.
> >  - dma-requests:      Number of DMA request signals supported by the
> >                       controller.
> > +- dma-channel-mask:  Bitmask of available DMA channels in ascending order
> > +                     that are not reserved by firmware and are available to
> > +                     the kernel. i.e. first channel corresponds to LSB.
>
> A general assumption is, "dma-channel-mask" refers to the bit fields of
> the channels which needs to be masked. But here, it refers to the channels
> which are available. Doesn't it contradict?

Hrm. So while I can sort of understand the common usage of "mask" as
to "hide", thus the desire to have a bitfield mean "the channels we
hide" or "don't use", but in my experience bitmasking is more commonly
used to keep only a portion of the the bits, so from that perspective
its more intuitive that a mask be the channels we keep to use. So I'm
not sure if your suggestion makes it more clear.

But I'm not very particular here, so I'll defer to others on this.

thanks
-john
