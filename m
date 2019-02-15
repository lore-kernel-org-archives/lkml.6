Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD078C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1B021A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbZlifBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfBORi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:38:58 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55248 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBORi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:38:56 -0500
Received: by mail-it1-f196.google.com with SMTP id f10so2471157ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGi7S/MNU3uYxAOGaRJ4HSpN828sKONDNI6b2ZNYQr8=;
        b=SbZlifBXMLKzWTPrMvZu0XJvqq7bCGviH/ni2/ZvQ0CFNimrCGPrjmQOSU0HO1sl8N
         GnJ/eSwr8tZytPoTCM5pv19ZqTmwrdmWuNxIhunWly5ialJVmpqKjRWv2BnqpuCAXjsX
         pQV94nbWJHRAAGmLbfiLaSLykwszA3N/CMc8hBt+WgI41RES9oj7zITd7BJDqGnHZO97
         QtuuCHFpnHN4acv9ovX7+sUAsA/f2sfKeZKhr79gn73EGoWC+H+Y9GOz3tTldCiLFZ/L
         fqrPsqupCOQag8FT93ZpS1Yxa9XedcBbTNuHytSwk9KcQv+pbl9mlnj8QlKt5bteOfFs
         cXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGi7S/MNU3uYxAOGaRJ4HSpN828sKONDNI6b2ZNYQr8=;
        b=Xuk9MooixWpGsvKHpK81Pq8mYK9WNl+3TraXmHLyx75ZIvsEgkmNIZOuyEa5iYAjS7
         8lkItoJx0qgwaSB/7jwDdyRbXe9OHg6oz/LlE7CMop8k2BwNK040vZ2JaVyOVXRYb8Lx
         78VkyX2hDiwodWi4snfv7Vp8HdVMrqcvp+TxNcC9by9+e1GNMLiFHn3gez9T2ncNWGLZ
         gljqrcXfvsPk47fOczTGZ+yEdgFpftREylbkUsAaXTvCjfjsONtya66AymVmvgvly0Dz
         EIy+9UjypKdGdqFbnOmdTJd/r1W3qM7I+vf8V1qmtbd9LAJq4xhVmjgO2uNt0niYfxkd
         f8DA==
X-Gm-Message-State: AHQUAuYKb5W4pZlsKz5Yu8nkgfb7xiRINUotPCTzGe+cQ7Fk8xNpk4pl
        LuycbmcEZSPOGeRH7Fd5qt+y3C6Fk/lMFHITLl7CFg==
X-Google-Smtp-Source: AHgI3IblIqdmw/DETGmd4Cz14adK5/7GpRsqSmT8X+9mo1jRrCm8eeW03zav29tYUOdIxGtxPeswWRjxB/SL3vn/uDY=
X-Received: by 2002:a02:3342:: with SMTP id k2mr5385833jak.62.1550252335329;
 Fri, 15 Feb 2019 09:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org>
In-Reply-To: <20190212180441.15340-1-keescook@chromium.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Feb 2019 18:38:43 +0100
Message-ID: <CAKv+Gu9Cecc1hAurC1TEwqnf5E1gOaUxNgHt64QnziT1enp6YQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gcc-plugins: structleak: Generalize to all variable types
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 19:04, Kees Cook <keescook@chromium.org> wrote:
>
> Instead of a new plugin for stack initialization[1], this improves
> structleak to handle initialization of all variable types. Since the
> instrumentation happens at a different point, the "switch" statement
> changes from the earlier posting[2] are no longer needed. As before,
> this also introduces a stack initialization regression testing module to
> validate various kinds of stack variable usage vs compiler instrumentation
> for initialization. See the individual patches for more details.
>

For the series,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

(although I reviewed 2/2 only cursorily)



> [1] https://lkml.kernel.org/r/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com
> [2] https://lkml.kernel.org/r/20190123110349.35882-1-keescook@chromium.org
>
> Kees Cook (2):
>   gcc-plugins: structleak: Generalize to all variable types
>   lib: Introduce test_stackinit module
>
>  lib/Kconfig.debug                       |  10 +
>  lib/Makefile                            |   1 +
>  lib/test_stackinit.c                    | 378 ++++++++++++++++++++++++
>  scripts/Makefile.gcc-plugins            |   2 +
>  scripts/gcc-plugins/Kconfig             |  58 +++-
>  scripts/gcc-plugins/structleak_plugin.c |  36 ++-
>  6 files changed, 463 insertions(+), 22 deletions(-)
>  create mode 100644 lib/test_stackinit.c
>
> --
> 2.17.1
>
