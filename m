Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7CBC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4952146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWQIwJoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4952146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeIMBhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:37:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40136 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIMBhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:37:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so3783051wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uKbZlKRk18d0Bh++mg/P1ykf95Ln8M343V4Ie880Cyk=;
        b=FWQIwJoK7AuL6bRgJUj3VpXgU1K8seoAbHPicwS5NFNORmOExh/UlObltt7xtkTuHg
         UtZJxmPVIop1y6w/uZVeaPL4ArnsmT7nCiUqemD2MNESIBA/wOabkXt0wmGo1Q7FO+CQ
         jCTdm/2+/53xR+wGXTcTqTcTP/rf0jyPxTPkXXM7eixX0BcHiOMm9lEJETmMahuosn4G
         TR4WXDNloIEMJO3vxkqR0GHof4AUqoCwIFQSHD28hhKVdzlnZu2+R736sOC3cXRuMV7O
         CiHYSd+l/kTpy/8zyjus9V1ka0aHG9qhJJqGZTpdFLKyTgsRnVe7cZDAeoFJPuwOWSrh
         7GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uKbZlKRk18d0Bh++mg/P1ykf95Ln8M343V4Ie880Cyk=;
        b=dmvFuSvlrurFWmbb4gRyFQT9CTfT7pUqDZ/A9SzznVDcOTGvIfVROAEnSyoxDb/bFA
         2z09KqtlUGxhZ3tuqEOcYnB7KxSpm1MGskHgbIdswrOdmESJ3fh7U/ZrKGckJ0hr+3a6
         4SFeK4CdLjYE6mOiIQ08p7i348zZd7I+YRqraIB5dAbNP33xi3uTESxQ937DxvNtvoVj
         cTX45outG1wJlUzl2ymcz3N8UYwKa6cpc4WCiM9cq5l8xufvap7/mgAcW9IwhqnP8eba
         EcpdiKLQSpOqrPy5cwVL/j9sNFya2fNFqjHZyaWp4cqygqfH6cxZuykArx6d7mjazNBB
         sViw==
X-Gm-Message-State: APzg51DsCNqrSVvbRffGkT3+pOVDG+LKwZYdUBKwU1xVmZ+RxuP09/Xf
        /m7MF7j67eJBaMACSvq3Ht8=
X-Google-Smtp-Source: ANB0VdacBMv5kz0W+omNuu2JyxFaQ94EB7uTDqPUFZVJlznjk+gePUGeog5trWDzJJFFoQ7ZAaJsgw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24-v6mr2808774wmc.33.1536784258126;
        Wed, 12 Sep 2018 13:30:58 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm3899997wmd.4.2018.09.12.13.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 13:30:57 -0700 (PDT)
Date:   Wed, 12 Sep 2018 13:30:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Richard Smith <richardsmith@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Message-ID: <20180912203055.GA9320@flashbox>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
 <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 01:24:34PM -0700, Richard Smith wrote:
> On Wed, Sep 12, 2018 at 10:38 AM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> 
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
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > index 9333109b210d..968cc1b8cdff 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct
> > amdgpu_device *adev,
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
> Sorry, I think I've caused some confusion here.
> 
> Elements with an omitted initializer get implicitly zero-initialized. In
> C++, it's idiomatic to write `= {}` to perform aggregate
> zero-initialization, but in C, that's invalid because at least one
> initializer is syntactically required within the braces. As a result, `=
> {0}` is an idiomatic way to perform zero-initialization of an aggregate in
> C. Clang intends to suppress the -Wmissing-braces in that case; if the
> warning is still being produced in a recent version of Clang, that's a bug.
> However, the warning suppression was added between Clang 5 and Clang 6, so
> it's very plausible that the compiler being used here is simply older than
> the warning fix.
> 
> (Long story short: the change here seems fine, but should be unnecessary as
> of Clang 6.)
> 

Interesting...

nathan@flashbox ~/kernels/next (master >) $ clang --version | head -n1
clang version 6.0.1 (tags/RELEASE_601/final)

I guess the v2 I sent is unnecessary then. I'll leave it up to the
maintainers to decide which one they want to take.

Thanks!
Nathan

> 
> > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > index 72f8018fa2a8..a781a5027212 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct
> > amdgpu_device *adev,
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
> >
