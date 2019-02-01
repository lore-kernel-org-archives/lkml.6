Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44377C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91BD21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JD1wCUkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfBAKF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:05:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38714 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfBAKF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:05:56 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so8941554itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEDhHuZvIysQfmivflCEaHSPLrsklmrA+WrNTFDD8n8=;
        b=JD1wCUkzMcbbG8tGfN3tExq66nnBvwkbPdPi5Fy22pHmiaH4xsxJaAMevAJL2h6bU0
         htKfhWIk/jjNGXCPkm0K4f7vKLGxbpyg9qtCtkxFlglMUBI4b9i2wuKUkdvifP51s0Vv
         boR3gcDaaOH83TBNRrXfu67oo4mRCtGRuKmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEDhHuZvIysQfmivflCEaHSPLrsklmrA+WrNTFDD8n8=;
        b=DeIzo+AZLp3fBQRZMaOQ6RrzzUMWUudHkKWTUadlGJkg1DUPCkLiswRxXlQazHf0yc
         pEVRqmwNf0QfmIbpO3yAnal7oGTTOujZZz6A/H5o9ZXPIcJ/B0hNy9wYAyiawXu9bwCv
         nN5sxj8rnqVVMTp/OULjon1EWP+NRybkiQ1iyPDVqsHQdrrApbgNcQE1f7YZ7GvMGhjg
         wqcEfd2A4G1+zTzXQy5WKG7dOk+mfe6eXbxgM5XrRoR5aSMZaHPYJbOfYe5fqvWm3WIc
         hA3mCWWYlZl0COrpvXqz2UL0gCO2SfXEwRJXqQl6QZ+hrZZhO1VsWHxK/YVjLXjbaGdu
         opBA==
X-Gm-Message-State: AHQUAuYmkWZ+mjXo1maJpPK+TrgEbU14uphAZ3a6y3FEOMIK3YF0YQpf
        TKHPDMXDUQlAxiiiNXGDdC9dwdld5r7Kcl/EXf8Uyg==
X-Google-Smtp-Source: AHgI3IZJM4BjdOyEYWG0watOSE2YEXvbeCyVfbEe/mJ3YyYNxgXwnzN512C5wW5BMoKku+79sxpc7ER2oeBvb39T7Qw=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr953867ite.117.1549015555009;
 Fri, 01 Feb 2019 02:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20190201105736.1428c9fc@canb.auug.org.au>
In-Reply-To: <20190201105736.1428c9fc@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 1 Feb 2019 11:05:43 +0100
Message-ID: <CAKMK7uGf7X3m3Hp1r3-RSrKvGqsJK61WAMQ7goFP_28GAieP2w@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Feb 1, 2019 at 12:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   a93587b31e34 ("drm/amd/display: Only get the connector state for VRR when toggled")
>
> Fixes tag
>
>   Fixes: 3cc22f281318 ("drm/amdgpu: Set FreeSync state using drm VRR properties")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe instead:
>
>   FIxes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR properties")
>
> In commit
>
>   32e61361b82e ("drm/amd/display: Fix 64-bit division for 32-bit builds")
>
> Fixes tag
>
>   Fixes: https://lists.freedesktop.org/archives/dri-devel/2018-December/201008.html
>
> has these problem(s):
>
>   - No SHA1 recognised
>
> Maybe instead:
>
>   Fixes: 80604e27bc9 ("drm/amd/display: Use 100 Hz precision for pipe pixel clocks")
>
> In commit
>
>   c4312c27c826 ("drm/amdgpu: Cleanup 2 compiler warnings")
>
> Fixes tag
>
>   Fixes: e4ae0fc drm/amdgpu: implement gfx8 post_soft_reset
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
>
> Fixes tag
>
>   Fixes: 5e01c09 drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe instead:
>
>   Fixes: c6064de4b734 ("drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings test sequence")

Yeah the top 71 commits in the latest amdgpu pull got rebased, which
is a bit much. Where are we with the "direct group commit, no more
rebases" project for amd? Still stuck on CI troubles?

Another one: Is the above checker script available somewhere, could be
useful to put that into our own scripts to make sure this doesn't
happen again.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
