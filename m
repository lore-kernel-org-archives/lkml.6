Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeDSGxb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:53:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52860 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeDSGx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:53:29 -0400
Date: Thu, 19 Apr 2018 08:53:16 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a
 file
Message-ID: <20180419085316.0bd9bfad@dell-desktop.home>
In-Reply-To: <CAGb2v64UCA825xC=wvBZ6n0K-c=vsOO15F7S6Bn=i9c=eAqYww@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
        <20180416215032.5023-2-mylene.josserand@bootlin.com>
        <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
        <20180417111737.6dous6eiuvjn33jf@flea>
        <CAGb2v67qvk=T7u7bOjVZ7q_qsjJuEOM6iarw7by42ga=EYuYDg@mail.gmail.com>
        <20180418084535.lqdvjgcbxtnwqwri@flea>
        <CAGb2v64UCA825xC=wvBZ6n0K-c=vsOO15F7S6Bn=i9c=eAqYww@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen-Yu,

On Wed, 18 Apr 2018 18:05:03 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Wed, Apr 18, 2018 at 4:45 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 17, 2018 at 07:25:15PM +0800, Chen-Yu Tsai wrote:  
> >> On Tue, Apr 17, 2018 at 7:17 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:  
> >> > On Tue, Apr 17, 2018 at 11:12:41AM +0800, Chen-Yu Tsai wrote:  
> >> >> On Tue, Apr 17, 2018 at 5:50 AM, Mylène Josserand
> >> >> <mylene.josserand@bootlin.com> wrote:  
> >> >> > Move the assembly code for cluster cache enabling and resuming
> >> >> > into an assembly file instead of having it directly in C code.
> >> >> >
> >> >> > Remove the CFLAGS because we are using the ARM directive "arch"
> >> >> > instead.
> >> >> >
> >> >> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> >> >> > ---
> >> >> >  arch/arm/mach-sunxi/Makefile  |  4 +--
> >> >> >  arch/arm/mach-sunxi/headsmp.S | 80 +++++++++++++++++++++++++++++++++++++++++
> >> >> >  arch/arm/mach-sunxi/mc_smp.c  | 82 +++----------------------------------------
> >> >> >  3 files changed, 85 insertions(+), 81 deletions(-)
> >> >> >  create mode 100644 arch/arm/mach-sunxi/headsmp.S  
> >> >>
> >> >> I'm still not convinced about this whole "move ASM to separate
> >> >> file" thing, especially now that you aren't actually adding any
> >> >> sunxi-specific ASM code beyond a simple function call.
> >> >>
> >> >> Could you drop this for now?  
> >> >
> >> > I'd really like to have this merged actually. There's a significant
> >> > readibility improvement, so even if there's no particular functional
> >> > improvement, I'd still call it a win.  
> >>
> >> What parts do you consider hard to read? The extra quotes? Trailing
> >> newline? Or perhaps the __stringify bits?  
> >
> > All of this, plus the clobbers and operands.  
> 
> Ok. Lets move it then.

Ok, I will not drop this patch then.

> 
> The kbuild reports indicate this still needs some work though.

Yes, this is "normal" because the patch, that I depend on, is not
applied yet (even if my cover-letter can let think that, it is not the
case, sorry).

It is applied on Broadcom ARM SoC since Tuesday: 
https://lkml.org/lkml/2018/2/23/1263
https://github.com/Broadcom/stblinux/commits/soc/next

With this patch, it should fix the errors reported by kbuild.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
