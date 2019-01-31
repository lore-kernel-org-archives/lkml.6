Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD11218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2ww8ncy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfAaKdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:33:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35889 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:33:37 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so3296503itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5OCV2eb5TSImT0OCdqMh36XZu7SuJl/MJd5OK0pMpw=;
        b=R2ww8ncyawJIWFf8Q5ydNy6tXXRHcFWBVkR7BPPiuTMYYZ6hZnE8t+oNIWkXzKslao
         QK2QA+nlrVf/48Ace5I+FbgGCB0y0xFkRjhflY22ydOgpTH95t42Isk05+8m85l4Qu85
         08+SaInSgNm4zQsoZOoWlCEGNnKCfcI1i/GstDVo0Q9wkqzJLKEYTBDfgGu/rcXaCA5N
         au79HEP2JQlS105xIjXjDD17uUYGrZs25oNtEdlvZZguiq1LXr6Te4FD9tp0GrAoMdxb
         RocOc/LL8cBOuxaQp6W9VUWAxSgOfcI8vz9EQLysTO8eVIR6HqA5DyDBn0OMSlQttMPr
         ly7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5OCV2eb5TSImT0OCdqMh36XZu7SuJl/MJd5OK0pMpw=;
        b=hsFYMlf/iCo9fVccOjWWNws1YOJQ51VHlaNHVse2kTd075xPRwLWA4tQ5F4yOEoI/F
         3NcgzZalknmojcjqaM6Y/Ms2MwgKJSreTk50Xx4Cj5v36t9SLstBrACOp9VHnZo5YkzT
         FWrl26h+JHT+ryDZVlFdZcOKg97mLJz4k5bBaviyK+ctnvQM3Nqka5rsDHDCWXCEDx0P
         7LQRtuK7MwJ1fdggcJx/JnOn1vzUkHZNxWCxtG2M6t2sk36ZiesE8znv1Ax+F2BoUVOT
         wf2ncgJM18XbwH15Iq9SEmIey4YNdkvg4guJme6DbKtEBIGE7QE20Vow43K6L2fyiUU7
         lr0A==
X-Gm-Message-State: AJcUukdsNH+upqmeMjDMFl988Lkpp8+fmkYascHLLT/jZEUHVFsT4m8w
        Itw7kBxjVTp7Xtc5htbmLVE7pKi0MHjnJPDMUaq/dg==
X-Google-Smtp-Source: ALg8bN4SyszOI3ZUPf/49Jon29rSWSKs3cEA3J99dXanmp0TNW3+sAb4Sb29BA3ZWQPqhLLMCUSFF/vRP7c1dMl3hl4=
X-Received: by 2002:a24:6511:: with SMTP id u17mr18444334itb.12.1548930815368;
 Thu, 31 Jan 2019 02:33:35 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <20190121123836.GC47506@lakrids.cambridge.arm.com> <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B9BBF9@IRSMSX102.ger.corp.intel.com>
 <CACT4Y+Y5Y54iWn3w2jifjecDb+dZa_B=qZBsKTH8immHktij2Q@mail.gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4B9BC4B@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B9BC4B@IRSMSX102.ger.corp.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 31 Jan 2019 11:33:24 +0100
Message-ID: <CACT4Y+bboJysvOc2d2z7qTqyPR+2mjK3AGxC0nnp8kbGWqcuZQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:09 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
> > On Thu, Jan 31, 2019 at 11:04 AM Reshetova, Elena
> > <elena.reshetova@intel.com> wrote:
> > >
> > >  > Just to check, has this been tested with CONFIG_REFCOUNT_FULL and
> > > > > something poking kcov?
> > > > >
> > > > > Given lib/refcount.c is instrumented, the refcount_*() calls will
> > > > > recurse back into the kcov code. It looks like that's fine, given these
> > > > > are only manipulated in setup/teardown paths, but it would be nice to be
> > > > > sure.
> > > >
> > > > A simple program using KCOV is available here:
> > > > https://elixir.bootlin.com/linux/v5.0-rc3/source/Documentation/dev-
> > > > tools/kcov.rst#L42
> > > > or here (it's like strace but collects and prints KCOV coverage):
> > > > https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c
> > > >
> > >
> > > Ok, so I finally got to compile kcov in and try the first test program
> > > and it works fine as far as I can see: runs, prints results, and no WARNs anywhere
> > > visible with regards to refcount_t.
> > >
> > > I did my test on 4.20 with CONFIG_REFCOUNT_FULL=y
> > > since I have serious issues getting 5.0 running as it is even from
> > > the stable branch, but unless kcov underwent some serious changes since
> > December,
> > > it should not affect.
> >
> > There were no changes that should affect this part.
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
>
> Thank you! Will you be able to take this change forward as for
> other normal kcov changes?

Andrew, please take this patch to mm tree.

+linux-mm mailing list for proper mm patch tracking
I am not a maintainer, all other KCOV patches went through mm tree.
