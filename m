Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D3ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98934214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy04zBAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98934214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeISGcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbeISGcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:32:20 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F2E214C2;
        Wed, 19 Sep 2018 00:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537318626;
        bh=KRIyMXFbY/VUa5hsN7ZARYR+EYOCJ7LFMCfmadOfzs8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iy04zBAjDYHX5OhzThf6vbJwG+0ts7xCy0n0YolcMsTG44Zr7qlQZ8ZF+ocsx3+BY
         88/cdrl6kF/m8Px0yl0LYlJY2r1e6reIRvvNOFs08QaRDM6svzvy9z71mZb9sNqkF3
         kYQRfalXR96VZqeZ3bstNkltULBgV5lqpMO06Slc=
Received: by mail-qt0-f179.google.com with SMTP id r37-v6so3624034qtc.0;
        Tue, 18 Sep 2018 17:57:06 -0700 (PDT)
X-Gm-Message-State: APzg51A4W1Xp+8n90QHCF8Q8Tu0eqOPYP0OuGqHDn4+5wq4KzG8I3NdV
        dDSvi6hBLIiP7I5UIFw3dSavm6UzWNnHZJ13+A==
X-Google-Smtp-Source: ANB0VdYXX0EWKDoRtOv1Ng088ZROB3NHzuj5CGJVT/VxAcLFAINsK/4UWpfuYUhZcPhmUzLq7HlshEd3KqJIn8qwm3o=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr23238323qtd.101.1537318625374;
 Tue, 18 Sep 2018 17:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <162f7f98697cd9d806a1a843c6177bb943ea2b33.1537087118.git.ren_guo@c-sky.com>
 <20180917062336.GA20555@bogus> <20180917083623.GA1069@guoren>
 <CAL_JsqJOoek+P+NR_jEfPJD1JLC4U-x_hmJL=vjvMU5JWxjVeA@mail.gmail.com> <20180917154150.GA6392@guoren-Inspiron-7460>
In-Reply-To: <20180917154150.GA6392@guoren-Inspiron-7460>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Sep 2018 17:56:50 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJ0OXjyX+Tn7zFy_=VrDgyQx3nX384drP_4T8brko+W7g@mail.gmail.com>
Message-ID: <CAL_JsqJ0OXjyX+Tn7zFy_=VrDgyQx3nX384drP_4T8brko+W7g@mail.gmail.com>
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

On Mon, Sep 17, 2018 at 8:41 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Mon, Sep 17, 2018 at 07:23:36AM -0700, Rob Herring wrote:
> > On Mon, Sep 17, 2018 at 1:36 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > On Mon, Sep 17, 2018 at 02:23:36AM -0400, Rob Herring wrote:
> > > > On Sun, Sep 16, 2018 at 04:50:03PM +0800, Guo Ren wrote:
> > > > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > >
> > > > Needs a commit description.
> > > >
> > > > > ---
> > > > >  .../interrupt-controller/csky,apb-intc.txt         | 70 ++++++++++++++++++++++
> > > > >  1 file changed, 70 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > > > > new file mode 100644
> > > > > index 0000000..be7c3d1
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > > > > @@ -0,0 +1,70 @@
> > > > > +==============================
> > > > > +C-SKY APB Interrupt Controller
> > > > > +==============================
> > > > > +
> > > > > +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> > > > > +on the apb bus and we only use it as root irq controller.
> > > > > +
> > > > > + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> > > > > + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
> > > > > + - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
> > > >
> > > > Is there a relationship between csky,gx6605s-intc and csky,apb-intc?
> > > They all use pending register to get irq num and use enable register to
> > > mask/unmask.
> > >
> > > > > +        - support-pulse-signal:
> > > > > +                Usage: select
> > > > > +           Description: to support pulse signal flag
> > > >
> > > > What is this for?
> > > This is a level-triger interrupt controller at first, but we want it
> > > to support pulse signal. It means that when the pulse signal coming,
> > > the pending register will hold signals without clear the IFR reg.
> > >
> > > Some C-SKY cpu's socs need this feature to support pulse interrupt
> > > signal.
> >
> > So an edge triggered interrupt. We have a way to support that on a per
> > interrupt basis with a 2nd cell (which you should consider if you may
> > need anyways). But this is a global setting for all interrupts the
> > interrupt controller serves? If so, it's fine,
> Yes, it's a global setting for all interrupts. not really edge triggered
> interrupt for every interrupt.
>
> > but does need a vendor prefix.
> vendor prefix? Em ... it's just used in fpga now.

What I mean is make it: csky,support-pulse-signal

>
> Best Regards
>  Guo Ren
