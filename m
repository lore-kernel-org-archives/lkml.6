Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68193C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ABE2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K2HUPNHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfBALEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:04:25 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:48712 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfBALEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:04:25 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x11B4J48019573;
        Fri, 1 Feb 2019 20:04:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x11B4J48019573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549019060;
        bh=yDAU8XmmXllW/wJ3sPN2nDmJhz8oMowNBjb9vphh7eU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K2HUPNHIXp33oEF2k3M3p7rKCKRYg50gNeB/9jB0pEosh7anoNF7Ft4zJuTKFTbHc
         eMg1YYPz6I5umH7+huBuyYFGG8O8k+/tXL8KWKpdAHxOAWf1y6oeMy+0ZOE9+1VVcZ
         ku6TfI2ngPcMdrsjJlgRaOXmeu5m21a50krfP0rMbSRHlbbSQ1fazw9xsL1SAnf/DC
         wejQg4T4CYWy+3m1NAHLhJhY6UCsixpvZF12WtIeToMRQMqT/bQoPfQfIkSTCWz8tS
         6JQZPGaF1wG0pwl/lwOxSRLOIp+JpwtrGcNV+zBb4vX9FwMweJG5i41qjPwOENsUjY
         tQrZ3rMDQSUnA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id h78so3923781vsi.6;
        Fri, 01 Feb 2019 03:04:20 -0800 (PST)
X-Gm-Message-State: AJcUukdgEuIwkamZslwkXgPo5gx0uYLjWO1kdUIKJWvH3oXI8buvwrFm
        TDNj/w4EgZOuioPtSgXz2fPe8Xaez6FRG3HRAQ8=
X-Google-Smtp-Source: ALg8bN4W5/eQwHQqoqGkbzuomK/Civjs8bMlxCBfD5EP6avmy1IxHHQHoXkBLTTlgXEa4/J9rXe2SvnLskj1Brq5ivE=
X-Received: by 2002:a67:385a:: with SMTP id f87mr16122960vsa.179.1549019059122;
 Fri, 01 Feb 2019 03:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20190121095338.8565-1-bp@alien8.de> <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic> <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201102332.GD31854@zn.tnic>
In-Reply-To: <20190201102332.GD31854@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 20:03:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQbJH_cScJ+feCSCFGbHr+EiaKcYLLxsvVn+WVCOoRbg@mail.gmail.com>
Message-ID: <CAK7LNARQbJH_cScJ+feCSCFGbHr+EiaKcYLLxsvVn+WVCOoRbg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 7:25 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 01, 2019 at 07:09:36PM +0900, Masahiro Yamada wrote:
> > Why should the normal build affected by the debugging aid?
>
> Hmm, ok, so then that target really is being used during the normal
> build. I don't know why yet so I'll have to do some more staring.
>
> > One more thing, you did not answer my question.
> >
> > If you are complaining about the DWARF info
> > enabled by CONFIG_DEBUG_INFO,
> > I recommend to turn off CONFIG_DEBUG_INFO.
>
> Yes but I don't want to be changing .config just so that I can look at
> the asm output.


Generally speaking, the build system should do what was
requested by a set of CONFIG options.

If you want to turn off DWARF info,
you should disable the corresponding CONFIG.


If you want to tweak the behavior from the command line,
KCFLAGS is available though.


make arch/x86/kernel/cpu/common.s KCFLAGS="-gno-as-locview-support
-fno-dwarf2-cfi-asm -feliminate-unused-debug-symbols
-gno-statement-frontiers"



> I'll think about a better solution.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada
