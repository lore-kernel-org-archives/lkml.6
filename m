Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DBC217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMzlMsD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DBC217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHUUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:21:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41238 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeHUUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:21:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so5966076pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axrEzShdx5QPxl/juPcsI2w2RlOHGua6EjE2ZesHLAc=;
        b=ZMzlMsD4OKDBj7l9zvxcMkGI07FqLUSfp45o9AIclriPU6ZoI/BdMS2mlt+GaZ8s/L
         VRaaRNfFdEnwkJ1kMlb1FU204AFPng6DZuPJTegVxBz59HRJx0FRrAh61OvwqpW5GSUw
         fQaSZkR1fVC2qcxEtAX0s1fMMuDwSZ2uUcXvgiCCP6NS9q0wEbKRHrTjV8QRPII+Ok/k
         kL+SE451UrBG+XLNx28H59sCBnf7Ha/rObcLsmyMa+Skla2F6SXSyFcP0AWIMqihk1P6
         cnU62xlnWZYIcvL+XobNt++DAloduG3QI7w3g7RlCa8kx982q+izrL17pOWfRgt6Whx8
         KYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axrEzShdx5QPxl/juPcsI2w2RlOHGua6EjE2ZesHLAc=;
        b=KEir6/tvHR7nGf+UERH0SYS0OzQrMwD8DuYMF3mTGLKD5A3gDpOBFjQ16iMZdxyU42
         7W3WJcV276yMDyszKIKVu8FVMVTU2nqnmxhIgY2ujyMxkT4646eDhJAzkuO3W1+64Los
         Fsu1RADbr3rVBqjUnWBuRyLZaBmjq34r3ck35OFrMXZP8VYSD4BDXhX+QDWRLgDi7W4P
         vrbr+BXPSZ194ocwzmSgbaPPWsYWZtSQq6rJtVlw8owimvMTXdZBS0+Gi0sczP7Lzisf
         czu+LfgrEq3AWKsXaKet1uek9/3SDmsv9Jk2JpOjegJVkAon3HvxpFVaNg0bwHTb9mt3
         +ABw==
X-Gm-Message-State: AOUpUlGEPWTUnVphqykqcc7HCJHm9BZbAccM67k3ZQ8ZLND/s8Bx/ET9
        NKw5zlDDxGLIB+ud2V9MNIhmcgREMZyb87//M6PuyA==
X-Google-Smtp-Source: AA+uWPwP71W/ooP2xuIgWtxWBBEIh5tBSgjHFc4TloxcNvlmUSWKntPaC/lJVcWpMReNmpND26mpKkz/hHEYtR6bHBo=
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr53675882pfy.227.1534870843859;
 Tue, 21 Aug 2018 10:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica> <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
In-Reply-To: <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 10:00:32 -0700
Message-ID: <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     joe@perches.com
Cc:     asmadeus@codewreck.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 9:45 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-08-21 at 09:32 -0700, Nick Desaulniers wrote:
> > On Tue, Aug 21, 2018 at 5:38 AM Dominique Martinet
> > <asmadeus@codewreck.org> wrote:
> > >
> > > Nick Desaulniers Aug. 21, 2018, 8:09 a.m. UTC:
> > > > Thanks for noticing, and sending this patch.  I'm happy to see others
> > > > testing with Clang.  I noticed this too near the end of the day
> > > > https://github.com/ClangBuiltLinux/linux/issues/27.
> > >
> > > FWIW libbcc so many BPF users also use clang, so this has more impact
> > > than just testing to build linux with clang (not that this would be any
> > > reason to delay fixing either way)
> > >
> > > I would tend to agree havin a compiler-common + make clang/intel not
> > > include compiler-gcc would probably be best in the long run but we might
> > > want a quick fix for 4.19 meanwhile..
> >
> > That's fair. SOP here is quick (full) revert, then come up with a
> > better fix.  And I do prefer Masahiro's partial revert to a full
> > revert of Joe's patch.  That will give us more time to develop the
> > proper fix rather than rush.  I'll try to see how we can more properly
> > split the compiler specific headers.
> >
> > Tested with gcc-7 and clang-8.
>
> clang-8? Isn't the latest officlal clang 6.0.1 ?

Yes, but I have a local llvm tree that I work out of, that's in my
$PATH, so my version of clang is never too far behind Top of Tree.
For android, we're using clang-5, but currently staging an upgrade to
clang 6.0.1.

> So if something other than 6.0.x is required,
> then some additional check should probably be
> added to compiler-clang.h as well.
>

Sure, but that doesn't need to go in Mashiro's patch today.  That can
wait for a proper separation between compiler headers where we can
then implement improved version checks.

-- 
Thanks,
~Nick Desaulniers
