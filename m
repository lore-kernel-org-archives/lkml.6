Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C9218AE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THEnSFS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfAGXSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:18:42 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33808 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:18:41 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so1363046vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5HVsH1a0vWV+EFF8RrEdBmIUHTwVCB9s8LdihxERN0=;
        b=THEnSFS2WgaTS4NLptScKlgGvvDoirqcQlj6dBWoVE6MdiEwp7rqSC9xrqtibDg5k5
         V9UC1kd/uElU0xJ/m91dAp20lEv2A8GUH3qzClBC/9siNUG5mdobNJenmG/lCV89TqKT
         uKQuqHMNjvBWgRy+/jAVw0jvMdpEy9a++vxyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5HVsH1a0vWV+EFF8RrEdBmIUHTwVCB9s8LdihxERN0=;
        b=rxj119bihmzhZ4wMGISlfc5nZz2xmUo7BOuoTi2XraUVwKt0i/1l2d+9N6lhh8tKq7
         AC0WwhPcuqxQ151g6Lad7RB1l61pmtpBqip6hBIiX+SjRgY7zolOvUq4Oe6HkJd6mePp
         CqwotmIOPvmo3Z+1AbhW0JnqmQ8w96OSdPEDxKO7N0W6roFCBHpma/SLHKI/MQfWzDkp
         dOlpU07N9goficHKITvmwWlXkevXTk9nHb5msM38HJjMAJnbzjAErncR7+lZCdrrtClK
         oqlseOZwUJ/F9oRwqGwWgm2N6yTkBYeZ8OlPfyylGkgW6xncZhKvPK0T/wFxk2YKTsKV
         Z3Pw==
X-Gm-Message-State: AA+aEWZ7qx8T4eA2BKyuKVMg560ya+GzHrvSoKJLFwm1Or3q0oZCOp0s
        ZinP/PhnMcTwsIWd1AOgpyfbfQgvevY=
X-Google-Smtp-Source: ALg8bN6GmSoB4EtMMAyaPnj5P9A6wT/sD4Mhria4ljtnULS3lhWh8iAQSTqW+B6GGWMReYI5kxqDGQ==
X-Received: by 2002:a67:3d54:: with SMTP id k81mr25286612vsa.57.1546903120393;
        Mon, 07 Jan 2019 15:18:40 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id k20sm17078516uaq.2.2019.01.07.15.18.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:18:39 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id h78so1344699vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:18:39 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr8825592vsl.66.1546903118803;
 Mon, 07 Jan 2019 15:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20190107231631.1849-1-tycho@tycho.ws>
In-Reply-To: <20190107231631.1849-1-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 15:18:27 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK1pY-RqB_J5_obMDaWav8cJHjXQkpz0B4cHM=A8Ztq7w@mail.gmail.com>
Message-ID: <CAGXu5jK1pY-RqB_J5_obMDaWav8cJHjXQkpz0B4cHM=A8Ztq7w@mail.gmail.com>
Subject: Re: [PATCH] samples/seccomp: fix 32-bit build
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 3:16 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> Both the .o and the actual executable need to be built with -m32 in order
> to link correctly.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> I guess x86 can pick this up directly? Not sure where it should go
> exactly.

Ingo, can you snag this? (It's a more direct path, otherwise I can
take it via seccomp, which will go through my tree then James's
tree...)

-Kees

> ---
>  samples/seccomp/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index 4920903c8009..fb43a814d4c0 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -34,6 +34,7 @@ HOSTCFLAGS_bpf-direct.o += $(MFLAG)
>  HOSTCFLAGS_dropper.o += $(MFLAG)
>  HOSTCFLAGS_bpf-helper.o += $(MFLAG)
>  HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
> +HOSTCFLAGS_user-trap.o += $(MFLAG)
>  HOSTLDLIBS_bpf-direct += $(MFLAG)
>  HOSTLDLIBS_bpf-fancy += $(MFLAG)
>  HOSTLDLIBS_dropper += $(MFLAG)
> --
> 2.19.1
>


-- 
Kees Cook
