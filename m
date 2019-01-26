Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B2C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80361218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSYum8KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfAZHeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:34:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAZHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:34:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so5560075ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 23:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQVwLMBYOqgP65T9bK/5DYy8TZ9YNsZFj8DWO7KBl+o=;
        b=YSYum8KRn7tx6wkquuofaMo7B+xhv0Q+pynw69/6VzZRqK1iaK1lSdAH6mn71sMCDI
         Cqh8BTp9LqCdUoz3sGNGc9Kc/fuHi0o8E/U2LdRvW2SrMbLD+A5h4/hKJAUQac2IU/BW
         OwxMvBtOBCSj9VBUmKSQB9UcQ5xl8gwWqt25NNxLMe9kCpfOso2W4tb9mDee706wgzzs
         nk9Yu365vGkxJ+A+Al4LvDTxOwiUjZO0oghmdxh5r2oF9BPI1vLnLe5lfp4F2wohGbxD
         wtYgEk5tDIa7MmryLZq2EwqFAuWbXPwIu7KbW2UDJLT8EC2JW0Q6MKbmp+iC9UepeVqA
         kpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQVwLMBYOqgP65T9bK/5DYy8TZ9YNsZFj8DWO7KBl+o=;
        b=da1SGDLfU+E1WzTz5dFg0JsbTcGU33E0xieQiaB8+ivbKsCN3xqBs/H6v2S3vlb6Rm
         6MfpHWXQb7jKoWxEShDn+KX0bPHMBH2EVM4MoTW9GjDlOWzMnR6i5eOkAwjnyRNdk1yp
         uUyrK+l6//QzPcttIDaJKKqZVOD1S63ca8V7+IJRJ/kEdc/uWjnhiAvdCX3dvNAzGq0D
         JhrO9UyxJkSypzGkITCT0E29m2WiKG2L5Eo5plYQqBO0YyPwKbjj77X/5bvaEh2Pha+F
         Ge3BsEops+X9DCZiqC/l0aSBLO7Nqt2Ylfj+htS266H32jkuoJ8ZO/JHvG652coHJLvm
         v+Fw==
X-Gm-Message-State: AJcUukfe9B4Mi0O6Om2Qi0QdLp8CIfvQhLeMnrY7GnkWVXQcr44c1aiX
        U4G1l0Q68vj9xHYaS7Qno4db0u7VLAgbtEtapOdLkoR9watByA==
X-Google-Smtp-Source: ALg8bN7uSPssnJDRTKFmB2NvjdPcwezVj+N/dVViDruYtB+kKLPgdtyFFTJsd3QX75AHcnc1B9j0H1wGhiHcNem2C8g=
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr14300714plb.217.1548488070357;
 Fri, 25 Jan 2019 23:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20190126071122.24557-1-natechancellor@gmail.com>
In-Reply-To: <20190126071122.24557-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Jan 2019 23:34:19 -0800
Message-ID: <CAKwvOdmA6075WEPaKkL9d1wUQmboU9CxhbNT1oiVk8_Onjh5Rg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Disable -Wuninitialized
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:13 PM Nathan Chancellor
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
> Explicitly disable the warning like commit 46e2068081e9 ("drm/i915:
> Disable some extra clang warnings").
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/220
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Nick Desaulniers <nick.desaulniers@gmail.com>

probably could give Chris Wilson the suggested by tag.
https://lore.kernel.org/lkml/154513398652.1108.7150969916024071452@skylake-alporthouse-com/

> ---
>
> v1 -> v2:
>
> * Rather than disable the warning for the problematic folder, disable it
>   for the entire folder like Matthias's commit.

Thanks for following up with a v2.

-- 
Thanks,
~Nick Desaulniers
