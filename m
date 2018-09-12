Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F0C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D516208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpIx9L4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D516208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeILXvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:51:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41285 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:51:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so3107330wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSByCHt3fgLyaE13tUD20diNWpAxwgoPxYLIjAQq5Jw=;
        b=cpIx9L4dpte5E8NlHo1SKnkO7u5g0j6w//AUx9bLfiExb2i1JftOS2kwQRaQNbLeis
         dvTHPVw2X0d4sQ8EJjtZrYSKZAJtihdUtizuvJ6keQkvfq10ME6jhfhIsdYbZWlTv8/Z
         4l+FXYnnADTXZfKda52H3PfvBCLnwE2Fiaowt1UHEamZDxCl+VvMBCEclNQaLehBYXZt
         jDPgxyykRHHMnoCaiXC4uJG7U/hpXyWbXmsbwo65QETrKeqTbdImAbKO/n5DZwDm4gOB
         d5lZhcewF1vod60TXu3xZfnSK3yCRdfGCxn4C073aAOyiLdHROWAi3ZuwEQvHnC+hfgv
         Ntlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSByCHt3fgLyaE13tUD20diNWpAxwgoPxYLIjAQq5Jw=;
        b=QlNUxRmnHFK+XOqD6RFUq1TT+1VgbMShsfvt/0aCayYQggWexzw/sIqnVqMtdt58eM
         n9TQLGJ2Wo0SomoiDYsH0IQSm6wTiqasvBHicDGMrtMqIYOzUwX5DEvsMjX1y+HKx5G7
         pfO1KVtXZO8HfWN49HppwmOnuCg7N+3syy7zfdydmLz4X3WoV5fugHg1iOTxJyo0fgWb
         LUdsw2d6Nz0ePZmvh+C7Y6MIpYOFI5NYlHfKKf0VxlS0r6BIi0BnndHqWbHafIgFPN3g
         aAkC2dR8zA38+7VGEzlIZCNFViKkFy5CB2WnPq0raUSl2OPaKoD2Fb4OJHymzNCSgiUc
         iGiQ==
X-Gm-Message-State: APzg51Ai/cdAy+dKLGCNLf+IzKCEvhXuKCUOw0rEukVrZ+zX9BwTK+dg
        YtcS+nSSasKjvifYP/pzMOgyWts2EENuAQ==
X-Google-Smtp-Source: ANB0VdanIkqDRaQxkKGc4RmVv7AyXHOnL9ANwwBclSApnbE6m7P8C7P3dKvMPF3d5tJnyp7I3WYoEw==
X-Received: by 2002:adf:b357:: with SMTP id k23-v6mr2609681wrd.207.1536777949586;
        Wed, 12 Sep 2018 11:45:49 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z101-v6sm2822154wrb.55.2018.09.12.11.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:45:48 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:45:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     ndesaulniers@google.com, Chunming Zhou <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, richardsmith@google.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Message-ID: <20180912184547.GA31724@flashbox>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
 <20180912183843.GB30421@flashbox>
 <CADnq5_MHoZXf+16ZqoA-h974-=2Ewk1TwbdiuAs71X6WiuL4GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MHoZXf+16ZqoA-h974-=2Ewk1TwbdiuAs71X6WiuL4GQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:44:34PM -0400, Alex Deucher wrote:
> On Wed, Sep 12, 2018 at 2:40 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Sep 12, 2018 at 10:38:30AM -0700, Nick Desaulniers wrote:
> > > On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Clang warns if there are missing braces around a subobject
> > > > initializer.
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> > > > around initialization of subobject [-Wmissing-braces]
> > > >                 struct amdgpu_task_info task_info = { 0 };
> > > >                                                       ^
> > > >                                                       {}
> > > > 1 warning generated.
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> > > > around initialization of subobject [-Wmissing-braces]
> > > >                 struct amdgpu_task_info task_info = { 0 };
> > > >                                                       ^
> > > >                                                       {}
> > > > 1 warning generated.
> > > >
> > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > index 9333109b210d..968cc1b8cdff 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
> > > >                 gmc_v8_0_set_fault_enable_default(adev, false);
> > > >
> > > >         if (printk_ratelimit()) {
> > > > -               struct amdgpu_task_info task_info = { 0 };
> > > > +               struct amdgpu_task_info task_info = { { 0 } };
> > >
> > > Hi Nathan,
> > > Thanks for this patch.  I discussed this syntax with our language
> > > lawyers.  Turns out, this is not quite correct, as you're now saying
> > > "initialize the first subobject to zero, but not the rest of the
> > > object."  -Wmissing-field-initializers would highlight this, but it's
> > > not part of -Wall.  It would be more correct to zero initialize the
> > > full struct, including all of its subobjects with `= {};`.
> > >
> >
> > Good point, I was debating on which one was correct. There are several
> > places in this driver that use the multiple brace + 0 idiom, which is
> > why I used this form. I will spin up a v2 with your suggestion, thank
> > you for the review!
> 
> Feel free to fix up the others as well. The others were only changed
> due to the same warning you sent the patch for.
> 
> Alex
> 

Hi Alex,

Thank you for the information, I will do that in v2.

Thanks,
Nathan

> >
> > Nathan
> >
> > > >
> > > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > index 72f8018fa2a8..a781a5027212 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
> > > >         }
> > > >
> > > >         if (printk_ratelimit()) {
> > > > -               struct amdgpu_task_info task_info = { 0 };
> > > > +               struct amdgpu_task_info task_info = { { 0 } };
> > > >
> > > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > > >
> > > > --
> > > > 2.18.0
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
