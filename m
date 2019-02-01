Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F3FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF85621872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RStH6yst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfBAUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:35:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53861 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfBAUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:35:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so7414698wmb.3;
        Fri, 01 Feb 2019 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3eB+KHPfFW4533Q7O4PGgrt6X5L4js3R6JGa0fxEkc=;
        b=RStH6ystIctEhOXUZWUHC3Uat/syzMeSJm62vXGiuzr4iLRlotR5MVTqzH3BgHGLEF
         xftiMP7ctSmnJFdcR69fIf9LhTcExZdCks1NGlNhfIwg3+YTJFajWItUXgFWNxx0DO6A
         NbcSWBzHdhJaXepJjlEqhtpCUbGyGBulsAqcVA2n5Px/PsEbSlIOHLBl8PTo4YJ0svRQ
         Sg1JKTBB3/a8IzsvPL25F+KVetFnQV9NT9tbqzZ7me+z+VIhCCdFMiwVIhMcii3K8YTU
         0/yCgERFMxuijsZ5V/DX/IHNsvmrK+h2KI2MxouShuJ0nWGQywaEJ4Qg4Xyf5maUWJv7
         OAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3eB+KHPfFW4533Q7O4PGgrt6X5L4js3R6JGa0fxEkc=;
        b=GeuLZbvmtKo+ndDTJc7PZWiM5FP7/1lCk8y4hMwjAZKQ8LnE47FonKsd8yk3BPLFGV
         JCfpw1kVKhBPQt76DlYo9przaYzXKgMFRGfxoZJHaWiek4gnNxLCWN9NCk7KdP7wv1N9
         RgIsKbwvElwpustKnNDc/9pYUNHwb+vux7pdqtQgTPmI3cP7yxYfiGLN8HHPcdmIxT5y
         hH4KKS3iEt7K7kiDi2/5Q4IHKKor/ouuiMYV2n+cPpDlCJl7Niei99zBGhj5ovb9NURL
         R/DR2USsw/LMGr/f2+BdbYzAnfboNoDBzPU8msjPNJ05mOKRZ3urbL3eb60fRX3wTUMh
         cK3Q==
X-Gm-Message-State: AHQUAubu2cPTKIzrqYJOqYDPKUK3V/VA7E+xDESGHJpCAsQHIe+xX9Aq
        oOVJZrkdI/ht2wD5Vhl6De8xsaAstax+Q4ZJeEQ=
X-Google-Smtp-Source: AHgI3IZMS2nyV359D68HA6GDv/ztqM1LSXZFiV6T/unw73cvtr1dqzM0f6HoqfSDV7ARgJPemBPnd2ROhwXAQ2q1xuo=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr3738666wmb.153.1549053298330;
 Fri, 01 Feb 2019 12:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20190201105736.1428c9fc@canb.auug.org.au> <CAKMK7uGf7X3m3Hp1r3-RSrKvGqsJK61WAMQ7goFP_28GAieP2w@mail.gmail.com>
In-Reply-To: <CAKMK7uGf7X3m3Hp1r3-RSrKvGqsJK61WAMQ7goFP_28GAieP2w@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Feb 2019 15:34:46 -0500
Message-ID: <CADnq5_O3rGYGi95pB_0-xxODpcKYdB_ZaHcNS9zzBRGorE2oMg@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the drm tree
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kent Russell <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 5:05 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Feb 1, 2019 at 12:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commit
> >
> >   a93587b31e34 ("drm/amd/display: Only get the connector state for VRR when toggled")
> >
> > Fixes tag
> >
> >   Fixes: 3cc22f281318 ("drm/amdgpu: Set FreeSync state using drm VRR properties")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Maybe instead:
> >
> >   FIxes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR properties")
> >
> > In commit
> >
> >   32e61361b82e ("drm/amd/display: Fix 64-bit division for 32-bit builds")
> >
> > Fixes tag
> >
> >   Fixes: https://lists.freedesktop.org/archives/dri-devel/2018-December/201008.html
> >
> > has these problem(s):
> >
> >   - No SHA1 recognised
> >
> > Maybe instead:
> >
> >   Fixes: 80604e27bc9 ("drm/amd/display: Use 100 Hz precision for pipe pixel clocks")
> >
> > In commit
> >
> >   c4312c27c826 ("drm/amdgpu: Cleanup 2 compiler warnings")
> >
> > Fixes tag
> >
> >   Fixes: e4ae0fc drm/amdgpu: implement gfx8 post_soft_reset
> >
> > has these problem(s):
> >
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >     or later) just making sure it is not set (or set to "auto").
> >
> > Fixes tag
> >
> >   Fixes: 5e01c09 drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Maybe instead:
> >
> >   Fixes: c6064de4b734 ("drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings test sequence")
>
> Yeah the top 71 commits in the latest amdgpu pull got rebased, which
> is a bit much. Where are we with the "direct group commit, no more
> rebases" project for amd? Still stuck on CI troubles?

In fairness, some of the rebasing was to squash in some bug fixes to
help with bisecting.  As to direct commit, not enough internal
priority at the moment and too many other projects.  I'll try to
double check them better going forward.

Alex

>
> Another one: Is the above checker script available somewhere, could be
> useful to put that into our own scripts to make sure this doesn't
> happen again.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
