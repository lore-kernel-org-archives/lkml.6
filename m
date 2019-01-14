Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E264C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E6320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMm/zoEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfANIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:00:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40406 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfANIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:00:01 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so10996866ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gk9rSO8J83NbTCQtOpkCSkrQyA43rrcFDi2wjDFjP4=;
        b=FMm/zoEZQ9yp+HgY5S0it1F+OenthqBptU3DkfUZwHKs7BVbSwmiCZu6nuqoaI0Hic
         Ipj5UsMiEnrM5pZwqMd4yH1wusaMQf3fZhEMLe1x+MFCyi8/3dRboj6aOByg1D+ztev7
         qdBmnnAfOhsBaBvGj4/eIQAnVHxBmOjhsN6I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gk9rSO8J83NbTCQtOpkCSkrQyA43rrcFDi2wjDFjP4=;
        b=G2g/MP5UZSsylxAgUNrH/xbC8k/z3C6eQrxPVnGCAjhYP6zxWjUhl29z0a9F+AF1sl
         uSaJlW0CgT26P79+KOZ36tk8+Gj9eYny9B50KA7R0CVZBidKdnkSo056so1zBQi5g5yO
         CZH738nRn1383oQQ3YHtUAG8rETGhYh3iKJW0LiPxqBT96HktAF81uBUdDD/XsQ6IJz1
         C23GroLPgmd1VzOge7NrRb5H6MWciEkba9tppoTGlIabNjyJj/bL/zQVHy+qGZDNiLu3
         NsIvoHh9EmxtEgH0oOcN3mIIuvxdzT0mplNEDAA0/z46hmB6mIz1ig2842BXIuctvnib
         w/JA==
X-Gm-Message-State: AJcUukePlnHmanfuX0JwkmjlQmPmf5FElOfMeW0MCMeJUnpx7cm16zXI
        CrLU0Fz/xWG0cj+IEwGTbIcxqSqQ5e7sTivZhF9ghA==
X-Google-Smtp-Source: ALg8bN4ba3YwgsCIqixbbT4sJbOCyf7rX+upIDFZHl5oXwM65KR+EcmbBB7RtV/LqjW64iF5VjizVgKq4r7FoUrJ+xs=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr7254619itl.83.1547452800502;
 Mon, 14 Jan 2019 00:00:00 -0800 (PST)
MIME-Version: 1.0
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org> <20190110235428.GA10016@roeck-us.net>
 <CAMuHMdXuo1wMvwx-FZB6uBJahSSbqrmnxEAfepnhAS_odQkHDA@mail.gmail.com>
In-Reply-To: <CAMuHMdXuo1wMvwx-FZB6uBJahSSbqrmnxEAfepnhAS_odQkHDA@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 14 Jan 2019 13:29:49 +0530
Message-ID: <CALxhOnjZrZksPypSvewsF1d=94sxAQNx7smKJLiXP364jzCZFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header files
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
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

Hi Geert, Rob, Guenter,

Thanks for the mail.

On Sat, 12 Jan 2019 at 14:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 11, 2019 at 1:37 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
> > Have you tested this patch ?

Yes.

>
> All these series depend on "scripts: unify system call table generation
> scripts"
> https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Yes, This patch is depends on:
https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

FYI, I'm going to abandon this patch series (for other 9 architecture
also) and planning
to come up with asm-generic support along with this one. That can be
single patch
series. And everything can be landed in upstream in the same time.

Rob,

> I tested it at one point, but not recently. (It was before 4.20 came out...)

The one you tested is the previous version this patch series (w/o
unified script)

Thanks
Firoz
