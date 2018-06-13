Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 21BC0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DB72086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DB72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934627AbeFMHRj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:17:39 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34878 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933999AbeFMHRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:17:37 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so1050469uad.2;
        Wed, 13 Jun 2018 00:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kiYH9DwiIFzBD3/Rt5861aLo9fia85zzfXULsZivXM=;
        b=g2sECHrBs8FQiNdTzKpt5hSH0YxPLTRyWrfcbWZ0qU79BEtwOut5FCuqB9wQMFKx+r
         oaSTIDF4cZOCS+mkB9TVQ3hZepEZ/vI+kTolzjQaM0Wyxfy8RPX633EIc6ZaFS7GQbjr
         lMBYajd1MwsyO0MWPJ9yle3nfpD7Ohc5Cj3RbJlCCMBkFdYY4EC93nXWxNOzyaZ/OI2M
         no6xCbbjx/Ao+N2E2ctZCriSgCGd2LfWNpxbn/ZEc7uDO00OaPsAk3adSDDvkzsgTXSw
         G6mf1oVOi+d8vUiyhi8O/nULl+lpPKVQukDEcaITKHWflBp4f9fRPvYa8oM/rHU849H4
         ekFg==
X-Gm-Message-State: APt69E36MBVDd1KjCT/H1bq+swfrmAyY/C0z1eqT6IcVGaeEphnoWicJ
        lVzVSCKsPoE6poeIic37GhC9qCO7b2OowwZs2t8=
X-Google-Smtp-Source: ADUXVKIpT4WPkBjlwtinfayzhN7ycvreFHCVp8EP/MkhvDui7I1Kt15BQcaZjFCF6MlTT73KfMhhqr5HZg7fHYTbO5w=
X-Received: by 2002:ab0:5105:: with SMTP id e5-v6mr2679815uaa.33.1528874256573;
 Wed, 13 Jun 2018 00:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <1528187462-47093-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528187462-47093-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWoE=+sEUtFdPKk4eBGtOn8f7bUPV-HLAvEETuqgVMeVw@mail.gmail.com> <OSBPR01MB2054D7F35A31A8331B906E05D27E0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2054D7F35A31A8331B906E05D27E0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jun 2018 09:17:24 +0200
Message-ID: <CAMuHMdUtdRB_L-WsphJYBd9m-3tth3KHGK1wWdr_UJF18S9Z5A@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Wed, Jun 13, 2018 at 8:38 AM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 11 June 2018 11:01, Geert wrote:
> > On Tue, Jun 5, 2018 at 10:36 AM Michel Pollet
> > <michel.pollet@bp.renesas.com> wrote:
> > > The Renesas R9A06G032 SYSCTRL node description.
> > >
> > > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-
> > sysctr
> > > +++ l.txt
> > > @@ -0,0 +1,32 @@
> > > +* Renesas R9A06G032 SYSCTRL
> > > +
> > > +Required Properties:
> > > +
> > > +  - compatible: Must be:
> > > +    - "renesas,r9a06g032-sysctrl"
> > > +  - reg: Base address and length of the SYSCTRL IO block.
> > > +  - #clock-cells: Must be 1
> >
> > (repeating myself) No clocks/clock-names for the external clock inputs?
> >
> > "RZ/N1 has 3 clock sources, 1 reference clock inputs for RGMII, and 2
> > reference clock outputs for RMII/MII."
>
> Well, I'm trying to keep the binding as simple as possible, to dodge any
> further discussion. Adding these will be possible later, I don't need them
> for the moment anyway.

Don't you? The external clock inputs are at the root of the clock tree, so I'd
say you need them. Bolting them on later may become complicated, especially
if you care about DTB backwards compatibility.

The reset controller subsystem is optional anyway, and used only by a small
number of drivers, so support for resets can definitely be postponed.

> Did you have a chance to review the clock driver proper? I'm pondering
> sending a v9 since it's been a week (with very minor changes) -- but I
> don't want to interrupt if you were in the process of reviewing...

I had a quick glance. Looks OK mostly, so it's definitely heading for the right
direction!
One remaining question: do you need CLK_OF_DECLARE()?
Is there any reason your clock driver cannot be a platform driver, which is
the recommended way?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
