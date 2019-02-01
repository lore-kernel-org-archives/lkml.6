Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F02C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159EB21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fHvGQzdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfBAKKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:10:30 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20737 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfBAKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:10:29 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x11AADgX026505;
        Fri, 1 Feb 2019 19:10:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x11AADgX026505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549015814;
        bh=dxd+EXZies+5uKKup3Yw/Jpca021xVJeVxsA4HMd9V8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fHvGQzdiXd4zpqDhSgjNT9qDtT+x6BqoXhGnxqoQEpTU3nUD68CL+uRx15dc1PPc3
         9PTkANA4fVc8kjQR91rQe2yqKSYUWQbTJDNhSrCx3PEziHzbjf+PXCI/Nlnk2SzGeJ
         2ZHJpAI+CV1Umstjr5whY3xYoIBlFc4tIDzRI/44knI9xg+PNvaS8K+eYsYPmbewYP
         znqnnaYDwPRWkmXi5ulnKhBrQBbb2JagjGw2Qz5mpskFJi8Ncitq57z/28fDDy3cW1
         Qo+XhfMz983F5B+NmrGc65zBN/JDeSByu70pu7DNVhSVtGPbkQByCtZt6HzxTMlLTa
         H47aCcTz+4Iwg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id p74so3869242vsc.0;
        Fri, 01 Feb 2019 02:10:14 -0800 (PST)
X-Gm-Message-State: AJcUukcGZsf3tyPPJfpYY/7wg53DEEnu4EFVTJQm/8ExNDurIumGKsK3
        zyDCFTSE53RkdEGi3WLB2IbYpf8lkBbJ3JTlv9g=
X-Google-Smtp-Source: ALg8bN4ap20VeMmDshliDIOUyeO2/ed1zHkx1g22HH/H1DH+HnUdaL+bNVC/L7wxC76csZ5RTQ1696tJZDK0XueGyxQ=
X-Received: by 2002:a67:a858:: with SMTP id r85mr15604615vse.215.1549015812966;
 Fri, 01 Feb 2019 02:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20190121095338.8565-1-bp@alien8.de> <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com> <20190201094217.GB31854@zn.tnic>
In-Reply-To: <20190201094217.GB31854@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 19:09:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
Message-ID: <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
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

On Fri, Feb 1, 2019 at 6:50 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 01, 2019 at 12:06:13PM +0900, Masahiro Yamada wrote:
> > This would make the build speed slower
> > because the compiler is invoked to check those flags in every directory.
> >
> > I tested this patch with x86_64_defconfig and GCC 8.2
> > (on ubuntu 18.10 in docker)
> > but I saw no effect of this patch.
>
> Yes, because that's the .s target which is meant to be used to convert
> only a *single* .c file to assembly in order to stare at the resulting
> asm. For example:
>
> make arch/x86/kernel/cpu/common.s


I do know this, and did compare the output
from the *single* target "make arch/x86/kernel/cpu/common.s"



> It is a debugging aid - and a very basic and important one - and is not
> usually used during a normal kernel build. AFAIK.
>
> So we shouldn't worry about any slowdowns here.


Your patch does slowdown the build system extremely.


I provide the result of "perf stat" of the incremental build for you.



Without your patch:


 Performance counter stats for 'make -j8' (20 runs):

       2.721312445 seconds time elapsed
          ( +-  1.02% )



With you patch:


 Performance counter stats for 'make -j8' (20 runs):

       5.038521415 seconds time elapsed
          ( +-  0.56% )




Why should the normal build affected by the debugging aid?




One more thing, you did not answer my question.

If you are complaining about the DWARF info
enabled by CONFIG_DEBUG_INFO,
I recommend to turn off CONFIG_DEBUG_INFO.



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
