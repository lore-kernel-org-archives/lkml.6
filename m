Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeFAPhd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:37:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46612 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeFAPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:37:31 -0400
X-Google-Smtp-Source: ADUXVKJuAAndjAKvgyO0DLrrH6AnlMOWhDxXgwtgxh7LajV9BDdQRKOMtuPvc7txxve1o2J9hJG9DA==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the regulator tree with the arm-soc tree
Date: Fri, 01 Jun 2018 00:49:53 +0200
Message-ID: <2564792.sYBGPVz9u3@z50>
In-Reply-To: <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
References: <20180530150711.2c7c1fe9@canb.auug.org.au> <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 9:29:24 AM CEST Linus Walleij wrote:
> On Wed, May 30, 2018 at 7:07 AM, Stephen Rothwell <sfr@canb.auug.org.au> 
wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the regulator tree got a conflict in:
> >   arch/arm/mach-omap1/board-ams-delta.c
> > 
> > between commit:
> >   0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")
> > 
> > from the arm-soc tree and commit:
> >   6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
> > 
> > from the regulator tree.
> > 
> > I fixed it up (see below - it may be better done) and can carry the fix
> > as necessary.
> 
> OMG that patch on a patch makes my head spin.
>
> I think I just have to look at the eventual result in linux-next and see if
> it makes proper sense, and rely on Janusz to test the result and help
> to fix it up.

Hi,

I confirm the fix by Stephen works for me, however, the conflicting patch by 
Linus breaks things a bit.

Lookup tables added to board files use function name "enable" while the 
regulator uses NULL. As a result, GPIO descriptor is not matched and not 
assigned to the regulator which ends up running with no control over GPIO pin.

Either the regulator driver should use the function name "enable" or that name 
should be removed from lookup tables.

Thanks,
Janusz
