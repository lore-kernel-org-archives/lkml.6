Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CBBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCCC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MB0fVuOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfANWBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:01:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40458 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANWBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:01:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so244328pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COA4+y8BR+vzlMXulf2QmLFF6N6buS8a74k/Xy/7vFw=;
        b=MB0fVuOLyz1WkhggvnB37sMqe1T8gyl51XE+R59wRNERF/txILXSvReUgja7ePaUur
         xplNBSXnnEiJHfxocvFW9hxHYajnh9gQy7R7b6BVpn6516x2pWtvg08w7y7P5nq6ZtHC
         i2whOf0/WxfO/ur/F/IrZhR4c6W1K7fPeXnK5IlW68E3qAY7/GZULTOEQbpY/bWy9LPV
         a4/5TX8Pz+/v4nOLXnQOVa0nw0CzKB3U9/9hpt/7tQlGD3NgmuMvf1UtHe8nfzyXeGQF
         KRkOYZV4/xTUxwsWlJwA/UgzfsDrTYjMIVsFaygUDPuVT7U8oz0fo5FwH7k6s9+Ua+Ub
         kjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COA4+y8BR+vzlMXulf2QmLFF6N6buS8a74k/Xy/7vFw=;
        b=i0pb5F/oIwZUIDA8p9GrX6LNsPDO46uGG50POmAxsDkS4wMVAkSO9IUUBYGAP4ni/p
         N82IE/v8d0ykFvFgn6Q+suDGtxxZ7uZIPEh0QB09cAgj+Mcm5yaSJTJNbUYMxwpBE8U8
         vlHeaDr3VsyqYACZCkwn6A1y1M6dOPt17Jw7CdRWPf6ZTUAumR52rFVUkYkT7ikghVn2
         WK0Hindew6wJGERQ3CJwYmueWR6HN/9jEgqvfbtE11JtTZmNsYabhpQT6+XB8GTGgyte
         wRPI342rbbcV2Adt2fxV4AQXcaGKxuFTstOXV+T8j9QeIWpR4By/F2SHhE20ymCN3HOI
         uw2A==
X-Gm-Message-State: AJcUukct20JwRe6EqGJP4ztM32M2E9kN4Sz5exEYSEEfRfcRX4yBY0rz
        vRTXINmk015TTr/UkSQ/TlUm3BccG2bzHmpA+19WLg==
X-Google-Smtp-Source: ALg8bN7rKvGWzQ7lP2eNg0CvEBFgMbngKttkMT446J8hbFttrQQ//Y2jmz4UYaBK/qcKZxImZYsaf+RzlTPtvoheLIc=
X-Received: by 2002:a62:13c3:: with SMTP id 64mr608260pft.93.1547503263001;
 Mon, 14 Jan 2019 14:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20190114210426.177543-1-trong@android.com> <CAKwvOdkoN1myuDM1OFga+v30LQ9pV5VD9J_KCJN1Z7AY+kaXxQ@mail.gmail.com>
 <CANA+-vDLJAHFLZADBM_2JhRy5-OR1tsLCJRqk-7mUfFxNO8dEw@mail.gmail.com>
In-Reply-To: <CANA+-vDLJAHFLZADBM_2JhRy5-OR1tsLCJRqk-7mUfFxNO8dEw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jan 2019 14:00:51 -0800
Message-ID: <CAKwvOdnfMFmDm-DdbFEZxQdXzP47mnZ27hWw5vqe8Lqh21hBhg@mail.gmail.com>
Subject: Re: [PATCH 0/4] gcov: add Clang support
To:     Tri Vo <trong@android.com>
Cc:     oberpar@linux.ibm.com, Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:53 PM Tri Vo <trong@android.com> wrote:
>
> On Mon, Jan 14, 2019 at 1:33 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Jan 14, 2019 at 1:04 PM Tri Vo <trong@android.com> wrote:
> > >
> > > This patch series adds Clang supoprt for gcov.
> > >
> > > Patch 1 refactors existing code in preparation for Clang support. Patches
> > > 2-3 implement necessary LLVM runtime hooks and gcov kernel interfaces.
> > > Patch 4 simplifies config selection.
> > >
> > > Greg Hackmann (2):
> > >   gcov: clang: move common gcc code into gcc_base.c
> > >   gcov: clang support
> > >
> > > Nick Desaulniers (1):
> > >   gcov: clang: link/unlink profiling data set.
> > >
> > > Tri Vo (1):
> > >   gcov: clang: pick GCC vs Clang format depending on compiler
> >
> > Thanks for sending Tri!  Doesn't the output format require llvm-cov, or no?
>
> Yes, .gcda files generated by a Clang-built kernel could only be
> parsed by llvm-cov, but not gcc gcov (at least in my local tests).
>
> llvm-cov documentation also indicates that GCC and LLVM gcov tools are
> not necessarily compatible. "[llvm-cov] is compatible with the gcov
> tool from version 4.2 of GCC and may also be compatible with some
> later versions of gcov."
> https://llvm.org/docs/CommandGuide/llvm-cov.html

Thanks, that's good to know for folks looking to help test.  Note to
reviewers that we're actively using this patch set on arm64 devices.

-- 
Thanks,
~Nick Desaulniers
