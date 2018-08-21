Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42F0C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EEF2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LY+3Oe9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EEF2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeHUT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:56:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35230 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbeHUT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:56:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id z4-v6so3710095pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CCBJJVGFxAAwcmcH3qHRf297x5GqLjNnSdZ9JhxvWg=;
        b=LY+3Oe9BzzOeNFP8x5PrmfRY16UWqVc4fGKMkVPyT7S9xW5vYzzUQaxNbW3FN+vHbp
         bHnk8ZevMlIrgZxZ14eH04N1aC8WmlH04cDO00Y1wPa5BZ/tk7tEeJsONeUZNKwE+oKr
         Cs9xOqfhv+mNbA8s7FtqtJUw7tTe6AVHiPULZLxS0iv0Cyan1N1e/oTDxNXh0YlsUMMd
         DbH8DWpwCMRT0Zi4ML5IK9HvTjryaqkPQcr29axgoRiEP246rbD7SSnqIlh7KbNW+1AH
         F8pvxbFJMnQNNrUH66qgc4e9U2/rHqwaNOfnnnX+Sl4Y5RWwcHWd1KcCC0uCoFfQ7Th/
         Ysgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CCBJJVGFxAAwcmcH3qHRf297x5GqLjNnSdZ9JhxvWg=;
        b=KGNR0LBhXpvu25BJDqxNQEQC/lAtj1hFNC+Xmi9AcRpRiGApeViDxcEfK/150qdG4m
         GsT2L/9DjhsKVtACWb5pT4XSctFLaMbEh6RCwIYMKqtJMozqTuvvXyTNafZ2YKwm5Zwk
         kdK4nghK4yY/BaeyoJkokIdSx930F/tSXQhZeLUXcx823qnUBb7B3sqWgYeGEpnWj6Yw
         ZfuI3Pm4qG90gP88XgpUR3xY/2DM+LEC5irwhhwGFELw+Gyof1nWnDUto3w06usx8Lx6
         3WujGoJVxR7kq7x5AwwwkgAR0BWBtLu4NJIth2r32U6IZNFpf5g8NCBCLk3pZcChZyS9
         uPDw==
X-Gm-Message-State: AOUpUlELeHeDoYl9IA0EAZXWuUQybTN5wvlTRjQOjcN3oLBH83KL0cow
        2/pbz5iWItX5EcwvifSveBCVwMDftN5tx9DpcAIqCg==
X-Google-Smtp-Source: AA+uWPyq8XI1O9hYyvkD2leLahyEYxcyD/LoN9ljpRsqhgSilcYVd3IbWJEMB8zhFk1NQ+tNPTVBFfag0P8j0GO3gQA=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr53606775pfi.174.1534869342435;
 Tue, 21 Aug 2018 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com> <7bbf0a3c97f817c81df2316fca0ec88d5a6b4302.camel@perches.com>
In-Reply-To: <7bbf0a3c97f817c81df2316fca0ec88d5a6b4302.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 09:35:31 -0700
Message-ID: <CAKwvOdmFqz6M+dPbYBMdOVMkDyLD568zNFOyva+20GK66h3Qrg@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     joe@perches.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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

On Tue, Aug 21, 2018 at 3:39 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
> > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > missed the fact that <linux/compiler-gcc.h> is included by Clang
> > as well as by GCC.
> >
> > Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
> > and it looks like GCC 4.2.1.
> >
> >   $ scripts/gcc-version.sh -p clang
> >   040201
>
> Perhaps this would work, but I can't test it as
> my clang version doesn't otherwise build a defconfig
> and errors out with
>
> $ make CC=clang
> arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.

Sorry, we're working on implementing this in clang and llvm for x86.
I recently reviewed the design doc, and am trying to see how I can
actively help push this along.  It's not a small/quick change to llvm,
but we're working on it.

-- 
Thanks,
~Nick Desaulniers
