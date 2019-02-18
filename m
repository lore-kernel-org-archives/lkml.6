Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F78C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AB2217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mbiv0ln1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfBRSYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:24:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41602 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbfBRSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:24:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id z25so7363857ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ugg6qjw/VPgwUqG388rggtOkIKyyqj1TQcTRKc3q+c=;
        b=Mbiv0ln1dESwZkzD7g8+TCVykO3x4+wsMUje/nhgwunqYD8w0aw38yEjnveb3eHAdl
         5tZdmluBU3IXV1lCEW+/pZoA87eErWgrovKc9FqgCtn/QmeyFQYtEQO6G8d8hnYappun
         6YtiRUbs9jXSELgu3gi01SfVzsRTLSiS0VC9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ugg6qjw/VPgwUqG388rggtOkIKyyqj1TQcTRKc3q+c=;
        b=Canz3pA0Nx6lmHhCLzMPqQDlAtIqs4oCVC/XLrs2jlJffnOSpiJmmYa0Fg+hNxGONP
         IXE05HOzHoSo15bejN/SFoZ5u8w7KGqLRR0EAD+IRdcGvjlHQvDOvebRm1pFpEe7mfpZ
         jrRd1kRZ99/+qwabsd0DCYWk7ZZDMIRs86+SdvhM8Ud3jK5b1pzPq/NBejtjn5QzaL92
         kNU6o+Dy+/F0qeVbZZXn6fT8ybcxf0Z+1mr/IiXNE1lelr62aLQpxDLguay0NTO13HBe
         KKqFfEG/C+Jd1GHfLW2F3LLFQWyUOuRv/4ieQMCUa5IENTHvBXNdjKTkGmkN1Bf+NmdS
         YNTA==
X-Gm-Message-State: AHQUAuZtX5XIhwmuXSWj1nxlXiGwVUk+rz+4QHvhdp5t/0oR7DmM083L
        VvWxz5Ap8C9u0BA1EwxjSS2gqfi9hGE=
X-Google-Smtp-Source: AHgI3IaW81W2U/Ieg26iDmW+umeVGk7JlAxFoh2TmgAyen0xLH+2fXTHUFyNTiM56v4oPz0Qs9r0xA==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr13522281ljj.99.1550514241791;
        Mon, 18 Feb 2019 10:24:01 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f18sm4167734lfk.18.2019.02.18.10.24.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 10:24:01 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id q12so13046453lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:24:00 -0800 (PST)
X-Received: by 2002:a19:7410:: with SMTP id v16mr15075194lfe.166.1550514240331;
 Mon, 18 Feb 2019 10:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 10:23:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
Message-ID: <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 9:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I've pulled the existing pull request, because it papers over one
> particular issue, but the real fix would require:
>
>  - knowing whether it's kernel or user space you access

Actually, it would be good to split the "kernel space" access into
finer granularities, because it would be good to limit those addresses
by what you expect to happen.

For example, on x86-64, we have a separate virtual mapping for kernel
text. If you're following a data pointer, you probably shouldn't even
look at that area, and just disallow it up-front.

And the vmalloc space, we should probably look up the vmalloc
descriptor for the address, to make sure we don't go into ioremap'ed
areas (but we'd generally *do* want to follow pages for module data,
or for vmap'ed stacks).

And fixmap and/or percpu pointers may or may not be something that
we'd want to follow.

Etc.

So it would be good to not just say "user or kernel", but actually say
what *kind* of kernel access it expects.

               Linus
