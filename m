Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1368620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag78r9d/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfA3Nd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:33:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56059 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA3Nd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:33:59 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so10221745ith.5;
        Wed, 30 Jan 2019 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5cdkgdNcTluzV7ErxQTrVc9Y3rcoh9266HOxln35YM=;
        b=ag78r9d/QsJ13JJIVBoHbqFQpbVFDFl6I7YTCK8t2LwUWuWvCWExXiS6Y6gEILKlEy
         IyDOHYwM5LVl/9isIBc6o9OnU9420uaohazlV9gjSFScT2EXtVAry1uuxDWlY5X8baPC
         Qc8cykr2v5OargLzg7Plpr9sjTIYYIuja9I8f/ja0XbM6RFc4Qh5ArumUnPWGhHL9/P9
         jWuZR5PGq697Y8BNneUMnG6JWGAv2z1o12hII2tnxVkfGGDnwcaSWnRDsNwZxRSUVSnu
         yeu7xKJL/PJD9UEak2rKzlvTFaoWFqUI/eeIL3n2rNcIt9kMUX5miDQwQAyiwAuJCgBE
         BJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5cdkgdNcTluzV7ErxQTrVc9Y3rcoh9266HOxln35YM=;
        b=LT20h2GXeI83yk9xIPpj5jyLFZSD/JVUMggwKjYBNiOk/lA96AaHimolz91oF5SZiT
         Ajhk8cGhWOth5LHb3kWxVwmrxDkMLjTxJrri5nMJ8Yv8eG1CSY80pPHULl4wurpu2U74
         hlRed9fKlleurn/AOot7FVaZBAnrnqa5yiiD2rlEPC+7o8ma00tHFezCC6O93b23DJnN
         Oj676jqVwRzEQbRIcdw1wLlZp09ydQzkQzrYkdZWP7JKZeuEyz9YCPEconfw1LEKyZ+R
         ke+5+HfEYG6yWQo0tPPvv6Sac9qT+slFu0FaAX7DyPk/22dnqBujB+mygFyXIihRXhUr
         cuQw==
X-Gm-Message-State: AJcUukeSK7LqYeT66CrOlFKd5xq+vDubGu5w9d70LCzgEYF0/CCcZnVC
        JHF/DH0qTcfvR+Sw9rC/y5IWTmg4GwzmlIXzyPslKw==
X-Google-Smtp-Source: ALg8bN5UPHF/sDemIE55aSZwXevNPHFIXLFyyWmVN54K+NSHh49RGEqQo+iQK2Q8wJdAysID/FdesUqUDyCeIT2tXmI=
X-Received: by 2002:a02:49c9:: with SMTP id p70mr18999360jad.40.1548855237942;
 Wed, 30 Jan 2019 05:33:57 -0800 (PST)
MIME-Version: 1.0
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-3-git-send-email-aisheng.dong@nxp.com> <1548854330.6869.22.camel@pengutronix.de>
In-Reply-To: <1548854330.6869.22.camel@pengutronix.de>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 30 Jan 2019 21:33:47 +0800
Message-ID: <CAA+hA=QCYzjqDx1ELSu4dbrwy8JNr4TUr8N1fzKunjT13KEvYA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: irq: imx-irqsteer: add multi output
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

On Wed, Jan 30, 2019 at 9:21 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 30.01.2019, 13:05 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v1->v2:
> >  * remove one unnecessary note.
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index 6d0a41b..984ab92 100644
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
>
> Typos here, should be: "specified sequentially"
>

Nice catch. Will update in new version.
Thanks

Regards
Dong Aisheng

> > +  from output 0 to 7.
> >  - clocks: Should contain one clock for entry in clock-names
> >    see Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  - clock-names:
