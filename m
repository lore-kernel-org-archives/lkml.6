Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579DC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDA22064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8VVeqbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDA22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeJVX76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:59:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46581 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeJVX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:59:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id o21so40455254otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvsX9dQCPrkAj3MHZDA4EnE4GMAnXv5rUfn9w1e1f58=;
        b=E8VVeqbSJiZloog0zEBTji4k4JTo9g9fOJxyilcgvU9foJ0x6CYG3Wyuz0/T3p9boi
         Pnvou58a06ZEzKQFLT0XHEzbF7qvJYYWAHTbeDF5oARbWIo5TA/TckhRSWZTi00kbn//
         55NPrFWBi6UUa5TyXXGW1Vdch+Dj9w+7GhtdnjsPV4HfozA0in+6kJTRT4v6rp3ZPbsc
         YcVu0YmAmtGydR/Htl/XSvz3GUvjrRpjq98WtTlKhwfCvadN/Q0EbO5WFXmCQOTTx0dd
         RPtS3jWdxqOMtLx6L9GqjRBvbvfZLhc56cyACVRDpvA/iEUkZUtXR51IpXa6ZuT2AmVb
         AYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvsX9dQCPrkAj3MHZDA4EnE4GMAnXv5rUfn9w1e1f58=;
        b=Vum89U4kLpCQKF8RyK42gMQe9fFD0GpRWRVnEuZM8xNoMqeEbIoeG+voVsIuFkWpPN
         scxHsnTGetiI97wWZj/+IvY/gRiOmUmgqb9KqBT6gz9RYEGhGiuXVlrEyGTdLaT0wc+P
         36gXMdfooZbouhmYP1+POM7ds/uFaqUq+R31Z3KATmUsNagoS9pt5THMAX7EteSiRn3G
         LU+7G9XupCb7ZxeakD78HDSKGkMdDTJG7fvGiwVgEgk75wsvhvxRQNgOSZe6DELvBkR1
         KbjDaSjxE6Zba5xU7mKqK3jo47P+BmE/fFqwtcSH6YAND4kwVcjPXpkuh4TnJcRiV6rP
         2AMA==
X-Gm-Message-State: ABuFfoiiQsF04E88cvOQ+BRJV9MEkne5AVtW1oW3QSMffXE9rjLDXiZQ
        Ecihpacq8PEpu/OC2124U5NUI2P+5lFOwjzsKhFGzQ==
X-Google-Smtp-Source: ACcGV63np2+wSRwuJQQ/KHlVEtAOAYZHyGxLFqtsaLvOfYx580pny66E4ls4LE5+koaXI9HHR1+tFWco9oCCMtMBTU4=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr27555555oth.292.1540222855377;
 Mon, 22 Oct 2018 08:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
 <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com> <CAG48ez2ZD=dovBApR07wi_DzYjJvEyO-Pm35eLv9AyXv1tcAFQ@mail.gmail.com>
 <2631f765-8d7a-45ea-6aa4-d8a9bb00d56f@cisco.com>
In-Reply-To: <2631f765-8d7a-45ea-6aa4-d8a9bb00d56f@cisco.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 22 Oct 2018 17:40:28 +0200
Message-ID: <CAG48ez27=w0oWFTYUeFc72-0DL0tf=NOzGCeZgtxFOePPPE5cA@mail.gmail.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     enkechen@cisco.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com,
        mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        xe-linux-external@cisco.com, sstrogin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 1:01 AM Enke Chen <enkechen@cisco.com> wrote:
> Regarding the security considerations, it seems simpler and more secure to
> just clear the "pre-coredump signal" cross execve(2), and let the new program
> decide for itself.  What do you think?

I don't have a problem with these semantics.

I could imagine someone being unhappy about the theoretical race
window if they want to perform an in-place reexecution of a running
service, but I don't know whether anyone actually cares about that.

> Changes to prctl(2):
>
> DESCRIPTION
>
>        PR_SET_PREDUMP_SIG (since Linux 4.20.x)
>               This allows the calling process to receive a signal (arg2,
>               if nonzero) from a child process prior to the coredump of
>               the child process. arg2 must be SIGUSR1, or SIGUSR2, or
>               SIGCHLD, or 0 (for clear).
>
>               When SIGCHLD is specified, the signal code is set to
>               CLD_PREDUMP in such an SIGCHLD signal.
>
>               The value of the pre-coredump signal is cleared across
>               execve(2), or for the child of a fork(2).
>
>        PR_GET_PREDUMP_SIG (since Linux 4.20.x)
>               Return the current value of the pre-coredump signal for the
>               calling process, in the location pointed to by (int *) arg2.
