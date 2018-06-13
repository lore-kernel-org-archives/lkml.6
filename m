Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 153A9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53542086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFP+T55r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53542086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbeFMIxv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:53:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39388 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933732AbeFMIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:53:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so1141712plt.6;
        Wed, 13 Jun 2018 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRAwUrqCAvTvutnolJbHOaHl55SyhMZEFEXZmfjbNLQ=;
        b=KFP+T55rqBRa4J2UMgswmTtCeyx7/1U+7zFapgADCM1e5PxVn3jZkjLDPLgH2TThzw
         IzQDz7Xhfht6CEmakfDHqZSmwV0yFOLdaHzgGejNuSuPj2WMICSCP38uv6iSjP6q6ZDZ
         mWJYaE5SYe8D6cwdh4wK86lUX1pfT0OQ4egvXE148dY6XPBQ5S4V50zvo6gHFbvmpnrH
         W5dh/2vF8xT0pw8l402+zZ2QH7+NdenI6QrHMQc4/ZKdiIemmBJkyM/kejdhcT08/GJz
         k2ZsRLkzTxo0rziIJBmQs4M+IRbVDqHCsQjSldEYnCYnBYHi9lV5WrNUsyN0H/RPyYhj
         FoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRAwUrqCAvTvutnolJbHOaHl55SyhMZEFEXZmfjbNLQ=;
        b=iGK6d5OtQmkYHFXJbKPuZY9jLclP5dtFBJPoE+Y0/R1VuuH594fSwfRBoLHaGbtsuf
         GbZGYZFexWNy2EA/QPuVX12vC4ZCS3I4kJkvXc7GXzZ1lj6HA2PAAsjAilANaA79ua4L
         KRkKnbsqnEDV6ycToPijCR+vVKwXSXm51j/Du9cPZefs2ZnKi0gQFf5lyM008vkez1CL
         laiRrdvUg6nNzEPUJu41awgqdLIKCpTYPm7brOJW1KgjElZDr4lVshJ5i99uxNjdX3QM
         ibvtBIx87aJTKLFB3NgD2uIKiQweRHqpEm6o691o1B6utz17jJKMYFbL0uAqlo9U4qw+
         d5og==
X-Gm-Message-State: APt69E2EzkkcXd/XosTq5NHjCIyvJ3kRBrmA2/mcROvl1kBZR5qdgjzB
        RewwCXoHovlgNZ+Ws+bY+caz9pqmPjGjiumiMao=
X-Google-Smtp-Source: ADUXVKJR6qrHR00M2WNkIN6WtBBlRqSCZ+AO8euIW5eFTUU27NE2nTFgbskG6BzSSV9pE5XrivvqQBuWDWwzhS7dhU0=
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr4242750pld.118.1528880026661;
 Wed, 13 Jun 2018 01:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <1528187462-47093-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528187462-47093-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWoE=+sEUtFdPKk4eBGtOn8f7bUPV-HLAvEETuqgVMeVw@mail.gmail.com>
 <OSBPR01MB2054D7F35A31A8331B906E05D27E0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAMuHMdUtdRB_L-WsphJYBd9m-3tth3KHGK1wWdr_UJF18S9Z5A@mail.gmail.com>
In-Reply-To: <CAMuHMdUtdRB_L-WsphJYBd9m-3tth3KHGK1wWdr_UJF18S9Z5A@mail.gmail.com>
From:   M P <buserror@gmail.com>
Date:   Wed, 13 Jun 2018 09:53:35 +0100
Message-ID: <CAMMfpEwhpoBvO+JGPFYeNznns9W=+6iZoUec5Ffk-ppUH_9BFg@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     michel.pollet@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        buserror+upstream@gmail.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, geert+renesas@glider.be,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Geert,

On Wed, 13 Jun 2018 at 08:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Michel,
>
> On Wed, Jun 13, 2018 at 8:38 AM Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > On 11 June 2018 11:01, Geert wrote:
> > > On Tue, Jun 5, 2018 at 10:36 AM Michel Pollet
> > > <michel.pollet@bp.renesas.com> wrote:
> > > > The Renesas R9A06G032 SYSCTRL node description.
> > > >
> > > > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-
> > > sysctr
> > > > +++ l.txt
> > > > @@ -0,0 +1,32 @@
> > > > +* Renesas R9A06G032 SYSCTRL
> > > > +
> > > > +Required Properties:
> > > > +
> > > > +  - compatible: Must be:
> > > > +    - "renesas,r9a06g032-sysctrl"
> > > > +  - reg: Base address and length of the SYSCTRL IO block.
> > > > +  - #clock-cells: Must be 1
> > >
> > > (repeating myself) No clocks/clock-names for the external clock inputs?
> > >
> > > "RZ/N1 has 3 clock sources, 1 reference clock inputs for RGMII, and 2
> > > reference clock outputs for RMII/MII."
> >
> > Well, I'm trying to keep the binding as simple as possible, to dodge any
> > further discussion. Adding these will be possible later, I don't need them
> > for the moment anyway.
>
> Don't you? The external clock inputs are at the root of the clock tree, so I'd
> say you need them. Bolting them on later may become complicated, especially
> if you care about DTB backwards compatibility.

Well the input is fixed frequency -- and there is a clock (gate)
created for it in the driver
(CLK_RGMII_REF) so you can turn it on/off if you like...

The only configurable bit is a *nightmare* as the selection bit for
whether it is coming
from CLKOUT_D8 or from an external input is in a *completely different
IP block*. I'd
need another iomap() and all that stuff, and a custom driver for it.

If I were to implement it, I'd have to add a custom driver for that
clock, use the current
gate as a parent, iomap the selection bit register etc -- basically.
All of that for a use
case of *none ever* as most people would probably tweak that bit in
the bootloader
anyway -- also, I'd have zero capability for testing it.

As far as the output, they also have their own gates (already
created). They are also fixed
frequency and the only thing that matters to them is the pinmux
settings. So (soon) with the
pinmux driver, you can enable that clock properly without a special
driver, just by adding
that gate to your ethernet, and add the pinmux config for it.

So what do I go with that?

>
> The reset controller subsystem is optional anyway, and used only by a small
> number of drivers, so support for resets can definitely be postponed.
>
> > Did you have a chance to review the clock driver proper? I'm pondering
> > sending a v9 since it's been a week (with very minor changes) -- but I
> > don't want to interrupt if you were in the process of reviewing...
>
> I had a quick glance. Looks OK mostly, so it's definitely heading for the right
> direction!
> One remaining question: do you need CLK_OF_DECLARE()?
> Is there any reason your clock driver cannot be a platform driver, which is
> the recommended way?

I copied it straight out of clk-rcar-gen2.c -- I don't 'need' anything more than
instantiating my driver; does it make a difference? ie a one liner macro vs
adding an extra struct, 2 functions to do the same thing?
Just curious, sometime I lose track of that the goalpost is -- for
years I understood
that having OF was simpler and better all around?

Thanks!
Michel
