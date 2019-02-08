Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65400C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E49220863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7UJ39DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfBHRp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:45:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45174 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:45:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id t6so3450324edw.12;
        Fri, 08 Feb 2019 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VPAIx60fv8TTLxQI5f+txnUSAJApFxWkRXdwiHSG3cg=;
        b=t7UJ39DYjeycYbXdDVeVsrpvAi34UPA/SMs3H47gNMdpipS4gWsPBnkpRv1h+/EpRS
         WQ21bJBOVLmv2PbwJHD21IEtP4mgMzqi5Jm8JAUmEQNYG0cDupmWbzsB+VU1SRm0WwwX
         9PmLwluhWUizSWZi7POA42lfHG3txAAClDBtnmZcdDv8PoqpqfUy5qNAhVVOvy4zmwqw
         oD+9Q6miuD7r8pp7vcw94hmOQmhm4BLwuf9PpAgedVtTX6vHLRsqlR0UAz1o46Y5C+kx
         FompjPdlu+DBmHanOw8uG5MmHS6o49u0WgQhMCLqdZqQFo2MRj1QcDJq16Gq6JPAPl9A
         I0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VPAIx60fv8TTLxQI5f+txnUSAJApFxWkRXdwiHSG3cg=;
        b=dsidNrRykRGztkgH+emhdjK68prSzelV9SLve/gjMP/FisvWfaqfmTLKhhM/rB/FUW
         xE7dHjG2IASKQuZTVxt2vdgZvvtxQm86Y3cpK3l81nS1XH8Nc/E8iVhjc6dJxm1OsaPO
         lSRQtIxyfb4YCJm+k96HKDLfowkczP72SW2uDq62lJP/sySWFU8DudVAuczDD9Vs7SFz
         /dVPGqHlhrACbK+zupBsfwhPQCFjWR4YR3eFr3wNTzlcDpoUT8k2jiknr+LI74hLazzU
         ELx7WbYeFyiOrGe0hbF6697WIfC106y0Uf7H/FefJrKFokOVmuJa+NLNDhFpfneL3e7U
         YblA==
X-Gm-Message-State: AHQUAub+8VTMKIsoLQei32HleixZzd0EvxYKd/twt33Nklfg5qtxrsQ6
        1z+Gx1m9F2arm8PdGpkj5n0=
X-Google-Smtp-Source: AHgI3IbRiFZijyeBx6re2AuyUmg6ziXdUK85x/JFep51TPatSsdnZ3wQxoiCjzaOXmPcie14MRiMOg==
X-Received: by 2002:a17:906:4ac2:: with SMTP id u2mr16873967ejt.94.1549647955913;
        Fri, 08 Feb 2019 09:45:55 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l17sm758756edc.56.2019.02.08.09.45.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 09:45:55 -0800 (PST)
Date:   Fri, 8 Feb 2019 10:45:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sedat.dilek@gmail.com
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
Message-ID: <20190208174553.GA14762@archlinux-ryzen>
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com>
 <20190208055059.GD9647@archlinux-ryzen>
 <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:27:19AM -0800, Nick Desaulniers wrote:
> On Thu, Feb 7, 2019 at 9:51 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Feb 07, 2019 at 02:01:51PM -0800, ndesaulniers@google.com wrote:
> > > This is needed because clang doesn't select which linker to use based on
> > > $LD but rather -fuse-ld=$(LD). This is problematic especially for
> > > cc-ldoption, which checks for linker flag support via invoking the
> > > compiler, rather than the linker.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 0eae4277206e..6307c17259ea 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -502,6 +502,9 @@ endif
> > >  CLANG_FLAGS  += -no-integrated-as
> > >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > > +CLANG_FLAGS  += -fuse-ld=lld
> 
> Sorry, Sedat reports [0] that this is not quite correct; if $(LD)
> matches LLD, then we need to set -fuse-ld=$(LD), not -fuse-ld=lld,
> since you may have lld installed as lld-7 or lld-8, for example:
> https://github.com/ClangBuiltLinux/linux/issues/358
> 

We'll need to make sure that it is compatible with the way that Clang
expects arguments to '-fuse-ld=' because it looks like 'ld.' is
automatically appended.

https://github.com/llvm/llvm-project/blob/5be3dbdb082ffba4f846e3572ea802d156dd8d34/clang/lib/Driver/ToolChain.cpp#L438-L468

> > > +endif
> >
> > This section needs to be moved up above KBUILD_CFLAGS otherwise it never
> > actually gets passed along.
> >
> > With that change, please add:
> >
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > >  export CLANG_FLAGS
> > >  endif
> > >
> > > --
> > > 2.20.1.791.gb4d0f1c61a-goog
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
