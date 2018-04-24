Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934543AbeDXNfQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:35:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934343AbeDXNfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:35:09 -0400
Date: Tue, 24 Apr 2018 14:35:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: support __int128 with clang
Message-ID: <20180424133527.GB24599@arm.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
 <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 06:20:11PM +0200, Jason A. Donenfeld wrote:
> Would you review/merge this when you have a chance?

No real objection from me, but does the arm64 kernel actually build with
clang?

Will

> On Sat, Dec 23, 2017 at 1:43 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Commit fb8722735f50 ("arm64: support __int128 on gcc 5+") added support
> > for arm64 __int128 with gcc with a version-conditional, but neglected to
> > enable this for clang, which in fact appears to support aarch64 __int128.
> > This commit therefore enables it if the compiler is clang, using the
> > same type of makefile conditional used elsewhere in the tree.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/arm64/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index b481b4a7c011..16c2e8b58546 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -57,7 +57,11 @@ KBUILD_AFLAGS        += $(lseinstr) $(brokengasinst)
> >  KBUILD_CFLAGS  += $(call cc-option,-mabi=lp64)
> >  KBUILD_AFLAGS  += $(call cc-option,-mabi=lp64)
> >
> > +ifeq ($(cc-name),clang)
> > +KBUILD_CFLAGS  += -DCONFIG_ARCH_SUPPORTS_INT128
> > +else
> >  KBUILD_CFLAGS  += $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
> > +endif
> >
> >  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
> >  KBUILD_CPPFLAGS        += -mbig-endian
> > --
> > 2.15.1
> >
