Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4639AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB522147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Q/OGFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA0OFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:05:36 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34014 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0OFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:05:36 -0500
Received: by mail-io1-f66.google.com with SMTP id b16so11379173ior.1;
        Sun, 27 Jan 2019 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBDXSPPE8rbUIbTQbMP7QKuhbhBWsipIQGdKvkjV/u8=;
        b=a4Q/OGFfu+oaoFzwaKj++e8BiN9GJ+tuKIUNTVpx//3IhJzHdm8o4UBVO+v9Q1VzPe
         LUQcDUjr+WVQEyk4CSLdYJrUfmVhNxi43qN08YfTSbadB/uZBo0jmQ1Ritl8sP4ns+SV
         xwkxrYlVN5q2t22rrMx9sIyBIUExhmYdB/taAcRTA5PEWjCm0fYTGJSz0JnQ4suCJCz3
         GUqLet7BDk3ORlHOEQ+xJk7703m21LnIArnbfgfAH2xJ6o8czu1YdohGfS/hwyRM83yS
         i0r/cF2nnYj+tO97/jHlwgIT40jPR8cMZINC2BrgiWHBfCo4AP+TSG4aD0AttLLOwOyv
         /jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBDXSPPE8rbUIbTQbMP7QKuhbhBWsipIQGdKvkjV/u8=;
        b=akhvUSDYt8OQ8cHQuGA42O6WPLjqCvCqizFa8r4+L5os8YD4P0+Dtox1zVEY9VyoGO
         4Pkd2pR7gzNr8wVUINqnVvElD9GjWcR8MYZ7KPvJ9x7tEkztxFBjfC5YCakLxbpF9gFy
         xwfUA91b2CgfTzgHVwNS86z0jSiTWULj/VT3XkxNqb9Qhs+MiGoi7tuIoNWsg5uEROuA
         9l78Gq3NEFEyWZBoQ1BxTlPAceRehlxNB5CxGXLY4lCzZJAaYCYokA9aUJfRVIpkjB3Q
         QqAfXzyBLqMKbxHtfLApqvWUcXD1LOLl+oGQVdLNRNAEHnutPKFTIAc44qYJiG9zoPTT
         tNYA==
X-Gm-Message-State: AHQUAuZWBCwlwXVEp/yg+b6qDe7DjkoWbpBLBJkFEgQ0cLSoaVt9Z65c
        g9D5LT84p7wzaruoua33s0gpZYaC7x38jSKEO90=
X-Google-Smtp-Source: ALg8bN4u5a7DdbPqpWKdyk4/kXY65NEPnJsUJAcJF+K4XKWXYxu2JDBLVdQkuXhnqH8p/9vrx6G9p/SwqYMNgk2d1ao=
X-Received: by 2002:a5d:9913:: with SMTP id x19mr9070391iol.99.1548597935061;
 Sun, 27 Jan 2019 06:05:35 -0800 (PST)
MIME-Version: 1.0
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-3-git-send-email-aisheng.dong@nxp.com> <1548413169.28802.43.camel@pengutronix.de>
In-Reply-To: <1548413169.28802.43.camel@pengutronix.de>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Sun, 27 Jan 2019 22:05:23 +0800
Message-ID: <CAA+hA=QsbQ7k-5aXyWCM+Fss5nc7yr5=CRC3Uo+5r67Da5Pg6g@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 6:47 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index eaabcda..beeed4a 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > @@ -6,8 +6,9 @@ Required properties:
> > >     - "fsl,imx8m-irqsteer"
> > >     - "fsl,imx-irqsteer"
> >  - reg: Physical base address and size of registers.
> > -- interrupts: Should contain the parent interrupt line used to multiplex the
> > -  input interrupts.
> > +- interrupts: Should contain the up to 8 parent interrupt lines used to
> > +  multiplex the input interrupts. They should be sepcified seqencially
> > +  from output 0 to 7. NOTE at least one output interrupt has to be specified.
>
> I don't think the note clarifies anything. Given that the thing is a
> irq multiplexer I don't think anyone expects that you could get away
> with no output irq.
>

Sound reasonable to me.
I will remove the note and keep other as it is.

Regards
Dong Aisheng
