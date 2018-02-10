Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBJOTm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:19:42 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45415 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBJOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:19:41 -0500
X-Google-Smtp-Source: AH8x224YtALGUzy0hJFrSeAGckmdljVQaFnaphFXwaqxpOmV+3kw1J/MVYCbuhyhzeOtU6b3smp0+g==
Date: Sat, 10 Feb 2018 15:19:36 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: James Hogan <james@albanarts.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, Linus Walleij <linus.walleij@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mel Gorman <mgorman@techsingularity.net>, hch@lst.de,
        mina86@mina86.com, robh@kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>, paulus@ozlabs.org,
        Will Deacon <will.deacon@arm.com>, tony@atomide.com, npiggin@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 16/20] auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
Message-ID: <20180210141936.mi2mo4c45nfzw34a@huvuddator>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-17-ulfalizer@gmail.com>
 <CAAG0J98pFG=XFYAzQJ2+hROWWF1C=g-jePk6wh2EXsxX51TGVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAG0J98pFG=XFYAzQJ2+hROWWF1C=g-jePk6wh2EXsxX51TGVQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 05:35:30PM +0000, James Hogan wrote:
> On 5 February 2018 at 01:21, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> > The MIPS_SEAD3 symbol was removed in commit 64601cb1343f ("leds: Remove SEAD-3
> > driver").
> >
> > Remove the MIPS_SEAD3 dependency from IMG_ASCII_LCD.
> 
> Its not a dependency, just a default (presumably so that existing
> kernel configs get updated automatically).

Note that it appears in the default's condition rather than as part of
the default value.

Undefined Kconfig symbols always evaluate to n in a tristate state,
regardless of whether they're given a user value in a .config file or
not, so this is a no-op as far as Kconfig in concerned.

The motivation in the original commit message was a bit lackluster
though. I've submitted a v2.

> 
> Note that sead3 now uses MIPS_GENERIC (or more specifically
> CONFIG_LEGACY_BOARD_SEAD3), but this driver is enabled in the config
> snippets, e.g.:
> arch/mips/configs/generic/board-sead-3.config
> arch/mips/configs/generic/board-boston.config
> 
> so indeed there is no real need to replace MIPS_SEAD3 with anything here.
> 
> Cheers
> James
> 
> >
> > Discovered with the
> > https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> > script.
> >
> > Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> > ---
> >  drivers/auxdisplay/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> > index 2c2ed9cf8796..3cba78d36eec 100644
> > --- a/drivers/auxdisplay/Kconfig
> > +++ b/drivers/auxdisplay/Kconfig
> > @@ -137,7 +137,7 @@ config CFAG12864B_RATE
> >  config IMG_ASCII_LCD
> >         tristate "Imagination Technologies ASCII LCD Display"
> >         depends on HAS_IOMEM
> > -       default y if MIPS_MALTA || MIPS_SEAD3
> > +       default y if MIPS_MALTA
> >         select SYSCON
> >         help
> >           Enable this to support the simple ASCII LCD displays found on
> > --
> > 2.14.1
> >
> 
> 
> 
> -- 
> James Hogan

Cheers,
Ulf
