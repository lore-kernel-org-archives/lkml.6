Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F3AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F362098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzfiiTE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F362098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeIQTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbeIQTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:51:23 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20989214DA;
        Mon, 17 Sep 2018 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537194229;
        bh=wwpD+nKD+NYJolPUicqzvE+SY/l95dZ42cCywe1Q3dQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NzfiiTE1telsxt4Pwo3Ec2Q+TY2DWoRNIkn4lrUczGYKgAt83xdoLcCEAIaNhcr7B
         FDenFsTO15Jl2JXBxraEjGGN4lWfxbWWf0eB8TgaCwJmfEBKTAFqAk5t+DYTsulajt
         IY16OIr4lC2UtECBo7LNPTBX3jpDIAnvVAyRROuM=
Received: by mail-qt0-f180.google.com with SMTP id m13-v6so15448854qth.1;
        Mon, 17 Sep 2018 07:23:49 -0700 (PDT)
X-Gm-Message-State: APzg51DuQH2wa5qPTLORJ3AI44ci69dQ/d0lnJHq0AbykeGdNr82RdWn
        wThl5kMNPqkdP7I3FZiVx0bsg0IqkRgELsUD1g==
X-Google-Smtp-Source: ANB0VdY4QAL5kElODBNzlx2bju6c2QiE0DW6nvxPc2mZAs7rrN16gXBbo3+jzYB9AhXaoRIvw+3i5takeFRaLhLL9n8=
X-Received: by 2002:a0c:d5d3:: with SMTP id h19-v6mr18204974qvi.218.1537194228276;
 Mon, 17 Sep 2018 07:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <162f7f98697cd9d806a1a843c6177bb943ea2b33.1537087118.git.ren_guo@c-sky.com>
 <20180917062336.GA20555@bogus> <20180917083623.GA1069@guoren>
In-Reply-To: <20180917083623.GA1069@guoren>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Sep 2018 07:23:36 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJOoek+P+NR_jEfPJD1JLC4U-x_hmJL=vjvMU5JWxjVeA@mail.gmail.com>
Message-ID: <CAL_JsqJOoek+P+NR_jEfPJD1JLC4U-x_hmJL=vjvMU5JWxjVeA@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] dt-bindings: interrupt-controller: C-SKY APB intc
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 1:36 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Mon, Sep 17, 2018 at 02:23:36AM -0400, Rob Herring wrote:
> > On Sun, Sep 16, 2018 at 04:50:03PM +0800, Guo Ren wrote:
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> >
> > Needs a commit description.
> >
> > > ---
> > >  .../interrupt-controller/csky,apb-intc.txt         | 70 ++++++++++++++++++++++
> > >  1 file changed, 70 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > > new file mode 100644
> > > index 0000000..be7c3d1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > > @@ -0,0 +1,70 @@
> > > +==============================
> > > +C-SKY APB Interrupt Controller
> > > +==============================
> > > +
> > > +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> > > +on the apb bus and we only use it as root irq controller.
> > > +
> > > + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> > > + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
> > > + - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
> >
> > Is there a relationship between csky,gx6605s-intc and csky,apb-intc?
> They all use pending register to get irq num and use enable register to
> mask/unmask.
>
> > > +        - support-pulse-signal:
> > > +                Usage: select
> > > +           Description: to support pulse signal flag
> >
> > What is this for?
> This is a level-triger interrupt controller at first, but we want it
> to support pulse signal. It means that when the pulse signal coming,
> the pending register will hold signals without clear the IFR reg.
>
> Some C-SKY cpu's socs need this feature to support pulse interrupt
> signal.

So an edge triggered interrupt. We have a way to support that on a per
interrupt basis with a 2nd cell (which you should consider if you may
need anyways). But this is a global setting for all interrupts the
interrupt controller serves? If so, it's fine, but does need a vendor
prefix.

Rob
