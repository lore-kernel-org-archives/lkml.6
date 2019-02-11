Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4094FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107D4218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMMMgpkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbfBKTcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:32:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfBKTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:32:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so24955pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7Vpcu98+gD4EE9XrIJ1Ld431U8bHMH0CQZqIbdv5bY=;
        b=JMMMgpkZaL2uQe6u3kh/dp6JfWAYAY4mUstktQDziTUDn4xOkiprw7u00P6Duo4mUB
         9d5sfDK185GUxoFERNF5b5yE7ltchm0dtKnGklyKpk1werDE6JajKR/pZuYsZCj15WML
         XMExT0DNgug8knBLbB+LBxJnYB9gl5Qylm65AEUvk3Q2vOXvTFBb/IlLDEmsS5BC2UbK
         lPV7+fZCAPk05neN6OAZVUtTCuVNucrcBcNx1uZOB91pYx8vfnunf4enmV2SEeiPioZW
         NwvKegm9vANQ6HJJcqzwuwEsBZ8D7KHYUVzlBmqbxZpLsWuQLZ9ZFO4vB/Esn69kvcPK
         nzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7Vpcu98+gD4EE9XrIJ1Ld431U8bHMH0CQZqIbdv5bY=;
        b=bwpmmC9S5ZanIovSmQNMR3qYmhMAP6D38fmOFrURv3Q/CPiN65gWOOEnGW7bk3VdG1
         /DtUQbKlaZAD334Z9EpAjp75jzNT2JYz4xka9YB+T4MF2LocjSUtB1AH/ZK9wLlKdV51
         I3HHz3z4pFnAEsB9PZSKR/Y7OzNCNCW+M3+n3nJAF+erlkfo+IiD218hbLeG7KdK963w
         Ef890wfSZBLrMcgh1dGI/ZiiTJ5e4QFUjSjd+PtZyIBz74WIYU1Ix5w+ScCmeNwwvi6q
         KcwsitrIE142BA5yvrtsrByIXskuqS66nMPpX3fUYSiWbQxoKJH8W/vpMruG1WQd80eg
         zYQA==
X-Gm-Message-State: AHQUAub3qgMm/RFED3zx2y5YUMvyR0ot7ABlqXJBKHwLBs4sZi+0Vr0L
        TaDHyDWxCiiZNEZm+GgTGpK9WE1Xs0TqNh70juIUEA==
X-Google-Smtp-Source: AHgI3IYkIXQFUoOwTRsLPav5lTuQQJ+1C038vJfUOPDGrW3cHz4kCk7LJwgEsblUVQUypbKAgeWwjMQTqfKOkRyyXlk=
X-Received: by 2002:a63:ce0e:: with SMTP id y14mr35278528pgf.145.1549913172124;
 Mon, 11 Feb 2019 11:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com> <20190208055059.GD9647@archlinux-ryzen>
In-Reply-To: <20190208055059.GD9647@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Feb 2019 11:26:00 -0800
Message-ID: <CAKwvOdnSStbZ35RqSoy-B8sdx+MCR867gKTu4UA5g8wvUHwVFw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Feb 07, 2019 at 02:01:51PM -0800, ndesaulniers@google.com wrote:
> > This is needed because clang doesn't select which linker to use based on
> > $LD but rather -fuse-ld=$(LD). This is problematic especially for
> > cc-ldoption, which checks for linker flag support via invoking the
> > compiler, rather than the linker.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 0eae4277206e..6307c17259ea 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -502,6 +502,9 @@ endif
> >  CLANG_FLAGS  += -no-integrated-as
> >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > +CLANG_FLAGS  += -fuse-ld=lld
> > +endif
>
> This section needs to be moved up above KBUILD_CFLAGS otherwise it never
> actually gets passed along.

Great catch! I had that correct in my Pixel kernel patches; messed
that up forward porting them.  Included in v2 (sending imminently).

-- 
Thanks,
~Nick Desaulniers
