Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E36BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B322084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjK7Pyf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B322084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJZGzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:55:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34538 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJZGzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:55:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so4898587pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P30d+GNq1b5I9TUOe1WdRWkpPmbYz+WuBXZwmJhEab0=;
        b=rjK7Pyf8s0VG0DvHTmK13vnxOkoLh/JCevekS9hu2xZM2TPv/ewCiRwhXYB1gVY5aF
         bA5HcbIxXmoWeqbg7nv0zgZwDymyoqhtpPK8r+5h4Yv9ibS8pWzZgy66PFseDyAVwEly
         JuFu9LkVtOMzJPSboJASqrYLMA3kGgdoY+SYeQ6HmlLfjVgxcS8O86lRZ2KRrf+FpF9E
         fQv20nn0EP/PROlLfcG/MNQS7oZieW6MCeF1DS5YQGydAS031zX7+WCsP+KMetCX8vJR
         nfsBotjvdSniL6KpRTjPnxti+7x2FcD5QVRoeAvlroUJURMjMcLL4hg647BzmW9lYqIy
         MSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P30d+GNq1b5I9TUOe1WdRWkpPmbYz+WuBXZwmJhEab0=;
        b=AQs9++BFkAO2qiJImmtO/AVT5h32CYxJsW5bmFC3j8e3pFkctGCbR/wnPLQFDOqkvH
         8CpY6jSWVe9hJ8mhxP8tlkvXYwLjqe3tdSSAkzmHjZXOdzSXuyI+y0uLG1cdCX82Aaa+
         5OXjpY1I4yr2vXXSm96QXVpOjmTMTZnFcdLSb5Xp3Hyl5g759KuBpUQ1FDdvqQn8hixf
         iHdqLNZaiP5+a/LkJ9aH1DV4xViEqDpDo0XWHgCD+uCXLPGMzxFw42GI3kMoX2JM8VsM
         /1Fv+72xCQrEUZXSMLfsYK90h/1bJ8Dh/4fFbCdXTN6koZCcqgs6dBq48u5MEc6skgw7
         KdYQ==
X-Gm-Message-State: AGRZ1gLhC1w7hDh9IOXXGFR2gtXJ8gq5Qjd/8/ASJA2bhL4ardxr7o9Z
        iVmOd8UWTNctVrCsltOo6bVEJmZyo4GXLjB9oP4j2A==
X-Google-Smtp-Source: AJdET5fcNv3fxVi9Sfi57rChQEAi1qYUxRdROp3hzu0ZUSJHnxPyEqP2wxVCOS4uWekNvVgj35um1syWTnyvQqp/JOI=
X-Received: by 2002:a65:4683:: with SMTP id h3mr873754pgr.225.1540506069520;
 Thu, 25 Oct 2018 15:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181025193601.11746-1-natechancellor@gmail.com>
In-Reply-To: <20181025193601.11746-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Oct 2018 15:20:58 -0700
Message-ID: <CAKwvOdm2r8bfXQCBiUjnQNnCs8ETxzYQHK4ZjMrfLyRvw77zAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Disable -Wuninitialized for intel_breadcrumbs.o
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:36 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> This warning is disabled by default in scripts/Makefile.extrawarn when
> W= is not provided but this Makefile adds -Wall after this warning is
> disabled so it shows up in the build when it shouldn't:
>
> In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
> drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
> variable 'wq' is uninitialized when used within its own initialization
> [-Werror,-Wuninitialized]
>         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>                                         ^~
> ./include/linux/wait.h:74:63: note: expanded from macro
> 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
>         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
>                                ~~~~                                  ^~~~
> ./include/linux/wait.h:72:33: note: expanded from macro
> '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
>         ({ init_waitqueue_head(&name); name; })
>                                        ^~~~
> 1 error generated.
>
> This warning looks to be a false positive given that init_waitqueue_head
> initializes name before it is used. Rather than disable the warning for
> the full folder like commit 46e2068081e9 ("drm/i915: Disable some extra

cc author/reviewer of 46e2068081e9.

I'm fine with the patch as is, unless others prefer to disable it for
the whole subdir?  We could be playing whack-a-mole in the future
disabling this warning for other translation units.

> clang warnings"), just disable it for the one problematic file because
> it could be a useful warning for other cases.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/220
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/i915/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 1c2857f13ad4..f36c420afb99 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -26,6 +26,7 @@ subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>
>  # Fine grained warnings disable
>  CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
> +CFLAGS_intel_breadcrumbs.o = $(call cc-disable-warning, uninitialized)
>  CFLAGS_intel_fbdev.o = $(call cc-disable-warning, override-init)
>
>  subdir-ccflags-y += \
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
