Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02086C4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3E82088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peSNWTYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3E82088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeILXui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:50:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:50:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so3088737wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaAWnvEhg5VqRaRUkrmZ77pD5Cyma8aZWARe9JtLxhU=;
        b=peSNWTYQGZ0UsAymEVWgWTcNEkW6I6afjVpjxnUicpe8GsIoFvQ8HA4pUDYSDqGOe7
         ARSRHDyPgec9dseiTKu4d6Z27zPpPceG8rzecjbi8O/TkNTqebUBJTLBGmgtyerJXTjk
         Qd66p3RVS0hdrFs/molK7G+FFEhhtsp1idf8b/NAGOv5UvbpCfeb9PRtOQafaecU1tWH
         qHMjx0YmYOlAn2oLyuBGrK684lzAFDfUQWuhNcHplnX75pJkDq/ZcIZHkiY4dFFnMspj
         BlSIEMyVqWrYSAXJbKi7CMnkQs5LEcfgyt4SjHFMEKYITX+w7iIkBosm896lC8pPy0JJ
         +Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaAWnvEhg5VqRaRUkrmZ77pD5Cyma8aZWARe9JtLxhU=;
        b=JOJyMge4DQ0e6Kjhn2WUkKClI9oBnGGoVC23aiCtCarXdfK8W7ChOmXZbd+XdiHsbj
         k5cEdzdEtWS9QYtFOtG3e/mQZD+23OOyo8WHojefis7wZGuClusI+5n9GjBF7naziRa4
         sZJZWYcJklHGcSKvPEWRV+T5vNojX4UtGBotxY5rmY1s3fAnXQ9T4k0h8JKCESDuqp3B
         +2G1upFiKhJCI4kOybfk0WEpuDF2jRBesgJQuQVqgo5XhV8w5xtGXHv5D5EyxkxxCtpy
         q/ky4Cn0O2W7Ag03IZmKPeSGs9O3kuq+L0+NiFUALFYOV9hK0v97lhCHYarzjaeaSMK4
         kwAQ==
X-Gm-Message-State: APzg51Dv7XpTe5uxEQApamnIpafW6D4wL0PJbSyLJPJhD8ILVjxOON+S
        RhqconeTQ0/52jyuUSMVAetoKeBigfOBnE/XsqI=
X-Google-Smtp-Source: ANB0VdZh4ZVDaYe4ameMVLnV2zaJPjWzpm4q2XrybevryGMBG+mRZXo9cqgsjasJEAMxDEewkpYG+wGXSuOF8OOeGhc=
X-Received: by 2002:adf:9366:: with SMTP id 93-v6mr2505534wro.60.1536777887786;
 Wed, 12 Sep 2018 11:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com> <20180912183843.GB30421@flashbox>
In-Reply-To: <20180912183843.GB30421@flashbox>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 12 Sep 2018 14:44:34 -0400
Message-ID: <CADnq5_MHoZXf+16ZqoA-h974-=2Ewk1TwbdiuAs71X6WiuL4GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
To:     natechancellor@gmail.com
Cc:     ndesaulniers@google.com, Chunming Zhou <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, richardsmith@google.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 2:40 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Sep 12, 2018 at 10:38:30AM -0700, Nick Desaulniers wrote:
> > On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns if there are missing braces around a subobject
> > > initializer.
> > >
> > > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> > > around initialization of subobject [-Wmissing-braces]
> > >                 struct amdgpu_task_info task_info = { 0 };
> > >                                                       ^
> > >                                                       {}
> > > 1 warning generated.
> > >
> > > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> > > around initialization of subobject [-Wmissing-braces]
> > >                 struct amdgpu_task_info task_info = { 0 };
> > >                                                       ^
> > >                                                       {}
> > > 1 warning generated.
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > index 9333109b210d..968cc1b8cdff 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
> > >                 gmc_v8_0_set_fault_enable_default(adev, false);
> > >
> > >         if (printk_ratelimit()) {
> > > -               struct amdgpu_task_info task_info = { 0 };
> > > +               struct amdgpu_task_info task_info = { { 0 } };
> >
> > Hi Nathan,
> > Thanks for this patch.  I discussed this syntax with our language
> > lawyers.  Turns out, this is not quite correct, as you're now saying
> > "initialize the first subobject to zero, but not the rest of the
> > object."  -Wmissing-field-initializers would highlight this, but it's
> > not part of -Wall.  It would be more correct to zero initialize the
> > full struct, including all of its subobjects with `= {};`.
> >
>
> Good point, I was debating on which one was correct. There are several
> places in this driver that use the multiple brace + 0 idiom, which is
> why I used this form. I will spin up a v2 with your suggestion, thank
> you for the review!

Feel free to fix up the others as well. The others were only changed
due to the same warning you sent the patch for.

Alex

>
> Nathan
>
> > >
> > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > index 72f8018fa2a8..a781a5027212 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
> > >         }
> > >
> > >         if (printk_ratelimit()) {
> > > -               struct amdgpu_task_info task_info = { 0 };
> > > +               struct amdgpu_task_info task_info = { { 0 } };
> > >
> > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > >
> > > --
> > > 2.18.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
