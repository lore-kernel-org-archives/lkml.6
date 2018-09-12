Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8FAC4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B167220882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la2zsDsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B167220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeILXog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:44:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33946 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:44:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id j25-v6so11250772wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42SJ0AhrwIclAOHsJeX1eIUPQkgkAoFcq2kMbakplNc=;
        b=la2zsDsCoRHnCNwsub3DYhszvqrcF4uE9wh9AGV9K5xRe7dd/2m/ZZ7IQozdj+rglb
         NJegZZjPsuCIj0rnQFmZPN21mVk+L8r0UMep+DN/KV/xhJqh4EpYWN4QkOzDuGIFvQtx
         xz00MVoyTdbf046NsUvRl6TAVPVD1xOQWqIQJrd6xdrUV8LPCLN8UHFsZIMztc82drj4
         2fktuAp3m0cL37grw6CWlGuKUyJ00PM6/HmbFUdu1Pg61ti+UpuIADLeHzeAHmLD9nrV
         qb/Zm5ixM75RxR/a9p60RUZwG0P4FpfCE35segmqEjFAUEwTECZxuwqGcoxoAoP82ENZ
         ttHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=42SJ0AhrwIclAOHsJeX1eIUPQkgkAoFcq2kMbakplNc=;
        b=bSJhTvDej3e9/Mq66GJA2x1DiGxjA4liJoDpchqqa6Qcrhaz90s6Jvi8NQdSLn+N+I
         nJnOxkPFloFOiHoQzSb/g0NTmJkV3WqY6s7QcohCFyA/8HSSU6yfHCbCNo1ucmAaFuFT
         sVxUXx60LUDY+CZNYjjgQFCnId8F8tz0S47FGM4MIEiT2qncH8nf99PnYfU5wsBBn2+U
         5zDbH+pUSZqBr+4k8HGvdIxkZmFhg3CEG2Ms9Hrfl0fYTpTgIBYhKzUWbiMEJStOKpsm
         2I2qU199OOVHgoAWqVbEa8K7C8tyXWJ7IRNtJYhfuWl0aOWQcxudJjRC8a+pMFu6NkcR
         xcAg==
X-Gm-Message-State: APzg51DldRvZReDRP9yqvKusmWVNWrjDTXUZohLcxifjAmXs2MFR5T31
        yrqmDIAseNYXPQoNzUpp48o=
X-Google-Smtp-Source: ANB0VdbGFAqRvq8l1Yz2ivyN6OH2KrlvmDqqfFR6X4D4MT9aFvabOvVNvu5v+FVflQhg84yQ5d505A==
X-Received: by 2002:a1c:a614:: with SMTP id p20-v6mr2652873wme.68.1536777526422;
        Wed, 12 Sep 2018 11:38:46 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x16-v6sm1405856wro.84.2018.09.12.11.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:38:45 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:38:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Smith <richardsmith@google.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Message-ID: <20180912183843.GB30421@flashbox>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:38:30AM -0700, Nick Desaulniers wrote:
> On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns if there are missing braces around a subobject
> > initializer.
> >
> > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> > around initialization of subobject [-Wmissing-braces]
> >                 struct amdgpu_task_info task_info = { 0 };
> >                                                       ^
> >                                                       {}
> > 1 warning generated.
> >
> > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> > around initialization of subobject [-Wmissing-braces]
> >                 struct amdgpu_task_info task_info = { 0 };
> >                                                       ^
> >                                                       {}
> > 1 warning generated.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > index 9333109b210d..968cc1b8cdff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
> >                 gmc_v8_0_set_fault_enable_default(adev, false);
> >
> >         if (printk_ratelimit()) {
> > -               struct amdgpu_task_info task_info = { 0 };
> > +               struct amdgpu_task_info task_info = { { 0 } };
> 
> Hi Nathan,
> Thanks for this patch.  I discussed this syntax with our language
> lawyers.  Turns out, this is not quite correct, as you're now saying
> "initialize the first subobject to zero, but not the rest of the
> object."  -Wmissing-field-initializers would highlight this, but it's
> not part of -Wall.  It would be more correct to zero initialize the
> full struct, including all of its subobjects with `= {};`.
> 

Good point, I was debating on which one was correct. There are several
places in this driver that use the multiple brace + 0 idiom, which is
why I used this form. I will spin up a v2 with your suggestion, thank
you for the review!

Nathan

> >
> >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index 72f8018fa2a8..a781a5027212 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
> >         }
> >
> >         if (printk_ratelimit()) {
> > -               struct amdgpu_task_info task_info = { 0 };
> > +               struct amdgpu_task_info task_info = { { 0 } };
> >
> >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> >
> > --
> > 2.18.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
