Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427323AbeBORZd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:25:33 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50496 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165131AbeBOPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:34:41 -0500
Date: Thu, 15 Feb 2018 16:34:37 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/15] soc: renesas: Add R-Car M3-N support
Message-ID: <20180215153436.77h46poeswto53lm@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdU-pYNwjrXSR7j2kNkJSYsKd=0Kf0Tzq5LHpwA7p4_9MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU-pYNwjrXSR7j2kNkJSYsKd=0Kf0Tzq5LHpwA7p4_9MA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 01:48:27PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> Thanks for your patch!
> 
> On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
> > Add support for R-Car M3-N (r8a77965) power areas and reset.
> > M3-N power areas are identical to M3-W ones, so just copy and rename
> > them.
> 
> They are not identical:
>   - M3-N does not have the CA53-related areas,
>   - M3-W does not have A3VP,
>   - M3-N does not have A2VC0 (M3-W also doesn't, according to latest
> datasheet?).
> 
> The datasheet also mentions A3SH, without further info about the register
> block. I think we need to bring this up with Renesas.
> 
> >  .../bindings/power/renesas,rcar-sysc.txt           |  1 +
> >  .../devicetree/bindings/reset/renesas,rst.txt      |  1 +
> >  drivers/soc/renesas/Kconfig                        |  9 ++++--
> >  drivers/soc/renesas/Makefile                       |  1 +
> >  drivers/soc/renesas/r8a77965-sysc.c                | 37 ++++++++++++++++++++++
> >  drivers/soc/renesas/rcar-rst.c                     |  1 +
> >  drivers/soc/renesas/rcar-sysc.c                    |  3 ++
> >  drivers/soc/renesas/rcar-sysc.h                    |  1 +
> >  drivers/soc/renesas/renesas-soc.c                  |  8 +++++
> >  include/dt-bindings/power/r8a77965-sysc.h          | 31 ++++++++++++++++++
> >  10 files changed, 91 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
> >  create mode 100644 include/dt-bindings/power/r8a77965-sysc.h
> 
> The maintainer may ask you to split this patch by functionality...

Yes, I would like this split up.

I think "[PATCH 00/11] Add R8A77980/Condor board support" provides
a good example.
