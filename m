Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEEC2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEEC2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJQW64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:58:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35772 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJQW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:58:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so16663038qka.2;
        Wed, 17 Oct 2018 08:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcVtJ8jFrYe8lGvm2RH0krjJ1rX8q0qlrQdjHm8p+18=;
        b=hwNJUQSIyHN6IxEOf0kuj6sIwmwp/KV8380xFgYnuGzhe9kiEqlRmj9XL3qUXPEFx7
         8ugI9Fnp4sc9KZpzALs1YZKB6iwsSN/9Ndd70fYpNSvbamvsd6eo6pq6BzCZKp+u9Fzi
         C2mlnS5caU46r464ZGKvARBfjhjcKiOxsrVdvgi1nBFgAjHS7i7V4Y8Fl4SjqfVI6HbT
         Ok8SEwz9XfvCjX2ThllkUvZRKnZF2n7IqCkDBXC+razuVKd5Ge7L/wq5fpquUIuLKJx3
         WVnN38dBIk3XoSo3oByW/g4QngedHR7dSG7J+4qMdlretsbT/mOHTruVjrHS7O7UR8Me
         altA==
X-Gm-Message-State: ABuFfojWYcptK9LyBS/mzOYhiEtMSTyGM9yT2FSXZEYMoOHtIeoC1Mbg
        H3SPVgJ3uNuCB0xW3+UuJYtaLL048AOohRrMAuxGH0xK
X-Google-Smtp-Source: ACcGV61nN88GwQZQqAPVHd6Tl1MgotW7Y71oD/pmr4t4E3L4Abcs6v3jHUj4OcLcLFU3YTSfo4S49lTMtTrM64A115Q=
X-Received: by 2002:a37:2b66:: with SMTP id r99-v6mr2781481qkh.343.1539788569460;
 Wed, 17 Oct 2018 08:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <d83762614122402ba4b55524e35b418c9f6baf53.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <d83762614122402ba4b55524e35b418c9f6baf53.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:02:33 +0200
Message-ID: <CAK8P3a3bNST+ZuPjLG0_sHjC=Ac0ir1omhHvMn9tz4zs+Kg9yw@mail.gmail.com>
Subject: Re: [PATCH V9 05/21] csky: System Call
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to syscall.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I had a detailed look at this one and provided lots of comments, however
one tiny thing escaped me:

> +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
> +__SYSCALL(__NR_cacheflush, sys_cacheflush)

It's odd that the second one uses __NR_arch_specific_syscall + 4 rather
than +1. If you can still change that changing too much other stuff,
that might avoid some head-scratching later. If it causes problems,
just leave it and maybe add a comment saying that the numbers
inbetween are still available.

      Arnd
