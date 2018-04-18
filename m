Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeDRKCJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:02:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57679 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeDRKCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:02:07 -0400
Date: Wed, 18 Apr 2018 12:01:54 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] ARM: smp: Add initialization of CNTVOFF
Message-ID: <20180418120154.28fe6c4c@dell-desktop.home>
In-Reply-To: <CAMuHMdWFyLCQb=c=gnWokxGFtsQF2i+s1nPWtJJmZPXAQjnu4g@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
        <20180416215032.5023-6-mylene.josserand@bootlin.com>
        <CAMuHMdWFyLCQb=c=gnWokxGFtsQF2i+s1nPWtJJmZPXAQjnu4g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On Wed, 18 Apr 2018 11:30:47 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Allo Mylène,
> 
> On Mon, Apr 16, 2018 at 11:50 PM, Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
> > The CNTVOFF register from arch timer is uninitialized.
> > It should be done by the bootloader but it is currently not the case,
> > even for boot CPU because this SoC is booting in secure mode.
> > It leads to an random offset value meaning that each CPU will have a
> > different time, which isn't working very well.
> >
> > Add assembly code used for boot CPU and secondary CPU cores to make
> > sure that the CNTVOFF register is initialized. Because this code can
> > be used by different platforms, add this assembly file in ARM's common
> > folder.  
> 
> Thanks for your patch!
> 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Great, thank you very much for your test!

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
