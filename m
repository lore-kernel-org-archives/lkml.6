Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035DDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E9E20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aJbUwez2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfAVFbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:31:11 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38472 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAVFbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:31:11 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x0M5UuUh025827;
        Tue, 22 Jan 2019 14:30:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0M5UuUh025827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548135057;
        bh=/UerpFNVq+RiW7QGbPyYsuL0OvnDvCDK82tBkZpFt7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aJbUwez20UirOCx2y43ijg349Sc9SmjJKxbGwopYxEu4rtrOzhmpvoNQCj9sTo3vB
         cVbotOsiKCSEYpaEj3xGHJ8v2TPPzFdFYRmd4gbQNliGQGuWDREpwWQwgN06HIBfpM
         APNoIms+wgKdBqRgtd03q4EghMZe9Yv3IC0x+mboA1Pk+UhN2//p9m9WEfQ52isO8G
         aVLDzgJmwd6Emkj5gj45u3W7s2nqn1c4glSEOE+BiAklfhb/o5NxEG2DE9Ax1KkQ8v
         qoyxueI7oFcFtP/Bzp22BssfYxDfUvU/ZS/YcUqDrCNM7pJVfUuQbkRcJEIU+fOAhb
         0rFKuzFpYdLmQ==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id x1so13973806vsc.10;
        Mon, 21 Jan 2019 21:30:57 -0800 (PST)
X-Gm-Message-State: AJcUukcBaGHLFxmDauCskg7Gj0DGa5PgP731NjSe6P/D5AO+7ohsObNn
        6ca69NsoSu2EiK4/hWqck//ek+viLRvM36Wtmvs=
X-Google-Smtp-Source: ALg8bN4fYaIAc6pmR8T+C8LImWViDQaM23mANtQQmKvX/ije8VsfZcC5WaRepMzKnKhUkuaxFZQ62M8pYS9txv6Q8Q4=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr13411241vsb.155.1548135056278;
 Mon, 21 Jan 2019 21:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20190122150231.0191e8d4@canb.auug.org.au>
In-Reply-To: <20190122150231.0191e8d4@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 22 Jan 2019 14:30:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAL0zm+OpHDpKdufznZ_nSqyOcEh_Pes3oCMs1CtA9Cw@mail.gmail.com>
Message-ID: <CAK7LNAQAL0zm+OpHDpKdufznZ_nSqyOcEh_Pes3oCMs1CtA9Cw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 1:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the akpm tree got a conflict in:
>
>   Makefile
>
> between commit:
>
>   b57304bb03de ("kbuild: remove meaningless prepare2 target")
>
> from the kbuild tree and patch:
>
>   "locking/atomics: build atomic headers as required"


This has been sitting around since the previous development cycle.
The relevant patches were not sent to Linus in the previous MW.

I believe those should be dropped entirely,
and re-implemented cleanly/correctly if Mark Rutland wants this change.

People already pointed out the scripts are so slow,
but that is not the only problem.

[1] I see annoying log message
    "Nothing to be done for 'all'"
    for every incremental build

[2] Dependencies might not be sufficient.
    For example, nothing is rebuilt when scripts/atomic/fallbacks/* is touched.

[3] I do not understand why scripts/Makefile.genheader must be added.






> from the akpm tree.
>
> I fixed it up (I hope - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc Makefile
> index 004a190e3ece,bd0f79d8295e..000000000000
> --- a/Makefile
> +++ b/Makefile
> @@@ -1077,8 -1077,12 +1077,8 @@@ ifneq ($(KBUILD_SRC),
>         fi;
>   endif
>
> - prepare1: prepare3 outputmakefile asm-generic $(version_h) $(autoksyms_h) \
> -                                               include/generated/utsrelease.h
>  -# prepare2 creates a makefile if using a separate output directory.
>  -# From this point forward, .config has been reprocessed, so any rules
>  -# that need to depend on updated CONFIG_* values can be checked here.
>  -prepare2: prepare3 outputmakefile asm-generic genheader
>  -
>  -prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
> ++prepare1: prepare3 outputmakefile asm-generic genheader $(version_h) \
> ++                              $(autoksyms_h) include/generated/utsrelease.h
>         $(cmd_crmodverdir)
>
>   archprepare: archheaders archscripts prepare1 scripts



-- 
Best Regards
Masahiro Yamada
