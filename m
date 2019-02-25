Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1DC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXtBAyP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfBYRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:07:11 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33238 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfBYRHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:07:11 -0500
Received: by mail-vk1-f195.google.com with SMTP id l62so2287507vkh.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGrG0c4LCo2Ok2zh+rPj7/ynCvqIdVeBdBz8/T+Z01I=;
        b=GXtBAyP8gtN2ST5K7velqc1rOZQRDeSK3Goz7EER0M04+yeSzHeJRjuqtL2SqL2IHa
         +hrjOyhyUO1ad82KWZj6660dm0FLgRswhAb9eBARs9FPBA8Ns1baVre5I4qj2M9Twiii
         xdNhlRC21Qg0u4EyBrVutt+s3sImYl1UAvgLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGrG0c4LCo2Ok2zh+rPj7/ynCvqIdVeBdBz8/T+Z01I=;
        b=ZdTLlwDiYAt4juWcY2++btg/h4RUOk2bvAho3X6g3bvfrBcMX9jfMd9XdTq4Er04uR
         4HTj2R7lAXGHzpTfy/F28OuFmaZlGz9VQ70Tx/TuXcXwURIkbQHimlSTcf+UU3ry0zbv
         YPJAcX1n7zQcbG4Hx1ZUWe7T4yBzvTG8PWgnjyBVTdEZt5EWLHrZxSPk+m9pQlojo7U7
         1tqObNYYU2P0jkZLnJOJ7ya3e8B3M8etYDbXjffuqpbR0GPSoGY3sLST2tBbFVPkTbpq
         DccrCPHWOi1khxi/vta2MSwEd0tn0/OzRuEwuqwZ0EISBWNvUBp5M5A1V686w3gnEPYY
         BsbQ==
X-Gm-Message-State: AHQUAuaiMUEoJvmSNK3FoRXH/e7lumiGHEg21ge/99N4fm5jvSAjiZpe
        cemepXSHvwZDhwdEIVdQMzEzFKA0FJE=
X-Google-Smtp-Source: AHgI3IYObplLDMGkFHDv4sdHvzFcg3DRfY+A7W4KcKBiE0A/K4ThRDJMWDdDH+iShck+1z7WmsQDvg==
X-Received: by 2002:a1f:2ccb:: with SMTP id s194mr9942171vks.20.1551114429058;
        Mon, 25 Feb 2019 09:07:09 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a64sm2083996uaa.1.2019.02.25.09.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:07:08 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id z24so9023484ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:07:07 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr9544336uaa.10.1551114427263;
 Mon, 25 Feb 2019 09:07:07 -0800 (PST)
MIME-Version: 1.0
References: <155110348217.21156.3874419272673328527.stgit@devbox> <155110354092.21156.13871336589042178985.stgit@devbox>
In-Reply-To: <155110354092.21156.13871336589042178985.stgit@devbox>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Feb 2019 09:06:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL+8nBen8_BjTziF=bGQm7hijV7YMa_a53vXfFT4+mwzQ@mail.gmail.com>
Message-ID: <CAGXu5jL+8nBen8_BjTziF=bGQm7hijV7YMa_a53vXfFT4+mwzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read functions
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 6:06 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> +static __always_inline long strncpy_from_unsafe_common(char *dst,
> +                               const char __user *unsafe_addr, long count)
> +{
> +       const char __user *src = unsafe_addr;
> +       int ret;
> +
> +       pagefault_disable();
> +       do {
> +               ret = __get_user(*dst++, src++);
> +       } while (dst[-1] && ret == 0 && src - unsafe_addr < count);
> +       dst[-1] = '\0';
> +       pagefault_enable();
> +
> +       return ret ? -EFAULT : src - unsafe_addr;
> +}

I'm all for always NUL-truncating, but this isn't "strncpy" (which has
the buggy maybe-I-didn't-NUL-terminate behavior). Can we call this
strscpy_...() instead?

-- 
Kees Cook
