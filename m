Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDEFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF97218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nA5FVrph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfBAL64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:58:56 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22941 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:58:56 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x11BwnXG010847;
        Fri, 1 Feb 2019 20:58:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x11BwnXG010847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549022330;
        bh=VmprrmhbQ2FLJ5GQ7pNlGsz5T3rYR8ECwAW/VerjiRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nA5FVrphSn7eHiIVhoYl0/h1lV/fJqa0spv1PGY8XH6vS8CPyATvkBbuqAYtn8RBP
         SUegmt1LyaU51WTjwxtfGvSKRy/iFdMj0jr2n7vGRBxd5FPExxmNdpupGf1IPNxB4c
         0GQ8XJFxjsGLH3NLIH1G1peT2ZdjeYvUmD+syxvAUAqP0yjNuh1JdmwMJwA7ZKjo7h
         wheo60kDjKO0TKoYdsolL8aGXLPLrYwmtF4pdqomWmTDNCW787cnjalYFUT60WQW4o
         WoElG0Hg8+XtQ84kt3vcZXf2obs7rHrWpTd4JavcadB5ypjE2ks9qUFVQdXZ6LLVVq
         QO8cOEUZXPJjQ==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id x1so3994171vsc.10;
        Fri, 01 Feb 2019 03:58:50 -0800 (PST)
X-Gm-Message-State: AJcUukdO4shm1w9PDaAltsMd617m6rCEeLKQDqx3bYWAOxkQkXPrdgFi
        D2FvWLroyo9MTyGfQxvpxCS/tAmrgCfclyx34zs=
X-Google-Smtp-Source: ALg8bN7OhOddNr3LhVvUIsS3XsTgAtWUejG5yu5kI4lQ3zlWIHZgCfGkwUlt/mji+BWKRy+8QfjC2eBXRzco3cpzCQ0=
X-Received: by 2002:a67:a858:: with SMTP id r85mr15788741vse.215.1549022329417;
 Fri, 01 Feb 2019 03:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190121095338.8565-1-bp@alien8.de> <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic> <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic> <20190201103648.GF31854@zn.tnic>
In-Reply-To: <20190201103648.GF31854@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 20:58:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
Message-ID: <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
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

On Fri, Feb 1, 2019 at 7:38 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 01, 2019 at 11:30:38AM +0100, Borislav Petkov wrote:
> > This can't be a full kernel build.
>
> So I did this:
>
> $(obj)/%.s: $(src)/%.c FORCE
>         @echo "HERE\n"
>         $(call if_changed_dep,cc_s_c)
>
> and did a full kernel build with my .config. I got exactly *three*
> "HERE"s in the build log.
>
> So pls explain in more detail how you're measuring that slowdown.


Variables assigned with ':=' are evaluated just on parsing Makefile.

The scripts/Makefile.build is parsed over and over again,
so the compiler is invoked hundreds times to test these four options
even when you are not actually building any new objects.

It is mitigated by replacing ':=' with '=',
but they are still evaluated multiple times when generating asm-offset.

Frankly, you cannot use cc-option in scripts/Makefile.build


Your next question might be,
"Is it OK to implement this in the top Makefile?"

It would be better, but I am not convinced to do it.



-- 
Best Regards
Masahiro Yamada
