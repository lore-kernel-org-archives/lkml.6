Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033299AbeCARNm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:13:42 -0500
Received: from foss.arm.com ([217.140.101.70]:42318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032742AbeCARNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:13:41 -0500
Date: Thu, 1 Mar 2018 17:13:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/efi: Make strrchr() available to the EFI namespace
Message-ID: <20180301171343.GB2678@arm.com>
References: <20180301162803.5490-1-robh@kernel.org>
 <20180301170826.GA2678@arm.com>
 <CAKv+Gu8E=wg-=KCtsR=GFEwT1SsEaGFujBx8PNq0JkCAmJYktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8E=wg-=KCtsR=GFEwT1SsEaGFujBx8PNq0JkCAmJYktw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 05:10:38PM +0000, Ard Biesheuvel wrote:
> On 1 March 2018 at 17:08, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Mar 01, 2018 at 10:28:03AM -0600, Rob Herring wrote:
> >> libfdt gained a new dependency on strrchr, so make it available to the
> >> EFI namespace before we update libfdt.
> >>
> >> Thanks to Ard for providing this fix.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Please ack. This is a dependency on a dtc upstream sync.
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > As an aside, I noticed that this __efistub prefixing is also being
> > applied to mapping symbols, so we get crazy stuff like __efistub_$x. I
> > didn't get round to working out whether that's going to be problematic,
> > but maybe it's all fine...
> >
> 
> Ugh. Those mapping symbols.
> 
> We can filter them explicitly in scripts/kallsyms, I guess, or even
> better, get rid of all __efistub_ symbols entirely (since they are
> either aliases or part of __init code)

Yeah, I started hooking into frob_arch_sections, but I didn't have my ELF
hat on so I set it aside for the time being. There were some other weird
symbols that ended up in modules, some of them with unprintable characters
due to gas generating weird local labels too (I think in BUG()).

Will
