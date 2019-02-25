Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD7420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfBYPTQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:19:16 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44984 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBYPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:19:15 -0500
Received: by mail-ua1-f65.google.com with SMTP id r21so1503730uan.11;
        Mon, 25 Feb 2019 07:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sYMvAdHP9MEDw8ADkokUZKn7rNN7j1k2Kc7E2aCC0L4=;
        b=hcDzx7iEGmb3muTviQnk2FuEa1gIO4llQmYsU0MNPqmey9rgs7ieEOeJTMWsCNnWg0
         di9OtIPzaF98K1EiXgmL3bGlv2pc38AWW6ewM0/1alSH1exJ6PreC1KY9ZYRjKC/TJxv
         Vr9iNStKoWdZNDSnmsl3XGC2i+SxphzMgKaQloINhsAutKQXzqq6WXYD4MJHasDZhY9L
         4KehoU2Zsvi6wzzlGQ2gljAakgTwPyUgJqolHt0R70txJK+HusGqwjCXwfbZ7no8VBsX
         sch04NXdjdCNbo9pkjd49pI1gQz8aDDPy5AUNenK3uVE41xhhKJwEbbZYgorrAqwggV6
         /9LQ==
X-Gm-Message-State: AHQUAuYj0gOH9Ff4qC41fDG0I0b9C1lq5VcEkCy9bNh8dlM7dN7r9fW3
        BjGQ+U8rFP2oidRU94g5hzhkE0gf99uQUfa5b3hBuh4w
X-Google-Smtp-Source: AHgI3IZbVbq++lpvKhvjmc4ymXT/E/rLLI7iH+wYZkB4RGH4l3uzy5SNfUpL9VDVNFTEZ8Aqt8p16VhftM9OXc9e8cA=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr9550214vsp.166.1551107954611;
 Mon, 25 Feb 2019 07:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20190225140355.4335-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190225140355.4335-1-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Feb 2019 16:19:02 +0100
Message-ID: <CAMuHMdXEY+ri8QO2AVGzD5vNuYujDNK-k62zz2Qd-ceMgT59tw@mail.gmail.com>
Subject: Re: [PATCH] div64.h: Fix description of do_div parameter
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Mon, Feb 25, 2019 at 3:05 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Contrary to the description, the first parameter (n) should not be
> passed as a pointer, but directly as an lvalue. This is possible because
> do_div is a macro.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Shouldn't the "semantics" at the top of include/asm-generic/div64.h be
updated, too?

As this can't be expressed in a C function, perhaps that should be done
using C++ syntax, like

    uint32_t do_div(uint64_t &n, uint32_t base)
    {
        ...
    }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
