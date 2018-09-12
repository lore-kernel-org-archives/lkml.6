Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132BBC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18BA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZoheSOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18BA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeILWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:44:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeILWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:44:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so1418376pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCEoLJLYyTfoVbsVd6d78nQEGqoDHGfHCMZoPI/Bc6U=;
        b=kZoheSObpJP/QjR+be0ayiuIiMibHtXoYeUUxKgQWBf2C8AkV0xo6akGH4gEf1YKUw
         4I7qeeTW/5hZgkr3UCQV/EEZxWApW3aulzjk58XzRWfvN1uSfHwkaGu0eNKYgwF/uqcy
         Bkc+u3w1vqU3lxtiQIloYW57cpsS0xNfi5zPY1AJzzh47bmvXWptnJTbGygiySaTbKDI
         c6Vc3Q30bUbatnvocr27LySrz1h0cmi2YzTlL5QF+W962VTlU1/4tduWo7YiTiooz5Uz
         f4tQ2ygEF7q+WgWgJqWB847fLwOBvVgGdSWF/f1D2y3rFss9jbInFw/Gt9ijv5RcEtqa
         qWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCEoLJLYyTfoVbsVd6d78nQEGqoDHGfHCMZoPI/Bc6U=;
        b=TLrlStxxjuc5TuTDbQ9kbzuILW+/mhDx7SN2uR7xLBm+NAkCm+a9uNrHiVoIETMfD3
         YksDXRtWvLL8kNNuUSfSJWbadshgDQU1FutOZBNEd3+rB7nA1c6SxQhs6fE/EsSZ5RLl
         A8nNbfYV6dOPJa7hKCOEyatGHrhDRqOPmYBdRsVeGficwbxPl1D5vt1TQA5N2XNcQZt3
         Ll8SUO1tdravAOYf+hz6AvGdSrz9GrRw7Q8KftjfbCqF99N/H4vdKDlCZDxWXP3yn5gn
         pMWRhwefnUO6dbBjYiul4cUG309BqsyXhYwtqqA1KGPe57RJX3cpWvd9hIWQPA9/a9Ig
         BmHg==
X-Gm-Message-State: APzg51Bdn7XkqOJSYY2Mv65mr4mJz+B2b2dbAFYqhUr5QayhkaWDaBIj
        gZ9GBA+0Dl4fICSWUVfAlcTSJPpICsm9zxMEOAzeJA==
X-Google-Smtp-Source: ANB0VdbR/x4wwcIDgFZY7Fg1TwhE15kHIjXlI0Wq6Y+jpUVCDzzPZhdUHMe04rgV4yVV1eah+4P7xcWbyaDwPXpeHHc=
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr3626778pfd.32.1536773921322;
 Wed, 12 Sep 2018 10:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180912002559.1853-1-natechancellor@gmail.com>
In-Reply-To: <20180912002559.1853-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Sep 2018 10:38:30 -0700
Message-ID: <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Smith <richardsmith@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns if there are missing braces around a subobject
> initializer.
>
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> around initialization of subobject [-Wmissing-braces]
>                 struct amdgpu_task_info task_info = { 0 };
>                                                       ^
>                                                       {}
> 1 warning generated.
>
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> around initialization of subobject [-Wmissing-braces]
>                 struct amdgpu_task_info task_info = { 0 };
>                                                       ^
>                                                       {}
> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9333109b210d..968cc1b8cdff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>                 gmc_v8_0_set_fault_enable_default(adev, false);
>
>         if (printk_ratelimit()) {
> -               struct amdgpu_task_info task_info = { 0 };
> +               struct amdgpu_task_info task_info = { { 0 } };

Hi Nathan,
Thanks for this patch.  I discussed this syntax with our language
lawyers.  Turns out, this is not quite correct, as you're now saying
"initialize the first subobject to zero, but not the rest of the
object."  -Wmissing-field-initializers would highlight this, but it's
not part of -Wall.  It would be more correct to zero initialize the
full struct, including all of its subobjects with `= {};`.

>
>                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 72f8018fa2a8..a781a5027212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>         }
>
>         if (printk_ratelimit()) {
> -               struct amdgpu_task_info task_info = { 0 };
> +               struct amdgpu_task_info task_info = { { 0 } };
>
>                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
