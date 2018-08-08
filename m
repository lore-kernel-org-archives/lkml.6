Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0921771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qod0KQL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF0921771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeHHSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeHHSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:36:34 -0400
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com [209.85.220.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3F6621A52;
        Wed,  8 Aug 2018 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533744971;
        bh=ZyEDCI4dacowTr5e9laR4cSic9IT5OKy4k/xuEXJScU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qod0KQL7ceK6d+Y9cC+8heVKSkJgunlh7Cv8WXnAWhhQID4r0MXUNHDKXsY8aijI3
         Xt86kWwKVJ9+4XICB6H+beJ5YTk6r5PcJB9ioEEsAzoT9oypjcOCyZYfs+RPOB+XYw
         dH2RaL2G0T5JYxI6VFjZz7l1H5qWJr/mc4ubK++Y=
Received: by mail-qk0-f178.google.com with SMTP id c126-v6so1893720qkd.7;
        Wed, 08 Aug 2018 09:16:10 -0700 (PDT)
X-Gm-Message-State: AOUpUlHA0oi6uiZJwYNobfiXeIFt8UwnrESQTex+CBIuFcpw9SeEC6ol
        lsTGizkEx/U/KNXxvteYnw3k+ES0PKA97lgByQ==
X-Google-Smtp-Source: AA+uWPzJjrjUFiCzCKPHuzUWj4LBHbWWaEKeMJide2wYrjdYX5xGVRvf1r0F/Bi5OE1dXpqNOz6kG8nraD5EABjBl0c=
X-Received: by 2002:ae9:e817:: with SMTP id a23-v6mr3062536qkg.213.1533744969973;
 Wed, 08 Aug 2018 09:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180804082319.5711-1-hch@lst.de> <20180804082319.5711-7-hch@lst.de>
 <CAL_JsqKKCPhb1um_+68ya0ng_v2tSb5O+-8RQPqx7Od3sJ4FuA@mail.gmail.com> <20180808150448.GA31785@lst.de>
In-Reply-To: <20180808150448.GA31785@lst.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Aug 2018 10:15:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgawQA5V2W1e9QFb_Ri+Aka-08WizeSD9kdxyBdcwpEQ@mail.gmail.com>
Message-ID: <CAL_JsqKgawQA5V2W1e9QFb_Ri+Aka-08WizeSD9kdxyBdcwpEQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] dt-bindings: interrupt-controller: RISC-V PLIC documentation
To:     Christoph Hellwig <hch@lst.de>, Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anup Patel <anup@brainfault.org>, atish.patra@wdc.com,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 8:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 08, 2018 at 08:29:50AM -0600, Rob Herring wrote:
> > Version numbers on the individual patches would be nice...
>
> We've never done these in the subsystems I'm involved with.  Too
> much clutter in the subject lines for information that is easily
> deductable.

Unfortunately not in Gmail which doesn't thread properly. But
patchwork also provides the version tag which I use to sort my
reviews.

> > > +Example:
> > > +
> > > +       plic: interrupt-controller@c000000 {
> > > +               #address-cells = <0>;
> > > +               #interrupt-cells = <1>;
> > > +               compatible = "riscv,plic0";
> > > +               interrupt-controller;
> > > +               interrupts-extended = <
> > > +                       &cpu0-intc 11
> > > +                       &cpu1-intc 11 &cpu1-intc 9
> > > +                       &cpu2-intc 11 &cpu2-intc 9
> > > +                       &cpu3-intc 11 &cpu3-intc 9
> > > +                       &cpu4-intc 11 &cpu4-intc 9>;
> >
> > I'm confused why this is still here if you are dropping the cpu intc binding?
>
> We need some parent that identifies the core (hart in RISC-V terminology).
> The way the code now works is that it just walks up the parent chain
> until it finds a CPU node, so it either accepts the legacy intc node
> inbetween, or it accepts the cpu node directly as the intc node is pointless.
>
> I guess for the documentation we should instead just point to the
> "riscv" cpu nodes instead?

That's not valid and dtc will tell you that. 'interrupts' (via
interrupt-parent) or 'interrupts-extended' has to point to an
'interrupt-controller' node. I guess you could make the cpu nodes
interrupt-controllers. That's a bit strange, but I can't think of a
reason why that wouldn't work.

Just because the cpu-intc is not made to be an irqchip in the kernel
doesn't mean it can't still be represented as an interrupt-controller
in DT. It shouldn't be designed just around how some OS happens to
implement things.

> > I also noticed the cpu binding refers to "riscv,cpu-intc" as well.
> > That needs to be fixed too if there's a change.
>
> Only in the examples.  I'd be fine with dropping them, but let's keep
> that separate from the interrupt support.

You need to sort out how this is all tied together and works because
right now you are supporting 2 ways and one is undocumented and the
other is invalid. Changing things later is only going to be more
painful.

Rob
