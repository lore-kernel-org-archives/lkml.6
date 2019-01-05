Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E8C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544FF222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B/cv29R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfAEXGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:06:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38232 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAEXGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:06:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so2707997lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XKfJS3aCUI5VPJ2OoPQz6I8Q3GqY3FZEmK8PJlfXZo=;
        b=B/cv29R5CnnR4cucX2UAJjOuhWykhQuhG+v+Oo2bw14iZUUk6FsYndgTSKJpoaicZ9
         zcGzc4h+DmkLxbm9wLZ8q++rbDh/1i1GjjM8RqoPJguvj7kh22AS5Tx7b/s0D/QAEnZY
         1EePYo9mzlT65j9NUQsGsLfB0eQtm16Ik0+aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XKfJS3aCUI5VPJ2OoPQz6I8Q3GqY3FZEmK8PJlfXZo=;
        b=PxdixLKAeqKjhI6nDhNFZPRuDRbUe1J96Rdcay59VpBOe84yzQNa82R7bSXeFkD9Sf
         VcNkDzzIvdJvHstmQ6OTMhE/DNnemwxRkKc9pOpE3EjWKjffdyQd1bKuzelwYxwDerJr
         nz5WdtG0WbQXOkgPrQdiL1gpyvgEcqKQqT3IKLqtdexJty3vqqPMCtUpZVDKrIwj4tGA
         x0NHE5xY+lzWmM0I65anw7pRQd3vk2JFMxllccJmV8t7GSCb/gk+igJ0+KJ2E4UyPPev
         J8iFe9yb5M58J+MzTup+y4SV/BfYw1q2EcRM8KPV6ucmMzmzQyAvyX6uTeJ40cLxWPE7
         v1Mw==
X-Gm-Message-State: AJcUukdvJUmrtTv0RaRiVuDMGfefDIo+WgFhcxk8KfbqP7hZSugU2cd2
        4xCLKUQ97FkQO/b9GUD3sUTJmywBmAg=
X-Google-Smtp-Source: ALg8bN5kkEvGizACJsEU6N5zN6C+dp3VlgQMKLTmjxO5aA6HxpkputOLzP+FWEV4mYWW4EC/qfXcSA==
X-Received: by 2002:a19:d619:: with SMTP id n25mr17974107lfg.91.1546729561214;
        Sat, 05 Jan 2019 15:06:01 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y24-v6sm13038023ljd.20.2019.01.05.15.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 15:06:00 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id i26so27779901lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:05:59 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr26764036lfa.106.1546729559515;
 Sat, 05 Jan 2019 15:05:59 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
In-Reply-To: <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 15:05:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
Message-ID: <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 2:55 PM Jann Horn <jannh@google.com> wrote:
>
> Just checking: I guess /proc/$pid/pagemap (iow, the pagemap_read()
> handler) is less problematic because it only returns data about the
> state of page tables, and doesn't query the address_space? In other
> words, it permits monitoring evictions, but non-intrusively detecting
> that something has been loaded into memory by another process is
> harder?

Yes. I think it was brought up during the original report, but to use
the pagemap for this, you'd basically need to first populate all the
pages, and then wait for pageout.

So pagemap *does* leak very similar data, but it's much harder to use
as an attack vector.

That said, I think "mincore()" is just the simple one. You *can* (and
this was also discussed on the security list) do things like

 - fault in a single page

 - the kernel will opportunistically fault in pages that it already
has available _around_ that page.

 - then use pagemap (or just _timing_ - no real kernel support needed)
to see if those pages are now mapped in your address space

so honestly, mincore is just the "big hammer" and easy way to get at
some of this data. But it's probably worth closing exactly because
it's easy. There are other ways to get at the "are these pages mapped"
information, but they are a lot more combersome to use.

Side note: maybe we could just remove the "__mincore_unmapped_range()"
thing entirely, and basically make mincore() do what pagemap does,
which is to say "are the pages mapped in this VM".

That would be nicer than my patch, simply because removing code is
always nice. And arguably it's a better semantic anyway.

                Linus
