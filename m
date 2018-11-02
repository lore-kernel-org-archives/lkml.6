Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF7EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D80E2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QC0rLOEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D80E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeKBOqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 10:46:06 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53495 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeKBOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 10:46:05 -0400
Received: by mail-it1-f195.google.com with SMTP id y73-v6so1732442itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWUFKRKSfF9Hz2V6ePTP5Qut3gz+ghlMg85DSc0lhnU=;
        b=QC0rLOEmD8G7NeKc+tLDM28SdHkRS4KbnOR1V5tLLfGUjqwxFcqwsPXa9zM+5iirgN
         GFZWGjao9fZrlsdCKz/xotP+a2vY9HxzjM1v3J5iiaUp4yRu278AntNTahxFWRuUVG95
         ZHQ4qN8EHnwVEccSmeA0x50mzYvkDEq6qpD1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWUFKRKSfF9Hz2V6ePTP5Qut3gz+ghlMg85DSc0lhnU=;
        b=JlNRxUFp4gVeod45ZjxBpDJ49PKC3djpuawoV8pjckxYiPBJW+9hWWnlAVw14jkgdt
         rHGznzLr0/Sz8IOh7cvuNNWT/6iExEa97yHKqHoGjMfslg0PKwjkuRSPnbgAy7M/TP8u
         TShVN0QQu9IbopGaY2SiY/oClSW5/ySJ66pWdoAd97uOPi3g1tDP52CMkGjXLHMSncQl
         vIrGl3Peu1TNP9UF55N3XQ7eLZ08RCGkUs0uOdu5wm1wjALnsXqOOOTGPHrtMKCqFwIX
         1UA6N7rkcOMpZHK736K2hkL0MCQi4DTvBTbHAyAk1XAI/NvwQTd8KhJsP9UFHUzoFz0k
         Gxaw==
X-Gm-Message-State: AGRZ1gLKOYL73CBR29pp1hy/crM/SqyAU6nBXZK017AWJA+zjztwL+sN
        /mkhsEYmPK9FcXCt/tj6rKcYb4GEq2bcDCl8C+zgdg==
X-Google-Smtp-Source: AJdET5cvWwgzaOe0HBNTyFNelAxgJaa80UACl1WVOOcQ12c3YWfeRGaDVzVT8fA33IOEFFo3fWFi0jiHa/aqziFRdkc=
X-Received: by 2002:a02:e43:: with SMTP id 64-v6mr9390608jae.58.1541137209335;
 Thu, 01 Nov 2018 22:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
 <1541080391-3890-4-git-send-email-firoz.khan@linaro.org> <20181101.133315.47887636039827313.davem@davemloft.net>
In-Reply-To: <20181101.133315.47887636039827313.davem@davemloft.net>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 2 Nov 2018 11:09:57 +0530
Message-ID: <CALxhOnieTqFzs-D9mNB5nL0=iPGFE92Gwm-Coft7D0_7RJgHiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux <sparclinux@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 2 Nov 2018 at 02:03, David Miller <davem@davemloft.net> wrote:
>
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Thu,  1 Nov 2018 19:23:10 +0530
>
> > +141  common  getpeername             sys_getpeername                 sys_nis_syscall
>  ...
> > +150  common  getsockname             sys_getsockname                 sys_nis_syscall
>
> The sys_nis_syscall in these two entries is incorrect, see the patch
> below.

True, The patch you mentioned here is the merged recently and I
created this patch series
few hours before that.

>
> One of my worst fears about this change has been realized, that
> instead of helping us find problems, it is so automated to the point
> that it fails to question issues like this.

Yes. I have created the system call table generation support for 10
architecture including
sparc. Every architecture I validated the generated file with replaced
one and made sure
both are same. But still I expect some human errors. The one which I
missed was caught
by respective maintainers.

BTW, the error can be raised only one time, during the development.

> If sys_nis_syscall for the compat syscall shows up in a situation where the
> native 32-bit syscall does have an entry, that's a BUG and the script should
> point this out so that the bug can be fixed.

syscall.tbl is the input to the script, so the developers has the
responsibility to fill the table
properly. I don't know, we have to write a script which has to be
smart enough to catch the
wrong syscall entries.

Thanks for your feedback.

Firoz

>
> Thank you.
>
> ====================
> From 1f2b5b8e2df4591fbca430aff9c5a072dcc0f408 Mon Sep 17 00:00:00 2001
> From: "David S. Miller" <davem@davemloft.net>
> Date: Wed, 31 Oct 2018 18:30:21 -0700
> Subject: [PATCH] sparc64: Wire up compat getpeername and getsockname.
>
> Fixes: 8b30ca73b7cc ("sparc: Add all necessary direct socket system calls.")
> Reported-by: Joseph Myers  <joseph@codesourcery.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/kernel/systbls_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
> index bb68c80..ff9389a 100644
> --- a/arch/sparc/kernel/systbls_64.S
> +++ b/arch/sparc/kernel/systbls_64.S
> @@ -47,9 +47,9 @@ sys_call_table32:
>         .word sys_recvfrom, sys_setreuid16, sys_setregid16, sys_rename, compat_sys_truncate
>  /*130*/        .word compat_sys_ftruncate, sys_flock, compat_sys_lstat64, sys_sendto, sys_shutdown
>         .word sys_socketpair, sys_mkdir, sys_rmdir, compat_sys_utimes, compat_sys_stat64
> -/*140*/        .word sys_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, compat_sys_getrlimit
> +/*140*/        .word sys_sendfile64, sys_getpeername, compat_sys_futex, sys_gettid, compat_sys_getrlimit
>         .word compat_sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
> -/*150*/        .word sys_nis_syscall, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
> +/*150*/        .word sys_getsockname, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
>         .word compat_sys_fcntl64, sys_inotify_rm_watch, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
>  /*160*/        .word compat_sys_sched_setaffinity, compat_sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
>         .word sys_quotactl, sys_set_tid_address, compat_sys_mount, compat_sys_ustat, sys_setxattr
> --
> 2.1.2.532.g19b5d50
>
