Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22403C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76CC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfAUJlt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:41:49 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43114 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfAUJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:41:48 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so6688955uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CUAqPe2jGuVKrsTYe4Wv/yT102nS5s3YxketnkM2/nI=;
        b=t414tb6i0e0HZk0ZMMvJuUjKpw8AqUpdqmDxN1SJ+0rm5oh1dVjvGL6f9neYX58m7T
         iCD/2EAVS8PrIXGZAJ3hvDXuO7mvxUGHRU6D6DgAlKajHOup9PgqbheengZGPdL6UaYu
         WOOOVHx4IK8v3bb+s/ZrK/vGKHwgxd0ULIYYq87uFuluy+PkgWLAINcp9kNNJiHzoJz4
         11i488AMtx17Bj8gcrduJCZo/LPxQ/DwGf2tM+OdvXZRfWdmEOc3ZNtHZ3dhHphIriqm
         41FIFBFQOVDYVLWhf8J+70WPJaVN7+H3Cp995icAG+dBTQrmxriw4t40Y5WnXNBRnSJ0
         zpbw==
X-Gm-Message-State: AJcUukex7K/Icf1fnUmmkoKEF6PzLwA0eefqT9HKAN+yc1h9bazz3f2b
        +EhOMeD5dkZ/cqPCjLfwDy3KON2te1y4WRTOlwA=
X-Google-Smtp-Source: ALg8bN4eDmvF0xiQ+tqitW9MGl4CShQWM9uIxyrq2kLEAgpx8ARqAhesc2YIo4w93O361l1Mggei36Jc2IMwXIysXBQ=
X-Received: by 2002:ab0:216:: with SMTP id 22mr11349845uas.28.1548063707808;
 Mon, 21 Jan 2019 01:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20190107092935.14617-1-geert@linux-m68k.org>
In-Reply-To: <20190107092935.14617-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:41:36 +0100
Message-ID: <CAMuHMdXBujvRZcurEP60VNYZPrJcO1-N6RWXhpsTEZ5r14e28g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Avoid VLA use in mangle_kernel_stack()
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> With gcc 7.3.0:
>
>     arch/m68k/kernel/signal.c: In function ‘mangle_kernel_stack’:
>     arch/m68k/kernel/signal.c:654:3: warning: ISO C90 forbids variable length array ‘buf’ [-Wvla]
>        unsigned long buf[fsize / 2]; /* yes, twice as much */
>        ^~~~~~~~
>
> Replace the variable size by the upper limit, which is 168 bytes.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
